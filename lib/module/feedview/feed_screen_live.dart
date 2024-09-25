import 'dart:io';
import 'dart:math';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:likeplay/module/feedview/dialog/comment_dialog_screen.dart';
import 'package:likeplay/module/feedview/dialog/like_dialog_screen.dart';
import 'package:likeplay/module/feedview/dialog/tags_dialog_screen.dart';
import 'package:likeplay/module/model/alluser_tag_response.dart';
import 'package:likeplay/module/model/create-comment_response.dart';
import 'package:likeplay/module/model/create_star_response.dart';
import 'package:likeplay/module/model/get_star_response.dart';
import 'package:likeplay/module/model/like_users_response.dart';
import 'package:likeplay/module/model/postTag_users_response.dart';
import 'package:likeplay/module/model/post_comment_users_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import 'package:likeplay/module/model/user_profile_response.dart';
import 'package:likeplay/utils/constant_lists.dart';
import 'package:likeplay/utils/route/route_name.dart';
import 'package:likeplay/utils/sharedpref/preferences.dart';
import 'package:likeplay/utils/sharedpref/shared_prefrence.dart';
import 'package:likeplay/widget/common/commontextfield_registerscreen.dart';
import 'package:need_resume/need_resume.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../../../utils/color_utils.dart';
import '../../../utils/responsive.dart';
import '../../utils/custom_scroll_behavior.dart';
import '../../utils/firebase/authentication_service.dart';
import '../../utils/information_guideline.dart';
import '../../utils/string_utils.dart';
import '../../utils/utils.dart';
import '../../utils/view_video/video_player_screen.dart';
import '../../widget/common/video_player.dart';
import '../message/mobile_message/message_presenter.dart';
import '../model/all_post_response.dart';
import '../model/comment_model.dart';
import '../model/text_bool.dart';
import '../model/user_model.dart';
import '../profile/profile_screen.dart';
import '../sidemenu/web_side_menu.dart';
import 'feed_presenter.dart';

class FeedLiveScreen extends StatefulWidget {
  const FeedLiveScreen({Key? key}) : super(key: key);

