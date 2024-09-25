// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/module/model/admiring_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import 'package:likeplay/utils/constant_lists.dart';
import 'package:likeplay/utils/sharedpref/preferences.dart';
import 'package:likeplay/utils/sharedpref/shared_prefrence.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/responsive.dart';
import '../../utils/firebase/authentication_service.dart';
import '../../utils/firebase/firebase_exceptions.dart';
import '../../utils/string_utils.dart';
import '../../utils/utils.dart';
import '../message/mobile_message/message_view_mobile.dart';
import '../model/admirers_response.dart';
import 'admire_presenter.dart';

class AdmiringViewScreen extends StatefulWidget {

  @override
  State<AdmiringViewScreen> createState() => _AdmiringViewScreenState();
}

class _AdmiringViewScreenState extends State<AdmiringViewScreen> implements AdmireInterface {
  DateTime ?dateTime;
  bool isLoading=false;
  int selectIndex=0;
  TextEditingController matchController = TextEditingController();
  AdmirePresenter? admirePresenter;
  List<AdmiringData> admiringList=[];
  final _authService = AuthenticationService();
  bool isShowText=true;
  @override
  void initState() {
    super.initState();
    admirePresenter=AdmirePresenter(this);
    setState(() {
      isLoading=true;
      admirePresenter?.onAdmiringData("");
    });
  }
 /* searchData(String keyword){
    if(keyword.isNotEmpty){
      admirePresenter?.onAdmiringData(keyword);
    }else{
      admirePresenter?.onAdmiringData("");
    }
  }*/
  void searchData(String value) {
    List<AdmiringData> results = [];
    if (value.isEmpty) {
      admirePresenter?.onAdmiringData("");
    } else {
      results = admiringList.where((user) {
        final title = user .admireTo!
            .name.toString().toLowerCase();
        final desc = user .admireTo!.country!.toLowerCase(); // added
        final searchLower = value.toLowerCase();
        return title.contains(searchLower) ||
            desc.contains(searchLower); //changed
      }).toList();
    }
    setState(() {
      admiringList = results;
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      /*width: size.width,
      height: size.height,*/
      color: Colors.white,
      child: Stack(
        children: [
          Container(
            width: Responsive().getResponsiveValue(
                forLargeScreen: MediaQuery
                    .of(context)
                    .size
                    .width,
                context: context),
            child:  Column(
              children: [
                Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        //Utils.
                        Expanded(
                            child: Container(
                              height: 46,
                              decoration: BoxDecoration(
                                color: const Color
                                    .fromRGBO(
                                    250, 245, 241, 1),
                                borderRadius: BorderRadius
                                    .circular(10),
                              ),
                              child: Stack(
                                children: [
                                  isShowText==true?  Container(
                                    margin: EdgeInsets.only(top: 12,left: 18),
                                    child: Row(
                                      children: [
                                        Utils.mediumHeadingNormalText(text:"Admiring",
                                            textSize: 10,fontWeight:
                                            FontWeight.w300,color: HexColor(AppColor.SIDE_TEXT_COLOR)),
                                        Container(
                                          width:Responsive().getResponsiveValue(
                                              forLargeScreen:  MediaQuery.of(context).size.width,
                                              forShortScreen:  MediaQuery.of(context).size.width/1.8,
                                              forMobLandScapeMode: MediaQuery.of(context).size.width/1.8,
                                              forMediumScreen: MediaQuery.of(context).size.width/1.8,
                                              forTabletScreen: MediaQuery.of(context).size.width/1.8,
                                              context: context),
                                          child: Utils.mediumHeadingNormalText(text: UtilStrings
                                              .Admiring_whey_de_enter,overflow: TextOverflow.ellipsis,
                                              textSize: 10,fontWeight:
                                              FontWeight.w300,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.left),
                                        ),
                                      ],
                                    ),
                                  ):Container(),
                                  TextField(
                                    onTap: (){
                                      /*setState(() {
                                           isShowText=false;
                                         });*/
                                    },
                                    onChanged: (value){
                                      setState(() {
                                        isShowText=false;
                                      });
                                      searchData(value);
                                    },
                                    style: TextStyle(
                                      color: AppColor.black,
                                      fontSize: 12,
                                    ),
                                    cursorColor: HexColor(AppColor.SIDE_TEXT_COLOR),
                                    decoration: InputDecoration(
                                        border: InputBorder
                                            .none,
                                        /* hintText: UtilStrings
                                                        .Admiring_whey_de_enter,
                                                    hintStyle: TextStyle(
                                                      color: AppColor
                                                          .black,
                                                      fontSize: 12,
                                                    ),*/
                                        contentPadding: EdgeInsets
                                            .all(13),
                                        suffixIcon: Icon(Icons
                                            .search_outlined,
                                          color: Colors
                                              .black,)
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                        Gap(12),
                      ],
                    )),
                Container(
                  color: Colors.grey,
                  height: 1,
                ),
                const Gap(16),
                Stack(children: [
                  Column(children: [
                    admiringList!=null?  admiringList.isNotEmpty ? Container(
                      padding: EdgeInsets.all(10),
                      height:
                      Responsive().getResponsiveValue(
                          forLargeScreen:
                          MediaQuery.of(context).size
                              .height,
                          forShortScreen:
                          MediaQuery
                              .of(context)
                              .size
                              .height/1.5,
                          forTabletScreen:
                          MediaQuery
                              .of(context)
                              .size
                              .height/1.5,
                          forMediumScreen:
                          MediaQuery
                              .of(context)
                              .size
                              .height/1.3,
                          context: context),
                      child: ResponsiveGridList(
                        maxItemsPerRow: Responsive()
                            .getResponsiveValue(
                            forLargeScreen: 4,
                            forShortScreen: 2,
                            forMobLandScapeMode: 2,
                            forMediumScreen: 2,
                            forTabletScreen: 2,
                            context: context),
                        minItemWidth: Responsive()
                            .getResponsiveValue(
                            forLargeScreen: 160.0,
                            forShortScreen: 160.0,
                            forMobLandScapeMode: 160.0,
                            forMediumScreen: 160.0,
                            forTabletScreen: 160.0,
                            context: context),
                        children: List.generate(
                          admiringList.length,
                              (index) =>
                              Padding(
                                padding: const EdgeInsets
                                    .only(left: 8.0),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius
                                              .circular(
                                              12),
                                          child: CachedNetworkImage(
                                            imageUrl: admiringList[index]
                                                .admireTo!
                                                .userImagesWhileSignup!
                                                .isNotEmpty
                                                ? IMAGE_URL +
                                                admiringList[index]
                                                    .admireTo!
                                                    .userImagesWhileSignup![0]
                                                    .imageUrl.toString()
                                                : "",
                                            imageBuilder: (
                                                context,
                                                imageProvider) =>
                                                Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius
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
                                            placeholder: (
                                                context,
                                                url) =>
                                            const Image(
                                                image: AssetImage(
                                                    "assets/images/icon_loading.png")),
                                            errorWidget: (
                                                context,
                                                url,
                                                error) =>
                                            const Image(
                                                image: AssetImage(
                                                    "assets/images/icon_loading.png")),
                                            width: 155,
                                            height: 110,
                                          ),),
                                        const Gap(12),
                                        Utils
                                            .mediumHeadingNormalText(
                                            text: admiringList[index]
                                                .admireTo!
                                                .name
                                                .toString() ==
                                                "null"
                                                ? "NA"
                                                : admiringList[index]
                                                .admireTo!
                                                .name
                                                .toString(),
                                            textSize: 12,
                                            fontWeight: FontWeight
                                                .bold,
                                            color: AppColor
                                                .APP_TEXT_COLOR),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: [
                                            Utils
                                                .mediumHeadingNormalText(
                                                text: admiringList[index]
                                                    .admireTo!
                                                    .age
                                                    .toString() ==
                                                    "null"
                                                    ? "NA"
                                                    : admiringList[index]
                                                    .admireTo!
                                                    .age
                                                    .toString(),
                                                textSize: 8,
                                                color: AppColor
                                                    .APP_TEXT_COLOR_SECOND),
                                            Gap(2),
                                            Container(
                                              height: 3,
                                              width: 3,
                                              margin: EdgeInsets.only(top: 4),
                                              decoration: BoxDecoration(
                                                color: AppColor.APP_TEXT_COLOR_SECOND,
                                                borderRadius: BorderRadius.circular(100),
                                              ),
                                            ),
                                            Gap(2),
                                            Utils
                                                .mediumHeadingNormalText(
                                                text: admiringList[index]
                                                    .admireTo!
                                                    .country
                                                    .toString() ==
                                                    "null"
                                                    ? "NA"
                                                    : admiringList[index]
                                                    .admireTo!
                                                    .country
                                                    .toString(),
                                                textSize: 8,
                                                fontWeight: FontWeight
                                                    .w400,
                                                color: AppColor
                                                    .APP_TEXT_COLOR_SECOND),
                                            Utils.customBlackDot(),
                                            Container(
                                                alignment:Alignment.topLeft,
                                                width: Responsive()
                                                    .getResponsiveValue(
                                                    forLargeScreen: 60.0,
                                                    forShortScreen: 64.0,
                                                    forMobLandScapeMode: 0.0,
                                                    forMediumScreen: 64.0,
                                                    forTabletScreen: 64.0,
                                                    context: context),
                                                child: Utils
                                                    .mediumHeadingNormalText(
                                                    text: admiringList[index]
                                                        .admireTo!
                                                        .employment
                                                        .toString() ==
                                                        "null"
                                                        ? "NA"
                                                        : admiringList[index]
                                                        .admireTo!
                                                        .employment
                                                        .toString(),
                                                    textSize: 8,
                                                    fontWeight: FontWeight
                                                        .w400,
                                                    color: AppColor
                                                        .APP_TEXT_COLOR_SECOND,
                                                    overflow: TextOverflow
                                                        .ellipsis)),
                                          ],
                                        ),
                                        const Gap(10),
                                        admiringList[index].status.toString()=="2"?
                                        GestureDetector(onTap: () async {
                                          /*  if(SessionManager.getString(Preferences.subscription_plan)=="0" ||
                                                              SessionManager.getString(Preferences.subscription_plan)=="1" ||
                                                              SessionManager.getString(Preferences.subscription_plan)=="2" ||
                                                              SessionManager.getString(Preferences.subscription_plan)=="3"
                                                          ){*/
                                          /*  subscriptionStatus: admiringList[index].admireTo!.subscriptionStatus.toString(),
                                                          subscriptionPlan:admiringList[index].admireTo!.subscriptions!.isNotEmpty?
                                                          admiringList[index].admireTo!.subscriptions![0].supscriptionType.toString():"",*/
                                          if(SessionManager.getString(Preferences.subscription_status)=="true"
                                          ){
                                            SessionManager.setString(Preferences.IS_MESSAGE, "");
                                            //Chat view
                                            final _status = await _authService.createChatUser(
                                              senderId:SessionManager.getString(Preferences.USER_ID),
                                              receiverId: admiringList[index].admireTo!.id.toString(),
                                              senderName: SessionManager.getString(Preferences.USER_NAME),
                                              receiverName: admiringList[index].admireTo!.name.toString(),
                                              receiverImage:  admiringList[index].admireTo!.userImagesWhileSignup!.isNotEmpty?IMAGE_URL+admiringList[index].admireTo!.userImagesWhileSignup![0].imageUrl.toString():"",
                                              senderImage: IMAGE_URL+ SessionManager.getString(Preferences.PROFILE_IMAGE),
                                              admrireStatus: "1",
                                              subscriptionStatus: admiringList[index].admireTo!.subscriptionStatus.toString(),
                                              subscriptionPlan:admiringList[index].admireTo!.subscriptions!.isNotEmpty?
                                              admiringList[index].admireTo!.subscriptions![0].supscriptionType.toString():"",
                                            );
                                            if (_status == AuthStatus.successful) {
                                              // SessionManager.setString(Preferences.INDEX,"4");
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => MessageMobileViewScreen(
                                                        senderId:SessionManager.getString(Preferences.USER_ID),
                                                        receiverId: admiringList[index].admireTo!.id.toString(),
                                                        senderName: SessionManager.getString(Preferences.USER_NAME),
                                                        receiverName: admiringList[index].admireTo!.name.toString(),
                                                        receiverImage: admiringList[index].admireTo!.userImagesWhileSignup!.isNotEmpty?admiringList[index].admireTo!.userImagesWhileSignup![0].imageUrl.toString():"",
                                                        senderImage: SessionManager.getString(Preferences.PROFILE_IMAGE),
                                                      )));
                                            }

                                          }else{
                                            // Utils.customDialog("Please subscribe plan for enable this feature");
                                          }
                                        },child:Container(
                                          height: 28,
                                          width: 150,
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
                                              Image.asset(
                                                  "assets/images/admire_messages.png",
                                                  height: 16,
                                                  width: 16,  color:SessionManager.getString(Preferences.subscription_status)=="false"? AppColor.grey:null),
                                              const Gap(
                                                  5),
                                              Utils.mediumHeadingNormalText(
                                                  text: UtilStrings.Chat,
                                                  textSize: 12,
                                                  fontWeight: FontWeight
                                                      .bold,
                                                  color: SessionManager.getString(Preferences.subscription_status)=="false"?
                                                  AppColor.grey:AppColor.black,
                                                  overflow: TextOverflow
                                                      .ellipsis),
                                              Spacer(),
                                              SessionManager.getString(Preferences.subscription_plan)=="3" ?
                                              admiringList[index].admireTo!.subscriptions!.isNotEmpty?
                                              admiringList[index].admireTo!.subscriptions![0].supscriptionType.toString()=="3"?
                                              GestureDetector(
                                                onTap: () {

                                                },
                                                child: Theme(
                                                  data: Theme
                                                      .of(
                                                      context)
                                                      .copyWith(
                                                      cardColor: Colors
                                                          .white
                                                  ),
                                                  child: PopupMenuButton(

                                                      shape: const RoundedRectangleBorder(
                                                        borderRadius: BorderRadius
                                                            .all(
                                                          Radius
                                                              .circular(
                                                              15.0),
                                                        ),
                                                      ),
                                                      child: const Icon(
                                                          Icons
                                                              .keyboard_arrow_down,
                                                          size: 20,
                                                          color: Colors
                                                              .black),
                                                      itemBuilder: (
                                                          ctx) =>
                                                      [
                                                        _buildPopupMenuItem(
                                                            admiringList[index].admireTo!.id.toString(),  admiringList[index].admireTo!.name.toString(),"Voice call",false,() {
                                                          /*  if(SessionManager.getString(Preferences.subscription_plan)=="0" ||
                                                                                SessionManager.getString(Preferences.subscription_plan)=="1" ||
                                                                                ){
                                                                              Utils.customDialog("Please subscribe gold orplatinum plan");
                                                                            }*/
                                                          setState(() {});

                                                        }),
                                                      ]),
                                                ),

                                              ):Container():Container():
                                              SessionManager.getString(Preferences.subscription_plan)=="3" || SessionManager.getString(Preferences.subscription_plan)=="4"?
                                              admiringList[index].admireTo!.subscriptions!.isNotEmpty?
                                              admiringList[index].admireTo!.subscriptions![0].supscriptionType.toString()=="3" || admiringList[index].admireTo!.subscriptions![0].supscriptionType.toString()=="4"?
                                              GestureDetector(
                                                onTap: () {

                                                },
                                                child: Theme(
                                                  data: Theme
                                                      .of(
                                                      context)
                                                      .copyWith(
                                                      cardColor: Colors
                                                          .white
                                                  ),
                                                  child: PopupMenuButton(

                                                      shape: const RoundedRectangleBorder(
                                                        borderRadius: BorderRadius
                                                            .all(
                                                          Radius
                                                              .circular(
                                                              15.0),
                                                        ),
                                                      ),
                                                      child: const Icon(
                                                          Icons
                                                              .keyboard_arrow_down,
                                                          size: 20,
                                                          color: Colors
                                                              .black),
                                                      itemBuilder: (
                                                          ctx) =>
                                                      [
                                                        _buildPopupMenuItem(
                                                            admiringList[index].admireTo!.id.toString(),  admiringList[index].admireTo!.name.toString(),"Video call", true,() {
                                                          /*  if(SessionManager.getString(Preferences.subscription_plan)=="0" ||
                                                                                SessionManager.getString(Preferences.subscription_plan)=="1" ||
                                                                                ){
                                                                              Utils.customDialog("Please subscribe gold orplatinum plan");
                                                                            }*/
                                                          setState(() {});
                                                        }),
                                                        _buildPopupMenuItem(
                                                            admiringList[index].admireTo!.id.toString(),  admiringList[index].admireTo!.name.toString(),"Voice call",false,() {
                                                          /*if(SessionManager.getString(Preferences.subscription_plan)=="0" ||
                                                                              SessionManager.getString(Preferences.subscription_plan)=="1" ||
                                                                              SessionManager.getString(Preferences.subscription_plan)=="2"){
                                                                            Utils.customDialog("Please subscribe platinum plan");
                                                                          }*/
                                                          setState(() {});
                                                        }),
                                                      ]),
                                                ),

                                              ):Container():Container():Container(),
                                              const Gap(
                                                  6),
                                            ],
                                          ),
                                        ))
                                            :
                                        GestureDetector(onTap: (){
                                        }, child:Container(
                                          height: 28,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: HexColor('#F2F2F2')
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Utils.mediumHeadingNormalText(text:UtilStrings.Pending,textSize: 12,fontWeight:  FontWeight.bold,color: AppColor.black,overflow: TextOverflow.ellipsis),
                                            ],
                                          ),
                                        ),),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets
                                          .only(left: 4.0,
                                          top: 12),
                                      child: Container(
                                        height: 16,
                                        width: 32,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius
                                              .circular(
                                              20),
                                          color: HexColor(
                                              '#FF483C'),
                                        ),
                                        child: Center(
                                          child:
                                          Utils
                                              .mediumHeadingNormalText(
                                              text: UtilStrings
                                                  .New,
                                              textSize: 10,
                                              fontWeight: FontWeight
                                                  .w400,
                                              color: Colors
                                                  .white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                        ),
                      ),
                    ) :
                    Container(height: Responsive().getResponsiveValue(
                        forLargeScreen: MediaQuery.of(context).size.height,
                        forShortScreen: MediaQuery.of(context).size.height/1.8,
                        forMobLandScapeMode: MediaQuery.of(context).size.height,
                        forMediumScreen: MediaQuery.of(context).size.height/1.8,
                        forTabletScreen:MediaQuery.of(context).size.height,context:
                    context),
                      alignment: Alignment.center,
                      child: Utils
                          .mediumHeadingNormalText(
                          text: isLoading ==
                              false
                              ? UtilStrings
                              .NO_RECORD
                              : "",
                          textSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColor.black,
                          textAlign: TextAlign.end),
                    ): Container(height:Responsive().getResponsiveValue(
                        forLargeScreen: MediaQuery.of(context).size.height,
                        forShortScreen: MediaQuery.of(context).size.height/1.8,
                        forMobLandScapeMode: MediaQuery.of(context).size.height,
                        forMediumScreen: MediaQuery.of(context).size.height/1.8,
                        forTabletScreen:MediaQuery.of(context).size.height,context:
                    context),
                      alignment: Alignment.center,
                      child: Utils
                          .mediumHeadingNormalText(
                          text: isLoading ==
                              false
                              ? UtilStrings
                              .NO_RECORD
                              : "",
                          textSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColor.black,
                          textAlign: TextAlign.end),
                    )
                  ],),
                ],)
              ],
            ),
          ),
          Utils.progressDialog(context, isLoading, type: 3)
        ],
      ),
    );
  }

  @override
  onAdmirers(AdmirersResponse response) {
  }

  @override
  onAdmiring(AdmiringDataResponse response) {
    setState(() {
      isLoading=false;
      admiringList.clear();
      if(response.status==200){
        admiringList.addAll(response.data!);
      }
    });
  }

  @override
  onError(String msg, int status) {
    print("onError======>"+msg.toString());
    setState(() {
      isLoading=false;
    });
    if(status==401){
      Utils.sessionExpire(context);
    }
    else if(status==404){
      Utils.sessionExpire(context);
    }
  }

  @override
  onSendRequest(SuccessResponse response) {
  }

}

PopupMenuItem _buildPopupMenuItem(String id,String name,String title,bool status ,Function onTap) {
  return PopupMenuItem(

    onTap: (){
      onTap()!;
    },
    child:Container(width: 60.0, height: 60,child: actionButton(status,id,name,title)),
  );
}
ZegoSendCallInvitationButton actionButton(bool isVideo,String id,String name,String title) =>
    ZegoSendCallInvitationButton(
      text: title,
      verticalLayout: false,
      textStyle: TextStyle(fontSize: 12,color: Colors.black),
      iconSize: Size(12, 12),
      buttonSize: Size(22, 22),
        icon: ButtonIcon(icon:
        Icon(isVideo==true?Icons.videocam:Icons.call,size: 10,color: Colors.white,),backgroundColor: HexColor(AppColor.bgFemaleColor)
        ),
      isVideoCall: isVideo,
      resourceID: "zegouikit_call",
      invitees: [
        ZegoUIKitUser(
          id: id,
          name:name,
        ),
      ],
    );
