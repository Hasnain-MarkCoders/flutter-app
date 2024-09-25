import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/module/model/like_shorts_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import 'package:likeplay/module/model/user_profile_response.dart';
import 'package:likeplay/module/profile/edit_profile_screen.dart';
import 'package:likeplay/module/profile/profile_presenter.dart';
import 'package:likeplay/module/profile/user_profile_screen.dart';
import 'package:likeplay/module/profile/user_shots_screen.dart';
import 'package:likeplay/utils/constant_lists.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/responsive.dart';
import '../../utils/firebase/authentication_service.dart';
import '../../utils/firebase/firebase_exceptions.dart';
import '../../utils/sharedpref/preferences.dart';
import '../../utils/sharedpref/shared_prefrence.dart';
import '../../utils/string_utils.dart';
import '../../utils/utils.dart';
import '../message/mobile_message/message_presenter.dart';
import '../message/mobile_message/message_view_mobile.dart';
import '../model/create_star_response.dart';
import '../model/get_star_response.dart';
import '../sidemenu/web_side_menu.dart';
import 'like_shots_screen.dart';
import 'package:need_resume/need_resume.dart';
class ProfileScreen extends StatefulWidget {
  String userId;

  ProfileScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ResumableState<ProfileScreen>
    with SingleTickerProviderStateMixin
    implements ProfileInterface ,MessageInterface{
  DateTime? dateTime;
  bool isLoading = false;
  int selectIndex = 0;
  TextEditingController reportController = TextEditingController();
  TextEditingController takefloorController = TextEditingController();
  TabController? _tabController;
  bool floorPage = false;
  UserData? userData;
  ProfilePresenter? profilePresenter;
  MessagePresenter? messagePresenter;
  int starCount=0;
  bool isCheckId=false;

  int? matchLength;
  void onResume() {
    profilePresenter?.doUserResponseData(widget.userId.toString());
    if(widget.userId!=SessionManager.getString(Preferences.USER_ID)){
      setState(() {
        isLoading=true;
      });
      messagePresenter?.onGetStar(SessionManager.getString(Preferences.USER_ID));
    }
    super.onResume();
  }
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widget.userId==SessionManager.getString(Preferences.USER_ID)?
    myprofileTabs.length:  myOtherprofileTabs.length);
    profilePresenter = ProfilePresenter(this);
    messagePresenter=MessagePresenter(this);

    setState(() {
      isLoading = true;
      //SessionManager.getString(Preferences.USER_ID)
      profilePresenter?.doUserResponseData(widget.userId.toString());
    });
    if(widget.userId!=SessionManager.getString(Preferences.USER_ID)){
      messagePresenter?.onGetStar(SessionManager.getString(Preferences.USER_ID));
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
  final _authService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return /*kIsWeb?*/ AppSideMenu(
        pageTitle: UtilStrings.Home,
        screenType: 0,
        body: kIsWeb
            ? SingleChildScrollView(
                child: webWidget(),
              )
            : mobileWidget());
  }

