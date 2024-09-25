import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/module/model/like_shorts_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import 'package:likeplay/module/model/user_profile_response.dart';
import 'package:likeplay/module/profile/profile_presenter.dart';
import 'package:likeplay/utils/constant_lists.dart';
import 'package:likeplay/utils/sharedpref/preferences.dart';
import 'package:likeplay/utils/sharedpref/shared_prefrence.dart';
import 'package:need_resume/need_resume.dart';

import '../../../utils/color_utils.dart';
import '../../../utils/responsive.dart';
import '../../utils/string_utils.dart';
import '../../utils/utils.dart';
import '../home/home.dart';

class UsersProfileScreen extends StatefulWidget {
  int? type;
  String? user_id;
  UsersProfileScreen({
    required this.type,
    required this.user_id,
  });
  @override
  State<UsersProfileScreen> createState() => _UsersProfileScreenState();
}

class _UsersProfileScreenState extends ResumableState<UsersProfileScreen> implements  ProfileInterface{
  bool isLoading=false;
  UserData? userData;
  ProfilePresenter? profilePresenter;
  @override
  void initState() {
    super.initState();
    profilePresenter=ProfilePresenter(this);
    setState(() {
      isLoading=true;
      profilePresenter?.doUserResponseData(widget.user_id.toString());
    });
  }

