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
import 'package:likeplay/module/profile/profile_presenter.dart';
import 'package:likeplay/module/profile/user_profile_screen.dart';
import 'package:likeplay/module/profile/user_shots_screen.dart';
import 'package:likeplay/utils/constant_lists.dart';
import 'package:likeplay/widget/common/commontextfield_registerscreen.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/responsive.dart';
import '../../utils/sharedpref/preferences.dart';
import '../../utils/sharedpref/shared_prefrence.dart';
import '../../utils/string_utils.dart';
import '../../utils/utils.dart';
import '../sidemenu/web_side_menu.dart';
import 'like_shots_screen.dart';
import 'package:need_resume/need_resume.dart';

class EditProfileScreen extends StatefulWidget {
  int? selectedPage;
  EditProfileScreen({this.selectedPage});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ResumableState<EditProfileScreen> with SingleTickerProviderStateMixin implements ProfileInterface{
  DateTime ?dateTime;
  bool isLoading=false;
  TextEditingController reportController = TextEditingController();
  TextEditingController takefloorController = TextEditingController();
  TabController? _tabController;
  bool floorPage = false;
  UserData? userData;
  ProfilePresenter? profilePresenter;

  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myprofileTabs.length);
    profilePresenter=ProfilePresenter(this);
    _tabController!.animateTo(widget.selectedPage!);
    setState(() {
      isLoading=true;
      profilePresenter?.doUserResponseData(SessionManager.getString(Preferences.USER_ID));
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
  void onResume() {
    print("onresume edit==");
    profilePresenter?.doUserResponseData(SessionManager.getString(Preferences.USER_ID));
    super.onResume();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return /*kIsWeb?*/AppSideMenu(
      pageTitle:UtilStrings.Home,
      screenType: 0,
      body:Container(
        /*width: size.width,
          height: size.height,*/
          color: Colors.white,
          child: Stack(children: [
            userData!=null?
            Container(
              decoration: Responsive().getResponsiveValue(
                  forLargeScreen: const BoxDecoration(
                      border: Border(
                          right: BorderSide(width: 1.0, color: Colors.black26),
                          left: BorderSide(width: 1.0, color:Colors.black26))),
                  context: context),
              width:  Responsive().getResponsiveValue(
                  forLargeScreen: MediaQuery.of(context).size.width,
                  context: context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    child:  Row(
                      children: [
                        Gap(10),
                        SizedBox (
                          height: 32,
                          width: 32,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl:userData!.userImagesWhileSignup!.isNotEmpty?IMAGE_URL+userData!.userImagesWhileSignup![0].imageUrl.toString():"",
                              imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                                    image: DecorationImage(
                                      image:imageProvider,
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                              placeholder: (context, url) =>  const Image(image: AssetImage("assets/images/icon_loading.png")),
                              errorWidget: (context, url, error) =>   const Image(image: AssetImage("assets/images/icon_loading.png")),
                              width: 32,
                              height: 32,
                            ),
                          ),
                        ),
                        const Gap(20),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Gap(5),
                              Row( children: [
                                Utils.mediumHeadingNormalText(text:userData!.name.toString(),textSize: 14,fontWeight: FontWeight.normal,color: AppColor.APP_TEXT_COLOR),
                                Spacer(),
                                /*GestureDetector(
                                                    child:Utils.imageView(image: "assets/images/icon_edit.png",width: 16,height: 16),),
                                                  Gap(12),*/
                              ]),
                              const Gap(5),
                              Row(
                                children: [
                                  Utils.mediumHeadingNormalText(text:userData!.age.toString(),textSize: 12,fontWeight: FontWeight.normal,color: AppColor.APP_TEXT_COLOR_SECOND),
                                  Utils.customBlackDot(),
                                  Utils.mediumHeadingNormalText(text:userData!.gender.toString() == "0" ? "Male" : "Female",textSize: 12,fontWeight: FontWeight.normal,color: AppColor.APP_TEXT_COLOR_SECOND),
                                  Utils.customBlackDot(),
                                  Utils.mediumHeadingNormalText(text:userData!.lookingFor,textSize: 12,fontWeight: FontWeight.normal,color: AppColor.APP_TEXT_COLOR_SECOND),
                                ],
                              ),
                              const Gap(5),
                              Utils.mediumHeadingNormalText(text:userData!.residenceCountry.toString()+", "+userData!.state.toString(),textSize: 12,fontWeight: FontWeight.normal,color: AppColor.APP_TEXT_COLOR_SECOND),
                            ],
                          ),
                        ),
                      ],
                    ),),
                  Container(
                    color: Colors.grey,
                    height: 1,
                  ),
                  const Gap(16),
                  DefaultTabController(
                    initialIndex:widget.selectedPage!,
                    length: 2,
                    child: Container(
                      //padding: EdgeInsets.all(20),
                      height: MediaQuery.of(context).size.height/1.4,
                      child: Column(children: [
                        TabBar(
                          controller: _tabController,
                          tabs: myprofileTabs,
                          labelColor: Colors.black,
                          isScrollable: true,
                          indicatorColor: Colors.red,
                          unselectedLabelColor: HexColor('#7B7F91'),

                        ),
                        Expanded(
                          // height:MediaQuery.of(context).size.height/1.2,
                          // width:MediaQuery.of(context).size.width ,
                          child: TabBarView(
                            controller: _tabController,
                            children:  [
                              ///Shots Tab
                              UsersShotScreen(user_id: SessionManager.getString(Preferences.USER_ID),),
                              ///About me Tab
                              UsersProfileScreen(type:1,user_id: SessionManager.getString(Preferences.USER_ID),),
                              LikeShotScreen(user_id:SessionManager.getString(Preferences.USER_ID),),

                            ],
                          ),
                        ),
                      ],),

                    ),
                  ),
                ],
              ),
            ):Container(),
            Utils.progressDialog(context, isLoading,type: 3)
          ],)
      ) , );
  }

  static showAlertDialog(BuildContext context,title,description,) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
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
              width:  Responsive().getResponsiveValue(
                  forLargeScreen:  MediaQuery.of(context).size.width/3.8,
                  forShortScreen:  MediaQuery.of(context).size.width,
                  forMobLandScapeMode: MediaQuery.of(context).size.width,
                  forMediumScreen: MediaQuery.of(context).size.width,
                  forTabletScreen: MediaQuery.of(context).size.width/2.2,
                  context: context),
              height:  Responsive().getResponsiveValue(
                  forLargeScreen:  MediaQuery.of(context).size.height/4,
                  forShortScreen:  MediaQuery.of(context).size.height/4.2,
                  forMobLandScapeMode: MediaQuery.of(context).size.height/4,
                  forMediumScreen: MediaQuery.of(context).size.height/4.2,
                  forTabletScreen: MediaQuery.of(context).size.height/4,
                  context: context),
              child: Wrap(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20,bottom: 10.0),
                    child: Center(
                      child: Utils.mediumHeadingNormalText(text:title,textSize: 16,fontWeight: FontWeight.bold,color: HexColor("#242424")),
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
                      child:*/Center(
                    child:Utils.mediumHeadingNormalText(text:description,textSize: 12,fontWeight: FontWeight.normal,color: HexColor("#7B7F91"),textAlign: TextAlign.center),
                    // )
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child:Container(
                              width: 120,
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(top: 30.0,bottom: 20),
                              decoration: BoxDecoration(
                                color: HexColor("#F0F0F0"),
                                borderRadius: BorderRadius.circular(8),/*
                                border: Border.all(color: HexColor("#FF483C"))*/
                              ),
                              child: Text("Cancel",textAlign:TextAlign.center,style: TextStyle(color: Colors.black),),
                            )),
                        SizedBox(width: 12,),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 120,
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.only(top: 30.0,bottom: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: HexColor("#FF483C"),
                            ),
                            child: Text("Yes",textAlign:TextAlign.center,style: TextStyle(color: Colors.white),),
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

  @override
  onError(String msg, int status) {
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
  onProfileResponse(UserProfileResponse response) {
    setState(() {
      isLoading=false;
      if(response.status==200){
        userData=response.data;
        floorPage=response.data!.floorStatus!;
      }
    });
  }

  @override
  onUpdateFloorStatusData(SuccessResponse response) {
    if(response.status==200){
      Utils.customDialog(context,message:response.message.toString());
    }
  }

  @override
  onLikeShortsData(LikeShortResponse response) {

  }
}

PopupMenuItem _buildPopupMenuItem(String title, Function onTap) {
  return PopupMenuItem(
    onTap: (){
      onTap()!;
    },
    child:Utils.mediumHeadingNormalText(text:title,textSize: 12,fontWeight: FontWeight.normal,color: Colors.black),
  );
}