import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:likeplay/module/model/block_response.dart';
import 'package:likeplay/module/model/cancel_subscription_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import 'package:likeplay/module/model/user_profile_response.dart';
import 'package:likeplay/utils/constant_lists.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../utils/color_utils.dart';
import '../../../utils/firebase/authentication_service.dart';
import '../../../utils/responsive.dart';
import '../../../utils/route/route_name.dart';
import '../../../utils/sharedpref/preferences.dart';
import '../../../utils/sharedpref/shared_prefrence.dart';
import '../../../utils/string_utils.dart';
import '../../../utils/utils.dart';
import '../../../utils/view_video/video_player_screen.dart';
import '../../../widget/common/video_player.dart';
import '../../model/create_star_response.dart';
import '../../model/get_star_response.dart';
import '../../setting/setting_presenter.dart';
import 'message_presenter.dart';

class MessageMobileViewScreen extends StatefulWidget {
  String? senderId, receiverId,senderName,receiverName,receiverImage,senderImage,comesFrom;
  int? starCount;

  MessageMobileViewScreen({Key? key,
    this.senderId,
    this.receiverId,
    this.senderName,
    this.receiverName,
    this.receiverImage,
    this.senderImage,
    this.comesFrom,
    this.starCount,
  }) : super(key: key);
  @override
  State<MessageMobileViewScreen> createState() => _MessageMobileViewScreenState();
}

class _MessageMobileViewScreenState extends State<MessageMobileViewScreen>  implements SettingInterface,MessageInterface {
  bool isLoading = false;
  ScrollController controller = ScrollController();
  TextEditingController chatController = TextEditingController();
  final _authService = AuthenticationService();
  MessagePresenter? messagePresenter;

  bool? isShowSticker;
  var result;
  int? activeTime;
  String isAdmire = "1";
  String userId = "";
  String senderIdFirst = "";
  String receiverIdFirst = "";
  String receiverNameFirst = "";
  String receiverImageFirst = "";
  String senderImageFirst = "";
  String senderNameFirst = "";
  bool isBlock = false;
  String admireSender = "";
  String admirereciver = "";
  int? admireDocLength;
  bool isReport = false;
  String otherSubscriptionPlan = "";
  bool otherSubscriptionStatus = false;
  SettingPresenter? settingPresenter;
  bool checkValue = true;
  int? senderActiveTime;
  int? receiverActiveTime;
  bool isApiHit=false;
  bool isGallery=false;

  @override
  void initState() {
    super.initState();
    settingPresenter = SettingPresenter(this);
    messagePresenter=MessagePresenter(this);

    setState(() {
      isShowSticker = false;
    });
    getData();
  }
  String generateChatId(String senderId, String receiverId) {
    return senderId.compareTo(receiverId) <= 0
        ? '${senderId}_${receiverId}'
        : '${receiverId}_${senderId}';
  }
  getData() async {
    FlutterAppBadger.removeBadge();
    await FirebaseMessaging.instance.unsubscribeFromTopic("chatId_${SessionManager.getString(Preferences.USER_ID)}");
    var refrecne = await FirebaseFirestore.instance.collection('chat');
    try{
      var chatId=generateChatId(widget.senderId.toString(),widget.receiverId.toString());
      var docRefrecne = await refrecne.doc(chatId);
      docRefrecne.get().then((value) {
        setState(() {
          try{
            senderIdFirst = value.data()!["recentMessage"]["senderID"].toString();
            isBlock = value.data()!["recentMessage"]["is_block"];
            receiverIdFirst = value.data()!["recentMessage"]["receiverID"].toString();
            receiverImageFirst = value.data()!["receiver_image"].toString();
            receiverNameFirst = value.data()!["receiver_name"].toString();
            senderNameFirst = value.data()!["sender_name"].toString();
            senderImageFirst = value.data()!["sender_image"].toString();
            isReport = value.data()!["recentMessage"]["is_report"];
            isAdmire = value.data()!["recentMessage"]["is_admire"].toString();
            receiverActiveTime =  value.data()!["recentMessage"]["receiver_active_time"];
            senderActiveTime =  value.data()!["recentMessage"]["sender_active_time"];
          }on FirebaseAuthException catch (e) {
            // print("FirebaseAuthException=====>"+e.toString());
          }
        });
      });
    }on FirebaseAuthException catch (e) {
      // print("FirebaseAuthException=====>"+e.toString());
    }

    Utils.scroll(controller);
    if (senderIdFirst == SessionManager.getString(Preferences.USER_ID)) {
      settingPresenter!.doUserResponseData(receiverIdFirst.toString());
    } else {
      settingPresenter!.doUserResponseData(senderIdFirst.toString());
    }
// });
  }