  @override
  void onResume() {
    print("_UsersProfileScreenState====");
    profilePresenter?.doUserResponseData(widget.user_id.toString());
    super.onResume();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
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
                        Utils.mediumHeadingNormalText(
                            text: UtilStrings.About_me,
                            fontFamily: 'Poppins',
                            color: AppColor.black,
                            textSize: 12),
                        Gap(12),
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
                                text: userData!.aboutMe.toString() ==
                                    "null"
                                    ? "NA"
                                    : userData!.aboutMe.toString(),
                                fontFamily: 'Poppins',
                                color: AppColor.APP_TEXT_COLOR_SECOND,
                                textAlign: TextAlign.start,
                                textSize: 12)),
                      ],),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        if(widget.type==1){
                          push(context, MaterialPageRoute(builder: (context)=>
                              HomeScreen(
                                viewType:10,
                                comesFrom: "EditFromProfile",
                              )));
                        }
                      },
                      child: Utils.imageView(image: "assets/images/icon_edit.png",
                          width: 16,
                          height: 16,
                          color: widget.type==0?HexColor("#FFFFFF"):HexColor("#FF483C")),
                    )
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
                        GestureDetector(
                          onTap: (){
                            if(widget.type==1){
                              push(context, MaterialPageRoute(builder: (context)=>
                                  HomeScreen(
                                    viewType:11,
                                    comesFrom: "EditFromProfile",
                                  )));
                            }
                          },
                          child: Utils.imageView(image: "assets/images/icon_edit.png",
                              width: 16,
                              height: 16,
                              color: widget.type==0?HexColor("#FFFFFF"):HexColor("#FF483C")),
                        )
                      ],),
                    Container(
                      height: 120, width: size.width/1.2,
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
                                                Radius.circular(16)),
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
                            name: userData!.name.toString() ==
                                "null"
                                ? "NA"
                                :  userData!.name.toString(),),
                        Utils.profileView(title: UtilStrings.Age,
                            name: userData!.age.toString() ==
                                "null"
                                ? "NA"
                                :  userData!.age.toString() +
                                " years".toString(),),
                        GestureDetector(
                          onTap: (){
                            if(widget.type==1){
                              SessionManager.setString(Preferences.VALUE, "1");
                              push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                                viewType:6,
                                comesFrom: "EditFromProfile",
                              )));
                            }
                          },
                          child: Utils.imageView(image: "assets/images/icon_edit.png",
                              width: 16,
                              height: 16,
                              color: widget.type==0?HexColor("#FFFFFF"):HexColor("#FF483C")),
                        )
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
                        Utils.imageView(image: "assets/images/icon_edit.png",
                            width: 16,
                            height: 16,
                            color:widget.type==0?HexColor("#FFFFFF"):HexColor("#F8F8F8"))
                      ],),
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
                        Utils.profileView(title: UtilStrings.Status,
                            name: userData!.status.toString() ==
                                "null"
                                ? "NA"
                                :  userData!.status.toString(),),
                        Utils.profileView(title: UtilStrings.Body_Type,
                            name: userData!.bodyType.toString() ==
                                "null"
                                ? "NA"
                                :  userData!.bodyType.toString(),),
                        GestureDetector(
                          onTap: (){
                            if(widget.type==1){
                              SessionManager.setString(Preferences.VALUE, "0");
                              push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                                viewType:7,
                                comesFrom: "EditFromProfile",
                              )));
                            }
                          },
                          child: Utils.imageView(image: "assets/images/icon_edit.png",
                              width: 16,
                              height: 16,
                              color: widget.type==0?HexColor("#FFFFFF"):HexColor("#FF483C")),
                        )
                      ],),
                    Gap(12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Utils.profileView(title: UtilStrings.Heightp,
                            name:  userData!.height.toString() ==
                                "null"
                                ? "NA"
                                :  userData!.height.toString(),),
                        Utils.profileView(title: UtilStrings.Education,
                            name: userData!.education.toString() ==
                                "null"
                                ? "NA"
                                :  userData!.education.toString(),),
                        Utils.imageView(image: "assets/images/icon_edit.png",
                            width: 16,
                            height: 16,
                            color: widget.type==0?HexColor("#FFFFFF"):HexColor("#F8F8F8"))
                      ],),
                    Gap(12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Utils.profileView(title: UtilStrings.Employment,
                            name: userData!.employment.toString() ==
                                "null"
                                ? "NA"
                                : userData!.employment.toString(),),
                        Utils.profileView(title: "", name: ""),
                        Utils.imageView(image: "assets/images/icon_edit.png",
                            width: 16,
                            height: 16,
                            color: widget.type==0?HexColor("#FFFFFF"):HexColor("#F8F8F8"))
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
                        /*Utils.profileView(title: UtilStrings.Country_of_Residence,
                            name: userData!.residenceCountry.toString() ==
                                "null"
                                ? "NA"
                                : userData!.residenceCountry.toString()),*/
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 140,
                              child: Utils.mediumHeadingNormalText(
                                  text: UtilStrings.Country_of_Residence,
                                  textAlign: TextAlign.left,
                                  fontFamily: 'Poppins',
                                  color: AppColor.black,
                                  textSize: 12),
                            ),
                            Container(
                              width: 140,
                              child: Utils.mediumHeadingNormalText(
                                  text: userData!.residenceCountry.toString() ==
                                      "null"
                                      ? "NA"
                                      : userData!.residenceCountry.toString(),
                                  fontFamily: 'Poppins',
                                  color: AppColor.APP_TEXT_COLOR_SECOND,
                                  textAlign: TextAlign.left,
                                  textSize: 12),
                            ),
                          ],
                        ),
                        Utils.profileView(
                            title: UtilStrings.State, name:userData!.state.toString() ==
                            "null"
                            ? "NA"
                            : userData!.state.toString() ),
                        GestureDetector(
                          onTap: (){
                            if(widget.type==1){
                              SessionManager.setString(Preferences.VALUE_ADDRESS, "1");
                              push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                                viewType:8,
                                comesFrom: "EditFromProfile",
                              )));
                            }
                          },
                          child: Utils.imageView(image: "assets/images/icon_edit.png",
                              width: 16,
                              height: 16,
                              color: widget.type==0?HexColor("#FFFFFF"):HexColor("#FF483C")),
                        ),
                      ],),
                    Gap(12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Utils.profileView(title: UtilStrings.Nationality,
                            name:userData!.nationality.toString() ==
                                "null"
                                ? "NA"
                                : userData!.nationality.toString()),
                        Utils.profileView(title: UtilStrings.City,
                            name: userData!.city.toString() ==
                                "null"
                                ? "NA"
                                : userData!.city.toString()),
                        Utils.imageView(image: "assets/images/icon_edit.png",
                            width: 16,
                            height: 16,
                            color:widget.type==0?HexColor("#FFFFFF"):HexColor("#F8F8F8"))
                      ],),
                    Gap(12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Utils.profileView(title: UtilStrings.Religion,
                            name:userData!.religion.toString() ==
                                "null"
                                ? "NA"
                                : userData!.religion.toString()),
                        Utils.profileView(title: UtilStrings.Your_Tribe,
                            name:userData!.yourTribe.toString() ==
                                "null"
                                ? "NA"
                                : userData!.yourTribe.toString()),
                        Utils.imageView(image: "assets/images/icon_edit.png",
                            width: 16,
                            height: 16,
                            color:widget.type==0?HexColor("#FFFFFF"):HexColor("#F8F8F8"))
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
                        text: UtilStrings.Age_Range_preferred_to_date,
                        textAlign: TextAlign.left,
                        fontFamily: 'Poppins',
                        color: AppColor.black,
                        textSize: 12),
                    Utils.mediumHeadingNormalText(
                        text: userData!.ageRangeForDate.toString() ==
                            "null"
                            ? "NA"
                            : userData!.ageRangeForDate.toString(),
                        fontFamily: 'Poppins',
                        color: AppColor.APP_TEXT_COLOR_SECOND,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        textSize: 12),
                  ],),
                       /* Utils.profileView(
                            title: UtilStrings.Age_Range_preferred_to_date,
                            name: userData!.ageRangeForDate.toString() ==
                                "null"
                                ? "NA"
                                : userData!.ageRangeForDate.toString()),*/
                        GestureDetector(
                          onTap: (){
                            if(widget.type==1){
                              SessionManager.setString(Preferences.VALUE_ADDRESS, "0");
                              push(context, MaterialPageRoute(builder: (context)=>
                                  HomeScreen(
                                    viewType:9,
                                    comesFrom: "EditFromProfile",
                                  )));
                            }
                          },
                          child: Utils.imageView(image: "assets/images/icon_edit.png",
                              width: 16,
                              height: 16,
                              color: widget.type==0?HexColor("#FFFFFF"):HexColor("#FF483C")),
                        )
                      ],),
                    Gap(12),
                    Utils.profileView(
                        title: UtilStrings.Tribe_to_date, name:
                    userData!.tribeToDate.toString() ==
                        "null"
                        ? "NA"
                        : userData!.tribeToDate.toString()
                    ),
                    Gap(12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Utils.profileView(title: UtilStrings.Looking_for,
                            name:userData!.lookingFor.toString() ==
                                "null"
                                ? "NA"
                                : userData!.lookingFor.toString() ),
                        Utils.profileView(title: "", name: ""),
                        Utils.imageView(image: "assets/images/icon_edit.png",
                            width: 16,
                            height: 16,
                            color:widget.type==0?HexColor("#FFFFFF"):HexColor("#F8F8F8"))
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
        Utils.progressDialog(context, isLoading,type: 2)
      ],),
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
  List<String> imageList=[];
  List<String> listImageID=[];
  @override
  onProfileResponse(UserProfileResponse response) {
    setState(() {
      isLoading=false;
      if(response.status==200){
        userData=response.data;
        if( SessionManager.getString(Preferences.USER_ID)==widget.user_id){
          SessionManager.setString(Preferences.NAME, response.data!.name.toString());
          SessionManager.setString(Preferences.USER_NAME, response.data!.name.toString());
          SessionManager.setString(Preferences.AGE, response.data!.age.toString());
          SessionManager.setString(Preferences.GENDER, response.data!.gender.toString());
          SessionManager.setString(Preferences.INTERESTED_IN, response.data!.interestedIn.toString());
          SessionManager.setString(Preferences.STATUS, response.data!.status.toString());
          SessionManager.setString(Preferences.BODY_TYPE, response.data!.bodyType.toString());
          SessionManager.setString(Preferences.HEIGHT, response.data!.height.toString());
          SessionManager.setString(Preferences.EDUCATION, response.data!.education.toString());
          SessionManager.setString(Preferences.EMPLOYMENT, response.data!.employment.toString());
          SessionManager.setString(Preferences.RESIDENCE_COUNTRY, response.data!.residenceCountry.toString());
          SessionManager.setString(Preferences.STATE, response.data!.state.toString());
          SessionManager.setString(Preferences.CITY, response.data!.city.toString());
          SessionManager.setString(Preferences.NATIONALITY, response.data!.nationality.toString());
          SessionManager.setString(Preferences.RELIGION, response.data!.religion.toString());
          SessionManager.setString(Preferences.TRIBE, response.data!.yourTribe.toString());
          SessionManager.setString(Preferences.AGE_RANGE, response.data!.ageRangeForDate.toString());
          SessionManager.setString(Preferences.TRIBE_TO_DATE, response.data!.tribeToDate.toString());
          SessionManager.setString(Preferences.TRIBE_IRRELAVANT, response.data!.tribeIrrelevant.toString());
          SessionManager.setString(Preferences.LOOKING_FOR, response.data!.lookingFor.toString());
          SessionManager.setString(Preferences.ABOUT_ME, response.data!.aboutMe.toString());
          SessionManager.setString(Preferences.verification_status,response.data!.userVerification.toString());
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
          imageList.clear();
          listImageID.clear();
          for (var images in  response.data!.userImagesWhileSignup!) {
            imageList.add(IMAGE_URL+images.imageUrl.toString());
            listImageID.add(images.id.toString());
          }
          SessionManager.setStringList(Preferences.IMAGE_ID, listImageID);
          SessionManager.setStringList(Preferences.IMAGE_LIST, imageList);
        }
        }
    });
  }

  @override
  onUpdateFloorStatusData(SuccessResponse response) {

  }

  @override
  onLikeShortsData(LikeShortResponse response) {

  }
}