  @override
  State<FeedLiveScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ResumableState<FeedLiveScreen> implements FeedInterface,MessageInterface {
  DateTime? dateTime;
  bool isLoading = false;
  bool isLoadingPop = false;
  int selectIndex = 0;
  TextEditingController reportController = TextEditingController();
  TextEditingController takefloorController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  ScrollController _mycontroller1 = new ScrollController();
  ScrollController _mycontroller2 = new ScrollController();
  FeedPresenter? feedPresenter;
  List<AllPostData> allPosts = [];
  static List<AllUsers> allTagUsers = [];
  PlatformFile? importFile;
  String fileName = "null";
  String fileType = "null";
  var postMediaUrl="";
  static String photoName = "";
  File? postImage;
  static List<int>? file;
  int editType = 0;
  var imageName;
  String resaon = "";
  bool? isShowSticker;
  List<AllPostData> allPostsTemp=[];
  //final List <UserModel>postTagUsers=[];
/*  final List <UserModel>postLikeUsers=[];*/
  final List<CommentModel> postCommentUsers = [];
  int postType = 0;
  String postID = "";
  String userName = "";
  String postDate = "";
  String senderId   = "";
  String receiverId = "";
  String userProfile = "";
  static List<int> tagUserIds = [];
  static List<String> tempUserName = [];
  static List<TextBool> checkBoxValue = [];
  static List<TextBool> checkBoxValueTemp = [];
  final List <UserModel> postTagUsers=[];
  static List<TextBool> userList = [];
  final int _limit = 10;
  MessagePresenter? messagePresenter;

  final _authService = AuthenticationService();

  void onResume() {
    feedPresenter?.doAllPostResponseData(currentPage.toString(),_limit.toString());
  }
  int currentPage = 1;
  int totalPages = 1;
  @override
  void initState() {
    super.initState();
    FlutterAppBadger.removeBadge();
    feedPresenter = FeedPresenter(this);
    messagePresenter=MessagePresenter(this);

    setState(() {
      isShowSticker = false;
      resaon = reportList[0].name;
      isLoading = true;
      Utils.onUserLogin(SessionManager.getString(Preferences.USER_ID),SessionManager.getString(Preferences.USER_NAME));
      feedPresenter?.doAllPostResponseData(currentPage.toString(),_limit.toString());
      // fetchData();
      feedPresenter?.doUserResponseData("");
      feedPresenter?.doAllUsers();
     /* _firstLoad();
      _controller = ScrollController()..addListener(_loadMore);*/
    });
  }
  Future<void> fetchData() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    // Simulating API request with a delay
    await Future.delayed(Duration(seconds: 2));
    // print("doAllPostResponseData===========>"+allPostsTemp.length.toString());
    feedPresenter?.doAllPostResponseData(currentPage.toString(),_limit.toString());
  }
/*  bool _onNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        notification.metrics.pixels >=
            notification.metrics.maxScrollExtent - 200) {
      // if(currentPage>1){
      fetchData();
      // }
    }
    return true;
  }*/
  void _searchingData(String value,StateSetter setState) {
    List<TextBool> results = [];
    if (value.isEmpty) {
      setState(() {
        results=checkBoxValue;
      });
    } else {
      results = checkBoxValueTemp.where((user) {
        final title = user.text!.toLowerCase();// added
        final searchLower = value.toLowerCase();
        return title.contains(searchLower); //changed
      }).toList();
    }
    setState(() {
      checkBoxValueTemp = results;
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return /*kIsWeb?*/ AppSideMenu(
      pageTitle: UtilStrings.Home,
      screenType: 1,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _mycontroller1,
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              /*width: size.width,
              height: size.height,*/
              color: Colors.white,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ResponsiveRowColumn(
                        rowMainAxisAlignment: MainAxisAlignment.start,
                        rowCrossAxisAlignment: CrossAxisAlignment.start,
                        layout: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                            ? ResponsiveRowColumnType.COLUMN
                            : ResponsiveRowColumnType.ROW,
                        children: [
                          ResponsiveRowColumnItem(
                            rowFlex: 2,
                            child: Column(
                              children: [
                                /* Container(
                              margin: EdgeInsets.only(right: 12),
                              child:*/ /*Card(
                                  color: HexColor("#FFFFFF"),
                                  elevation: 8.0,
                                  child:*/
                                Container(
                                  decoration: Responsive().getResponsiveValue(
                                      forLargeScreen: const BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                                  width: 1.0,
                                                  color: Colors.black26),
                                              left: BorderSide(
                                                  width: 1.0,
                                                  color: Colors.black26))),
                                      context: context),
                                  width: Responsive().getResponsiveValue(
                                      forLargeScreen:
                                      MediaQuery.of(context).size.width,
                                      context: context),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ResponsiveRowColumn(
                                        rowMainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        rowCrossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        layout: ResponsiveWrapper.of(context)
                                            .isSmallerThan(DESKTOP)
                                            ? ResponsiveRowColumnType.COLUMN
                                            : ResponsiveRowColumnType.ROW,
                                        children: [
                                          ResponsiveRowColumnItem(
                                              rowFlex: 2,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                            padding:
                                                            EdgeInsets.all(Responsive().getResponsiveValue(
                                                                forLargeScreen:  20.0,
                                                                forMediumScreen: 12.0,
                                                                forMobLandScapeMode: 12.0,
                                                                forShortScreen:12.0,
                                                                forTabletScreen: 12.0,
                                                                context: context)),
                                                            margin: EdgeInsets.only(left:10),
                                                            child: Row(
                                                              children: [
                                                                //Utils.
                                                                Expanded(
                                                                    child: Container(
                                                                       height: 80,
                                                                      decoration: BoxDecoration(
                                                                        color:const Color.fromRGBO(250, 245, 241, 1),
                                                                        borderRadius: BorderRadius.circular(10),
                                                                      ),
                                                                      child:Stack(
                                                                        children: [
                                                                          Center(
                                                                            child: Container(
                                                                              // margin: EdgeInsets.only(top: 1,left: 40),
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  /* Utils.mediumHeadingNormalText(text:"ShowRoom", textAlign:  TextAlign.start,
                                                                                    textSize: 16,fontWeight:
                                                                                      FontWeight.bold,color: HexColor(AppColor.SIDE_TEXT_COLOR),),*/
                                                                                Utils
                                                                                      .imageView(
                                                                                    image: "assets/images/SHOWROOM.png",
                                                                                  width: 160,height:45),
                                                                                  Gap(6),
                                                                                  Text(
                                                                                    UtilStrings.Take_the_Floor_Pick_the_Mic,
                                                                                    textAlign:  TextAlign.start,
                                                                                    style: TextStyle(height: 0.5,
                                                                                      decoration: TextDecoration.none,
                                                                                      color:AppColor.APP_TEXT_COLOR_SECOND,
                                                                                      fontWeight: FontWeight.w400,
                                                                                      fontSize: 12,
                                                                                      fontFamily: 'Poppins',
                                                                                    ),
                                                                                  ),
                                                                                  /* Utils.mediumHeadingNormalText(text:UtilStrings.Take_the_Floor_Pick_the_Mic,
                                                                                      textSize: 10,fontWeight:
                                                                                      FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND),*/
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          TextField(
                                                                            onTap: (){
                                                                              if( SessionManager.getString(Preferences.subscription_status)=="false"){
                                                                                Utils.showAlertSubscriptionDialog(context);
                                                                              }else{
                                                                                setState(() {
                                                                                  postType = 0;
                                                                                  editType = 0;
                                                                                  tempUserName.clear();
                                                                                  userList.clear();
                                                                                  tagUserIds.clear();
                                                                                  takefloorController.clear();
                                                                                  for (int i = 0; i < checkBoxValue.length; i++) {
                                                                                    if(checkBoxValue[i].value==true) {
                                                                                      setState(() {
                                                                                        checkBoxValue[i].value=false;
                                                                                      });

                                                                                    }
                                                                                  }
                                                                                });
                                                                                showPostFeedDialog(
                                                                                    context,
                                                                                    takefloorController,
                                                                                    "",
                                                                                    "",tempUserName,tagUserIds);}
                                                                            },
                                                                            onChanged: (value){
                                                                              /*setState(() {
                                                                                isShowText=false;
                                                                              });
                                                                              searchData(value);*/
                                                                            },
                                                                            style: TextStyle(
                                                                              color:AppColor.black,
                                                                              fontSize: 12,

                                                                            ),
                                                                            cursorColor: HexColor(AppColor.SIDE_TEXT_COLOR),
                                                                            readOnly:true,
                                                                            decoration: InputDecoration(
                                                                              border: InputBorder.none,
                                                                              contentPadding:EdgeInsets.all(13),
                                                                              // suffixIcon: Icon(Icons.search_outlined,color: Colors.black,)
                                                                           prefixIcon:
                                                                              Padding(
                                                                                padding:
                                                                                EdgeInsets.only(top:26,left:6.0),
                                                                                child: Image
                                                                                    .asset(
                                                                                  "assets/images/icon_mic.png",
                                                                                  height:
                                                                                  22,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                ),
                                                                const Gap(11),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    if( SessionManager.getString(Preferences.subscription_status)=="false"){
                                                                      Utils.showAlertSubscriptionDialog(context);
                                                                    }else{
                                                                      setState(() {
                                                                        postType = 0;
                                                                        editType = 0;
                                                                        tempUserName.clear();
                                                                        userList.clear();
                                                                        tagUserIds.clear();
                                                                        takefloorController.clear();
                                                                        for (int i = 0; i < checkBoxValue.length; i++) {
                                                                          if(checkBoxValue[i].value==true) {
                                                                            setState(() {
                                                                              checkBoxValue[i].value=false;
                                                                            });
                                                                          }
                                                                        }
                                                                      });
                                                                      showPostFeedDialog(
                                                                          context,
                                                                          takefloorController,
                                                                          "",
                                                                          "",tempUserName,tagUserIds);
                                                                    }
                                                                  },
                                                                  child:
                                                                  Image.asset(
                                                                    "assets/images/icon_post.png",
                                                                    height: 42,
                                                                    width: 42,
                                                                  ),
                                                                ),
                                                                const Gap(4),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    showDialog(
                                                                      context: context,
                                                                      barrierDismissible: true,
                                                                      builder: (BuildContext context) {
                                                                        return GuildelinesInfo();
                                                                      },
                                                                    );
                                                                  },
                                                                  child:
                                                                  Image.asset(
                                                                    "assets/images/icon_information.png",
                                                                    height: 25,
                                                                  ),
                                                                ),
                                                                const Gap(12),
                                                              ],
                                                            )),
                                                        /*Container(
                                                          color: Colors.grey,
                                                          height: 1,
                                                        ),*/
                                                        const Gap(16),
                                                        if (allPosts.isNotEmpty) Container(padding:
                                                        EdgeInsets.only(right: Responsive().getResponsiveValue(
                                                            forLargeScreen:  20.0,
                                                            forMediumScreen: 12.0,
                                                            forMobLandScapeMode: 12.0,
                                                            forShortScreen:12.0,
                                                            forTabletScreen: 12.0,
                                                            context: context),left:Responsive().getResponsiveValue(
                                                            forLargeScreen:  20.0,
                                                            forMediumScreen: 12.0,
                                                            forMobLandScapeMode: 12.0,
                                                            forShortScreen:12.0,
                                                            forTabletScreen: 12.0,
                                                            context: context),bottom:Responsive().getResponsiveValue(
                                                            forLargeScreen:  20.0,
                                                            forMediumScreen: 200.0,
                                                            forMobLandScapeMode: 60.0,
                                                            forShortScreen:200.0,
                                                            forTabletScreen: 120.0,
                                                            context: context)),
                                                          height:
                                                          MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height,
                                                          child: ListView
                                                              .builder(
                                                            shrinkWrap: true,
                                                            controller: _mycontroller2,
                                                            padding:
                                                            const EdgeInsets.only(right: 10,left:10,bottom:10),
                                                            itemCount:allPosts.length,
                                                            itemBuilder:
                                                                (BuildContext
                                                            context,
                                                                int index) {
                                                              return Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                        42,
                                                                        child:
                                                                        Row(
                                                                          children: [
                                                                            GestureDetector(
                                                                              onTap: (){
                                                                                if(allPosts[index].user!.isAdmin==false){
                                                                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileScreen(
                                                                                      userId:   allPosts[index].userId.toString()
                                                                                  )));
                                                                                }else{

                                                                                }
                                                                              },
                                                                              child:   SizedBox(
                                                                                height: 42,
                                                                                width: 42,
                                                                                child: ClipOval(
                                                                                  child: CachedNetworkImage(
                                                                                    imageUrl: allPosts[index].user!.userImagesWhileSignup!.isNotEmpty ? IMAGE_URL + allPosts[index].user!.userImagesWhileSignup![0].imageUrl.toString() : "",
                                                                                    imageBuilder:
                                                                                        (context, imageProvider) =>
                                                                                        Container(
                                                                                            decoration:
                                                                                            BoxDecoration(
                                                                                              borderRadius:
                                                                                              const BorderRadius.all(
                                                                                                  Radius.circular(8)),
                                                                                              image: DecorationImage(
                                                                                                image: imageProvider,
                                                                                                fit: BoxFit.fill,

                                                                                              ),
                                                                                            )),
                                                                                    placeholder: (context, url) =>
                                                                                    const Image(
                                                                                        image: AssetImage(
                                                                                            "assets/images/icon_loading.png")),
                                                                                    errorWidget: (context, url,
                                                                                        error) =>
                                                                                    const Image(
                                                                                        image: AssetImage(
                                                                                            "assets/images/icon_loading.png")),
                                                                                    width: 32,
                                                                                    height: 32,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      const Gap(
                                                                          10),
                                                                      Expanded(
                                                                        child:
                                                                        Column(
                                                                          children: [
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Utils.mediumHeadingNormalText(text: allPosts[index].user!.name.toString(), textSize: 14, fontWeight: FontWeight.normal, color: AppColor.APP_TEXT_COLOR),
                                                                                GestureDetector(
                                                                                  onTap: () {},
                                                                                  child: Theme(
                                                                                    data: Theme.of(context).copyWith(cardColor: Colors.white),
                                                                                    child: SessionManager.getString(Preferences.USER_ID) == allPosts[index]!.userId.toString()
                                                                                        ? PopupMenuButton(
                                                                                        shape: const RoundedRectangleBorder(
                                                                                          borderRadius: BorderRadius.all(
                                                                                            Radius.circular(15.0),
                                                                                          ),
                                                                                        ),
                                                                                        child: Image.asset(
                                                                                          "assets/images/feed_more.png",
                                                                                          height: 22,
                                                                                          width: 22,
                                                                                        ),
                                                                                        itemBuilder: (ctx) => [
                                                                                          _buildPopupMenuItem(UtilStrings.Edit, () async {
                                                                                            setState(() {
                                                                                              tempUserName.clear();
                                                                                              tagUserIds.clear();
                                                                                              postType = 1;
                                                                                              editType = 1;
                                                                                              takefloorController.text =allPosts[index].caption.toString()=="null"?"": allPosts[index].caption.toString();
                                                                                              postID = allPosts[index].postContents![0].postId!.toString();
                                                                                              postMediaUrl=allPosts[index].postContents![0].mediaUrl!.toString();
                                                                                            });
                                                                                            getTagUsers(allPosts[index].postContents![0].postId!);

                                                                                            /* showPostFeedDialog(context, takefloorController,
                                                                                                              allPosts[index]!.postContents![0].mediaUrl!.toString(),
                                                                                                              allPosts[index]!.postContents![0].postId!.toString(),
                                                                                                              tempUserName);*/
                                                                                          }),
                                                                                          _buildPopupMenuItem(UtilStrings.Delete, () {
                                                                                            setState(() {});
                                                                                            showAlertDialog(context, "Delete Shot", "Are you sure you want to Delete this Shot?", allPosts[index]!.postContents![0].postId!.toInt(), 2);
                                                                                          }),
                                                                                          _buildPopupMenuItem(UtilStrings.Hide_Shot, () {
                                                                                            setState(() {
                                                                                              //filterType=2;
                                                                                            });
                                                                                            showAlertDialog(context, "Hide Shot", "Are you sure you want to Hide this Shot?", allPosts[index]!.postContents![0].postId!.toInt(), 3);
                                                                                          }),
                                                                                        ]):
                                                                                    allPosts[index].user!.isAdmin==false?
                                                                                    PopupMenuButton(
                                                                                        shape: const RoundedRectangleBorder(
                                                                                          borderRadius: BorderRadius.all(
                                                                                            Radius.circular(15.0),
                                                                                          ),
                                                                                        ),
                                                                                        child: Image.asset(
                                                                                          "assets/images/feed_more.png",
                                                                                          height: 22,
                                                                                          width: 22,
                                                                                        ),
                                                                                        itemBuilder: (ctx) => [
                                                                                          _buildPopupMenuItem(UtilStrings.Block, () {
                                                                                            setState(() {
                                                                                              senderId=SessionManager.getString(Preferences.USER_ID);
                                                                                              receiverId= allPosts[index]!.userId.toString();
                                                                                            });
                                                                                            showAlertDialog(context, "Block User", "Are you sure you want to block user?", allPosts[index].userId!, 1);
                                                                                          }),
                                                                                          _buildPopupMenuItem(UtilStrings.Report, () {
                                                                                            setState(() {
                                                                                              postID = allPosts[index]!.postContents![0].postId!.toString();
                                                                                             /* senderId=SessionManager.getString(Preferences.USER_ID);
                                                                                              receiverId= allPosts[index]!.userId.toString();*/
                                                                                            });
                                                                                            showReportDialog(context, reportController, allPosts[index]!.postContents![0].postId!.toInt(), allPosts[index]!.userId!);
                                                                                          }),
                                                                                        ]):Container(),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            const Gap(4),
                                                                            Row(
                                                                              children: [
                                                                                Utils.mediumHeadingNormalText(text: allPosts[index].postContents!.isNotEmpty?
                                                                                Utils.convertDate(allPosts[index].postContents![0].createdAt.toString() ):"", textSize: 10, fontWeight: FontWeight.normal, color: HexColor("#7B7F91")),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  const Gap(
                                                                      5),
                                                                  Utils.mediumHeadingNormalText(
                                                                      text: allPosts[index]
                                                                          .caption,
                                                                      textSize:
                                                                      12,
                                                                      color: AppColor
                                                                          .APP_TEXT_COLOR,
                                                                      textAlign:
                                                                      TextAlign.start),
                                                                  const Gap(20),
                                                                  /*CachedNetworkImage(
                                                          imageUrl:allPosts[index].postContents!.isNotEmpty?IMAGE_URL+allPosts[index].postContents![0].contentType.toString():"",
                                                          imageBuilder: (context, imageProvider) => Container(
                                                               height: 50,
                                                              decoration: BoxDecoration(
                                                                borderRadius: const BorderRadius.all(Radius.circular(0)),
                                                                image: DecorationImage(
                                                                  image:imageProvider,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              )),
                                                          placeholder: (context, url) =>  const Image(image: AssetImage("assets/images/icon_loading.png")),
                                                          errorWidget: (context, url, error) =>   const Image(image: AssetImage("assets/images/icon_loading.png")),
                                                        )*/
                                                                  // Image.network(IMAGE_URL+allPosts[index].postContents![0].mediaUrl.toString()),
                                                                  allPosts[index].postContents![0].mediaUrl.toString().contains(".mp4") || allPosts[index].postContents![0].mediaUrl.toString().contains(".mov")?
                                                                  Container(
                                                                    height:Responsive().getResponsiveValue(
                                                                        forLargeScreen:  size.height / 1.8,
                                                                        forMediumScreen: size.height /2,
                                                                        forMobLandScapeMode: size.height / 1.6,
                                                                        forShortScreen: size.height / 2,
                                                                        forTabletScreen: size.height / 1.6,
                                                                        context: context),
                                                                    width: size
                                                                        .width,
                                                                    child:  VideoPlayerApp(
                                                                      IMAGE_URL + allPosts[index].postContents![0].mediaUrl.toString(),'',
                                                                    ),
                                                                  )
                                                                      :
                                                                  GestureDetector(
                                                                    onTap: (){
                                                                      Utils.viewPhoto(context, IMAGE_URL + allPosts[index].postContents![0].mediaUrl.toString());
                                                                    },
                                                                    child: Container(
                                                                      height:Responsive().getResponsiveValue(
                                                                          forLargeScreen:  size.height / 1.4,
                                                                          forMediumScreen: size.height / 2,
                                                                          forMobLandScapeMode: size.height / 1.8,
                                                                          forShortScreen: size.height / 2,
                                                                          forTabletScreen: size.height / 1.8,
                                                                          context: context),
                                                                      width: size
                                                                          .width,
                                                                      decoration: BoxDecoration(
                                                                          image: DecorationImage(
                                                                            image: NetworkImage(IMAGE_URL + allPosts[index].postContents![0].mediaUrl.toString()),
                                                                            fit: Responsive().getResponsiveValue(
                                                                                forLargeScreen: BoxFit.fill,
                                                                                forShortScreen:  BoxFit.fill,
                                                                                forMobLandScapeMode: BoxFit.fill,
                                                                                forMediumScreen: BoxFit.fill,
                                                                                forTabletScreen:BoxFit.fill,
                                                                                context: context),)),
                                                                    ),
                                                                    /*    Image(
                                                                           image: NetworkImage(IMAGE_URL + allPosts[index].postContents![0].mediaUrl.toString()),
                                                                           fit: BoxFit.contain, // set the fit property to contain
                                                                           filterQuality: FilterQuality.high, // set the filter quality to high
                                                                           // filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0), // apply a blur filter
                                                                         ),*/
                                                                  ),
                                                                  // ),
                                                                  const Gap(
                                                                      10),
                                                                  // allPosts[index].user!.isAdmin==false?
                                                                  Row(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                        33,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                          borderRadius:
                                                                          BorderRadius.circular(10),
                                                                          color: const Color.fromRGBO(
                                                                              247,
                                                                              247,
                                                                              247,
                                                                              1),
                                                                        ),
                                                                        child:
                                                                        Container(
                                                                          padding:
                                                                          EdgeInsets.only(top: 4, bottom: 4),
                                                                          height:
                                                                          56,
                                                                          child:
                                                                          Row(
                                                                            children: [
                                                                              Gap(4),
                                                                              GestureDetector(
                                                                                behavior: HitTestBehavior.translucent,
                                                                                onTap: () {
                                                                                  /*if(SessionManager.getString(Preferences.subscription_plan)=="0" ||
                                                                                            SessionManager.getString(Preferences.subscription_plan)=="1" ||
                                                                                            SessionManager.getString(Preferences.subscription_plan)=="2"){}*/
                                                                                  setState(() {
                                                                                    if(allPosts[index].currentUserLikeByHeart=="1"){
                                                                                      allPosts[index].currentUserLikeByHeart="0";
                                                                                      feedPresenter?.doLikePost(allPosts[index]!.id.toString(), false, "1");
                                                                                    }else{
                                                                                      allPosts[index].currentUserLikeByHeart="1";
                                                                                      allPosts[index].currentUserLikeByThumb="0";
                                                                                      allPosts[index].currentUserLikeByStar="0";
                                                                                      feedPresenter?.doLikePost(allPosts[index]!.id.toString(), true, "1");
                                                                                    }
                                                                                  });
                                                                                },
                                                                                child: allPosts[index].currentUserLikeByHeart == "0"
                                                                                    ? const Image(
                                                                                  image: AssetImage("assets/images/icon_likes.png"),
                                                                                  height: 14,
                                                                                  width: 14,
                                                                                )
                                                                                    : const Image(
                                                                                  image: AssetImage("assets/images/feed_unlikes.png"),
                                                                                  height: 14,
                                                                                  width: 14,
                                                                                ),
                                                                              ),
                                                                              GestureDetector(
                                                                                  behavior: HitTestBehavior.translucent,
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      userName = allPosts[index]!.user!.name.toString();
                                                                                      postDate = allPosts[index]!.user!.createdAt.toString();
                                                                                      postID =allPosts[index]!.postContents![0].postId!.toString();;
                                                                                      userProfile = allPosts[index]!.user!.userImagesWhileSignup!.isNotEmpty ? allPosts[index]!.user!.userImagesWhileSignup![0].imageUrl.toString() : "";
                                                                                    });
                                                                                    if (allPosts[index].totalLikeByHeart.toString() == "0") {
                                                                                    } else {
                                                                                      getLikePost(allPosts[index]!.postContents![0].postId!.toInt(),"1");
                                                                                    }
                                                                                  },
                                                                                  child: Utils.mediumHeadingNormalText(text: " ${allPosts[index].totalLikeByHeart}", textSize: 10, color: HexColor("#7B7F91"))),
                                                                              VerticalDivider(
                                                                                color: HexColor("#E2E2E2"),
                                                                                thickness: 1,
                                                                              ),
                                                                              GestureDetector(
                                                                                behavior: HitTestBehavior.translucent,
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    if(allPosts[index].currentUserLikeByThumb=="1"){
                                                                                      allPosts[index].currentUserLikeByThumb="0";
                                                                                      feedPresenter?.doLikePost(allPosts[index]!.id.toString(), false, "0");
                                                                                    }else{
                                                                                      allPosts[index].currentUserLikeByThumb="1";
                                                                                      allPosts[index].currentUserLikeByHeart="0";
                                                                                      allPosts[index].currentUserLikeByStar="0";
                                                                                      feedPresenter?.doLikePost(allPosts[index]!.id.toString(), true, "0");
                                                                                    }
                                                                                  });
                                                                                },
                                                                                child: allPosts[index].currentUserLikeByThumb == "1"
                                                                                    ? const Image(
                                                                                  image: AssetImage("assets/images/feed_like.png"),
                                                                                  height: 14,
                                                                                  width: 14,
                                                                                )
                                                                                    : const Image(
                                                                                  image: AssetImage("assets/images/icon_feed_unlike.png"),
                                                                                  height: 14,
                                                                                  width: 14,
                                                                                ),
                                                                              ),
                                                                              GestureDetector(
                                                                                  behavior: HitTestBehavior.translucent,
                                                                                  onTap: (){
                                                                                    setState(() {
                                                                                      userName = allPosts[index]!.user!.name.toString();
                                                                                      postDate = allPosts[index]!.user!.createdAt.toString();
                                                                                      postID =allPosts[index]!.postContents![0].postId!.toString();;
                                                                                      userProfile = allPosts[index]!.user!.userImagesWhileSignup!.isNotEmpty ? allPosts[index]!.user!.userImagesWhileSignup![0].imageUrl.toString() : "";
                                                                                    });
                                                                                    if (allPosts[index].totalLikeByThumb.toString() == "0") {
                                                                                    } else {
                                                                                      getLikePost(allPosts[index].id!.toInt(),"0");
                                                                                    }
                                                                                  },
                                                                                  child: Utils.mediumHeadingNormalText(text: " ${allPosts[index].totalLikeByThumb}", textSize: 10, color: HexColor("#7B7F91"))),
                                                                              VerticalDivider(
                                                                                color: HexColor("#E2E2E2"),
                                                                                thickness: 1,
                                                                              ),
                                                                              GestureDetector(
                                                                                  behavior: HitTestBehavior.translucent,
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      if(allPosts[index].currentUserLikeByStar=="1"){
                                                                                        allPosts[index].currentUserLikeByStar="0";
                                                                                        feedPresenter?.doLikePost(allPosts[index]!.id.toString(), false, "2");
                                                                                      }else{
                                                                                        allPosts[index].currentUserLikeByStar="1";
                                                                                        allPosts[index].currentUserLikeByHeart="0";
                                                                                        allPosts[index].currentUserLikeByThumb="0";
                                                                                        feedPresenter?.doLikePost(allPosts[index]!.id.toString(), true, "2");
                                                                                      }
                                                                                    });
                                                                                    /*setState(() {
                                                                                          feedPresenter?.doLikePost(allPosts[index]!.postContents![0].postId.toString(), true, "2");
                                                                                        });*/
                                                                                  },
                                                                                  child: allPosts[index].currentUserLikeByStar == "1"?
                                                                                  Image(
                                                                                    image: AssetImage("assets/images/icon_star.png"),
                                                                                    height: 14,
                                                                                    width: 14,
                                                                                  )
                                                                                      : const Image(
                                                                                    image: AssetImage("assets/images/icon_unstar.png"),
                                                                                    height: 14,
                                                                                    width: 14,
                                                                                  )
                                                                              ),
                                                                              GestureDetector(
                                                                                behavior: HitTestBehavior.translucent,
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    userName = allPosts[index]!.user!.name.toString();
                                                                                    postDate = allPosts[index]!.user!.createdAt.toString();
                                                                                    postID =allPosts[index]!.postContents![0].postId!.toString();;
                                                                                    userProfile = allPosts[index]!.user!.userImagesWhileSignup!.isNotEmpty ? allPosts[index]!.user!.userImagesWhileSignup![0].imageUrl.toString() : "";
                                                                                  });
                                                                                  if (allPosts[index].totalLikeByStar.toString() == "0") {
                                                                                  } else {
                                                                                    getLikePost(allPosts[index]!.postContents![0].postId!.toInt(),"2");
                                                                                  }
                                                                                },
                                                                                child: Utils.mediumHeadingNormalText(text: " ${allPosts[index].totalLikeByStar}", textSize: 10, color: HexColor("#7B7F91")),
                                                                              ),
                                                                              Gap(4),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      // allPosts[index].user!.isAdmin==false?
                                                                      GestureDetector(
                                                                        behavior: HitTestBehavior.translucent,
                                                                        onTap:
                                                                            () {
                                                                          setState(() {
                                                                            userName = allPosts[index]!.user!.name.toString();
                                                                            postDate = allPosts[index]!.user!.createdAt.toString();
                                                                            postID =allPosts[index]!.postContents![0].postId!.toString();;
                                                                            userProfile = allPosts[index]!.user!.userImagesWhileSignup!.isNotEmpty ? allPosts[index]!.user!.userImagesWhileSignup![0].imageUrl.toString() : "";
                                                                          });
                                                                          getcommentPost(allPosts[index]!.postContents![0].postId!.toString());
                                                                        },
                                                                        child: Container(
                                                                            height: 33,
                                                                            decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              color: const Color.fromRGBO(247, 247, 247, 1),
                                                                            ),
                                                                            child: Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                const Gap(8),
                                                                                Image.asset(
                                                                                  "assets/images/icon_comment.png",
                                                                                  height: 14,
                                                                                ),
                                                                                const Gap(4),
                                                                                Utils.mediumHeadingNormalText(text: allPosts![index].totalCommments.toString() + " Comments", textSize: 10, color: HexColor("#7B7F91")),
                                                                                const Gap(8),
                                                                              ],
                                                                            )),
                                                                      )
                                                                          /*:Container()*/,
                                                                      // allPosts[index].user!.isAdmin==false?
                                                                      GestureDetector(
                                                                        onTap: () {
                                                                          setState(() {
                                                                            userName = allPosts[index]!.user!.name.toString();
                                                                            postDate = allPosts[index]!.user!.createdAt.toString();
                                                                            postID =allPosts[index]!.postContents![0].postId!.toString();
                                                                            userProfile = allPosts[index]!.user!.userImagesWhileSignup!.isNotEmpty ? allPosts[index]!.user!.userImagesWhileSignup![0].imageUrl.toString() : "";
                                                                          });
                                                                          if (allPosts![index].totalTags.toString() != "0") {
                                                                            setState(() {
                                                                              postID = allPosts[index]!.postContents![0].postId!.toString();
                                                                            });
                                                                            showPopTagInformation(context);
                                                                          }
                                                                        },
                                                                        child: Container(
                                                                            height:
                                                                            33,
                                                                            decoration:
                                                                            BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              color: const Color.fromRGBO(247, 247, 247, 1),
                                                                            ),
                                                                            child:
                                                                            Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                const Gap(8),
                                                                                Image.asset(
                                                                                  "assets/images/icon_tag.png",
                                                                                  height: 14,
                                                                                ),
                                                                                const Gap(4),
                                                                                Utils.mediumHeadingNormalText(text: "${allPosts![index].totalTags} Tags", textSize: 10, color: HexColor("#7B7F91")),
                                                                                const Gap(6),
                                                                                Image.asset(
                                                                                  "assets/images/icon_down.png",
                                                                                  height: 10,
                                                                                  width: 10,
                                                                                ),
                                                                                const Gap(8),
                                                                              ],
                                                                            )),
                                                                      )/*:Container()*/,
                                                                    ],
                                                                  ) /*:
                                                                  Utils.mediumHeadingNormalText(text: UtilStrings.Admin_Text,
                                                                      textSize: 10, fontWeight: FontWeight.normal, color: AppColor.grey,textAlign: TextAlign.left)
                                                               */   ,
                                                                  const Gap(
                                                                      20),
                                                                ],
                                                              );
                                                            },
                                                          ),
                                                        ) else Container(
                                                          alignment: Alignment
                                                              .center,
                                                          padding:
                                                          EdgeInsets.all(
                                                              20),
                                                          height:
                                                          MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height,
                                                          child: Utils.mediumHeadingNormalText(
                                                              text: isLoading ==
                                                                  false
                                                                  ? UtilStrings
                                                                  .NO_POST
                                                                  : "",
                                                              textSize: 14,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                              color: Colors
                                                                  .black),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),

                                          /* ResponsiveRowColumnItem(
                                              rowFlex: 1, child:
                                            Container(
                                              margin: EdgeInsets.only(left: 42,right: 42),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: HexColor(AppColor.BLACK)),
                                                borderRadius: BorderRadius.circular(8.0),
                                                color: HexColor(AppColor.BLACK),
                                              ),
                                              child:  Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Utils.mediumHeadingNormalText(text: "This month",
                                                    color: AppColor.black,fontWeight: FontWeight.normal,textSize: 14),
                                              ),
                                            ),
                                            ),*/
                                        ],
                                      ),
                                      Gap(20),
                                    ],
                                  ),
                                )

                                //),
                                //),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Utils.progressDialog(context, isLoading, type: 3)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



  showAlertDialog(BuildContext context, title, description, int postID, type) {
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
                  forLargeScreen: MediaQuery.of(context).size.width / 3.8,
                  forShortScreen: MediaQuery.of(context).size.width,
                  forMobLandScapeMode: MediaQuery.of(context).size.width,
                  forMediumScreen: MediaQuery.of(context).size.width,
                  forTabletScreen: MediaQuery.of(context).size.width / 2.2,
                  context: context),
              height: Responsive().getResponsiveValue(
                  forLargeScreen: MediaQuery.of(context).size.height / 4,
                  forShortScreen: MediaQuery.of(context).size.height / 4.2,
                  forMobLandScapeMode: MediaQuery.of(context).size.height / 4,
                  forMediumScreen: MediaQuery.of(context).size.height / 4.2,
                  forTabletScreen: MediaQuery.of(context).size.height / 4,
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
                            setState(() {
                              isLoading = true;
                              if (type == 1) {
                                feedPresenter?.doBlockPost(postID.toString(), true);

                              } else if (type == 2) {
                                feedPresenter?.doDeleteSlot(postID.toString());
                              } else if (type == 3) {
                                feedPresenter?.doHidePost(
                                    postID.toString(), true);
                              }
                            });
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
  int? selectedIndex;
  showReportDialog(BuildContext context, TextEditingController reportController,
      int postID, int userID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                contentPadding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                actions: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(width: 1.0, color: Colors.black26)),
                    width: Responsive().getResponsiveValue(
                        forLargeScreen: MediaQuery.of(context).size.width / 3.8,
                        forShortScreen: MediaQuery.of(context).size.width,
                        forMobLandScapeMode: MediaQuery.of(context).size.width,
                        forMediumScreen: MediaQuery.of(context).size.width,
                        forTabletScreen: MediaQuery.of(context).size.width,
                        context: context),
                    height: Responsive().getResponsiveValue(
                        forLargeScreen: MediaQuery.of(context).size.height / 1.4,
                        forShortScreen: MediaQuery.of(context).size.height / 1.7,
                        forMobLandScapeMode:
                        MediaQuery.of(context).size.height / 1.7,
                        forMediumScreen: MediaQuery.of(context).size.height / 1.7,
                        forTabletScreen: MediaQuery.of(context).size.height / 1.7,
                        context: context),
                    child: Wrap(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 10.0),
                          child: Center(
                            child: Utils.mediumHeadingNormalText(
                                text: UtilStrings.Report_User,
                                textSize: 16,
                                fontWeight: FontWeight.bold,
                                color: HexColor("#242424"),
                                textAlign: TextAlign.center),
                          ),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    width: Responsive().getResponsiveValue(
                                        forLargeScreen:
                                        MediaQuery.of(context).size.width / 4.5,
                                        forShortScreen:
                                        MediaQuery.of(context).size.width / 1.6,
                                        forTabletScreen:
                                        MediaQuery.of(context).size.width / 1.6,
                                        forMediumScreen:
                                        MediaQuery.of(context).size.width / 1.6,
                                        context: context),
                                    child: Utils.mediumHeadingNormalText(
                                        text: UtilStrings.kindly_select_why_you_want,
                                        textSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: HexColor("#7B7F91"))),
                                ListView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(10),
                                  itemCount: reportList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedIndex=index;
                                              // reportList[index].select = !reportList[index].select;
                                              resaon = reportList[index].name;
                                            });
                                          },
                                          child: Container(
                                            height: 38,
                                            margin: EdgeInsets.only(bottom: 8),
                                            width: Responsive().getResponsiveValue(
                                                forLargeScreen:
                                                MediaQuery.of(context).size.width /
                                                    4.5,
                                                forShortScreen:
                                                MediaQuery.of(context).size.width /
                                                    1.6,
                                                forTabletScreen:
                                                MediaQuery.of(context).size.width /
                                                    1.6,
                                                forMediumScreen:
                                                MediaQuery.of(context).size.width /
                                                    1.6,
                                                context: context),
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color: HexColor(
                                                    selectedIndex==index
                                                        ? "#A8580F"
                                                        : "#F0F0F0"),
                                                border: Border.all(
                                                    color: HexColor(
                                                        selectedIndex==index
                                                            ? "#A8580F"
                                                            : "#F0F0F0")),
                                                borderRadius:
                                                BorderRadius.circular(10)),
                                            child: Utils.mediumHeadingNormalText(
                                                text: reportList[index].name,
                                                color: selectedIndex==index
                                                    ? AppColor.white
                                                    : HexColor("#242424"),
                                                fontFamily: 'Poppins',
                                                left: 10,
                                                textSize: 12),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(
                                      left: Responsive().getResponsiveValue(
                                          forLargeScreen: 36.0,
                                          forShortScreen: 28.0,
                                          forMobLandScapeMode: 28.0,
                                          forMediumScreen: 28.0,
                                          forTabletScreen: 64.0,
                                          context: context)),
                                  child: Utils.mediumHeadingNormalText(
                                      text: "Other Reason",
                                      fontFamily: 'Poppins',
                                      color: AppColor.black,
                                      textAlign: TextAlign.start,
                                      textSize: 12),
                                ),
                                Container(
                                    margin: EdgeInsets.only(bottom: 8),
                                    width: Responsive().getResponsiveValue(
                                        forLargeScreen:
                                        MediaQuery.of(context).size.width / 4.5,
                                        forShortScreen:
                                        MediaQuery.of(context).size.width / 1.6,
                                        forTabletScreen:
                                        MediaQuery.of(context).size.width / 1.6,
                                        forMediumScreen:
                                        MediaQuery.of(context).size.width / 1.6,
                                        context: context),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: CommonTextfieldRegister(
                                        hint: "Type something...",
                                        controller: reportController,
                                        maxLines: 5,
                                        height: 60,
                                        length: 2001,
                                        toppadding: 12,
                                      ),
                                    )),
                              ],
                            )),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex=null;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: 120,
                                    padding: EdgeInsets.all(10.0),
                                    margin: EdgeInsets.only(top: 20.0, bottom: 20),
                                    decoration: BoxDecoration(
                                      color: HexColor("#F0F0F0"),
                                      borderRadius: BorderRadius.circular(
                                          8), /*
                        border: Border.all(color: HexColor("#FF483C"))*/
                                    ),
                                    child: Utils.mediumHeadingNormalText(
                                        text: "Cancel",
                                        textSize: 12,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  )),
                              SizedBox(
                                width: 12,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isLoading = true;
                                    Navigator.pop(context);
                                    if(selectedIndex==null && reportController.text.isEmpty){
                                      Utils.customDialog(context,message: "Please provide a reason for reporting");
                                    }else{
                                      if(selectedIndex!=0){
                                        feedPresenter?.doReportforSlot(postID.toString(), resaon, userID.toString());
                                      }else{
                                        feedPresenter?.doReportforSlot(postID.toString(), reportController.text.toString(),
                                            userID.toString());
                                      }
                                    }
                                  });
                                },
                                child: Container(
                                  width: 120,
                                  padding: EdgeInsets.all(10.0),
                                  margin: EdgeInsets.only(top: 20.0, bottom: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: HexColor("#FF483C"),
                                  ),
                                  child: Utils.mediumHeadingNormalText(
                                      text: "Submit",
                                      textSize: 12,
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white),
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
            });
      },
    );
  }


  //Upload Post
  showPostFeedDialog(
      BuildContext context,
      TextEditingController takefloorController,
      String mediaURL,
      String postId,
      List<String> taggedUsers,
      List<int> tagUserIds,
      ) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return WillPopScope(
                onWillPop: () => Future.value(false),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      actionsPadding: EdgeInsets.zero,
                      actions: [
                        GestureDetector(
                          onTap: (){
                            Utils.hideKeyBoard(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(width: 1.0, color: Colors.black26)),
                            /*  margin:  EdgeInsets.only(left: Responsive().getResponsiveValue(
                          forLargeScreen:  0.0,
                          forShortScreen:  16,
                          forMobLandScapeMode: 16,
                          forMediumScreen: 16,
                          forTabletScreen:16,
                          context: context),right: Responsive().getResponsiveValue(
                          forLargeScreen:  0.0,
                          forShortScreen:  16,
                          forMobLandScapeMode: 16,
                          forMediumScreen: 16,
                          forTabletScreen:16,
                          context: context)),*/
                            width: Responsive().getResponsiveValue(
                                forLargeScreen: MediaQuery.of(context).size.width / 3.8,
                                forShortScreen: MediaQuery.of(context).size.width,
                                forMobLandScapeMode: MediaQuery.of(context).size.width,
                                forMediumScreen: MediaQuery.of(context).size.width,
                                forTabletScreen: MediaQuery.of(context).size.width,
                                context: context),
                            height: Responsive().getResponsiveValue(
                                forLargeScreen: MediaQuery.of(context).size.height / 1.5,
                                forShortScreen:Platform.isAndroid? MediaQuery.of(context).size.height / 1.7:MediaQuery.of(context).size.height / 1.5,
                                forMobLandScapeMode:
                                MediaQuery.of(context).size.height / 1.8,
                                forMediumScreen: MediaQuery.of(context).size.height / 1.8,
                                forTabletScreen: MediaQuery.of(context).size.height / 1.7,
                                context: context),
                            /* height: Responsive().getResponsiveValue(
                            forLargeScreen: MediaQuery.of(context).size.height / 1.5,
                            forShortScreen: MediaQuery.of(context).size.height / 1.5,
                            forMobLandScapeMode:
                            MediaQuery.of(context).size.height / 1.8,
                            forMediumScreen: MediaQuery.of(context).size.height / 1.5,
                            forTabletScreen: MediaQuery.of(context).size.height / 1.5,
                            context: context),*/
                            child: Wrap(
                              children: [
                                Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Gap(16),
                                        /* Container(
                                   margin: EdgeInsets.only(left: Responsive().getResponsiveValue(
                                        forLargeScreen:  12,
                                        forShortScreen:  12,
                                        forMobLandScapeMode: 12,
                                        forMediumScreen: 12,
                                        forTabletScreen:32,
                                        context: context)),
                                    child:*/
                                        Utils.mediumHeadingNormalText(
                                            text: "Take the Floor",
                                            fontFamily: 'Poppins',
                                            color: AppColor.black,
                                            textSize: 12),
                                        //),
                                        Gap(10),
                                        editType==0?
                                        GestureDetector(
                                            onTap: () async {
                                              var output = await FilePicker.platform.pickFiles(
                                                type: FileType.custom,
                                                allowedExtensions: [
                                                  'png',
                                                  'jpeg',
                                                  'jpg',
                                                  'mp4',
                                                ],
                                                allowMultiple: false,
                                              );
                                              FilePickerResult? finalOutput = output;
                                              setState(() {
                                                importFile = finalOutput!.files[0];
                                                fileName = importFile!.name;
                                              });
                                              if (fileName.contains(".png") ||fileName.contains(".PNG")) {
                                                  fileType = "png";
                                                } else if (fileName.contains(".jpeg") || fileName.contains(".JPEG")) {
                                                  fileType = "jpeg";
                                                } else if (fileName.contains(".jpg")|| fileName.contains(".JPG")) {
                                                  fileType = "jpg";
                                                }else if (fileName.contains(".mp4")|| fileName.contains(".MP4")) {
                                                  fileType = "mp4";
                                                }else if (fileName.contains(".mov")|| fileName.contains(".MOV")) {
                                                  fileType = "mov";
                                                }else if (fileName.contains(".gif")|| fileName.contains(".GIF")) {
                                                  fileType = "gif";
                                                }/*else if(fileName.contains(".heic") || fileName.contains(".HEIC")){
                                                  List<int> compressedBytes = await FlutterImageCompress.compressWithList(
                                                    importFile!.bytes!,
                                                    minHeight: 1920,
                                                    minWidth: 1080,
                                                    quality: 90,
                                                    format: CompressFormat.png,
                                                  );
                                                  print("compressedBytes===>"+compressedBytes.toString());
                                                }*/
                                              PlatformFile platformFile = importFile!;
                                              if (kIsWeb) {
                                                setState(()  {
                                                  photoName = platformFile.name;
                                                  file = platformFile.bytes;
                                                  imageName = platformFile.bytes;
                                                  // copyAssetFile(platformFile.name!);
                                                });
                                              }else{
                                                if(fileType=="png" ||fileType=="jpeg"||fileType=="jpg" ||fileType=="mp4"||fileType=="mov"||fileType=="gif"){
                                                  File uploadFile = File(platformFile.path.toString());
                                                  setState(() {
                                                    postImage=uploadFile;
                                                  });
                                                }else{
                                                  // Utils.customDialog(context,message: "Invalid Data!");
                                                }

                                              }
                                            },
                                            child: Container(
                                              height: 110,
                                              width: Responsive().getResponsiveValue(
                                                  forLargeScreen:
                                                  MediaQuery.of(context).size.width / 4.5,
                                                  forShortScreen:
                                                  MediaQuery.of(context).size.width / 1.6,
                                                  forTabletScreen:
                                                  MediaQuery.of(context).size.width / 1.6,
                                                  forMediumScreen:
                                                  MediaQuery.of(context).size.width / 1.6,
                                                  context: context),
                                              decoration: kIsWeb?
                                              imageName != null && editType == 0
                                                  ? fileType=="mp4"?
                                              BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage("assets/images/play.png",),
                                                  ),
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: HexColor('#E2E2E2')))
                                                  :BoxDecoration(
                                                  image: DecorationImage(
                                                      image: MemoryImage(imageName),
                                                      fit: BoxFit.fill),
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: HexColor('#E2E2E2')))
                                                  : BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: HexColor('#E2E2E2'))):
                                              postImage != null && editType == 0
                                                  ? fileType=="mp4"?
                                              BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage("assets/images/play.png",),
                                                  ),
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: HexColor('#E2E2E2')))
                                                  :BoxDecoration(
                                                  image: DecorationImage(
                                                      image: FileImage(File(postImage!.path)),
                                                      fit: BoxFit.fill),
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: HexColor('#E2E2E2')))
                                                  : BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: HexColor('#E2E2E2'))),
                                              child: editType == 0 && postImage == null
                                                  ? Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  const Image(
                                                    image: AssetImage(
                                                        'assets/images/ic_gallery.png'),
                                                    height: 40,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Utils.mediumHeadingNormalText(
                                                    text: UtilStrings.Upload_Image_video,
                                                    textSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: HexColor('#7B7F91'),
                                                  ),
                                                ],
                                              )
                                                  : Container(),
                                            )):
                                        Container(
                                          height: 110,
                                          width: Responsive().getResponsiveValue(
                                              forLargeScreen:
                                              MediaQuery.of(context).size.width / 4.5,
                                              forShortScreen:
                                              MediaQuery.of(context).size.width / 1.6,
                                              forTabletScreen:
                                              MediaQuery.of(context).size.width / 1.6,
                                              forMediumScreen:
                                              MediaQuery.of(context).size.width / 1.6,
                                              context: context),
                                          decoration:mediaURL.contains(".mp4") ||mediaURL.contains(".mov")?
                                          BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage("assets/images/play.png"),
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: HexColor('#E2E2E2'))):
                                          BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      IMAGE_URL + mediaURL),
                                                  fit: BoxFit.fill),
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: HexColor('#E2E2E2'))),
                                        ),
                                        Gap(10),
                                        /*Container(
                                    margin: EdgeInsets.only(left: Responsive().getResponsiveValue(
                                        forLargeScreen:  12,
                                        forShortScreen:  12,
                                        forMobLandScapeMode: 12,
                                        forMediumScreen: 12,
                                        forTabletScreen:32,
                                        context: context)),
                                    child:*/
                                        Utils.mediumHeadingNormalText(
                                            text: "Pick the Mic",
                                            fontFamily: 'Poppins',
                                            color: AppColor.black,
                                            textSize: 12),
                                        Container(
                                            margin: EdgeInsets.only(bottom: 8),
                                            width: Responsive().getResponsiveValue(
                                                forLargeScreen:
                                                MediaQuery.of(context).size.width / 4.5,
                                                forShortScreen:
                                                MediaQuery.of(context).size.width / 1.6,
                                                forTabletScreen:
                                                MediaQuery.of(context).size.width / 1.6,
                                                forMediumScreen:
                                                MediaQuery.of(context).size.width / 1.6,
                                                context: context),
                                            child: Padding(
                                                padding: const EdgeInsets.only(top: 6),
                                                child: Container(
                                                  height: 60,
                                                  width:  Responsive().getResponsiveValue(
                                                      forLargeScreen: MediaQuery.of(context).size.width/4.5,
                                                      forShortScreen: MediaQuery.of(context).size.width/1.2,
                                                      forTabletScreen: MediaQuery.of(context).size.width/1.2,
                                                      forMediumScreen:  MediaQuery.of(context).size.width/1.2,
                                                      context: context),
                                                  decoration: BoxDecoration(
                                                      color:AppColor.white,
                                                      border: Border.all(color: HexColor('#E2E2E2')),
                                                      borderRadius:BorderRadius.circular(10)
                                                  ),
                                                  child: TextField(
                                                    onTap: () {
                                                      /*if (isShowSticker != false) {
                                                        setState(() {
                                                          isShowSticker = !isShowSticker!!;
                                                        });
                                                      }*/
                                                    },
                                                    maxLines: 5,
                                                    controller: takefloorController,
                                                    cursorColor:Colors.black,
                                                    textInputAction:TextInputAction.done,
                                                    style: const TextStyle(color:Colors.black,fontFamily: 'Poppins',fontSize: 12,fontWeight: FontWeight.normal),
                                                    decoration: InputDecoration(
                                                       /* suffixIcon: GestureDetector(
                                                            onTap: (){
                                                              setState(() {
                                                                isShowSticker = !isShowSticker!;
                                                              });
                                                              if (isShowSticker != false) {
                                                                FocusScope.of(context).unfocus();
                                                              }
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets.only(right:8.0,bottom: 8.0,top: 22),
                                                              child: Icon(Icons.face,color: Colors.red,size: 18,),
                                                            )),*/
                                                        counterText:'',
                                                        contentPadding: EdgeInsets.only(left:16,bottom:4,right: 10,top: 12),
                                                        border: InputBorder.none,
                                                        hintText:"Write something...",
                                                        hintStyle:TextStyle(color:Colors.grey,fontFamily: 'Poppins',fontSize: 12)
                                                    ),
                                                  ),
                                                )
                                            )),
                                        /*Container(
                                    margin: EdgeInsets.only(left: Responsive().getResponsiveValue(
                                        forLargeScreen:  12,
                                        forShortScreen:  12,
                                        forMobLandScapeMode: 12,
                                        forMediumScreen: 12,
                                        forTabletScreen:32,
                                        context: context)),
                                    child: */
                                        Utils.mediumHeadingNormalText(
                                            text: "Tag",
                                            fontFamily: 'Poppins',
                                            color: AppColor.black,
                                            textSize: 12),
                                        //),
                                        Gap(10),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                            showPopInformation(context, setState, mediaURL,taggedUsers,tagUserIds,userList);
                                          },
                                          child: Container(
                                            width: Responsive().getResponsiveValue(
                                                forLargeScreen:
                                                MediaQuery.of(context).size.width / 4.5,
                                                forShortScreen:
                                                MediaQuery.of(context).size.width / 1.6,
                                                forTabletScreen:
                                                MediaQuery.of(context).size.width / 1.6,
                                                forMediumScreen:
                                                MediaQuery.of(context).size.width / 1.6,
                                                context: context),
                                            height: 56,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(color: HexColor('#E2E2E2')),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8, bottom: 8, left: 10),
                                              child: Row(
                                                children: <Widget>[
                                                  SizedBox(
                                                      width: Responsive().getResponsiveValue(
                                                          forLargeScreen:
                                                          MediaQuery.of(context).size.width /
                                                              5.0,
                                                          forShortScreen:
                                                          MediaQuery.of(context).size.width /
                                                              2,
                                                          forTabletScreen:
                                                          MediaQuery.of(context).size.width /
                                                              2.6,
                                                          forMediumScreen:
                                                          MediaQuery.of(context).size.width /
                                                              2,
                                                          context: context),
                                                      child: ScrollConfiguration(
                                                          behavior: MyCustomScrollBehavior(),
                                                          child: ListView.builder(
                                                              shrinkWrap: true,
                                                              scrollDirection: Axis.horizontal,
                                                              itemCount: userList.length,
                                                              itemBuilder: (_, index) {
                                                                return Container(
                                                                  height: 20,
                                                                  margin:
                                                                  EdgeInsets.only(right: 8),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          10),
                                                                      color: HexColor('#A8580F')),
                                                                  child: Row(
                                                                    children: [
                                                                      Gap(5),
                                                                      Center(
                                                                          child: Utils
                                                                              .mediumHeadingNormalText(
                                                                            text: userList[index].text,
                                                                            textSize: 10,
                                                                            color: Colors.white,
                                                                          )),
                                                                      Gap(5),
                                                                      GestureDetector(
                                                                        onTap: () {
                                                                          setState(() {
                                                                            for(int i=0;i<checkBoxValue.length;i++){
                                                                              if(userList[index].tagUserId.toString().contains(checkBoxValue[i].tagUserId.toString())) {
                                                                                checkBoxValue[i].value=false;
                                                                              }
                                                                            }
                                                                            userList.removeAt(index);
                                                                          });
                                                                        },
                                                                        child: Icon(
                                                                          Icons.close_sharp,
                                                                          color: Colors.white,
                                                                          size: 12,
                                                                        ),
                                                                      ),
                                                                      Gap(5),
                                                                    ],
                                                                  ),
                                                                );
                                                              }))),
                                                  Spacer(),
                                                  Image.asset(
                                                    "assets/images/icon_down.png",
                                                    height: 10,
                                                    width: 10,
                                                  ),
                                                  Gap(8),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            if(editType==0){
                                              setState(() {
                                                tempUserName.clear();
                                                userList.clear();
                                                tagUserIds.clear();
                                                takefloorController.clear();
                                                imageName=null;
                                                postImage=null;
                                              });
                                            }
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            width: 120,
                                            padding: EdgeInsets.all(10.0),
                                            margin: EdgeInsets.only(top: 20.0, bottom: 20),
                                            decoration: BoxDecoration(
                                              color: HexColor("#F0F0F0"),
                                              borderRadius: BorderRadius.circular(
                                                  8), /*
                                        border: Border.all(color: HexColor("#FF483C"))*/
                                            ),
                                            child: Utils.mediumHeadingNormalText(
                                                text: "Cancel",
                                                textSize: 12,
                                                textAlign: TextAlign.center,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          )),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          validation();
                                        },
                                        child: Container(
                                          width: 120,
                                          padding: EdgeInsets.all(10.0),
                                          margin: EdgeInsets.only(top: 20.0, bottom: 20),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: HexColor("#FF483C"),
                                          ),
                                          child: Utils.mediumHeadingNormalText(
                                              text: "Submit",
                                              textSize: 12,
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Offstage(
                      offstage: !isShowSticker!,
                      child: SizedBox(
                        height: 250,
                        width: Responsive().getResponsiveValue(
                            forLargeScreen: MediaQuery.of(context).size.width / 3.8,
                            forShortScreen: MediaQuery.of(context).size.width,
                            forMobLandScapeMode: MediaQuery.of(context).size.width,
                            forMediumScreen: MediaQuery.of(context).size.width,
                            forTabletScreen: MediaQuery.of(context).size.width,
                            context: context),
                        child: EmojiPicker(
                          /* onEmojiSelected: (Category category, Emoji emoji) {
                                                            _onEmojiSelected(emoji);
                                                          },*/
                          textEditingController: takefloorController,
                          config: Config(
                            columns: 8,
                            verticalSpacing: 0,
                            horizontalSpacing: 0,
                            gridPadding: EdgeInsets.zero,
                            bgColor: Colors.white,
                            indicatorColor: Theme.of(context).primaryColor,
                            iconColor: Colors.grey,
                            iconColorSelected: Theme.of(context).primaryColor,
                            backspaceColor: Theme.of(context).primaryColor,
                            skinToneDialogBgColor: Colors.white,
                            skinToneIndicatorColor: Colors.grey,
                            enableSkinTones: true,
                            //showRecentsTab: true,
                            recentsLimit: 32,
                            noRecents: const Text(
                              'Pas d\'émojis récents',
                              style: TextStyle(fontSize: 20, color: Colors.black26),
                              textAlign: TextAlign.center,
                            ),
                            tabIndicatorAnimDuration: kTabScrollDuration,
                            categoryIcons: const CategoryIcons(),
                            buttonMode: ButtonMode.MATERIAL,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            });
      },
    );
  }


  showPopInformation(
      BuildContext context, StateSetter setState, String mediaUrl,List<String> taggedUser,List<int> tagUserIds,
      List<TextBool> userList) {
    if(userList.isNotEmpty){
      for (int i = 0; i < checkBoxValueTemp.length; i++) {
        for (int j = 0; j < userList.length; j++) {
          if(checkBoxValueTemp[i].tagUserId!.toString().contains(userList[j].tagUserId.toString())) {
            setState(() {
              checkBoxValueTemp[i].value=true;
            });
          }
        }
      }
    }
    else{
      for (int i = 0; i < checkBoxValueTemp.length; i++) {
        setState((){
          checkBoxValueTemp[i].value=false;
        });
      }
    }
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return WillPopScope(
                  onWillPop: () => Future.value(false),
                  child: AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    actionsPadding:EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    actions: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(width: 1.0, color: Colors.black26)),
                        /*  margin:  EdgeInsets.only(left: Responsive().getResponsiveValue(
                    forLargeScreen:  0.0,
                    forShortScreen:  16,
                    forMobLandScapeMode: 16,
                    forMediumScreen: 16,
                    forTabletScreen:16,
                    context: context),right: Responsive().getResponsiveValue(
                    forLargeScreen:  0.0,
                    forShortScreen:  16,
                    forMobLandScapeMode: 16,
                    forMediumScreen: 16,
                    forTabletScreen:16,
                    context: context)),*/
                        width: Responsive().getResponsiveValue(
                            forLargeScreen: MediaQuery.of(context).size.width / 3.8,
                            forShortScreen: MediaQuery.of(context).size.width,
                            forMobLandScapeMode: MediaQuery.of(context).size.width,
                            forMediumScreen: MediaQuery.of(context).size.width,
                            forTabletScreen: MediaQuery.of(context).size.width,
                            context: context),
                        height:  Responsive().getResponsiveValue(
                            forLargeScreen:  MediaQuery.of(context).size.height/1.6,
                            forShortScreen:  MediaQuery.of(context).size.height/1.8,
                            forMobLandScapeMode: MediaQuery.of(context).size.height/2,
                            forMediumScreen: MediaQuery.of(context).size.height/1.8,
                            forTabletScreen: MediaQuery.of(context).size.height/2,
                            context: context),
                        child: Wrap(
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    height: 50,
                                    width: Responsive().getResponsiveValue(
                                        forLargeScreen: MediaQuery.of(context).size.width/4.4,
                                        forShortScreen: MediaQuery.of(context).size.width/1.5,
                                        forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                        forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                        context: context),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor.grey.withOpacity(0.2),
                                          width: 1.0,
                                          style: BorderStyle.solid
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.search,
                                          color: AppColor.appGrey_2,
                                        ),
                                        const Gap(8),
                                        Expanded(
                                          child: TextField(
                                            controller: searchController,
                                            onChanged: (value) => _searchingData(value,setState),
                                            style: const TextStyle(
                                                color: AppColor.black),
                                            //controller: searchController,
                                            maxLines: 1,
                                            cursorColor:
                                            AppColor.appPrimaryColor,
                                            decoration: const InputDecoration(
                                              hintText: "Search..",
                                              hintStyle: TextStyle(
                                                  fontSize: 16,
                                                  color: AppColor.light_grey),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Gap(8),
                                  SizedBox(
                                      height:Responsive().getResponsiveValue(
                                          forLargeScreen:  MediaQuery.of(context).size.height/2.2,
                                          forShortScreen:  MediaQuery.of(context).size.height/2.8,
                                          forMobLandScapeMode: MediaQuery.of(context).size.height/3.0,
                                          forMediumScreen: MediaQuery.of(context).size.height/2.8,
                                          forTabletScreen: MediaQuery.of(context).size.height/3.0,
                                          context: context),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: checkBoxValueTemp.length,
                                          itemBuilder: (_, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                bottom: 8,
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(children: [
                                                    GestureDetector(
                                                      onTap: (){
                                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileScreen(
                                                            userId:  checkBoxValueTemp[index].tagUserId.toString()
                                                        )));
                                                      },
                                                      child: SizedBox(
                                                        height: 30,
                                                        width: 30,
                                                        child: ClipOval(
                                                          child: CachedNetworkImage(
                                                            imageUrl: checkBoxValueTemp[index].profileImage.toString(),
                                                            imageBuilder:
                                                                (context, imageProvider) =>
                                                                Container(
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      borderRadius:
                                                                      const BorderRadius.all(
                                                                          Radius.circular(8)),
                                                                      image: DecorationImage(
                                                                        image: imageProvider,
                                                                        fit: BoxFit.fill,

                                                                      ),
                                                                    )),
                                                            placeholder: (context, url) =>
                                                            const Image(
                                                                image: AssetImage(
                                                                    "assets/images/icon_loading.png")),
                                                            errorWidget: (context, url,
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
                                                    Gap(6),
                                                    Utils.mediumHeadingNormalText(
                                                        text: checkBoxValueTemp[index].text,
                                                        textSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.black),
                                                    Spacer(),
                                                    Theme(
                                                      data: Theme.of(context).copyWith(
                                                        unselectedWidgetColor:
                                                        Color(0xffFF2C5A),
                                                      ),
                                                      child: Checkbox(
                                                          checkColor: Colors.white,
                                                          activeColor:
                                                          Color(0xffFF2C5A),
                                                          value: checkBoxValueTemp[index].value,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              if(userList.length<=6){
                                                                checkBoxValueTemp[index].value = value!;
                                                                if(checkBoxValueTemp[index].value==true){
                                                                  setState(() {
                                                                    tagUserIds.add(checkBoxValueTemp[index].tagUserId!.toInt());
                                                                    tempUserName.add(checkBoxValueTemp[index].text.toString());
                                                                    TextBool textBool =TextBool(text:checkBoxValueTemp[index].text.toString() ,
                                                                        tagUserId: checkBoxValueTemp[index].tagUserId!.toInt(),value: checkBoxValueTemp[index].value);
                                                                    userList.add(textBool);
                                                                  });
                                                                }else{
                                                                  userList.removeWhere((element) => element.tagUserId == checkBoxValueTemp[index].tagUserId);
                                                                }}else{
                                                                if(checkBoxValueTemp[index].value==true){
                                                                  checkBoxValueTemp[index].value = false;
                                                                  userList.removeWhere((element) => element.tagUserId == checkBoxValueTemp[index].tagUserId);
                                                                }else{
                                                                  Utils.customDialog(context,message: "You can tag only 7 person in each post!");

                                                                }
                                                              }
                                                            });
                                                          }),
                                                    ),
                                                  ]),
                                                ],
                                              ),
                                            );
                                          })),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      // catchDataId(setState, mediaUrl,taggedUser);
                                      if(editType==0){
                                        setState((){
                                          userList.clear();
                                        });
                                        Navigator.pop(context);
                                        showPostFeedDialog(
                                            context, takefloorController, mediaUrl, "",taggedUser,tagUserIds);
                                      }else{
                                        for(int i=0;i<checkBoxValueTemp.length;i++){
                                          setState((){
                                            checkBoxValueTemp[i].value=false;
                                          });
                                        }
                                        Navigator.pop(context);
                                        showPostFeedDialog(context, takefloorController, mediaUrl, "",taggedUser,tagUserIds);
                                      }
                                    },
                                    child: Container(
                                      width: 120,
                                      padding: EdgeInsets.all(10.0),
                                      margin: EdgeInsets.only(bottom: 10,top:10),
                                      decoration: BoxDecoration(
                                        color: HexColor("#F0F0F0"),
                                        borderRadius: BorderRadius.circular(
                                            8), /*
                                border: Border.all(color: HexColor("#FF483C"))*/
                                      ),
                                      child: Utils.mediumHeadingNormalText(
                                          text: "Cancel",
                                          textSize: 12,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    )),
                                SizedBox(
                                  width: 12,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if(userList.length>7){
                                      Utils.customDialog(context,message: "You can tag only 7 person in each post!");
                                    }else{
                                      Navigator.pop(context);
                                      setState((){
                                        searchController.text="";
                                        checkBoxValueTemp = checkBoxValue;
                                      });
                                      showPostFeedDialog(context, takefloorController, mediaUrl, "",tempUserName.toSet().toList(),tagUserIds.toSet().toList());
                                    }
                                  },
                                  child: Container(
                                    width: 120,
                                    padding: EdgeInsets.all(10.0),
                                    margin: EdgeInsets.only(bottom: 10,top:10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: HexColor("#FF483C"),
                                    ),
                                    child: Utils.mediumHeadingNormalText(
                                        text: "Done",
                                        textSize: 12,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }

  showPopTagInformation(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return TagsDialogScreen(
                  userName: userName,
                  userProfile: userProfile,
                  postID: postID,
                  postDate: postDate,
                  isLoading: isLoading,
                );
              });
        });
  }
  showPopLikeInformation(BuildContext context,String type) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setInnerState) {
            return LikeDialogScreen(
              userName: userName,
              userProfile: userProfile,
              postID: postID,
              postDate: postDate,
              isLoading: isLoading,
              type: type,
            );
          });
        });
  }
  Future<bool> _onWillPop() async {
    feedPresenter?.doAllPostResponseData(currentPage.toString(),_limit.toString());
    return true; //<-- SEE HERE
  }

  showPopCommentInformation(
      BuildContext context, List<CommentModel> commentUsers, bool isLoading,String postId) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setInnerState) {
            return WillPopScope(onWillPop: _onWillPop, child:
            CommentDialogScreen(
              userName: userName,
              userProfile: userProfile,
              postID: postId,
              postDate: postDate,
              isLoading: isLoading,
            ));
          });
        });
  }
  @override
  onError(String msg, int status) {
    print("onError==>"+msg.toString());
    setState(() {
      isLoading = false;
      //isLoadingPop=false;
    });
    if(status==401){
      Utils.sessionExpire(context);
    }
    else if(status==404){
      Utils.sessionExpire(context);
    }
    //Utils.customDialog(msg);
  }

  @override
  onAllPostResponse(AllPostResponse response) {
    allPosts.clear();
    // allPostsTemp.clear();
    setState(() {
      isLoading = false;
      if (response.status == 200) {
        allPosts.addAll(response.data!);
        if(Utils.calculateDay()=="Friday" ||  Utils.calculateDay()=="friday"){
          messagePresenter!.onUpdateStar();
        }else if(Utils.calculateDay()=="Monday" ||  Utils.calculateDay()=="monday"){
          messagePresenter!.onUpdateStar();
        }
        // allPostsTemp.addAll(response.data!);
        // allPosts.addAll(allPostsTemp);
        // currentPage++;
        // totalPages = (totalItems / 10).ceil();
        isLoading = false;
      }
    });
  }

  @override
  onPostSlotResponse(SuccessResponse response) {
    setState(() {
      isLoading = false;
      imageName=null;
      postImage=null;
      if (response.status == 200) {
        Utils.customDialog(context,message:response.message.toString());
        feedPresenter?.doAllPostResponseData(currentPage.toString(),_limit.toString());
      }
    });
  }

  @override
  onAllUserResponse(AllUserForTagResponse response) {
    allTagUsers.clear();
    checkBoxValue.clear();
    checkBoxValueTemp.clear();
    setState(() {
      if (response.status == 200) {
        allTagUsers.addAll(response.data!);
        for (int i = 0; i < allTagUsers.length; i++) {
          TextBool textBool = TextBool(
              text: response.data![i].name.toString(),
              value: false,
              tagUserId: response.data![i].id, profileImage: response.data![i].userImagesWhileSignup!.isNotEmpty?
          response.data![i].userImagesWhileSignup![0].imageUrl.toString()==""?"":
          IMAGE_URL+ response.data![i].userImagesWhileSignup![0].imageUrl.toString():"");
          checkBoxValue.add(textBool);
          checkBoxValueTemp.add(textBool);

          /*  tempUserName.add(response.data![i].name.toString());
          tagUserIds.add(response.data![i].id!);*/
        }
      }
    });
  }

  @override
  onBlockPost(SuccessResponse response) {
    setState(() {
      isLoading = false;
      if (response.status == 200) {
        Utils.customDialog(context,message:response.message.toString());
        _authService.updateBlockStatus(senderId, receiverId, true);
        feedPresenter?.doAllPostResponseData(currentPage.toString(),_limit.toString());

      }
    });
  }

  @override
  onDeletePost(SuccessResponse response) {
    setState(() {
      isLoading = false;
      if (response.status == 200) {
        Utils.customDialog(context,message:response.message.toString());
        feedPresenter?.doAllPostResponseData(currentPage.toString(),_limit.toString());
      }
    });
  }

  @override
  onReportPost(SuccessResponse response) {
    setState(() {
      isLoading = false;
      if (response.status == 200) {
        reportController.clear();
        Navigator.pop(context);
        Utils.customDialog(context,message:response.message.toString());
        feedPresenter?.doAllPostResponseData(currentPage.toString(),_limit.toString());
      }
    });
  }
  List<int> newTagIds=[];
  List<int> addTagIds=[];
  void validation() {
    if (editType == 0) {
      if(kIsWeb){
        if (imageName == null) {
          Utils.customDialog(context,message:UtilStrings.Choose_your_post_images);
        } else if (takefloorController.text.trim().toString().isEmpty) {
          Utils.customDialog(context,message:UtilStrings.Add_Your_Post_Description);
        } else {
          Navigator.pop(context);
          setState(() {
            isLoading = true;
            imageName=null;
            addTagIds.clear();
            for(int i=0;i<userList.length;i++){
              addTagIds.add(userList[i].tagUserId!);
            }
            feedPresenter?.doPostSlot(
                photoName, file, takefloorController.text.toString(), addTagIds.toSet().toList());
          });
        }
      }else{
        if (postImage == null) {
          Utils.customDialog(context,message:UtilStrings.Choose_your_post_images);
        } else if (takefloorController.text.trim().toString().isEmpty) {
          Utils.customDialog(context,message:UtilStrings.Add_Your_Post_Description);
        } else {
          addTagIds.clear();
          for(int i=0;i<userList.length;i++){
            addTagIds.add(userList[i].tagUserId!);
          }
          setState(() {
            isLoading = true;
            feedPresenter?.doPostSlotMobile(
                postImage!, takefloorController.text.toString(),  addTagIds.toSet().toList());
            Navigator.pop(context);

          });
        }
      }

    } else {
      if (takefloorController.text.toString().isEmpty) {
        Utils.customDialog(context,message:UtilStrings.Add_Your_Post_Description);
      } else {
        Navigator.pop(context);
        setState(()  {
          isLoading = true;
          newTagIds.clear();
          for(int i=0;i<userList.length;i++){
            newTagIds.add(userList[i].tagUserId!);
          }
          feedPresenter?.doEditPost(
              takefloorController.text.toString(), newTagIds.toSet().toList(), postID);
        });
      }
    }
  }

  void getTagUsers(int postID) async{
    setState(() {
      //isLoading=true;
      feedPresenter?.doPostTags(postID.toString());
    });
  }

  void getLikePost(int postID,String type) {
    showPopLikeInformation(context,type);
  }

  void getcommentPost(String postIdData) {
    setState(() {
      //feedPresenter?.doCommentData(postID.toString());
      showPopCommentInformation(context, postCommentUsers, isLoading,postIdData);
    });
  }


  @override
  onPostTag(PostTagUsersResponse response) {
    setState(() {
      isLoading = false;
      userList.clear();
      if (response.status == 200) {
        for (var item in response.data!) {
          tagUserIds.add(item.tagTo!.id!);
          tempUserName.add(item.tagTo!.name!);
          TextBool textBool=TextBool(text: item.tagTo!.name!, value: false,tagUserId:item.tagTo!.id );
          userList.add(textBool);
        }
        showPostFeedDialog(context, takefloorController,
            postMediaUrl,
            postID,
            tempUserName,tagUserIds);
        //Showing Tag Data according to Post
      }
    });
  }