  Future<bool> onBackPress() async {
    if (isShowSticker!) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      Navigator.pop(context);
    }
    await FirebaseMessaging.instance.subscribeToTopic("user_${SessionManager.getString(Preferences.USER_ID)}");
    await FirebaseMessaging.instance.subscribeToTopic("chatId_${SessionManager.getString(Preferences.USER_ID)}");
    return Future.value(false);
  }

  onTimeUpdate(String senderId, String receiverId) async {
    var chatId=generateChatId(widget.senderId.toString(),widget.receiverId.toString());
    final query = await FirebaseFirestore.instance
        .collection('chat')
        .doc(chatId)
        .collection('messages')
        .where(
        "receiver_id", isEqualTo: SessionManager.getString(Preferences.USER_ID))
        .
    where('read_status', isEqualTo: false)
        .get();
    query.docs.forEach((doc) {
      doc.reference.update({'read_status': true}).then((value) {}).catchError((
          error) {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return  WillPopScope(
      onWillPop: onBackPress,
      child: SafeArea(
        child: Scaffold(
            body: Stack(
                children: [
                  senderIdFirst!=""&& receiverIdFirst!=""?
                  GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                      },
                      child: Container(
                        constraints: const BoxConstraints.expand(),
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            Container(
                                padding: const EdgeInsets.all(10),
                                color: HexColor(AppColor.WHITE),
                                child: Row(
                                  children: [
                                    //Utils.
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Gap(18),
                                          GestureDetector(
                                              onTap: () async {
                                                await FirebaseMessaging.instance.subscribeToTopic("user_${SessionManager.getString(Preferences.USER_ID)}");
                                                await FirebaseMessaging.instance.subscribeToTopic("chatId_${SessionManager.getString(Preferences.USER_ID)}");
                                                Navigator.pop(context);
                                              },
                                              child: Icon(Icons.arrow_back,
                                                color: Colors.black,)),
                                          Gap(8),
                                          GestureDetector(
                                            onTap: () {
                                              Utils.viewPhoto(context,
                                                  SessionManager.getString(Preferences.USER_ID) == senderIdFirst ? receiverImageFirst : senderImageFirst);
                                            },
                                            child: SizedBox(
                                              height: 32,
                                              width: 32,
                                              child: ClipOval(
                                                child: CachedNetworkImage(
                                                  imageUrl: SessionManager
                                                      .getString(
                                                      Preferences.USER_ID) ==
                                                      senderIdFirst
                                                      ?
                                                  receiverImageFirst
                                                      : senderImageFirst,
                                                  imageBuilder:
                                                      (context,
                                                      imageProvider) =>
                                                      Container(
                                                          decoration:
                                                          BoxDecoration(
                                                            borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius
                                                                    .circular(
                                                                    8)),
                                                            image: DecorationImage(
                                                              image: imageProvider,
                                                              fit: BoxFit
                                                                  .fill,
                                                            ),
                                                          )),
                                                  placeholder: (context,
                                                      url) =>
                                                  const Image(
                                                      image: AssetImage(
                                                          "assets/images/icon_loading.png")),
                                                  errorWidget: (context,
                                                      url,
                                                      error) =>
                                                  const Image(
                                                      image: AssetImage(
                                                          "assets/images/icon_loading.png")),
                                                  width: 32,
                                                  height: 32,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Gap(10),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Utils
                                                  .mediumHeadingNormalText(
                                                  text: SessionManager.getString(
                                                      Preferences.USER_ID) ==
                                                      senderIdFirst
                                                      ?
                                                  receiverNameFirst
                                                      : senderNameFirst,
                                                  textSize: 14,
                                                  fontWeight: FontWeight
                                                      .w500,
                                                  color: AppColor
                                                      .APP_TEXT_COLOR),
                                              const Gap(3),
                                              Utils
                                                  .mediumHeadingNormalText(
                                                  text:SessionManager.getString(Preferences.USER_ID) ==senderIdFirst?
                                                  receiverActiveTime==null?"":
                                                  "Last active at  ${Utils.convertTimestamp(receiverActiveTime!)}":
                                                  senderActiveTime==null?"":
                                                  "Last active at  ${Utils.convertTimestamp(senderActiveTime!)}",
                                                  textSize: 12,
                                                  color: AppColor
                                                      .APP_TEXT_COLOR_SECOND,
                                                  overflow: TextOverflow
                                                      .ellipsis)
                                            ],
                                          ),
                                          const Spacer(),
                                          /*  isAdmire=="1"? GestureDetector(
                                        onTap: (){
                                          */ /* if(SessionManager.getString(Preferences.subscription_plan)=="0" ||
                                                              SessionManager.getString(Preferences.subscription_plan)=="1"
                                                          ){
                                                            Utils.customDialog("Please buy gold or platinum subscription to enable this feature");
                                                          }*/ /*
                                        },
                                        child: Image.asset(
                                          'assets/images/icon_voiceCall.png',
                                          height: 25,),
                                      ):SizedBox(),*/
                                          isAdmire == "1" ? isBlock == false ?
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              /*  ButtonIcon(icon: Icon(Icons.call,size: 22,color: Colors.white),backgroundColor:
                                          HexColor(AppColor.grey)),*/
                                              /*  ButtonIcon(icon: Icon(Icons.call,size: 22,color: Colors.white),backgroundColor:
                                          HexColor(AppColor.grey)),*/
                                              SessionManager.getString(
                                                  Preferences.USER_ID) ==
                                                  senderIdFirst ?
                                              SessionManager.getString(
                                                  Preferences.subscription_plan) ==
                                                  "3" ||
                                                  SessionManager.getString(
                                                      Preferences
                                                          .subscription_plan) == "4"
                                                  ?
                                              otherSubscriptionPlan == "3" ||
                                                  otherSubscriptionPlan == "4" ?
                                              checkValue == true
                                                  ?
                                              actionButtonAudio(
                                                  false, receiverIdFirst,
                                                  receiverNameFirst)
                                                  : GestureDetector(
                                                onTap: () {
                                                  Utils.customDialog(context,
                                                      message: "You do not have permission to use this feature");
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: AppColor.grey,
                                                      borderRadius: BorderRadius
                                                          .circular(50)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(
                                                        6.0),
                                                    child: Icon(
                                                        Icons.call, size: 20,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ) : GestureDetector(
                                                onTap: () {
                                                  Utils.customDialog(context,
                                                      message: "You do not have permission to use this feature");
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: AppColor.grey,
                                                      borderRadius: BorderRadius
                                                          .circular(50)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(
                                                        6.0),
                                                    child: Icon(
                                                        Icons.call, size: 20,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )
                                                  : Container() :
                                              SessionManager.getString(
                                                  Preferences.subscription_plan) ==
                                                  "3" || SessionManager.getString(
                                                  Preferences.subscription_plan) ==
                                                  "4" ?
                                              otherSubscriptionPlan == "3" ||
                                                  otherSubscriptionPlan == "4" ?
                                              checkValue == true
                                                  ?
                                              actionButtonAudio(
                                                  false, senderIdFirst,
                                                  senderNameFirst)
                                                  : GestureDetector(
                                                onTap: () {
                                                  Utils.customDialog(context,
                                                      message: "You do not have permission to use this feature");
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: AppColor.grey,
                                                      borderRadius: BorderRadius
                                                          .circular(50)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(
                                                        6.0),
                                                    child: Icon(
                                                        Icons.call, size: 20,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ) : GestureDetector(
                                                onTap: () {
                                                  Utils.customDialog(context,
                                                      message: "You do not have permission to use this feature");
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: AppColor.grey,
                                                      borderRadius: BorderRadius
                                                          .circular(50)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(
                                                        6.0),
                                                    child: Icon(
                                                        Icons.call, size: 20,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ) : Container(),
                                            ],
                                          ) : SizedBox() : SizedBox(),
                                          isAdmire == "1"
                                              ? const Gap(15)
                                              : SizedBox(),
                                          /*isAdmire=="1"? GestureDetector(
                                        onTap: (){
                                          */ /* if(SessionManager.getString(Preferences.subscription_plan)=="0" ||
                                                              SessionManager.getString(Preferences.subscription_plan)=="1" ||
                                                              SessionManager.getString(Preferences.subscription_plan)=="2"
                                                          ){
                                                            Utils.customDialog("Please buy basic or standard or gold or platinum subscription to enable this feature");
                                                          }*/ /*
                                        },
                                        child: Image.asset(
                                          'assets/images/icon_video.png',
                                          height: 25,),
                                      ):SizedBox(),*/
                                          isAdmire == "1" ?
                                          isBlock == false ? Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              /*  ButtonIcon(icon: Icon(Icons.videocam,size: 22,color: Colors.white),backgroundColor:
                                          HexColor(AppColor.grey)),*/
                                              SessionManager.getString(Preferences.USER_ID) ==
                                                  senderIdFirst ? SessionManager.getString(Preferences.subscription_plan) == "4" ?
                                              otherSubscriptionStatus == true &&
                                                  otherSubscriptionPlan == "4" ?
                                                checkValue == true
                                                  ?
                                              actionButton(true, receiverIdFirst,
                                                  receiverNameFirst)
                                                  : GestureDetector(
                                                onTap: () {
                                                  Utils.customDialog(context,
                                                      message: "You do not have permission to use this feature");
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: AppColor.grey,
                                                      borderRadius: BorderRadius
                                                          .circular(50)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(
                                                        6.0),
                                                    child: Icon(
                                                        Icons.videocam, size: 20,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ) : GestureDetector(
                                                onTap: () {
                                                  Utils.customDialog(context,
                                                      message: "You do not have permission to use this feature");
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: AppColor.grey,
                                                      borderRadius: BorderRadius
                                                          .circular(50)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(
                                                        6.0),
                                                    child: Icon(
                                                        Icons.videocam, size: 20,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ) :
                                              Container()
                                                  : SessionManager.getString(
                                                  Preferences.subscription_plan) ==
                                                  "4" ?
                                              SessionManager.getString(
                                                  Preferences.subscription_plan) ==
                                                  "4" ?
                                              otherSubscriptionStatus == true &&
                                                  otherSubscriptionPlan == "4" ?
                                              checkValue == true
                                                  ?
                                              actionButton(true, senderIdFirst,
                                                  senderNameFirst)
                                                  : GestureDetector(
                                                onTap: () {
                                                  Utils.customDialog(context,
                                                      message: "You do not have permission to use this feature");
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: AppColor.grey,
                                                      borderRadius: BorderRadius
                                                          .circular(50)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(
                                                        6.0),
                                                    child: Icon(
                                                        Icons.videocam, size: 20,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ) : GestureDetector(
                                                onTap: () {
                                                  Utils.customDialog(context,
                                                      message: "You do not have permission to use this feature");
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: AppColor.grey,
                                                      borderRadius: BorderRadius
                                                          .circular(50)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(
                                                        6.0),
                                                    child: Icon(
                                                        Icons.videocam, size: 20,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ) : Container() : Container()

                                              /*              SessionManager.getString(Preferences.USER_ID)==senderIdFirst?
                                         SessionManager.getString(Preferences.subscription_plan)=="4"?
                                          actionButton(true,receiverIdFirst,receiverNameFirst):
                                          Container()
                                         :SessionManager.getString(Preferences.subscription_plan)=="4"?
                                         actionButton(true,senderIdFirst,senderNameFirst):Container()*/
                                            ],
                                          ) : SizedBox() : SizedBox(),
                                          isAdmire == "1"
                                              ? const Gap(15)
                                              : SizedBox(),
                                          isAdmire == "1" ? GestureDetector(
                                            onTap: () {

                                            },
                                            child: Theme(
                                                data: Theme.of(context)
                                                    .copyWith(
                                                    cardColor: Colors
                                                        .white
                                                ),
                                                child: isBlock == false ?
                                                PopupMenuButton(
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .all(
                                                        Radius.circular(
                                                            15.0),
                                                      ),
                                                    ),
                                                    child: Image.asset(
                                                      'assets/images/more.png',
                                                      height: 25,),
                                                    itemBuilder: (ctx) =>
                                                    [
                                                      _buildPopupMenuItem(
                                                          UtilStrings
                                                              .Block,
                                                          "ic_block.png", () {
                                                        print("receiverIdFirst==>" +
                                                            receiverIdFirst);
                                                        print("senderIdFirst==>" +
                                                            senderIdFirst);
                                                        showAlertDialog(
                                                            context, "Block User",
                                                            "Are you sure you want to block user?",
                                                            SessionManager
                                                                .getString(
                                                                Preferences
                                                                    .USER_ID) ==
                                                                senderIdFirst ? int
                                                                .parse(
                                                                senderIdFirst) : int
                                                                .parse(
                                                                receiverIdFirst),
                                                            1);
                                                      }),
                                                      _buildPopupMenuItem(
                                                          UtilStrings
                                                              .Delete,
                                                          "trash.png", () {
                                                        showAlertDialog(
                                                            context, "Delete",
                                                            "Are you sure you want to delete?",
                                                            SessionManager
                                                                .getString(
                                                                Preferences
                                                                    .USER_ID) ==
                                                                senderIdFirst ? int
                                                                .parse(
                                                                senderIdFirst) : int
                                                                .parse(
                                                                receiverIdFirst),
                                                            3);
                                                      }
                                                      ),
                                                      _buildPopupMenuItem(
                                                          UtilStrings
                                                              .Report,
                                                          "ic_report.png", () {
                                                        setState(() {});
                                                        showAlertDialog(
                                                            context, "Report",
                                                            "Are you sure you want to report?",
                                                            SessionManager
                                                                .getString(
                                                                Preferences
                                                                    .USER_ID) ==
                                                                senderIdFirst ? int
                                                                .parse(
                                                                senderIdFirst) : int
                                                                .parse(
                                                                receiverIdFirst),
                                                            4);
                                                      }
                                                      ),
                                                    ]) : SizedBox()
                                            ),

                                          ) : SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                            Utils.customDivider(),
                            Gap(12),
                            Expanded(
                              child: StreamBuilder<QuerySnapshot<
                                  Map<String, dynamic>>>(
                                /*.orderBy('time_stamp', descending: true)*/
                                stream:
                                FirebaseFirestore.instance
                                    .collection('chat').doc(generateChatId(senderIdFirst,receiverIdFirst))
                                    .collection("messages").orderBy(
                                    'time_stamp', descending: false)
                                    .snapshots(),
                                builder: (_, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text(
                                        'Error = ${snapshot
                                            .error}');
                                  }
                                  if (snapshot.hasData) {
                                    final docs = snapshot
                                        .data!.docs;
                                    return docs.isNotEmpty
                                        ? Container(
                                      // margin: EdgeInsets.only(bottom: 180),
                                      child: ListView.builder(
                                          shrinkWrap: false,
                                          reverse: false,
                                          itemCount: docs.length,
                                          controller: controller,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            if (docs.isNotEmpty) {
                                              if (isAdmire == "1") {
                                                onTimeUpdate(
                                                    docs[index]["sender_id"],
                                                    docs[index]["receiver_id"]);
                                              }
                                            }
                                            List deleteList=[];
                                            bool isDelete=false;
                                            List deleteUser=  docs[index]["delete_by"];
                                            if(deleteUser.isNotEmpty){
                                              // print("deleteUser====>"+deleteUser.toString());
                                              deleteList.addAll(docs[index]["delete_by"]);
                                              if(deleteList.contains(SessionManager.getString(Preferences.USER_ID))){
                                                isDelete=true;
                                              }
                                            }
                                           /* controller.animateTo(
                                              controller.position.maxScrollExtent,
                                              duration: Duration(milliseconds: 300),
                                              curve: Curves.easeOut,
                                            );*/
                                            return SessionManager.getString(
                                                Preferences.USER_ID) ==
                                                docs[index]["receiver_id"] &&
                                                docs.length == 1 &&
                                                isAdmire == "0" ?

                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width / 2),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center,
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  Utils
                                                      .mediumHeadingNormalText(
                                                      text: docs[index]["message"]
                                                          .toString(),
                                                      textSize: 12,
                                                      color: AppColor
                                                          .APP_TEXT_COLOR_SECOND,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  Gap(16),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () async {
                                                          // if (SessionManager.getString(Preferences.subscription_status) == "true") {
                                                            setState(() {
                                                              isLoading = true;
                                                              admireSender =
                                                              docs[index]["sender_id"];
                                                              admirereciver =
                                                              docs[index]["receiver_id"];
                                                              admireDocLength =
                                                                  docs.length;
                                                            });
                                                            if (senderIdFirst == SessionManager.getString(Preferences.USER_ID)) {
                                                              settingPresenter?.onSendRequest(receiverIdFirst, "2");
                                                            } else {
                                                              settingPresenter?.onSendRequest(senderIdFirst, "2");
                                                            }

                                                         /* } else {
                                                            Utils
                                                                .customDialog(
                                                                context,
                                                                message: "Please subscribe to enable this feature");
                                                          }*/
                                                        },
                                                        child: Container(
                                                          height: 28,
                                                          width: 120,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .circular(
                                                                  5),
                                                              color: HexColor(
                                                                  '#FF483C')
                                                          ),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment: MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              Utils
                                                                  .mediumHeadingNormalText(
                                                                  text: "Admire Back",
                                                                  textSize: 8,
                                                                  fontWeight: FontWeight
                                                                      .bold,
                                                                  color: AppColor
                                                                      .white,
                                                                  overflow: TextOverflow
                                                                      .ellipsis),
                                                            ],
                                                          ),
                                                        ),),
                                                      Gap(
                                                          8),
                                                      GestureDetector(
                                                        onTap: () async {
                                                        /*  if (SessionManager
                                                              .getString(
                                                              Preferences
                                                                  .subscription_status) ==
                                                              "true") {*/
                                                            if (senderIdFirst ==
                                                                SessionManager
                                                                    .getString(
                                                                    Preferences
                                                                        .USER_ID)) {
                                                              setState(() {
                                                                isLoading =
                                                                true;
                                                              });
                                                              settingPresenter
                                                                  ?.onSendRemoveRequest(
                                                                  receiverIdFirst,
                                                                  "0");
                                                            } else {
                                                              setState(() {
                                                                isLoading =
                                                                true;
                                                              });
                                                              settingPresenter
                                                                  ?.onSendRemoveRequest(
                                                                  senderIdFirst,
                                                                  "0");
                                                            }
                                                          /*} else {
                                                            Utils
                                                                .customDialog(
                                                                context,
                                                                message: "Please subscribe to enable this feature");
                                                          }*/
                                                        },
                                                        child: Container(
                                                          height: 28,
                                                          width: 120,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .circular(
                                                                  5),
                                                              color: HexColor(
                                                                  '#F2F2F2')
                                                          ),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment: MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              const Gap(
                                                                  6),
                                                              Image
                                                                  .asset(
                                                                "assets/images/icon_waving.png",
                                                                height: 14,
                                                                width: 14,),
                                                            ],
                                                          ),
                                                        ),),
                                                    ],),
                                                ],),
                                            ) :
                                            isDelete == false ?
                                            Container(
                                              margin: EdgeInsets
                                                  .only(
                                                  left: 40,
                                                  right: 40),
                                              child: docs[index]["messageType"] ==
                                                  1 ||
                                                  docs[index]["messageType"] ==
                                                      2
                                                  ?
                                              GestureDetector(
                                                onTap: () {
                                                  if (docs[index]["messageType"] ==
                                                      1) {
                                                    Utils
                                                        .viewPhoto(
                                                        context,
                                                        docs[index]["thumbURL"]);
                                                  } else
                                                  if (docs[index]["messageType"] ==
                                                      2) {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                VideoPlayerApp(
                                                                    docs[index]["media_url"]
                                                                        .toString(),
                                                                    "")));
                                                  }
                                                },
                                                child: Row(
                                                  mainAxisAlignment: docs[index]["sender_id"] ==
                                                      SessionManager
                                                          .getString(
                                                          Preferences.USER_ID)
                                                      ? MainAxisAlignment.end
                                                      : MainAxisAlignment
                                                      .start,
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment: docs[index]["sender_id"] ==
                                                          SessionManager
                                                              .getString(
                                                              Preferences
                                                                  .USER_ID)
                                                          ?
                                                      MainAxisAlignment.end
                                                          : MainAxisAlignment
                                                          .start,
                                                      crossAxisAlignment: docs[index]["sender_id"] ==
                                                          SessionManager
                                                              .getString(
                                                              Preferences
                                                                  .USER_ID)
                                                          ? CrossAxisAlignment
                                                          .end
                                                          : CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets
                                                              .only(left: 18,
                                                              right: 18),
                                                          child: docs[index]["messageType"] ==
                                                              1
                                                              ? Container(
                                                            padding: EdgeInsets.all(8.0),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(12),
                                                                color: docs[index]["sender_id"] ==
                                                                    SessionManager
                                                                        .getString(
                                                                        Preferences
                                                                            .USER_ID)
                                                                    ? HexColor(
                                                                    AppColor.FillColor)
                                                                    : AppColor.grey_low
                                                                    .withOpacity(0.9),
                                                              ),
                                                                child: Image.network(
                                                            docs[index]["thumbURL"],
                                                            height:
                                                            Responsive()
                                                                  .getResponsiveValue(
                                                                  forLargeScreen: size
                                                                      .height /
                                                                      6,
                                                                  forShortScreen: size
                                                                      .height /
                                                                      6,
                                                                  forMobLandScapeMode: size
                                                                      .height /
                                                                      4,
                                                                  forMediumScreen: size
                                                                      .height /
                                                                      6,
                                                                  forTabletScreen: size
                                                                      .height /
                                                                      4,
                                                                  context: context)
                                                            ,
                                                            width: Responsive()
                                                                  .getResponsiveValue(
                                                                  forLargeScreen: size
                                                                      .width /
                                                                      6,
                                                                  forShortScreen: size
                                                                      .width /
                                                                      2.5,
                                                                  forMobLandScapeMode: size
                                                                      .width /
                                                                      4,
                                                                  forMediumScreen: size
                                                                      .width /
                                                                      2.5,
                                                                  forTabletScreen: size
                                                                      .width /
                                                                      4,
                                                                  context: context),
                                                            fit: BoxFit.fill,),
                                                              )
                                                              : Container(
                                                              height:
                                                              Responsive()
                                                                  .getResponsiveValue(
                                                                  forLargeScreen: size
                                                                      .height /
                                                                      6,
                                                                  forShortScreen: size
                                                                      .height /
                                                                      6,
                                                                  forMobLandScapeMode: size
                                                                      .height /
                                                                      4,
                                                                  forMediumScreen: size
                                                                      .height /
                                                                      6,
                                                                  forTabletScreen: size
                                                                      .height /
                                                                      4,
                                                                  context: context)
                                                              ,
                                                              width: Responsive()
                                                                  .getResponsiveValue(
                                                                  forLargeScreen: size
                                                                      .width /
                                                                      6,
                                                                  forShortScreen: size
                                                                      .width /
                                                                      2.5,
                                                                  forMobLandScapeMode: size
                                                                      .width /
                                                                      4,
                                                                  forMediumScreen: size
                                                                      .width /
                                                                      2.5,
                                                                  forTabletScreen: size
                                                                      .width /
                                                                      4,
                                                                  context: context),
                                                              decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                border: Border
                                                                    .all(
                                                                    color: Colors
                                                                        .grey),
                                                                borderRadius: BorderRadius.circular(8)
                                                              ),
                                                              child: Center(
                                                                  child: Icon(
                                                                      Icons
                                                                          .video_collection_rounded,
                                                                      color: HexColor(
                                                                          AppColor
                                                                              .SIDE_TEXT_COLOR)))
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets
                                                              .only(top: 4),
                                                          child: Row(
                                                            mainAxisAlignment: docs[index]["sender_id"] ==
                                                                SessionManager
                                                                    .getString(
                                                                    Preferences
                                                                        .USER_ID)
                                                                ? MainAxisAlignment
                                                                .end
                                                                : MainAxisAlignment
                                                                .start,
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Gap(18),
                                                              Utils
                                                                  .mediumHeadingNormalText(
                                                                  text:"${Utils
                                                                      .convertDateTimestamp(
                                                                      docs[index]["message_time"])} ${Utils
                                                                      .convertTimestamp(
                                                                      docs[index]["message_time"])}  ",
                                                                  fontWeight: FontWeight
                                                                      .normal,
                                                                  textSize: 9,
                                                                  color: AppColor
                                                                      .grey),
                                                              SessionManager
                                                                  .getString(
                                                                  Preferences
                                                                      .USER_ID) ==
                                                                  docs[index]["sender_id"]
                                                                  ? Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .end,
                                                                crossAxisAlignment: CrossAxisAlignment
                                                                    .end,
                                                                children: [
                                                                  docs[index]["read_status"] ==
                                                                      true
                                                                      ?
                                                                  Image.asset(
                                                                    "assets/images/read_true.png",
                                                                    height: 14,
                                                                    width: 14,)
                                                                      :
                                                                  Image.asset(
                                                                    "assets/images/read_false.png",
                                                                    height: 14,
                                                                    width: 14,),
                                                                  Gap(22)
                                                                ],
                                                              )
                                                                  : Container(),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                                  : Column(
                                                children: [
                                                  BubbleSpecialOne(
                                                    tail: false,
                                                    color: docs[index]["sender_id"] ==
                                                        SessionManager
                                                            .getString(
                                                            Preferences
                                                                .USER_ID)
                                                        ? HexColor(
                                                        AppColor.FillColor)
                                                        : AppColor.grey_low
                                                        .withOpacity(0.9),
                                                    text: docs[index]["message"]
                                                        .toString(),
                                                    isSender: docs[index]["sender_id"] ==
                                                        SessionManager
                                                            .getString(
                                                            Preferences
                                                                .USER_ID)
                                                        ?
                                                    true
                                                        :
                                                    false,
                                                    textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      color: AppColor
                                                          .black,
                                                      fontStyle: FontStyle
                                                          .normal,
                                                      fontWeight: FontWeight
                                                          .normal,

                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: docs[index]["sender_id"] ==
                                                        SessionManager
                                                            .getString(
                                                            Preferences
                                                                .USER_ID)
                                                        ? MainAxisAlignment
                                                        .end
                                                        : MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Gap(18),
                                                      Utils
                                                          .mediumHeadingNormalText(
                                                          text: "${Utils
                                                              .convertDateTimestamp(
                                                              docs[index]["message_time"])} ${Utils
                                                              .convertTimestamp(
                                                              docs[index]["message_time"])} ",
                                                          fontWeight: FontWeight
                                                              .normal,
                                                          textSize: 9,
                                                          color: AppColor
                                                              .grey),
                                                      SessionManager
                                                          .getString(
                                                          Preferences
                                                              .USER_ID) ==
                                                          docs[index]["sender_id"]
                                                          ? Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .end,
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .end,
                                                        children: [
                                                          docs[index]["read_status"] ==
                                                              true ?
                                                          Image.asset(
                                                            "assets/images/read_true.png",
                                                            height: 14,
                                                            width: 14,) :
                                                          Image.asset(
                                                            "assets/images/read_false.png",
                                                            height: 14,
                                                            width: 14,),
                                                          Gap(22)
                                                        ],
                                                      )
                                                          : Container(),
                                                    ],
                                                  ),
                                                ],
                                              ),

                                            ) : Container();
                                          }),
                                    ) : Center(
                                        child: Utils
                                            .mediumHeadingNormalText(
                                            text: "No Current Chat!",
                                            textSize: 12,
                                            fontWeight: FontWeight
                                                .bold,
                                            color: Colors
                                                .black));
                                  }
                                  return const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColor
                                            .APP_SUBMIT_COLOR,));
                                },
                              ),
                            ),
                            isAdmire == "0" ?
                            Container() :
                            isBlock == false ? Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .center,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment
                                      .end,
                                  children: [
                                    Container(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: 15,
                                                    left: 15,
                                                    top: 0,
                                                    bottom: 2),
                                                height: 60,
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Row(
                                                        children: <
                                                            Widget>[
                                                          const Gap(22),
                                                          GestureDetector(
                                                              onTap: () async {
                                                                setState(() {
                                                                  isGallery=true;
                                                                });

                                                                if(widget.comesFrom == "ProfileStar") {
                                                                  if(isApiHit==false) {
                                                                    setState(() {
                                                                      isLoading = true;
                                                                    });
                                                                    int count = widget
                                                                        .starCount! +
                                                                        1;
                                                                    messagePresenter!
                                                                        .onCreateStar(
                                                                        widget.receiverId.toString(),
                                                                        count
                                                                            .toString());
                                                                  }else{
                                                                    var refrecne = await FirebaseFirestore
                                                                        .instance
                                                                        .collection('chat');
                                                                    // doc(value.docs[0].id.toString(),)
                                                                    var chatId=generateChatId(widget.senderId.toString(),widget.receiverId.toString());
                                                                    var docRefrecne = await refrecne
                                                                        .doc(chatId);
                                                                    await docRefrecne.get()
                                                                        .then((value) {
                                                                      if (value
                                                                          .data()!["recentMessage"]["is_block"] ==
                                                                          false) {
                                                                        if (value
                                                                            .data()!["recentMessage"]["is_report"] ==
                                                                            false) {
                                                                          pickDialog(
                                                                              context,
                                                                              "Upload File",
                                                                              setState, 1);
                                                                        } else {
                                                                          Utils
                                                                              .customDialog(
                                                                              context,
                                                                              message: UtilStrings
                                                                                  .DONOT_PERMISION);
                                                                        }
                                                                      }
                                                                      else {
                                                                        Utils.customDialog(
                                                                            context,
                                                                            message: UtilStrings
                                                                                .DONOT_PERMISION);
                                                                      }
                                                                    });
                                                                  }
                                                                  }
                                                                else{
                                                                  var refrecne = await FirebaseFirestore
                                                                      .instance
                                                                      .collection('chat');
                                                                  // doc(value.docs[0].id.toString(),)
                                                                  var chatId=generateChatId(widget.senderId.toString(),widget.receiverId.toString());
                                                                  var docRefrecne = await refrecne
                                                                      .doc(chatId);
                                                                  await docRefrecne.get()
                                                                      .then((value) {
                                                                    if (value
                                                                        .data()!["recentMessage"]["is_block"] ==
                                                                        false) {
                                                                      if (value
                                                                          .data()!["recentMessage"]["is_report"] ==
                                                                          false) {
                                                                        pickDialog(
                                                                            context,
                                                                            "Upload File",
                                                                            setState, 1);
                                                                      } else {
                                                                        Utils
                                                                            .customDialog(
                                                                            context,
                                                                            message: UtilStrings
                                                                                .DONOT_PERMISION);
                                                                      }
                                                                    }
                                                                    else {
                                                                      Utils.customDialog(
                                                                          context,
                                                                          message: UtilStrings
                                                                              .DONOT_PERMISION);
                                                                    }
                                                                  });
                                                                }
                                                              },
                                                              child: Image
                                                                  .asset(
                                                                'assets/images/gallery.png',
                                                                height: 25,)),
                                                          const Gap(10),
                                                          Expanded(
                                                            child: TextField(
                                                              style: TextStyle(
                                                                color: AppColor
                                                                    .black,
                                                                fontSize: 14,
                                                              ),
                                                              keyboardType: TextInputType
                                                                  .multiline,
                                                              controller: chatController,
                                                              decoration: InputDecoration(
                                                                enabledBorder: const OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: AppColor
                                                                            .DIVIDER_COLOR)
                                                                ),
                                                                focusedBorder: const OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: AppColor
                                                                            .DIVIDER_COLOR)
                                                                ),
                                                                hintText: UtilStrings
                                                                    .Type_message,
                                                                hintStyle: const TextStyle(
                                                                  color: AppColor
                                                                      .APP_TEXT_COLOR_SECOND,
                                                                  fontSize: 14,
                                                                ),
                                                                contentPadding: const EdgeInsets
                                                                    .all(
                                                                    13),
                                                                suffixIcon: SizedBox(
                                                                  width: 100,
                                                                  child: Row(
                                                                    children: [
                                                                      IconButton(
                                                                        onPressed: () {
                                                                          setState(() {
                                                                            isShowSticker =
                                                                            !isShowSticker!;
                                                                          });
                                                                          if (isShowSticker !=
                                                                              false) {
                                                                            FocusScope
                                                                                .of(
                                                                                context)
                                                                                .unfocus();
                                                                          }
                                                                        },
                                                                        icon: Image
                                                                                                         .asset(
                                                                            'assets/images/ic_happy.png',height: 32,width: 32,),
                                                                      ),
                                                                      IconButton(
                                                                        onPressed: () async {
                                                                          if(widget.comesFrom == "ProfileStar") {
                                                                            if(isApiHit==false) {
                                                                              setState(() {
                                                                                isLoading = true;
                                                                              });
                                                                              int count=widget.starCount!+1;
                                                                              messagePresenter!.onCreateStar( widget.receiverId.toString(),count.toString());
                                                                            }else{
                                                                              var refrecne = await FirebaseFirestore
                                                                                  .instance
                                                                                  .collection(
                                                                                  'chat');
                                                                              // doc(value.docs[0].id.toString(),)
                                                                              var chatId=generateChatId(widget.senderId.toString(),widget.receiverId.toString());
                                                                              var docRefrecne = await refrecne
                                                                                  .doc(chatId);
                                                                              await docRefrecne
                                                                                  .get()
                                                                                  .then((
                                                                                  value) {
                                                                                if (value
                                                                                    .data()!["recentMessage"]["is_block"] ==
                                                                                    false) {
                                                                                  if (value
                                                                                      .data()!["recentMessage"]["is_report"] ==
                                                                                      false) {
                                                                                    if (chatController
                                                                                        .text
                                                                                        .toString()
                                                                                        .isNotEmpty) {
                                                                                      if (SessionManager
                                                                                          .getString(
                                                                                          Preferences
                                                                                              .USER_ID) ==
                                                                                          senderIdFirst) {
                                                                                        _authService
                                                                                            .sendMessage(
                                                                                            senderIdFirst,
                                                                                            receiverIdFirst,
                                                                                            senderNameFirst,
                                                                                            receiverNameFirst,
                                                                                            senderImageFirst,
                                                                                            receiverImageFirst,
                                                                                            "",
                                                                                            chatController
                                                                                                .text
                                                                                                .toString(),
                                                                                            0,
                                                                                            "");
                                                                                      } else {
                                                                                        _authService
                                                                                            .sendMessage(
                                                                                            receiverIdFirst,
                                                                                            senderIdFirst,
                                                                                            receiverNameFirst,
                                                                                            senderNameFirst,
                                                                                            receiverImageFirst,
                                                                                            senderImageFirst,
                                                                                            "",
                                                                                            chatController
                                                                                                .text
                                                                                                .toString(),
                                                                                            0,
                                                                                            "");
                                                                                      }
                                                                                      updateActiveTime();
                                                                                      if (isAdmire ==
                                                                                          "2") {
                                                                                        setState(() {
                                                                                          isAdmire =
                                                                                          "0";
                                                                                          // isAdmire = value.data()!["recentMessage"]["is_admire"];
                                                                                        });
                                                                                        _authService
                                                                                            .updateAdmireStatus(
                                                                                            senderIdFirst,
                                                                                            receiverIdFirst,
                                                                                            "0");
                                                                                      }
                                                                                      setState(() {
                                                                                        isShowSticker =
                                                                                        false;
                                                                                      });
                                                                                      chatController
                                                                                          .text =
                                                                                      "";
                                                                                      Utils
                                                                                          .scroll(
                                                                                          controller);
                                                                                    } else {
                                                                                      Utils
                                                                                          .customDialog(
                                                                                          context,
                                                                                          message: UtilStrings
                                                                                              .ENTER_YOUR_MESSAGE);
                                                                                    }
                                                                                  } else {
                                                                                    Utils
                                                                                        .customDialog(
                                                                                        context,
                                                                                        message: UtilStrings
                                                                                            .DONOT_PERMISION);
                                                                                  }
                                                                                }
                                                                                else {
                                                                                  Utils
                                                                                      .customDialog(
                                                                                      context,
                                                                                      message: UtilStrings
                                                                                          .DONOT_PERMISION);
                                                                                }
                                                                              });
                                                                             }}
                                                                          else{
                                                                          /*if (SessionManager
                                                                              .getString(
                                                                              Preferences
                                                                                  .subscription_status) ==
                                                                              "true") {*/
                                                                            var refrecne = await FirebaseFirestore
                                                                                .instance
                                                                                .collection(
                                                                                'chat');
                                                                            // doc(value.docs[0].id.toString(),)
                                                                            var chatId=generateChatId(widget.senderId.toString(),widget.receiverId.toString());
                                                                            var docRefrecne = await refrecne
                                                                                .doc(chatId);
                                                                            await docRefrecne
                                                                                .get()
                                                                                .then((
                                                                                value) {
                                                                              if (value
                                                                                  .data()!["recentMessage"]["is_block"] ==
                                                                                  false) {
                                                                                if (value
                                                                                    .data()!["recentMessage"]["is_report"] ==
                                                                                    false) {
                                                                                  if (chatController
                                                                                      .text
                                                                                      .toString()
                                                                                      .isNotEmpty) {
                                                                                    if (SessionManager
                                                                                        .getString(
                                                                                        Preferences
                                                                                            .USER_ID) ==
                                                                                        senderIdFirst) {
                                                                                      _authService
                                                                                          .sendMessage(
                                                                                          senderIdFirst,
                                                                                          receiverIdFirst,
                                                                                          senderNameFirst,
                                                                                          receiverNameFirst,
                                                                                          senderImageFirst,
                                                                                          receiverImageFirst,
                                                                                          "",
                                                                                          chatController
                                                                                              .text
                                                                                              .toString(),
                                                                                          0,
                                                                                          "");
                                                                                    } else {
                                                                                      _authService
                                                                                          .sendMessage(
                                                                                          receiverIdFirst,
                                                                                          senderIdFirst,
                                                                                          receiverNameFirst,
                                                                                          senderNameFirst,
                                                                                          receiverImageFirst,
                                                                                          senderImageFirst,
                                                                                          "",
                                                                                          chatController
                                                                                              .text
                                                                                              .toString(),
                                                                                          0,
                                                                                          "");
                                                                                    }
                                                                                    updateActiveTime();
                                                                                    if (isAdmire ==
                                                                                        "2") {
                                                                                      setState(() {
                                                                                        isAdmire =
                                                                                        "0";
                                                                                        // isAdmire = value.data()!["recentMessage"]["is_admire"];
                                                                                      });
                                                                                      _authService
                                                                                          .updateAdmireStatus(
                                                                                          senderIdFirst,
                                                                                          receiverIdFirst,
                                                                                          "0");
                                                                                    }
                                                                                    setState(() {
                                                                                      isShowSticker =
                                                                                      false;
                                                                                    });
                                                                                    chatController
                                                                                        .text =
                                                                                    "";
                                                                                    Utils
                                                                                        .scroll(
                                                                                        controller);
                                                                                  } else {
                                                                                    Utils
                                                                                        .customDialog(
                                                                                        context,
                                                                                        message: UtilStrings
                                                                                            .ENTER_YOUR_MESSAGE);
                                                                                  }
                                                                                } else {
                                                                                  Utils
                                                                                      .customDialog(
                                                                                      context,
                                                                                      message: UtilStrings
                                                                                          .DONOT_PERMISION);
                                                                                }
                                                                              }
                                                                              else {
                                                                                Utils
                                                                                    .customDialog(
                                                                                    context,
                                                                                    message: UtilStrings
                                                                                        .DONOT_PERMISION);
                                                                              }
                                                                            });
                                                                         /* }
                                                                          else {
                                                                            // Utils.customDialog(context,message: "");
                                                                          }*/}
                                                                        },
                                                                        icon: Image
                                                                            .asset(
                                                                            'assets/images/ic_send.png',height: 32,width: 32,),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              onTap: () {
                                                                if (isShowSticker !=
                                                                    false) {
                                                                  setState(() {
                                                                    isShowSticker =
                                                                    !isShowSticker!;
                                                                  });
                                                                }
                                                              },

                                                            ),
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Offstage(
                                                offstage: !isShowSticker!,
                                                child: SizedBox(
                                                  height: 250,
                                                  child: EmojiPicker(
                                                    /* onEmojiSelected: (Category category, Emoji emoji) {
                                                              _onEmojiSelected(emoji);
                                                            },*/
                                                    onBackspacePressed: onBackPress,
                                                    textEditingController: chatController,
                                                    config: Config(
                                                      columns: 8,
                                                      verticalSpacing: 0,
                                                      horizontalSpacing: 0,
                                                      gridPadding: EdgeInsets
                                                          .zero,
                                                      initCategory: Category
                                                          .RECENT,
                                                      bgColor: Colors
                                                          .white,
                                                      indicatorColor: Theme
                                                          .of(context)
                                                          .primaryColor,
                                                      iconColor: Colors
                                                          .grey,
                                                      iconColorSelected: Theme
                                                          .of(context)
                                                          .primaryColor,
                                                      backspaceColor: Theme
                                                          .of(context)
                                                          .primaryColor,
                                                      skinToneDialogBgColor: Colors
                                                          .white,
                                                      skinToneIndicatorColor: Colors
                                                          .grey,
                                                      enableSkinTones: true,
                                                      //showRecentsTab: true,
                                                      recentsLimit: 32,
                                                      noRecents: const Text(
                                                        'Pas d\'émojis récents',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors
                                                                .black26),
                                                        textAlign: TextAlign
                                                            .center,
                                                      ),
                                                      tabIndicatorAnimDuration: kTabScrollDuration,
                                                      categoryIcons: const CategoryIcons(),
                                                      buttonMode: ButtonMode
                                                          .MATERIAL,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                              ],
                            ) : Container(),
                          ],
                        ),
                      )):
                  Utils.progressDialogFullScreen(context, true),
                  Utils.progressDialog(context, isLoading)
                ]
            )),
      ),
    );
  }

  showAlertDialog(BuildContext context, title, description, int userID, type) {
    //1=Block 2=Delete 3=Hide
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          actions: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(width: 1.0, color: Colors.black26)),
              // margin: const EdgeInsets.only(left: 20,right: 20),
              width: Responsive().getResponsiveValue(
                  forLargeScreen: MediaQuery
                      .of(context)
                      .size
                      .width / 3.8,
                  forShortScreen: MediaQuery
                      .of(context)
                      .size
                      .width,
                  forMobLandScapeMode: MediaQuery
                      .of(context)
                      .size
                      .width,
                  forMediumScreen: MediaQuery
                      .of(context)
                      .size
                      .width,
                  forTabletScreen: MediaQuery
                      .of(context)
                      .size
                      .width / 2.2,
                  context: context),
              height: Responsive().getResponsiveValue(
                  forLargeScreen: MediaQuery
                      .of(context)
                      .size
                      .height / 4,
                  forShortScreen: MediaQuery
                      .of(context)
                      .size
                      .height / 4.2,
                  forMobLandScapeMode: MediaQuery
                      .of(context)
                      .size
                      .height / 4,
                  forMediumScreen: MediaQuery
                      .of(context)
                      .size
                      .height / 4.2,
                  forTabletScreen: MediaQuery
                      .of(context)
                      .size
                      .height / 4,
                  context: context),
              child: Wrap(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 10.0),
                    child: Center(
                      child: Utils.mediumHeadingNormalText(
                          text: title,
                          textSize: 16,
                          fontWeight: FontWeight.bold,
                          color: HexColor("#242424")),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  /* Container(
                    alignment: Alignment.center,
                      width:  Responsive().getResponsiveValue(
                          forLargeScreen: MediaQuery.of(context).size.width/4.5,
                          forShortScreen: MediaQuery.of(context).size.width/1.6,
                          forTabletScreen: MediaQuery.of(context).size.width/1.6,
                          forMediumScreen:  MediaQuery.of(context).size.width/1.6,
                          context: context),
                      child:*/
                  Center(
                    child: Utils.mediumHeadingNormalText(
                        text: description,
                        textSize: 12,
                        fontWeight: FontWeight.normal,
                        color: HexColor("#7B7F91"),
                        textAlign: TextAlign.center),
                    // )
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 120,
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(top: 30.0, bottom: 20),
                              decoration: BoxDecoration(
                                color: HexColor("#F0F0F0"),
                                borderRadius: BorderRadius.circular(
                                    8), /*
                                border: Border.all(color: HexColor("#FF483C"))*/
                              ),
                              child: Text(
                                "Cancel",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black),
                              ),
                            )),
                        SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (type == 1) {
                              setState(() {
                                isLoading = true;
                                isBlock = true;
                                if (senderIdFirst == SessionManager.getString(
                                    Preferences.USER_ID)) {
                                  settingPresenter?.doBlockPost(
                                      receiverIdFirst.toString(), true);
                                } else {
                                  settingPresenter?.doBlockPost(
                                      senderIdFirst.toString(), true);
                                }
                              });
                            }
                            else if (type == 2) {
                              setState(() {
                                isLoading = true;
                                isBlock = false;
                                if (senderIdFirst == SessionManager.getString(
                                    Preferences.USER_ID)) {
                                  settingPresenter?.doBlockPost(
                                      receiverIdFirst.toString(), true);
                                } else {
                                  settingPresenter?.doBlockPost(
                                      senderIdFirst.toString(), true);
                                }
                              });
                            } else if (type == 3) {
                              setState(() {
                                if (senderIdFirst == SessionManager.getString(
                                    Preferences.USER_ID)) {
                                  _authService.deleteChat(
                                      senderIdFirst, receiverIdFirst);
                                } else {
                                  _authService.deleteChat(
                                      receiverIdFirst, senderIdFirst);
                                }
                              });
                            } else if (type == 4) {
                              setState(() {
                                isReport = true;
                                if (senderIdFirst == SessionManager.getString(
                                    Preferences.USER_ID)) {
                                  settingPresenter!.doReportUser(
                                      receiverIdFirst.toString());
                                } else {
                                  settingPresenter!.doReportUser(
                                      senderIdFirst.toString());
                                }
                              });
                            }
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 120,
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.only(top: 30.0, bottom: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: HexColor("#FF483C"),
                            ),
                            child: Text(
                              "Yes",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  var uploadUrl = "";
  PlatformFile? importFile;
  String fileName = "null";
  String fileType = "null";
  int typeMessage = 0;
  PickedFile? pickImage;
  final _imagePicker = ImagePicker();

  Future fromFrontImage(int type, BuildContext context, StateSetter setState,
      int chooseType) async {
    //Check Permissions
    if (chooseType == 1) {
      if (type == 1) {
        pickImage = await _imagePicker.getImage(
            source: ImageSource.gallery, imageQuality: 40);
      } else {
        pickImage = await _imagePicker.getImage(
            source: ImageSource.camera, imageQuality: 40);
      }
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child(
          "images/" + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(File(pickImage!.path));
      uploadTask.then((res) {
        res.ref.getDownloadURL().then((url) {
          setState(() {
            uploadUrl = url;
            typeMessage = 1;
          });

          if (SessionManager.getString(Preferences.USER_ID) == senderIdFirst) {
            _authService
                .sendMessage(
                senderIdFirst,
                receiverIdFirst,
                senderNameFirst,
                receiverNameFirst,
                senderImageFirst,
                receiverImageFirst,
                uploadUrl,
                chatController.text.toString(),
                1,
                uploadUrl);
          } else {
            _authService
                .sendMessage(
                receiverIdFirst,
                senderIdFirst,
                receiverNameFirst,
                senderNameFirst,
                receiverImageFirst,
                senderImageFirst,
                uploadUrl,
                chatController.text.toString(),
                1,
                uploadUrl);
          }
          updateActiveTime();
          if (isAdmire == "2") {
            setState(() {
              isAdmire = "0";
              // isAdmire = value.data()!["recentMessage"]["is_admire"];
            });
            _authService
                .updateAdmireStatus(senderIdFirst,
                receiverIdFirst,
                "0");
          }
        });
      });
    } else {
      if (type == 1) {
        pickImage = await _imagePicker.getVideo(source: ImageSource.gallery);
      } else {
        pickImage = await _imagePicker.getVideo(source: ImageSource.camera);
      }
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child(
          "videos/" + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(
          File(pickImage!.path), SettableMetadata(contentType: 'video/mp4'));
      uploadTask.then((res) {
        res.ref.getDownloadURL().then((url) {
          setState(() {
            uploadUrl = url;
            typeMessage = 1;
          });

          if (SessionManager.getString(Preferences.USER_ID) == senderIdFirst) {
            _authService
                .sendMessage(
                senderIdFirst,
                receiverIdFirst,
                senderNameFirst,
                receiverNameFirst,
                senderImageFirst,
                receiverImageFirst,
                uploadUrl,
                chatController.text.toString(),
                2,
                uploadUrl);
          } else {
            _authService
                .sendMessage(
                receiverIdFirst,
                senderIdFirst,
                receiverNameFirst,
                senderNameFirst,
                receiverImageFirst,
                senderImageFirst,
                uploadUrl,
                chatController.text.toString(),
                2,
                uploadUrl);
          }
          updateActiveTime();
          if (isAdmire == "2") {
            setState(() {
              isAdmire = "0";
              // isAdmire = value.data()!["recentMessage"]["is_admire"];
            });
            _authService
                .updateAdmireStatus(senderIdFirst,
                receiverIdFirst,
                "0");
          }
        });
      });
    }
  }

  pickDialog(BuildContext context, String title, StateSetter setState,
      int type) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            backgroundColor: Colors.white,
            child: Container(
              margin: EdgeInsets.only(
                  right: MediaQuery
                      .of(context)
                      .size
                      .height / 100 * 2,
                  left: MediaQuery
                      .of(context)
                      .size
                      .height / 100 * 2),
              width: 300.0,
              height: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: MediaQuery
                          .of(context)
                          .size
                          .height / 100 * 4,
                    ),
                    child: Row(
                      children: [
                        /*  Container(
                          margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.height / 100 * 2,
                          ),
                          child: Image.asset(
                            "assets/images/uploadimageicon.png",
                            height:
                            MediaQuery.of(context).size.height / 100 * 4,
                          ),
                        ),*/
                        Text(
                          "Upload File",
                          style: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          showPhotoDialogForMobile(
                              context, title, setState, 1, 1);
                        },
                        child: Container(
                          padding: EdgeInsets.all(
                            MediaQuery
                                .of(context)
                                .size
                                .height / 100 * 1.5,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(color: AppColor.checkboxicon,
                                width: 1),
                            color: AppColor.dialogbgcolor,
                            borderRadius: BorderRadius.all(new Radius.circular(
                                10.0)),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.image,
                                size: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 100 * 12,),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Upload Image",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "Poppins",
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          showPhotoDialogForMobile(
                              context, title, setState, 2, 2);
                        },
                        child: Container(
                          padding: EdgeInsets.all(
                            MediaQuery
                                .of(context)
                                .size
                                .height / 100 * 1.5,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: AppColor.dialogbgcolor,
                            border: Border.all(color: AppColor.checkboxicon,
                                width: 1),
                            borderRadius:
                            new BorderRadius.all(new Radius.circular(10.0)),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.video_collection_rounded,
                                size: MediaQuery
                                    .of(context)
                                    .size
                                    .width /
                                    100 *
                                    12,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Upload Video",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "Poppins",
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery
                            .of(context)
                            .size
                            .height / 100 * 5,
                        left: MediaQuery
                            .of(context)
                            .size
                            .width / 100 * 5,
                        right: MediaQuery
                            .of(context)
                            .size
                            .width / 100 * 5,
                      ),
                      alignment: Alignment.center,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 100 * 6,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 100 * 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(MediaQuery
                                  .of(context)
                                  .size
                                  .height / 100 * 5,
                              )),
                          border: Border.all(color: Colors.black, width: 1)
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          );
        });
  }

  showPhotoDialogForMobile(BuildContext context, String title,
      StateSetter setState, int type, int chooseType) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            backgroundColor: Colors.white,
            child: Container(
              margin: EdgeInsets.only(
                  right: MediaQuery
                      .of(context)
                      .size
                      .height / 100 * 2,
                  left: MediaQuery
                      .of(context)
                      .size
                      .height / 100 * 2),
              width: 300.0,
              height: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: MediaQuery
                          .of(context)
                          .size
                          .height / 100 * 4,
                    ),
                    child: Row(
                      children: [
                        /*  Container(
                          margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.height / 100 * 2,
                          ),
                          child: Image.asset(
                            "assets/images/uploadimageicon.png",
                            height:
                            MediaQuery.of(context).size.height / 100 * 4,
                          ),
                        ),*/
                        Text(
                          title,
                          style: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          //captureImage(ImageSource.camera);
                          fromFrontImage(2, context, setState, chooseType);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.all(
                            MediaQuery
                                .of(context)
                                .size
                                .height / 100 * 1.5,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(color: AppColor.checkboxicon,
                                width: 1),
                            color: AppColor.dialogbgcolor,
                            borderRadius: BorderRadius.all(new Radius.circular(
                                10.0)),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.camera_alt_outlined,
                                size: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 100 * 12,),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  UtilStrings.From_Camera,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "Poppins",
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          fromFrontImage(1, context, setState, chooseType);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.all(
                            MediaQuery
                                .of(context)
                                .size
                                .height / 100 * 1.5,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: AppColor.dialogbgcolor,
                            border: Border.all(color: AppColor.checkboxicon,
                                width: 1),
                            borderRadius:
                            new BorderRadius.all(new Radius.circular(10.0)),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.folder_copy_outlined,
                                size: MediaQuery
                                    .of(context)
                                    .size
                                    .width /
                                    100 *
                                    12,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  UtilStrings.From_Gallery,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "Poppins",
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery
                            .of(context)
                            .size
                            .height / 100 * 5,
                        left: MediaQuery
                            .of(context)
                            .size
                            .width / 100 * 5,
                        right: MediaQuery
                            .of(context)
                            .size
                            .width / 100 * 5,
                      ),
                      alignment: Alignment.center,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 100 * 6,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 100 * 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(MediaQuery
                                  .of(context)
                                  .size
                                  .height / 100 * 5,
                              )),
                          border: Border.all(color: Colors.black, width: 1)
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          );
        });
  }

  ZegoSendCallInvitationButton actionButton(bool isVideo, String id,
      String name) =>
      ZegoSendCallInvitationButton(
        iconSize: Size(32, 32),
        verticalLayout: false,
        buttonSize: Size(32, 32),
        icon: ButtonIcon(
            icon: Icon(Icons.videocam, size: 22, color: Colors.white,),
            backgroundColor: HexColor(AppColor.bgFemaleColor)),
        isVideoCall: isVideo,
        resourceID: "zegouikit_call",
        invitees: [
          ZegoUIKitUser(
            id: id,
            name: name,
          ),
        ],
      );
  List<int> list = [];

  ZegoSendCallInvitationButton actionButtonAudio(bool isVideo, String id,
      String name) =>
      ZegoSendCallInvitationButton(
        iconSize: Size(32, 32),
        /*    onPressed:(code,  message, list){
          print("message==>");
          print("message==>"+message.toString());
          print("code==>"+code.toString());
          print("list==>"+list.toString());
      },*/
        icon: ButtonIcon(icon: Icon(Icons.call, size: 22, color: Colors.white),
            backgroundColor:
            HexColor(AppColor.bgFemaleColor)),
        isVideoCall: isVideo,
        buttonSize: Size(32, 32),
        verticalLayout: false,
        resourceID: "zegouikit_call",
        invitees: [
          ZegoUIKitUser(
            id: id,
            name: name,
          ),
        ],
      );

  @override
  onBlockList(BlockResponse response) {

  }

  @override
  onBlockPost(SuccessResponse response) {
    setState(() {
      isLoading = false;
    });
    if (senderIdFirst == SessionManager.getString(Preferences.USER_ID)) {
      _authService.updateBlockStatus(senderIdFirst, receiverIdFirst, true);
    } else {
      _authService.updateBlockStatus(receiverIdFirst, senderIdFirst, true);
    }
  }


  @override
  onCancelSubscription(CancelSubscriptionResponse response) {

  }

  @override
  onChangePWD(SuccessResponse response) {

  }

  @override
  onDeleteAccount(SuccessResponse response) {

  }

  @override
  onError(String msg, int status) {
    // print("onError===>>>"+msg);
    setState(() {
      isLoading = false;
    });
  }

  @override
  onProfileResponse(UserProfileResponse response) {
    setState(() {
      otherSubscriptionStatus = response.data!.subscriptionStatus!;
      otherSubscriptionPlan = response.data!.subscriptions!.isNotEmpty ?
      response.data!.subscriptions![0].supscriptionType.toString() : "";
    });
    var refrecne = FirebaseFirestore.instance.collection('chat');
    // doc(value.docs[0].id.toString(),)
    var chatId=generateChatId(widget.senderId.toString(),widget.receiverId.toString());
    var docRefrecne = refrecne.doc(chatId);
    docRefrecne.get().then((value) {
      setState(() {
        if (value.data()!["recentMessage"]["is_block"] == true) {
          checkValue = false;
        } else if (value.data()!["recentMessage"]["is_report"] == true) {
          checkValue = false;
        } else {
          checkValue = true;
        }
      });
    });
  }

  @override
  onReportResponse(SuccessResponse response) {
    setState(() {
      isLoading = false;
    });
    if (senderIdFirst == SessionManager.getString(Preferences.USER_ID)) {
      _authService.updateReportStatus(senderIdFirst, receiverIdFirst, true);
    } else {
      _authService.updateReportStatus(receiverIdFirst, senderIdFirst, true);
    }
    Navigator.pushNamed(context, RouteName.feed_screen);
  }

  @override
  onRequestError(String msg, int status) {
    setState(() {
      isLoading = false;
    });
  }

  @override
  onSendRequest(SuccessResponse response) async {
    setState(() {
      isLoading = false;
    });
    if (response.status == 200) {
      var chatId=generateChatId(admireSender.toString(),admirereciver.toString());
      final query = await FirebaseFirestore.instance.collection('chat').doc(chatId).collection("messages")
          .where('read_status', isEqualTo: false).get();
      query.docs.forEach((doc) {
        doc.reference.update({'read_status': true}).then((value) {})
            .catchError((error) {
          print('Error updating read field: $error');
        });
      });
      await _authService.updateAdmireStatus(
          senderIdFirst, receiverIdFirst, "1");
      // getIsAdmireValue();
      setState(() {
        if (admireDocLength == 1) {
          isAdmire = "1";
        }
      });
    }
  }

  @override
  onSendRemoveRequest(SuccessResponse response) {
    setState(() {
      isLoading = false;
    });
    _authService.delelteUser(senderIdFirst, receiverIdFirst);
    SessionManager.setString(Preferences.INDEX, "0");
    Navigator.pushNamed(context, RouteName.feed_screen);
  }

  Future<void> updateActiveTime() async {
    var chatId=generateChatId(senderIdFirst.toString(),receiverIdFirst.toString());
    final resultRecent = await FirebaseFirestore.instance
        .collection('chat').doc(chatId);
    if(SessionManager.getString(Preferences.USER_ID)==senderIdFirst){
      await resultRecent.update({
        "recentMessage.sender_active_time":DateTime.now().millisecondsSinceEpoch,
      });
    }else{
      await resultRecent.update({
        "recentMessage.receiver_active_time":DateTime.now().millisecondsSinceEpoch,
      });
    }
  }

  @override
  onSuccessCreateStar(CreateStarResponse response) async {
    if (response.status == 200) {
      setState(() {
        isLoading = false;
      });
      /* if (SessionManager
          .getString(
          Preferences
              .subscription_status) ==
          "true") {*/
      if(isGallery==true){
        setState(() {
          isApiHit=true;
        });
        var refrecne = await FirebaseFirestore
            .instance
            .collection('chat');
        // doc(value.docs[0].id.toString(),)
        var chatId=generateChatId(widget.senderId.toString(),widget.receiverId.toString());
        var docRefrecne = await refrecne
            .doc(chatId);
        await docRefrecne.get()
            .then((value) {
          if (value
              .data()!["recentMessage"]["is_block"] ==
              false) {
            if (value
                .data()!["recentMessage"]["is_report"] ==
                false) {
              pickDialog(
                  context,
                  "Upload File",
                  setState, 1);
            } else {
              Utils
                  .customDialog(
                  context,
                  message: UtilStrings
                      .DONOT_PERMISION);
            }
          }
          else {
            Utils.customDialog(
                context,
                message: UtilStrings
                    .DONOT_PERMISION);
          }
        });
      }

      else{
        setState(() {
          isApiHit=true;
        });
        var refrecne = await FirebaseFirestore.instance.collection('chat');
        // doc(value.docs[0].id.toString(),)
        var chatId = generateChatId(
            widget.senderId.toString(), widget.receiverId.toString());
        var docRefrecne = await refrecne
            .doc(chatId);
        await docRefrecne
            .get()
            .then((value) {
          if (value
              .data()!["recentMessage"]["is_block"] ==
              false) {
            if (value
                .data()!["recentMessage"]["is_report"] ==
                false) {
              if (chatController
                  .text
                  .toString()
                  .isNotEmpty) {
                if (SessionManager
                    .getString(
                    Preferences
                        .USER_ID) ==
                    senderIdFirst) {
                  _authService
                      .sendMessage(
                      senderIdFirst,
                      receiverIdFirst,
                      senderNameFirst,
                      receiverNameFirst,
                      senderImageFirst,
                      receiverImageFirst,
                      "",
                      chatController
                          .text
                          .toString(),
                      0,
                      "");
                } else {
                  _authService
                      .sendMessage(
                      receiverIdFirst,
                      senderIdFirst,
                      receiverNameFirst,
                      senderNameFirst,
                      receiverImageFirst,
                      senderImageFirst,
                      "",
                      chatController
                          .text
                          .toString(),
                      0,
                      "");
                }
                updateActiveTime();
                if (isAdmire ==
                    "2") {
                  setState(() {
                    isAdmire =
                    "0";
                    // isAdmire = value.data()!["recentMessage"]["is_admire"];
                  });
                  _authService
                      .updateAdmireStatus(
                      senderIdFirst,
                      receiverIdFirst,
                      "0");
                }
                setState(() {
                  isShowSticker =
                  false;
                });
                chatController
                    .text =
                "";
                Utils
                    .scroll(
                    controller);
              } else {
                Utils
                    .customDialog(
                    context,
                    message: UtilStrings
                        .ENTER_YOUR_MESSAGE);
              }
            } else {
              Utils
                  .customDialog(
                  context,
                  message: UtilStrings
                      .DONOT_PERMISION);
            }
          }
          else {
            Utils
                .customDialog(
                context,
                message: UtilStrings
                    .DONOT_PERMISION);
          }
        });

      }

      /* else {
        // Utils.customDialog(context,message: "");
      }*/
    }
  }

  @override
  onSuccessGetStar(GetStarResponse response) {

  }

  @override
  onSuccessUpdateStar(SuccessResponse response) {
 setState(() {
   isLoading=false;
 });
  }

}

PopupMenuItem _buildPopupMenuItem(String title, String imageUrl, Function onTap) {
  return PopupMenuItem(
    onTap: (){
      onTap()!;
    },
    child:Row(
      children: [
        Utils.imageView(image: "assets/images/"+imageUrl,height: 20,width: 20),
        Gap(2),
        Utils.mediumHeadingNormalText(text:title,textSize: 12,fontWeight: FontWeight.normal,color: Colors.black),
      ],
    ),);
}