  Widget mobileWidget() {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
            /*width: size.width,
              height: size.height,*/
            color: Colors.white,
            child: userData != null
                ? Column(

                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Gap(5),
                                Row( mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Utils.viewPhoto(
                                              context,
                                              IMAGE_URL +
                                                  userData!.userImagesWhileSignup![0]!
                                                      .imageUrl
                                                      .toString());
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(top: 4),
                                          height: 42,
                                          width: 42,
                                          child: ClipOval(
                                            child: CachedNetworkImage(
                                              imageUrl: userData!
                                                  .userImagesWhileSignup!.isNotEmpty
                                                  ? IMAGE_URL +
                                                  userData!
                                                      .userImagesWhileSignup![0]
                                                      .imageUrl
                                                      .toString()
                                                  : "",
                                              imageBuilder: (context, imageProvider) =>
                                                  Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.all(
                                                            Radius.circular(8)),
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      )),
                                              placeholder: (context, url) => const Image(
                                                  image: AssetImage(
                                                      "assets/images/icon_loading.png")),
                                              errorWidget: (context, url, error) =>
                                              const Image(
                                                  image: AssetImage(
                                                      "assets/images/icon_loading.png")),
                                              width: 32,
                                              height: 32,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Gap(10),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Utils.mediumHeadingNormalText(
                                              text:userData!.name==""?"": userData!.name.toString(),
                                              textSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: AppColor.APP_TEXT_COLOR),
                                          Row(
                                            children: [
                                              Utils.mediumHeadingNormalText(
                                                  text: userData!.age.toString() ==
                                                      "null"
                                                      ? "NA"
                                                      : userData!.age.toString(),
                                                  textSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  color:
                                                  AppColor.APP_TEXT_COLOR_SECOND),
                                              Utils.customBlackDot(),
                                              Utils.mediumHeadingNormalText(
                                                  text: userData!.gender.toString() ==
                                                      "0"
                                                      ? "Male"
                                                      : "Female",
                                                  textSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  color:
                                                  AppColor.APP_TEXT_COLOR_SECOND),
                                              // Utils.customBlackDot(),

                                            ],
                                          ),
                                          Gap(6),
                                          Utils.mediumHeadingNormalText(
                                              text: userData!.lookingFor
                                                  .toString() ==
                                                  "null"
                                                  ? "NA"
                                                  : userData!.lookingFor,
                                              textSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color:
                                              AppColor.APP_TEXT_COLOR_SECOND),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                           widget.userId==SessionManager.getString(Preferences.USER_ID)?
                        SessionManager.getString(Preferences.verification_status).toString()=="2"
                                          ? GestureDetector(
                                              onTap: () {
                                                push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditProfileScreen(
                                                              selectedPage:
                                                                  1,
                                                            )));
                                              },
                                              child: Utils.imageView(
                                                  image:
                                                      "assets/images/icon_edit.png",
                                                  width: 16,
                                                  height: 16),
                                            )
                                          : Container()
                                      : Container(),
                                      widget.userId==SessionManager.getString(Preferences.USER_ID)?Container():
                                      ((Utils.calculateDay()=="Thursday" ||  Utils.calculateDay()=="thursday") &&
                                          (starCount<2)) ||
                                          ((Utils.calculateDay()=="Sunday" ||  Utils.calculateDay()=="sunday") && (starCount<3)) ?
                                      isCheckId==true?Container():
                                      GestureDetector(
                                        onTap:() async {
                                          SessionManager.setString(Preferences.IS_MESSAGE, "");
                                          //Chat view
                                          final _status = await _authService.createChatUser(
                                            senderId:SessionManager.getString(Preferences.USER_ID),
                                            receiverId: userData!.id.toString(),
                                            senderName: SessionManager.getString(Preferences.USER_NAME),
                                            receiverName: userData!.name.toString(),
                                            receiverImage:   userData!.userImagesWhileSignup!.isNotEmpty?IMAGE_URL+ userData!.userImagesWhileSignup![0].imageUrl.toString():"",
                                            senderImage: IMAGE_URL+ SessionManager.getString(Preferences.PROFILE_IMAGE),
                                            admrireStatus: "1",
                                            subscriptionStatus:  userData!.subscriptionStatus.toString(),
                                            subscriptionPlan:userData!.subscriptions!.isNotEmpty?
                                            userData!.subscriptions![0].supscriptionType.toString():"",
                                          );
                                          if (_status == AuthStatus.successful) {
                                            // SessionManager.setString(Preferences.INDEX,"4");
                                            push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => MessageMobileViewScreen(
                                                        senderId:SessionManager.getString(Preferences.USER_ID),
                                                        receiverId: userData!.id.toString(),
                                                        senderName: SessionManager.getString(Preferences.USER_NAME),
                                                        receiverName: userData!.name.toString(),
                                                        receiverImage:userData!.userImagesWhileSignup!.isNotEmpty?IMAGE_URL+ userData!.userImagesWhileSignup![0].imageUrl.toString():"",
                                                        senderImage: SessionManager.getString(Preferences.PROFILE_IMAGE),
                                                      comesFrom:"ProfileStar",
                                                      starCount: starCount,)));
                                          }
                                        },
                                        child: Utils.imageView(image: "assets/images/ic_chat_star.png",
                                          width: 32,
                                          height: 32,
                                        ),
                                      ):Container(),
                                  Gap(12),
                                ]),
                                const Gap(5),
                               /* Utils.mediumHeadingNormalText(
                                    text: userData!.residenceCountry
                                                .toString() ==
                                            "null"
                                        ? "NA"
                                        : userData!.residenceCountry
                                                        .toString() +
                                                    ", " +
                                                    userData!.state
                                                        .toString() ==
                                                "null"
                                            ? "NA"
                                            : userData!.state.toString(),
                                    textSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: AppColor.APP_TEXT_COLOR_SECOND),*/
                                Gap(4),
                                Container(
                                  color: Colors.grey,
                                  height: 1,
                                ),
                                Gap(4),
                                Container(
                                  margin: EdgeInsets.only(left: 16,right: 16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        Utils.mediumHeadingNormalText(text:UtilStrings.Member_Since,textSize: 12,color: AppColor.APP_TEXT_COLOR_SECOND),
                                        Spacer(),
                                        Utils.mediumHeadingNormalText(text: userData!.createdAt.toString() ==
                                            "null"
                                            ? "NA"
                                            : Utils.getCreateDate(userData!.createdAt.toString(),),color: Colors.black,textSize: 12,),

                                      ],),
                                      Gap(6),
                                      Row(children: [
                                        Utils.mediumHeadingNormalText(text:UtilStrings.Last_Active,

                                            textSize: 12,color: AppColor.APP_TEXT_COLOR_SECOND),
                                        Spacer(),
                                        Utils.mediumHeadingNormalText(text: userData!.activeAt.toString() ==
                                            "null"
                                            ? "NA"
                                            : Utils.getCreateDate(userData!.activeAt.toString(),),color: Colors.black,textSize: 12,),
                                      ],),
                                      Gap(6),
                                      Row(children: [
                                        Utils.mediumHeadingNormalText(text:UtilStrings.Location,textSize: 12,color: AppColor.APP_TEXT_COLOR_SECOND),
                                        Spacer(),
                                        Utils.mediumHeadingNormalText(text:userData!.residenceCountry.toString() ==
                                            "null"
                                            ? "NA"
                                            : userData!.residenceCountry.toString(),textSize: 12,color: Colors.black),

                                      ],),
                                      Gap(6),
                                      Row(children: [
                                        Utils.mediumHeadingNormalText(text:UtilStrings.Verification,textSize: 12,color: AppColor.APP_TEXT_COLOR_SECOND),
                                        Spacer(),
                                        Utils.mediumHeadingNormalText(text:userData!.userVerification ==
                                            false
                                            ? "Not Verified"
                                            : "Verified",textSize: 12,color: Colors.black),
                                      ],)
                                    ],
                                  ),
                                ),
                                Gap(4),
                                widget.userId==SessionManager.getString(Preferences.USER_ID)?    Container(
                                  color: Colors.grey,
                                  height: 1,
                                ):Container(),
                                Gap(4),
                                widget.userId==SessionManager.getString(Preferences.USER_ID)?  Container(
                                  margin: EdgeInsets.only(left: 16,right: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Utils.mediumHeadingNormalText(
                                          text: UtilStrings.Introduce_me_on_The_Floor_Page,
                                          fontFamily: 'Poppins',
                                          color: AppColor.black,
                                          fontWeight:FontWeight.bold,
                                          textSize: 10),
                                      Transform.scale(
                                          scale: 0.5,
                                          child:CupertinoSwitch(
                                            value: floorPage,
                                            activeColor: HexColor("#A8580F"),
                                            onChanged: (value) {
                                              setState(() {
                                                floorPage=value;
                                                profilePresenter!.doUserOnFloor(value);
                                              });
                                            },
                                          )),
                                    ],),
                                ):Container(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey,
                      height: 1,
                    ),
                    const Gap(4),
                    Container(
                      //padding: EdgeInsets.all(20),
                      height: SessionManager.getString(Preferences.USER_ID)==widget.userId? MediaQuery.of(context).size.height/1.7:MediaQuery.of(context).size.height/1.6,
                      width: size.width,
                      child: Column(
                        children: [
                          SessionManager.getString(Preferences.USER_ID)==widget.userId?
                          TabBar(
                            controller: _tabController,
                            tabs: myprofileTabs,
                            labelColor: Colors.black,
                            isScrollable: true,
                            indicatorColor: Colors.red,
                            unselectedLabelColor: HexColor('#7B7F91'),
                            labelStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                          ):TabBar(
                            controller: _tabController,
                            tabs: myOtherprofileTabs,
                            labelColor: Colors.black,
                            isScrollable: true,
                            indicatorColor: Colors.red,
                            unselectedLabelColor: HexColor('#7B7F91'),

                          ),
                          Expanded(
                            child:   SessionManager.getString(Preferences.USER_ID)==widget.userId?
                            TabBarView(
                              controller: _tabController,
                              children:  [
                                ///Shots Tab
                                UsersShotScreen(user_id:widget.userId.toString()),
                                ///About me Tab
                                UsersProfileScreen(type:0,user_id:widget.userId.toString()),
                                ///Users Like Tab

                                LikeShotScreen(user_id:widget.userId.toString()),

                              ],
                            ):TabBarView(
                              controller: _tabController,
                              children:  [
                                ///Shots Tab
                                UsersShotScreen(user_id:widget.userId.toString()),
                                ///About me Tab
                                UsersProfileScreen(type:0,user_id:widget.userId.toString()),


                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
                : Container()),
        Utils.progressDialogFullScreen(context, isLoading,)
      ],
    );
  }


  @override
  onError(String msg, int status) {
    setState(() {
      isLoading = false;
    });
    if (status == 401) {
      Utils.sessionExpire(context);
    } else if (status == 404) {
      Utils.sessionExpire(context);
    }
  }

  @override
  onProfileResponse(UserProfileResponse response) {
    setState(() {
      isLoading = false;
      if (response.status == 200) {
        userData = response.data;
        floorPage = response.data!.floorStatus!;
      }
    });
  }

  @override
  onUpdateFloorStatusData(SuccessResponse response) {
    if (response.status == 200) {
      Utils.customDialog(context,message:response.message.toString());
    }
  }

  @override
  onSuccessCreateStar(CreateStarResponse response) {

  }

  @override
  onSuccessGetStar(GetStarResponse response) {
    setState(() {
      isLoading=false;
    });
    if(response.status==200){
      setState(() {
        starCount=response.data!.starCount!;
        // matchLength=response.data!.matchUserCount;
        for(var partnerID in response.data!.partnerIds!){
          // print("response partnerID=="+partnerID.toString());
          // print("partnerID=="+widget.userId.toString());

          if(widget.userId==partnerID.toString()){
            isCheckId=true;
            // print("partnerID=="+widget.userId.toString());
            break;
          }else{
            isCheckId=false;
            // print("partnerID=="+widget.userId.toString());
          }
        }
      });
      /*print("onSuccessGetStar=="+response.message.toString());
      print("calculateDay=="+Utils.calculateDay().toString());
      print("starCount=="+starCount.toString());
      print("isCheckId=="+isCheckId.toString());*/
    }
  }
  Widget webWidget() {
    return Container(
      /*width: size.width,
          height: size.height,*/
        color: Colors.white,
        child: Stack(
          children: [
            userData != null
                ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ResponsiveRowColumn(
                  rowMainAxisAlignment: MainAxisAlignment.start,
                  rowCrossAxisAlignment: CrossAxisAlignment.start,
                  layout:
                  ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                      ? ResponsiveRowColumnType.COLUMN
                      : ResponsiveRowColumnType.ROW,
                  children: [
                    ResponsiveRowColumnItem(
                      rowFlex: 2,
                      child: Column(
                        children: [
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
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
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
                                                    EdgeInsets.all(
                                                        12),
                                                    child: Row(
                                                      children: [
                                                        Gap(10),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Utils.viewPhoto(
                                                                context,
                                                                IMAGE_URL +
                                                                    userData!
                                                                        .userImagesWhileSignup![0]!
                                                                        .imageUrl
                                                                        .toString());
                                                          },
                                                          child: SizedBox(
                                                            height: 32,
                                                            width: 32,
                                                            child:
                                                            ClipOval(
                                                              child:
                                                              CachedNetworkImage(
                                                                imageUrl: userData!
                                                                    .userImagesWhileSignup!
                                                                    .isNotEmpty
                                                                    ? IMAGE_URL +
                                                                    userData!.userImagesWhileSignup![0].imageUrl.toString()
                                                                    : "",
                                                                imageBuilder: (context,
                                                                    imageProvider) =>
                                                                    Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius:
                                                                          const BorderRadius.all(Radius.circular(8)),
                                                                          image:
                                                                          DecorationImage(
                                                                            image:
                                                                            imageProvider,
                                                                            fit: BoxFit
                                                                                .fill,
                                                                          ),
                                                                        )),
                                                                placeholder: (context,
                                                                    url) =>
                                                                const Image(
                                                                    image: AssetImage("assets/images/icon_loading.png")),
                                                                errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Image(
                                                                    image: AssetImage("assets/images/icon_loading.png")),
                                                                width: 32,
                                                                height:
                                                                32,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const Gap(20),
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              const Gap(
                                                                  5),
                                                              Row(
                                                                  children: [
                                                                    Utils.mediumHeadingNormalText(
                                                                        text: userData!.name.toString(),
                                                                        textSize: 14,
                                                                        fontWeight: FontWeight.normal,
                                                                        color: AppColor.APP_TEXT_COLOR),
                                                                    Spacer(),
                                                                    widget.userId == SessionManager.getString(Preferences.USER_ID)
                                                                        ? SessionManager.getString(Preferences.verification_status).toString() == "2"
                                                                        ? GestureDetector(
                                                                      onTap: () {
                                                                        push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (context) => EditProfileScreen(
                                                                                  selectedPage: 1,
                                                                                )));
                                                                      },
                                                                      child: Utils.imageView(image: "assets/images/icon_edit.png", width: 16, height: 16),
                                                                    )
                                                                        : Container()
                                                                        : Container(),
                                                                    Gap(12),
                                                                  ]),
                                                              const Gap(
                                                                  5),
                                                              Row(
                                                                children: [
                                                                  Utils.mediumHeadingNormalText(
                                                                      text: userData!.age.toString() == "null"
                                                                          ? "NA"
                                                                          : userData!.age.toString(),
                                                                      textSize: 12,
                                                                      fontWeight: FontWeight.normal,
                                                                      color: AppColor.APP_TEXT_COLOR_SECOND),
                                                                  Utils
                                                                      .customBlackDot(),
                                                                  Utils.mediumHeadingNormalText(
                                                                      text: userData!.gender.toString() == "0"
                                                                          ? "Male"
                                                                          : "Female",
                                                                      textSize:
                                                                      12,
                                                                      fontWeight:
                                                                      FontWeight.normal,
                                                                      color: AppColor.APP_TEXT_COLOR_SECOND),
                                                                  Utils
                                                                      .customBlackDot(),
                                                                  Utils.mediumHeadingNormalText(
                                                                      text: userData!.lookingFor.toString() == "null"
                                                                          ? "NA"
                                                                          : userData!.lookingFor,
                                                                      textSize: 12,
                                                                      fontWeight: FontWeight.normal,
                                                                      color: AppColor.APP_TEXT_COLOR_SECOND),
                                                                ],
                                                              ),
                                                              const Gap(
                                                                  5),
                                                              Utils.mediumHeadingNormalText(
                                                                  text: userData!.residenceCountry.toString() == "null"
                                                                      ? "NA"
                                                                      : userData!.residenceCountry.toString() + ", " + userData!.state.toString() == "null"
                                                                      ? "NA"
                                                                      : userData!.state.toString(),
                                                                  textSize: 12,
                                                                  fontWeight: FontWeight.normal,
                                                                  color: AppColor.APP_TEXT_COLOR_SECOND),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    color: Colors.grey,
                                                    height: 1,
                                                  ),
                                                  const Gap(16),
                                                  Container(
                                                    //padding: EdgeInsets.all(20),
                                                    height: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height,
                                                    child: Column(
                                                      children: [
                                                        SessionManager.getString(Preferences.USER_ID)==widget.userId?
                                                        TabBar(
                                                          controller: _tabController,
                                                          tabs: myprofileTabs,
                                                          labelColor: Colors.black,
                                                          isScrollable: true,
                                                          indicatorColor: Colors.red,
                                                          unselectedLabelColor: HexColor('#7B7F91'),
                                                        ):TabBar(
                                                          controller: _tabController,
                                                          tabs: myOtherprofileTabs,
                                                          labelColor: Colors.black,
                                                          isScrollable: true,
                                                          indicatorColor: Colors.red,
                                                          unselectedLabelColor: HexColor('#7B7F91'),

                                                        ),
                                                        Expanded(
                                                          child:   SessionManager.getString(Preferences.USER_ID)==widget.userId?
                                                          TabBarView(
                                                            controller: _tabController,
                                                            children:  [
                                                              ///Shots Tab
                                                              UsersShotScreen(user_id:widget.userId.toString()),
                                                              ///About me Tab
                                                              UsersProfileScreen(type:0,user_id:widget.userId.toString()),
                                                              ///Users Like Tab

                                                              LikeShotScreen(user_id:widget.userId.toString()),

                                                            ],
                                                          ):TabBarView(
                                                            controller: _tabController,
                                                            children:  [
                                                              ///Shots Tab
                                                              UsersShotScreen(user_id:widget.userId.toString()),
                                                              ///About me Tab
                                                              UsersProfileScreen(type:0,user_id:widget.userId.toString()),


                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
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
                        ],
                      ),
                    ),
                    Responsive().getResponsiveValue(
                        forLargeScreen: ResponsiveRowColumnItem(
                            rowFlex: 1,
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: 12, left: 12, top: 12),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      margin: const EdgeInsets.only(
                                          left: 10, right: 20),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(4),
                                          border: Border.all(
                                              width: 1.0,
                                              color: Colors.black26)),
                                      width: Responsive()
                                          .getResponsiveValue(
                                          forLargeScreen:
                                          MediaQuery.of(context)
                                              .size
                                              .width /
                                              5,
                                          context: context),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Utils.mediumHeadingNormalText(
                                                  text: UtilStrings
                                                      .Member_Since,
                                                  textSize: 12,
                                                  color: AppColor
                                                      .APP_TEXT_COLOR_SECOND),
                                              Spacer(),
                                              Utils
                                                  .mediumHeadingNormalText(
                                                text: userData!.createdAt
                                                    .toString() ==
                                                    "null"
                                                    ? "NA"
                                                    : Utils.getCreateDate(
                                                  userData!
                                                      .createdAt
                                                      .toString(),
                                                ),
                                                color: Colors.black,
                                                textSize: 12,
                                              ),
                                            ],
                                          ),
                                          Gap(6),
                                          Row(
                                            children: [
                                              Utils.mediumHeadingNormalText(
                                                  text: UtilStrings
                                                      .Last_Active,
                                                  textSize: 12,
                                                  color: AppColor
                                                      .APP_TEXT_COLOR_SECOND),
                                              Spacer(),
                                              Utils
                                                  .mediumHeadingNormalText(
                                                text: userData!.activeAt
                                                    .toString() ==
                                                    "null"
                                                    ? "NA"
                                                    : Utils.getCreateDate(
                                                  userData!.activeAt
                                                      .toString(),
                                                ),
                                                color: Colors.black,
                                                textSize: 12,
                                              ),
                                            ],
                                          ),
                                          Gap(6),
                                          Row(
                                            children: [
                                              Utils.mediumHeadingNormalText(
                                                  text: UtilStrings
                                                      .Location,
                                                  textSize: 12,
                                                  color: AppColor
                                                      .APP_TEXT_COLOR_SECOND),
                                              Spacer(),
                                              Utils.mediumHeadingNormalText(
                                                  text: userData!
                                                      .residenceCountry
                                                      .toString() ==
                                                      "null"
                                                      ? "NA"
                                                      : userData!
                                                      .residenceCountry
                                                      .toString(),
                                                  textSize: 12,
                                                  color: Colors.black),
                                            ],
                                          ),
                                          Gap(6),
                                          Row(
                                            children: [
                                              Utils.mediumHeadingNormalText(
                                                  text: UtilStrings
                                                      .Verification,
                                                  textSize: 12,
                                                  color: AppColor
                                                      .APP_TEXT_COLOR_SECOND),
                                              Spacer(),
                                              Utils.mediumHeadingNormalText(
                                                  text: userData!
                                                      .userVerification ==
                                                      false
                                                      ? "Not Verified"
                                                      : "Verified",
                                                  textSize: 12,
                                                  color: Colors.black),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Gap(12),
                                  widget.userId ==
                                      SessionManager.getString(
                                          Preferences.USER_ID)
                                      ? Container(
                                      width: Responsive()
                                          .getResponsiveValue(
                                          forLargeScreen:
                                          MediaQuery.of(
                                              context)
                                              .size
                                              .width /
                                              5,
                                          context: context),
                                      padding: EdgeInsets.all(10),
                                      margin: const EdgeInsets.only(
                                          left: 10, right: 20),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(
                                              4),
                                          border: Border.all(
                                              width: 1.0,
                                              color: Colors.black26)),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Gap(Responsive()
                                              .getResponsiveValue(
                                              forLargeScreen: 8,
                                              forShortScreen: 6,
                                              forMobLandScapeMode:
                                              0.0,
                                              forMediumScreen: 6,
                                              forTabletScreen: 6,
                                              context: context)),
                                          Utils.mediumHeadingNormalText(
                                              text: UtilStrings
                                                  .Introduce_me_on_The_Floor_Page,
                                              fontFamily: 'Poppins',
                                              color: AppColor.black,
                                              fontWeight:
                                              FontWeight.bold,
                                              textSize: 10),
                                          Gap(12),
                                          Transform.scale(
                                              scale: 0.5,
                                              child: CupertinoSwitch(
                                                value: floorPage,
                                                activeColor: HexColor(
                                                    "#A8580F"),
                                                onChanged: (value) {
                                                  setState(() {
                                                    floorPage = value;
                                                    profilePresenter!
                                                        .doUserOnFloor(
                                                        value);
                                                  });
                                                },
                                              )),
                                        ],
                                      ))
                                      : Container(),
                                ],
                              ),
                            )),
                        forShortScreen: ResponsiveRowColumnItem(
                          rowFlex: 1,
                          child: Container(),
                        ),
                        context: context),
                  ],
                ),
              ],
            )
                : Container(),
            Utils.progressDialog(context, isLoading, type: 3)
          ],
        ));
  }

  @override
  onLikeShortsData(LikeShortResponse response) {

  }

  @override
  onSuccessUpdateStar(SuccessResponse response) {

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