/*  removeTagUser(int index) {
    tempUserName.removeAt(index);
    tagUserIds.removeAt(index);

    for (var checkitem in checkBoxValue) {
      for (var tempitem in tagUserIds) {
        if (checkitem.tagUserId == tempitem) {
          setState(() {
            checkitem.value = true;
          });
          break;
        } else {
          setState(() {
            checkitem.value = false;
          });
        }
      }
    }
  }*/

  catchDataId(StateSetter setState, String mediaUrl,List<String> taggedUser) {
    /*tagUserIds.clear();
    tempUserName.clear();*/
    userList.clear();
    for (int i = 0; i < checkBoxValue.length; i++) {
      if (checkBoxValue[i].value == true) {
        setState(() {
          tagUserIds.add(checkBoxValue[i].tagUserId!.toInt());
          tempUserName.add(checkBoxValue[i].text.toString());
          print("namee===>"+checkBoxValue[i].text.toString());
          TextBool textBool =TextBool(text:checkBoxValue[i].text.toString() ,
              tagUserId: checkBoxValue[i].tagUserId!.toInt(),value: checkBoxValue[i].value);
          userList.add(textBool);
        });
      }
    }
    setState((){
      userList=userList.toSet().toList();
    });
    showPostFeedDialog(context, takefloorController, mediaUrl, "",tempUserName.toSet().toList(),tagUserIds.toSet().toList());
  }

  Future<File>? urlToFile(String imageUrl) async {
    var rng = new Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File('$tempPath${rng.nextInt(100)}.png');
    http.Response response = await http.get(Uri.parse(imageUrl));
    await file.writeAsBytes(response.bodyBytes);

    // Utils.customDialog(file.toString());
    setState(() {
      file = file;
      imageName = file;
    });
    return file;
  }

  @override
  onPostLike(LikeUsersResponse response) {
    feedPresenter?.doAllPostResponseData(currentPage.toString(),_limit.toString());
  }

  @override
  onPostCommentList(PostCommentUsersResponse response) {

  }

  @override
  onPostComment(SuccessResponse response) {
    setState(() {
      isLoadingPop = false;
      if (response.status == 200) {/*
        Utils.customDialog(response.message.toString());*/
      }
    });
  }

  @override
  onHidePost(SuccessResponse response) {

    feedPresenter?.doAllPostResponseData(currentPage.toString(),_limit.toString());
  }
  @override
  onLikeByUserPost(SuccessResponse response) {
    print("onLikeByUserPost==>"+response.message.toString());
    if (response.status == 200) {
      // Utils.customDialog(context,message:response.message.toString());
      feedPresenter?.doAllPostResponseData(currentPage.toString(),_limit.toString());
    }
  }

  @override
  onPostHeartLike(SuccessResponse response) {
  }

  @override
  onPostLikeComment(CreateCommentResponse response) {
  }
  @override
  onReportError(String msg, int status) {
    if(status==400){
      Utils.customDialog(context,message:msg.toString());
      Navigator.pop(context);
    }
  }

  @override
  onProfileResponse(UserProfileResponse response) {
    if(response.status==200){
      //Utils.customDialog(response.message!);
      SessionManager.setString(Preferences.USER_NAME, response.data!.name.toString());
      SessionManager.setString(Preferences.EMAIL, response.data!.email.toString());
      SessionManager.setString(Preferences.REFERAL_CODE, response.data!.referCode.toString());
      SessionManager.setString(Preferences.USER_ID, response.data!.id.toString());
      SessionManager.setString(Preferences.CHOOSE_ANY_ONE, response.data!.chooseAnyOne.toString());
      SessionManager.setString(Preferences.PROFILE_IMAGE, response.data!.userImagesWhileSignup!.isNotEmpty?response.data!.userImagesWhileSignup![0].imageUrl.toString():"");
      SessionManager.setString(Preferences.INDEX,"0");
      SessionManager.setString(Preferences.profileStatus,response.data!.profileStatus.toString());
      SessionManager.setString(Preferences.verification_status,response.data!.userVerification.toString());
      SessionManager.setString(Preferences.government_status, "");
      SessionManager.setString(Preferences.phone_status, "");
      SessionManager.setString(Preferences.pose_status, "");
      SessionManager.setString(Preferences.facebook_status, "");
      //1=> Basic ,2=> Standard ,3=> Gold ,4=>Platinum
      // subscription type(1,2,3,4) 1 : basic, 2:standard, 3:gold, 4:platinum
      DateTime loginDate = DateTime.parse(response.data!.createdAt.toString());
      DateTime currentDate = DateTime.now();
      final result = currentDate.difference(loginDate).inDays;
      if(response.data!.subscriptionStatus==false){
        if(result<3){
          SessionManager.setString(Preferences.subscription_status, "true");
          SessionManager.setString(Preferences.subscription_plan, "4");
          SessionManager.setString(Preferences.plan_ammount,"");
          SessionManager.setString(Preferences.plan_id, "");
          SessionManager.setString(Preferences.is_trial, "true");
        }else{
          SessionManager.setString(Preferences.subscription_status, response.data!.subscriptionStatus.toString());
          SessionManager.setString(Preferences.subscription_plan, "");
          SessionManager.setString(Preferences.plan_ammount, "");
          SessionManager.setString(Preferences.plan_id, "");
          SessionManager.setString(Preferences.is_trial, "false");
        }
      }
      else if(response.data!.subscriptionStatus==false && response.data!.subscriptions!.isEmpty){
        SessionManager.setString(Preferences.subscription_status, response.data!.subscriptionStatus.toString());
        SessionManager.setString(Preferences.subscription_plan, "");
        SessionManager.setString(Preferences.plan_ammount, "");
        SessionManager.setString(Preferences.plan_id, "");
        SessionManager.setString(Preferences.is_trial, "false");
      }
      else if(response.data!.subscriptionStatus==true && response.data!.subscriptions!.isNotEmpty){
        SessionManager.setString(Preferences.subscription_status, response.data!.subscriptionStatus.toString());
        SessionManager.setString(Preferences.subscription_plan, response.data!.subscriptions![0].supscriptionType.toString());
        SessionManager.setString(Preferences.plan_ammount, response.data!.subscriptions![0].amount.toString());
        SessionManager.setString(Preferences.plan_id, response.data!.subscriptions![0].productId.toString());
        if(response.data!.subscriptions![0].purchaseType.toString()=="1"){
          DateTime resultDate = Utils.calculate28DaysFromDate(int.parse(response.data!.subscriptions![0].purchaseDate.toString()));
          SessionManager.setString(Preferences.subscription_end_date,resultDate.toString());
        }else if(response.data!.subscriptions![0].purchaseType.toString()=="2"){
          DateTime resultDate = Utils.calculate3MonthFromDate(int.parse(response.data!.subscriptions![0].purchaseDate.toString()));
          SessionManager.setString(Preferences.subscription_end_date,resultDate.toString());
        }else if(response.data!.subscriptions![0].purchaseType.toString()=="3"){
          DateTime resultDate = Utils.calculate12MonthFromDate(int.parse(response.data!.subscriptions![0].purchaseDate.toString()));
          SessionManager.setString(Preferences.subscription_end_date,resultDate.toString());
        }
        SessionManager.setString(Preferences.is_trial, "false");
      }else{
        SessionManager.setString(Preferences.subscription_status, response.data!.subscriptionStatus.toString());
        SessionManager.setString(Preferences.subscription_plan, "");
        SessionManager.setString(Preferences.plan_ammount, "");
        SessionManager.setString(Preferences.plan_id, "");
        SessionManager.setString(Preferences.is_trial, "false");
      }
    }
  }

  @override
  onSuccessCreateStar(CreateStarResponse response) {
    setState(() {
      isLoading=false;
    });
  }

  @override
  onSuccessGetStar(GetStarResponse response) {
    setState(() {
      isLoading=false;
    });
  }

  @override
  onSuccessUpdateStar(SuccessResponse response) {
    setState(() {
      isLoading=false;
    });
  }

  @override
  onDeleteComment(SuccessResponse response) {
  }
}

PopupMenuItem _buildPopupMenuItem(String title, Function onTap) {
  return PopupMenuItem(
    onTap: () {
      onTap()!;
    },
    child: Utils.mediumHeadingNormalText(
        text: title,
        textSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.black),
  );
}
