import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:likeplay/module/match/match_userprofile_screen.dart';
import 'package:likeplay/module/model/like_shorts_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import 'package:likeplay/utils/constant_lists.dart';
import 'package:likeplay/utils/online_dating_tips.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/responsive.dart';
import '../../utils/string_utils.dart';
import '../../utils/utils.dart';
import '../model/match_response.dart';
import '../model/user_profile_response.dart';
import '../profile/profile_presenter.dart';
import 'match_presenter.dart';

class MatchProfileViewScreen extends StatefulWidget {
  String? user_id;
  MatchProfileViewScreen({
    required this.user_id,
  });
  @override
  State<MatchProfileViewScreen> createState() => _MatchProfileViewScreenState();
}

class _MatchProfileViewScreenState extends State<MatchProfileViewScreen> implements  ProfileInterface,MatchInterface{
  bool isLoading=false;
  UserData? userData;
  ProfilePresenter? profilePresenter;
  MatchPresenter? matchPresenter;
  @override
  void initState() {
    super.initState();
    profilePresenter=ProfilePresenter(this);
    matchPresenter=MatchPresenter(this);
    setState(() {
      isLoading=true;
      profilePresenter?.doUserResponseData(widget.user_id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Column(children: [
      Container(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(20),
                color: HexColor("#F0F0F0"),
                child:Row(
                  children:  [
                    //Utils.
                    Container(
                      width: MediaQuery.of(context).size.width/1.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // const Gap(12),
                          Utils.mediumHeadingNormalText(text: UtilStrings.Matches,textSize: 14,color: HexColor("#A8580F")),
                          Row(children: [
                            GestureDetector(onTap: (){
                              setState(() {
                                isLoading=true;
                                matchPresenter?.onSendRequest(widget.user_id.toString(), "1");
                              });
                            }, child:Container(
                              height: 28,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: HexColor('#FF483C')
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Utils.mediumHeadingNormalText(text:UtilStrings.Entering_my_eye,textSize: 8,fontWeight:  FontWeight.bold,color: AppColor.white,overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ),),
                            Gap(8),
                            GestureDetector(onTap: (){
                              setState(() {
                                isLoading=true;
                                matchPresenter?.onSendRequest(widget.user_id.toString(), "0");
                              });
                            }, child:Container(
                              height: 28,
                              width: 80,
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
                                    "assets/images/icon_waving.png",
                                    height: 14,
                                    width: 14,),
                                  const Gap(
                                      5),
                                  Utils.mediumHeadingNormalText(
                                      text: UtilStrings.Waive,
                                      textSize: 12,
                                      fontWeight: FontWeight
                                          .bold,
                                      color: AppColor
                                          .black,
                                      overflow: TextOverflow
                                          .ellipsis),
                                ],
                              ),
                            )),
                          ],),
                        ],
                      ),
                    ),
                    Gap(12),
                  ],
                )),
            const Gap(12),
            SingleChildScrollView(
              child: Stack(children: [
                userData!=null?Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(Responsive().getResponsiveValue(
                                forLargeScreen: 14.0,
                                forShortScreen: 6.0,
                                forMobLandScapeMode: 0.0,
                                forMediumScreen: 6.0,
                                forTabletScreen: 6.0,
                                context: context)),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Utils.mediumHeadingNormalText(text:userData!.name.toString(),textSize: 14,fontWeight: FontWeight.normal,color: AppColor.APP_TEXT_COLOR),
                                        Container(
                                          child: Row(
                                            children: [
                                              Utils.mediumHeadingNormalText(text:userData!.age.toString(),textSize: 12,fontWeight: FontWeight.normal,color: AppColor.APP_TEXT_COLOR_SECOND),
                                              Utils.customBlackDot(),
                                              Utils.mediumHeadingNormalText(text:userData!.residenceCountry.toString(),textSize: 12,fontWeight: FontWeight.normal,color: AppColor.APP_TEXT_COLOR_SECOND),
                                              Utils.customBlackDot(),
                                              Utils.mediumHeadingNormalText(text:userData!.employment.toString(),textSize: 12,fontWeight: FontWeight.normal,color: AppColor.APP_TEXT_COLOR_SECOND),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Gap(12),

                                  ],
                                ),
                                Gap(12),
                                Utils.mediumHeadingNormalText(
                                    text: UtilStrings.About_me,
                                    fontFamily: 'Poppins',
                                    color: AppColor.black,
                                    textSize: 12),
                                Container(
                                    width: Responsive().getResponsiveValue(
                                        forLargeScreen: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 2.2,
                                        forShortScreen: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 1.4,
                                        forMobLandScapeMode: 0.0,
                                        forMediumScreen: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 1.4,
                                        forTabletScreen: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 2.0,
                                        context: context),
                                    child: Utils.mediumHeadingNormalText(
                                        text: userData!.aboutMe.toString(),
                                        fontFamily: 'Poppins',
                                        color: AppColor.APP_TEXT_COLOR_SECOND,
                                        textAlign: TextAlign.start,
                                        textSize: 12)),
                              ],),

                          ],),),
                      Gap(12),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Utils.profileView(title: "Images", name: ""),
                              /*  Utils.imageView(image: "assets/images/icon_edit.png",
                                    width: 16,
                                    height: 16,
                                    color: HexColor("#FFFFFF"))*/
                              ],),
                            Container(
                              height: 120,width: size.width/1.2,
                              child: ListView.builder(
                                  itemCount: userData!.userImagesWhileSignup !=
                                      null ? userData!.userImagesWhileSignup!
                                      .length : 0,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: (){
                                        Utils.viewPhoto(context, IMAGE_URL + userData!
                                            .userImagesWhileSignup![index]!.imageUrl
                                            .toString());
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(right: 6),
                                        height: 120, width: 100,
                                        child: CachedNetworkImage(
                                          imageUrl: IMAGE_URL + userData!
                                              .userImagesWhileSignup![index]!.imageUrl
                                              .toString(),
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
                                          errorWidget: (context, url,
                                              error) => const Image(image: AssetImage(
                                              "assets/images/icon_loading.png")),
                                        ),
                                      ),
                                    );
                                  }),),
                          ],),),
                      Gap(12),
                      Container(
                        decoration: BoxDecoration(
                            color: HexColor("#F8F8F8"),
                            borderRadius: BorderRadius.circular(8)
                        ), /*margin: EdgeInsets.only(left: Responsive().getResponsiveValue(
                                                        forLargeScreen:  12,
                                                        forShortScreen:  0,
                                                        forMobLandScapeMode: 0,
                                                        forMediumScreen: 0,
                                                        forTabletScreen:0,
                                                        context: context),right: Responsive().getResponsiveValue(
                                                        forLargeScreen:  12,
                                                        forShortScreen:  0,
                                                        forMobLandScapeMode: 0,
                                                        forMediumScreen: 0,
                                                        forTabletScreen:0,
                                                        context: context)),*/
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Utils.profileView(title: UtilStrings.Full_Name,
                                    name: userData!.name.toString()),
                                Utils.profileView(title: UtilStrings.Age,
                                    name: userData!.age.toString() +
                                        " years".toString()),
                              /*  Utils.imageView(image: "assets/images/icon_edit.png",
                                    width: 16,
                                    height: 16,
                                    color: HexColor("#F8F8F8"))*/
                              ],),
                            Gap(12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Utils.profileView(title: UtilStrings.Gender,
                                    name: userData!.gender.toString() == "0"
                                        ? "Male"
                                        : "Female"),
                                Utils.profileView(title: UtilStrings.Interested_In,
                                    name: userData!.interestedIn.toString() == "2"
                                        ? "Male"
                                        : "Female"),
                              /*  Utils.imageView(image: "assets/images/icon_edit.png",
                                    width: 16,
                                    height: 16,
                                    color: HexColor("#F8F8F8"))*/
                              ],),
                          ],),),
                      Gap(12),
                      Container(
                        /* margin: EdgeInsets.only(
                                                        right: Responsive().getResponsiveValue(
                                                            forLargeScreen: 22.0,
                                                            forShortScreen: 0.0,
                                                            context: context),),*/
                        decoration: BoxDecoration(
                            color: HexColor("#F8F8F8"),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Utils.profileView(title: UtilStrings.Status,
                                    name: userData!.status.toString()),
                                Utils.profileView(title: UtilStrings.Body_Type,
                                    name: userData!.bodyType.toString()),
                               /* Utils.imageView(image: "assets/images/icon_edit.png",
                                    width: 16,
                                    height: 16,
                                    color: HexColor("#F8F8F8"))*/
                              ],),
                            Gap(12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Utils.profileView(title: UtilStrings.Heightp,
                                    name: userData!.height.toString()),
                                Utils.profileView(title: UtilStrings.Education,
                                    name: userData!.education.toString()),
                                /*Utils.imageView(image: "assets/images/icon_edit.png",
                                    width: 16,
                                    height: 16,
                                    color: HexColor("#F8F8F8"))*/
                              ],),
                            Gap(12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Utils.profileView(title: UtilStrings.Employment,
                                    name: userData!.employment.toString()),
                                Utils.profileView(title: "", name: ""),
                              /*  Utils.imageView(image: "assets/images/icon_edit.png",
                                    width: 16,
                                    height: 16,
                                    color: HexColor("#F8F8F8"))*/
                              ],),
                            Gap(12),
                          ],),),
                      Gap(12),
                      Container(
                        decoration: BoxDecoration(
                            color: HexColor("#F8F8F8"),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Utils.mediumHeadingNormalText(
                                        text: UtilStrings.Country_of_Residence,
                                        textAlign: TextAlign.left,
                                        fontFamily: 'Poppins',
                                        color: AppColor.black,
                                        textSize: 12),
                                    Utils.mediumHeadingNormalText(
                                        text:  userData!.residenceCountry.toString(),
                                        fontFamily: 'Poppins',
                                        color: AppColor.APP_TEXT_COLOR_SECOND,
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        textSize: 12),
                                  ],
                                ),
                                Utils.profileView(
                                    title: UtilStrings.State, name:  userData!.state.toString()),
                               /* Utils.imageView(image: "assets/images/icon_edit.png",
                                    width: 16,
                                    height: 16,
                                    color: HexColor("#F8F8F8"))*/
                              ],),
                            Gap(12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Utils.profileView(title: UtilStrings.Nationality,
                                    name: userData!.nationality.toString()),
                                Utils.profileView(title: UtilStrings.City,
                                    name: userData!.city.toString()),
                               /* Utils.imageView(image: "assets/images/icon_edit.png",
                                    width: 16,
                                    height: 16,
                                    color: HexColor("#F8F8F8"))*/
                              ],),
                            Gap(12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Utils.profileView(title: UtilStrings.Religion,
                                    name: userData!.religion.toString()),
                                Utils.profileView(title: UtilStrings.Your_Tribe,
                                    name: userData!.yourTribe.toString()),
                               /* Utils.imageView(image: "assets/images/icon_edit.png",
                                    width: 16,
                                    height: 16,
                                    color: HexColor("#F8F8F8"))*/
                              ],),
                            Gap(12),
                          ],),),
                      Gap(12),
                      Container(
                        decoration: BoxDecoration(
                            color: HexColor("#F8F8F8"),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Utils.mediumHeadingNormalText(
                                        text: UtilStrings.Age_Range_preferred_to_date,
                                        textAlign: TextAlign.left,
                                        fontFamily: 'Poppins',
                                        color: AppColor.black,
                                        textSize: 12),
                                    Utils.mediumHeadingNormalText(
                                        text:  userData!.ageRangeForDate.toString(),
                                        fontFamily: 'Poppins',
                                        color: AppColor.APP_TEXT_COLOR_SECOND,
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        textSize: 12),
                                  ],
                                ),
                              ],),
                            Gap(12),
                           /* Utils.imageView(image: "assets/images/icon_edit.png",
                                width: 16,
                                height: 16,
                                color: HexColor("#F8F8F8")),*/
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               /* Utils.profileView(title: UtilStrings.Looking_for,
                                    name: userData!.lookingFor.toString()),*/
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 120,
                                      child: Utils.mediumHeadingNormalText(
                                          text: UtilStrings.Looking_for,
                                          textAlign: TextAlign.left,
                                          fontFamily: 'Poppins',
                                          color: AppColor.black,
                                          textSize: 12),
                                    ),
                                    Container(
                                      width: 140,
                                      child: Utils.mediumHeadingNormalText(
                                          text: userData!.lookingFor.toString(),
                                          fontFamily: 'Poppins',
                                          color: AppColor.APP_TEXT_COLOR_SECOND,
                                          textAlign: TextAlign.start,
                                          // overflow: TextOverflow.ellipsis,
                                          textSize: 12),
                                    ),
                                  ],),
                                Utils.profileView(
                                    title: UtilStrings.Tribe_to_date, name: userData!.tribeToDate.toString()),
                                // Utils.profileView(title: "", name: ""),
                                /*Utils.imageView(image: "assets/images/icon_edit.png",
                                    width: 16,
                                    height: 16,
                                    color: HexColor("#F8F8F8"))*/
                              ],),
                          ],),),
                      Gap(12),
                      Gap(Responsive().getResponsiveValue(
                          forLargeScreen: 12.0,
                          forShortScreen: 32.0,
                          context: context)),
                    ],
                  ),):Container(
                  alignment: Alignment.center,
                  child: Utils.mediumHeadingNormalText(
                      text: isLoading ==
                          false
                          ? UtilStrings
                          .NO_RECORD
                          : "",
                      textSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                      textAlign: TextAlign.end),
                ),
                Utils.progressDialog(context, isLoading, type: 3)
              ],),
            )
          ],
        ),
      ),

    ],);
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
      }
    });
  }

  @override
  onSendRequest(SuccessResponse response) {
    setState(() {
      isLoading=false;
      if(response.status==200){
        Utils.customDialog(context,message:response.message.toString());
        Navigator.pop(context);
      }else{
      }
    });
  }

  @override
  onUpdateFloorStatusData(SuccessResponse response) {
  }

  @override
  onMatch(MatchResponse response) {

  }

  @override
  onRequestError(String msg, int status) {
    print("onError===>"+msg);
    setState(() {
      isLoading=false;
    });
    if(status==400){
      Utils.customDialog(context,message: msg.toString());
    }
    else if(status==401){
      Utils.sessionExpire(context);
    }
    else if(status==404){
      Utils.sessionExpire(context);
    }
  }

  @override
  onLikeShortsData(LikeShortResponse response) {

  }
}


