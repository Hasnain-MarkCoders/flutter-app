import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/module/home/home.dart';
import 'package:likeplay/module/home/register/presenter/profile_update_presenter.dart';
import 'package:likeplay/module/model/photo_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import 'package:likeplay/module/model/update_profile_response.dart';
import 'package:likeplay/module/model/user_profile_response.dart';
import 'package:likeplay/utils/color_utils.dart';
import 'package:likeplay/utils/responsive.dart';
import 'package:likeplay/utils/route/route_name.dart';
import 'package:likeplay/utils/sharedpref/preferences.dart';
import 'package:likeplay/utils/sharedpref/shared_prefrence.dart';
import 'package:likeplay/utils/string_utils.dart';
import 'package:likeplay/utils/utils.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../model/phone_verification_response.dart';
import '../../../utils/constant_lists.dart';
import 'package:lottie/lottie.dart';

class ProfileViewScreen extends StatefulWidget {
  int? viewType;
  String? comesFrom;
  ProfileViewScreen({Key? key,this.viewType,this.comesFrom}) : super(key: key);
  @override
  State<ProfileViewScreen> createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> implements ProfileUpdateInterface{
  bool isLoading = false;
  bool floorPage = true;
  ProfileUpdatePresenter? profileUpdatePresenter;
  bool isSwitched = true;
  List<String> imageList=[];
  List<String> listImageID=[];
  UserData? userData;
  @override
  void initState() {
    super.initState();
    profileUpdatePresenter=ProfileUpdatePresenter(this);
    setState(() {
      isLoading=true;
      profileUpdatePresenter?.doUserResponseData(SessionManager.getString(Preferences.USER_ID));
    });
  }
  Future<bool> _onWillPop() async {
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen(viewType: 0,)));
    Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(builder: (BuildContext context) =>  HomeScreen(viewType: 0,)),
      ModalRoute.withName('/'),
    );
    return true;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SingleChildScrollView(
          child:
          ResponsiveRowColumn(
            rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
            rowCrossAxisAlignment: CrossAxisAlignment.center,
            layout: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                ? ResponsiveRowColumnType.COLUMN
                : ResponsiveRowColumnType.ROW,
            children: [
              ResponsiveRowColumnItem(
                  rowFlex: 2, child: Row(
                mainAxisAlignment: Responsive().getResponsiveValue(
                    forLargeScreen: MainAxisAlignment.start,
                    forShortScreen: MainAxisAlignment.center,
                    context: context),
                children: [
                  Gap(Responsive().getResponsiveValue(
                      forLargeScreen: 32.0,
                      forShortScreen: 0.0,
                      context: context)),
                  Column(
                    crossAxisAlignment: Responsive().getResponsiveValue(
                        forLargeScreen: CrossAxisAlignment.start,
                        forShortScreen: CrossAxisAlignment.center,
                        context: context),
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Gap(Responsive().getResponsiveValue(
                          forLargeScreen: 0.0,
                          forShortScreen: 40.0,
                          context: context)),
                      Gap(Responsive().getResponsiveValue(
                          forLargeScreen: 0.0,
                          forShortScreen: 8.0,
                          context: context),),
                    ],
                  )
                ],)),
              ResponsiveRowColumnItem(
                rowFlex: 1, child: SizedBox(
                /*height: Responsive().getResponsiveValue(
                    forLargeScreen: MediaQuery
                        .of(context)
                        .size
                        .height / 1.1,
                    forShortScreen: MediaQuery
                        .of(context)
                        .size
                        .height,
                    forMobLandScapeMode: MediaQuery
                        .of(context)
                        .size
                        .height / 1.2,
                    forMediumScreen: MediaQuery
                        .of(context)
                        .size
                        .height / 1.2,
                    forTabletScreen: MediaQuery
                        .of(context)
                        .size
                        .height,
                    context: context),
                width: Responsive().getResponsiveValue(
                    forLargeScreen: MediaQuery
                        .of(context)
                        .size
                        .width / 1.2,
                    forShortScreen: MediaQuery
                        .of(context)
                        .size
                        .width,
                    forMobLandScapeMode: MediaQuery
                        .of(context)
                        .size
                        .width / 2,
                    forMediumScreen: MediaQuery
                        .of(context)
                        .size
                        .width / 2,
                    forTabletScreen: MediaQuery
                        .of(context)
                        .size
                        .width / 2,
                    context: context),*/
                child: Stack(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Gap(Responsive().getResponsiveValue(
                          forLargeScreen: 32.0,
                          forShortScreen: 22.0,
                          context: context)),
                      Container(
                          alignment: Alignment.centerLeft,
                          width: Responsive().getResponsiveValue(
                              forLargeScreen: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 1.5,
                              forShortScreen: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              forMobLandScapeMode: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 4.2,
                              forMediumScreen: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 1.5,
                              forTabletScreen: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 1.5,
                              context: context),
                          margin: EdgeInsets.only(left: Responsive().getResponsiveValue(
                              forLargeScreen: 0.0,
                              forShortScreen: 22.0,
                              forMobLandScapeMode: 22.0,
                              forMediumScreen: 22.0,
                              forTabletScreen: 22.0,
                              context: context), right: Responsive().getResponsiveValue(
                              forLargeScreen: 36.0,
                              forShortScreen: 22.0,
                              forMobLandScapeMode: 22.0,
                              forMediumScreen: 22.0,
                              forTabletScreen: 22.0,
                              context: context),),
                          child:Image.asset(
                            'assets/images/step_complete.png',
                            width: Responsive().getResponsiveValue(
                                forLargeScreen: size.width / 2,
                                forShortScreen: size.width / 1.1,
                                forMobLandScapeMode: size.width / 2,
                                forMediumScreen: size.width / 2,
                                forTabletScreen: size.width / 2,
                                context: context),
                          )),
                      Gap(10),
                      Container(
                          alignment: Alignment.centerLeft,
                          width: Responsive().getResponsiveValue(
                              forLargeScreen: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 1.5,
                              forShortScreen: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              forMobLandScapeMode: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 4.2,
                              forMediumScreen: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 1.5,
                              forTabletScreen: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 1.5,
                              context: context),
                          child:Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Utils.mediumHeadingNormalText(
                                  text: UtilStrings.Profile_Review,
                                  fontFamily: 'Poppins',
                                  color: AppColor.white,
                                  left: Responsive().getResponsiveValue(
                                      forLargeScreen: 0.0,
                                      forShortScreen: 22.0,
                                      forMobLandScapeMode: 22.0,
                                      forMediumScreen: 22.0,
                                      forTabletScreen: 22.0,
                                      context: context),
                                  textSize: 14),
                            ],)),
                      Gap(6),
                      Container(
                          alignment: Alignment.centerLeft,
                          width: Responsive().getResponsiveValue(
                              forLargeScreen: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 1.5,
                              forShortScreen: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              forMobLandScapeMode: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 4.2,
                              forMediumScreen: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 1.5,
                              forTabletScreen: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 1.5,
                              context: context),
                          child: Utils.mediumHeadingNormalText(
                              text: UtilStrings
                                  .Please_review_your_profile_before_submission,
                              fontFamily: 'Poppins',
                              color: AppColor.white,
                              left: Responsive().getResponsiveValue(
                                  forLargeScreen: 0.0,
                                  forShortScreen: 22.0,
                                  forMobLandScapeMode: 22.0,
                                  forMediumScreen: 22.0,
                                  forTabletScreen: 22.0,
                                  context: context),
                              right: Responsive().getResponsiveValue(
                                  forLargeScreen: 36.0,
                                  forShortScreen: 22.0,
                                  forMobLandScapeMode: 22.0,
                                  forMediumScreen: 22.0,
                                  forTabletScreen: 22.0,
                                  context: context),
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.normal,
                              textSize: 10)),
                      Gap(10),
                      userData!=null?Container(
                        width: Responsive().getResponsiveValue(
                            forLargeScreen: MediaQuery
                                .of(context)
                                .size
                                .width / 1.5,
                            forShortScreen: MediaQuery
                                .of(context)
                                .size
                                .width,
                            forMobLandScapeMode: MediaQuery
                                .of(context)
                                .size
                                .height / 4.2,
                            forMediumScreen: MediaQuery
                                .of(context)
                                .size
                                .width / 1.5,
                            forTabletScreen: MediaQuery
                                .of(context)
                                .size
                                .width / 1.5,
                            context: context),
                        padding: EdgeInsets.only(left: Responsive()
                            .getResponsiveValue(
                            forLargeScreen: 12.0,
                            forShortScreen: 12.0,
                            forMobLandScapeMode: 12.0,
                            forMediumScreen: 12.0,
                            forTabletScreen: 12.0,
                            context: context),
                          top: Responsive().getResponsiveValue(
                              forLargeScreen: 16.0,
                              forShortScreen: 16.0,
                              context: context),
                          bottom: Responsive().getResponsiveValue(
                              forLargeScreen: 12.0,
                              forShortScreen: 32.0,
                              forMobLandScapeMode: 12.0,
                              forMediumScreen: 12.0,
                              forTabletScreen: 12.0,
                              context: context),),
                        margin: EdgeInsets.only(
                          left: Responsive().getResponsiveValue(
                              forLargeScreen: 0.0,
                              forShortScreen: 16.0,
                              forMobLandScapeMode: 0.0,
                              forMediumScreen: 0.0,
                              forTabletScreen: 0.0,
                              context: context),
                          right: Responsive().getResponsiveValue(
                              forLargeScreen: 36.0,
                              forShortScreen: 16.0,
                              forMobLandScapeMode: 0.0,
                              forMediumScreen: 0.0,
                              forTabletScreen: 0.0,
                              context: context),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white,
                              width: 1.0,
                              style: BorderStyle.solid
                          ),
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: Responsive().getResponsiveValue(
                                forLargeScreen: 8.0,
                                forShortScreen: 8.0,
                                context: context),
                            top: Responsive().getResponsiveValue(
                                forLargeScreen: 0.0,
                                forShortScreen: 0.0,
                                context: context),
                            right: Responsive().getResponsiveValue(
                                forLargeScreen: 0.0,
                                forShortScreen: 20.0,
                                context: context),),
                          child: Stack(children: [
                            Column(
                              children: [
                                     Stack(
                                       children: [
                                         Column(
                                           children: [
                                             Container(
                                               margin: EdgeInsets.only(
                                                 right: Responsive().getResponsiveValue(
                                                     forLargeScreen: 22.0,
                                                     forShortScreen: 0.0,
                                                     context: context),),
                                               decoration: BoxDecoration(
                                                   border: Border.all(color:HexColor("#E2E2E2")),
                                                   borderRadius:BorderRadius.circular(10)
                                               ),
                                               alignment: Alignment.center,
                                               padding: EdgeInsets.all(6),
                                               child:Column(
                                                 mainAxisAlignment: MainAxisAlignment.start,
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   Row(
                                                     mainAxisAlignment:MainAxisAlignment.spaceAround,
                                                     children: [
                                                       Utils.profileViewSignUp(title: UtilStrings.Full_Name,name: userData!.name.toString()),
                                                       Utils.profileViewSignUp(title: UtilStrings.Age,name: userData!.age.toString()),
                                                       Utils.profileViewSignUp(title: UtilStrings.Gender,name: userData!.gender.toString()=="0"?"Male":"Female"),
                                                       SessionManager.getString(Preferences.verification_status)=="2"?       GestureDetector(
                                                           onTap: (){
                                                             Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                                                               viewType:6,
                                                               comesFrom: "EditProfileUser",
                                                             )));
                                                           },
                                                           child: Utils.imageView(image: "assets/images/icon_edit.png",width: 16,height: 16))
                                                           :Container()
                                                     ],),
                                                   Gap(12),
                                                   Row(
                                                     mainAxisAlignment:MainAxisAlignment.start,
                                                     children: [
                                                       Gap(Responsive().getResponsiveValue(
                                                           forLargeScreen: 14.0,
                                                           forShortScreen: 6.0,
                                                           forMobLandScapeMode: 0.0,
                                                           forMediumScreen: 6.0,
                                                           forTabletScreen:6.0,
                                                           context: context)),
                                                       Utils.profileViewSignUp(title: UtilStrings.Interested_In,name: userData!.interestedIn.toString()=="1"?"Female":"Male"),
                                                     ],),
                                                 ],),),
                                             Gap(12),
                                             Container(
                                               margin: EdgeInsets.only(
                                                 right: Responsive().getResponsiveValue(
                                                     forLargeScreen: 22.0,
                                                     forShortScreen: 0.0,
                                                     context: context),),
                                               decoration: BoxDecoration(
                                                   border: Border.all(color:HexColor("#E2E2E2")),
                                                   borderRadius:BorderRadius.circular(10)
                                               ),
                                               alignment: Alignment.center,
                                               padding: EdgeInsets.all(6),
                                               child:Column(
                                                 mainAxisAlignment: MainAxisAlignment.start,
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   Row(
                                                     mainAxisAlignment:MainAxisAlignment.spaceAround,
                                                     children: [
                                                       Utils.profileViewSignUp(title: UtilStrings.Status,name: userData!.status.toString()),
                                                       Utils.profileViewSignUp(title: UtilStrings.Body_Type,name: userData!.bodyType.toString()),
                                                       Utils.profileViewSignUp(title: UtilStrings.Heightp,name: userData!.height.toString()),
                                                       SessionManager.getString(Preferences.verification_status)=="2"?
                                                       GestureDetector(
                                                           onTap: (){
                                                             Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                                                               viewType:7,
                                                               comesFrom: "EditProfile",
                                                             )));
                                                           },
                                                           child: Utils.imageView(image: "assets/images/icon_edit.png",width: 16,height: 16)):Container()
                                                     ],),
                                                   Gap(12),
                                                   Row(
                                                     mainAxisAlignment:MainAxisAlignment.spaceAround,
                                                     children: [
                                                       Utils.profileViewSignUp(title: UtilStrings.Education,name: userData!.education.toString()),
                                                       Utils.profileViewSignUp(title: UtilStrings.Employment,name: userData!.employment.toString()),
                                                       Utils.profileViewSignUp(title: "",name: ""),
                                                       Gap(22)
                                                     ],),
                                                   Gap(12),
                                                 ],),),
                                             Gap(12),
                                             Container(
                                               margin: EdgeInsets.only(
                                                 right: Responsive().getResponsiveValue(
                                                     forLargeScreen: 22.0,
                                                     forShortScreen: 0.0,
                                                     context: context),),
                                               decoration: BoxDecoration(
                                                   border: Border.all(color:HexColor("#E2E2E2")),
                                                   borderRadius:BorderRadius.circular(10)
                                               ),
                                               alignment: Alignment.center,
                                               padding: EdgeInsets.all(6),
                                               child:Column(
                                                 mainAxisAlignment: MainAxisAlignment.start,
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [

                                                   Row(
                                                     mainAxisAlignment:MainAxisAlignment.start,
                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                     children: [
                                                       Gap(8),
                                                       Utils.profileViewSignUp(title: UtilStrings.Country_of_Residence,name: userData!.residenceCountry.toString()),
                                                       Spacer(),
                                                       SessionManager.getString(Preferences.verification_status)=="2"?  GestureDetector(
                                                           onTap: (){
                                                             Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                                                               viewType:8,
                                                               comesFrom: "EditProfileAddress",
                                                             )));
                                                           },
                                                           child: Utils.imageView(image: "assets/images/icon_edit.png",width: 16,height: 16)):Container()
                                                     ],),  Gap(12),
                                                   Row(
                                                     children: [
                                                       Gap(8),
                                                       Utils.profileViewSignUp(title: UtilStrings.State,name: userData!.state.toString()),
                                                       Gap(22),
                                                       Utils.profileViewSignUp(title: UtilStrings.City,name: userData!.city.toString()),

                                                     ],
                                                   ),
                                                   Gap(12),
                                                   Row(
                                                     mainAxisAlignment:MainAxisAlignment.spaceAround,
                                                     children: [
                                                       Utils.profileViewSignUp(title: UtilStrings.Nationality,name: userData!.nationality.toString()),
                                                       Utils.profileViewSignUp(title: UtilStrings.Religion,name: userData!.religion.toString()),
                                                       Utils.profileViewSignUp(title: UtilStrings.Your_Tribe,name: userData!.yourTribe.toString()),
                                                       Gap(22)
                                                     ],),
                                                   Gap(12),
                                                 ],),),
                                             Gap(12),
                                             Container(
                                               margin: EdgeInsets.only(
                                                 right: Responsive().getResponsiveValue(
                                                     forLargeScreen: 22.0,
                                                     forShortScreen: 0.0,
                                                     context: context),),
                                               decoration: BoxDecoration(
                                                   border: Border.all(color:HexColor("#E2E2E2")),
                                                   borderRadius:BorderRadius.circular(10)
                                               ),
                                               alignment: Alignment.center,
                                               padding: EdgeInsets.all(6),
                                               child:Column(
                                                 mainAxisAlignment: MainAxisAlignment.start,
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   Row(
                                                     mainAxisAlignment:MainAxisAlignment.start,
                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                     children: [
                                                       Gap(8),
                                                       Utils.profileViewSignUp(title: UtilStrings.Age_Range_preferred_to_date,name: userData!.ageRangeForDate.toString()),
                                                       Spacer(),
                                                       SessionManager.getString(Preferences.verification_status)=="2"? GestureDetector(
                                                           onTap: (){
                                                             Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                                 HomeScreen(
                                                                   viewType:9,
                                                                   comesFrom: "EditProfile",
                                                                 )));
                                                           },child: Utils.imageView(image: "assets/images/icon_edit.png",width: 16,height: 16)):Container()
                                                     ],),
                                                   Gap(8),
                                                   Row(
                                                     mainAxisAlignment:MainAxisAlignment.start,
                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                     children: [
                                                       Gap(8),
                                                       Utils.profileViewSignUp(title: UtilStrings.Tribe_to_date,name: userData!.tribeToDate.toString()),
                                                     ],
                                                   ),
                                                   Gap(8),
                                                   Row( mainAxisAlignment:MainAxisAlignment.start,
                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                     children: [
                                                       Gap(8),
                                                       Column( mainAxisAlignment:MainAxisAlignment.start,
                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                         children: [
                                                           Utils.mediumHeadingNormalText(
                                                               text:  UtilStrings.Looking_for,
                                                               fontFamily: 'Poppins',
                                                               color: AppColor.black,
                                                               textSize: 10),
                                                           Utils.mediumHeadingNormalText(
                                                               text: userData!.lookingFor.toString(),
                                                               fontFamily: 'Poppins',
                                                               color: AppColor.APP_TEXT_COLOR_SECOND,
                                                               textAlign: TextAlign.start,
                                                               overflow: TextOverflow.ellipsis,
                                                               textSize: 10),
                                                         ],
                                                       ),

                                                       //Utils.profileViewSignUp(title: UtilStrings.Looking_for,name: userData!.lookingFor.toString()),
                                                     ],
                                                   ),
                                                 ],),),
                                             Gap(12),
                                             Container(
                                               margin: EdgeInsets.only(
                                                 right: Responsive().getResponsiveValue(
                                                     forLargeScreen: 22.0,
                                                     forShortScreen: 0.0,
                                                     context: context),),
                                               decoration: BoxDecoration(
                                                   border: Border.all(color:HexColor("#E2E2E2")),
                                                   borderRadius:BorderRadius.circular(10)
                                               ),
                                               alignment: Alignment.centerLeft,
                                               padding: EdgeInsets.all(6),
                                               child:Row(
                                                 mainAxisAlignment: MainAxisAlignment.start,
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   Gap(Responsive().getResponsiveValue(
                                                       forLargeScreen: 14.0,
                                                       forShortScreen: 6.0,
                                                       forMobLandScapeMode: 0.0,
                                                       forMediumScreen: 6.0,
                                                       forTabletScreen:6.0,
                                                       context: context)),
                                                   Column(
                                                     mainAxisAlignment: MainAxisAlignment.start,
                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                     children: [
                                                       Utils.mediumHeadingNormalText(
                                                           text: UtilStrings.About_me,
                                                           fontFamily: 'Poppins',
                                                           color: AppColor.black,
                                                           textSize: 10),
                                                       Container(
                                                           width:Responsive().getResponsiveValue(
                                                               forLargeScreen: MediaQuery.of(context).size.width/4.5,
                                                               forShortScreen: MediaQuery.of(context).size.width/1.9,
                                                               forMobLandScapeMode: 0.0,
                                                               forMediumScreen: MediaQuery.of(context).size.width/1.9,
                                                               forTabletScreen:MediaQuery.of(context).size.width/2.6,
                                                               context: context) ,
                                                           child:Utils.mediumHeadingNormalText(
                                                               text: userData!.aboutMe.toString(),
                                                               fontFamily: 'Poppins',
                                                               color: AppColor.grey,
                                                               textAlign: TextAlign.start,
                                                               textSize: 8)),
                                                     ],),
                                                   Spacer(),
                                                   SessionManager.getString(Preferences.verification_status)=="2"?  GestureDetector(
                                                       onTap:(){
                                                         Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                             HomeScreen(
                                                               viewType:10,
                                                               comesFrom: "EditProfile",
                                                             )));
                                                       },
                                                       child: Utils.imageView(image: "assets/images/icon_edit.png",width: 16,height: 16)):Container(),
                                                   Gap(
                                                       Responsive().getResponsiveValue(
                                                           forLargeScreen: 12.0,
                                                           forShortScreen: 6.0,
                                                           forMobLandScapeMode: 6.0,
                                                           forMediumScreen: 6.0,
                                                           forTabletScreen:12.0,
                                                           context: context)
                                                   )
                                                 ],),),
                                             Gap(12),
                                             Container(
                                               margin: EdgeInsets.only(
                                                 right: Responsive().getResponsiveValue(
                                                     forLargeScreen: 22.0,
                                                     forShortScreen: 0.0,
                                                     context: context),),
                                               decoration: BoxDecoration(
                                                   border: Border.all(color:HexColor("#E2E2E2")),
                                                   borderRadius:BorderRadius.circular(10)
                                               ),
                                               alignment: Alignment.centerLeft,
                                               padding: EdgeInsets.all(6),
                                               child:Row(
                                                 mainAxisAlignment: MainAxisAlignment.start,
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   Gap(Responsive().getResponsiveValue(
                                                       forLargeScreen: 14.0,
                                                       forShortScreen: 6.0,
                                                       forMobLandScapeMode: 0.0,
                                                       forMediumScreen: 6.0,
                                                       forTabletScreen:6.0,
                                                       context: context)),
                                                   Column(
                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                     mainAxisAlignment: MainAxisAlignment.start,
                                                     children: [
                                                       Utils.profileViewSignUp(title: UtilStrings.Upload_Images,name: ""),
                                                       Container(
                                                         height: 56,
                                                         child:  ListView.builder(
                                                             itemCount: userData!.userImagesWhileSignup!=null?userData!.userImagesWhileSignup!.length:0,
                                                             shrinkWrap: true,
                                                             scrollDirection: Axis.horizontal,
                                                             itemBuilder:(BuildContext context, int index){
                                                               return GestureDetector(
                                                                 child:Container(
                                                                   padding: EdgeInsets.only(right: 6),
                                                                   height:52,width:50,
                                                                   child: CachedNetworkImage(
                                                                     imageUrl:IMAGE_URL+userData!.userImagesWhileSignup![index]!.imageUrl.toString(),
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
                                                                   ),
                                                                 ),
                                                               );
                                                             }),),
                                                     ],),
                                                   Spacer(),
                                                   SessionManager.getString(Preferences.verification_status)=="2"?    GestureDetector(
                                                       onTap:(){
                                                         Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                             HomeScreen(
                                                               viewType:11,
                                                               comesFrom: "EditProfile",
                                                             )));
                                                       },
                                                       child: Utils.imageView(image: "assets/images/icon_edit.png",width: 16,height: 16)):Container(),
                                                   Gap(
                                                       Responsive().getResponsiveValue(
                                                           forLargeScreen: 12.0,
                                                           forShortScreen: 6.0,
                                                           forMobLandScapeMode: 6.0,
                                                           forMediumScreen: 6.0,
                                                           forTabletScreen:12.0,
                                                           context: context)
                                                   )
                                                 ],),),
                                             Gap(12),
                                             Container(
                                               margin: EdgeInsets.only(
                                                 right: Responsive().getResponsiveValue(
                                                     forLargeScreen: 80.0,
                                                     forShortScreen: 10.0,
                                                     forMobLandScapeMode: 100.0,
                                                     forMediumScreen: 10.0,
                                                     forTabletScreen:100.0,
                                                     context: context),),
                                               decoration: BoxDecoration(
                                                   border: Border.all(color:HexColor("#E2E2E2")),
                                                   borderRadius:BorderRadius.circular(10)
                                               ),
                                               alignment: Alignment.centerLeft,
                                               padding: EdgeInsets.all(6),
                                               child:Row(
                                                 mainAxisAlignment: MainAxisAlignment.start,
                                                 children: [
                                                   Gap(Responsive().getResponsiveValue(
                                                       forLargeScreen: 14.0,
                                                       forShortScreen: 6.0,
                                                       forMobLandScapeMode: 0.0,
                                                       forMediumScreen: 6.0,
                                                       forTabletScreen:6.0,
                                                       context: context)),
                                                   Utils.mediumHeadingNormalText(
                                                       text: UtilStrings.Introduce_me_on_The_Floor_Page,
                                                       fontFamily: 'Poppins',
                                                       color: AppColor.black,
                                                       textSize: 10),
                                                 Spacer(),
                                                   Transform.scale(
                                                       scale: 0.4,
                                                       child:CupertinoSwitch(
                                                         value: floorPage,
                                                         activeColor: HexColor("#A8580F"),
                                                         onChanged: (value) {
                                                           setState(() {
                                                             floorPage=value;
                                                           });
                                                         },
                                                       )),
                                                 ],),),
                                             Gap(16),
                                           ],
                                         ),
                                         SessionManager.getString(Preferences.verification_status)=="2"?Container():Column(
                                           mainAxisAlignment: MainAxisAlignment.end,
                                           crossAxisAlignment: CrossAxisAlignment.end,
                                           children: [
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.end,
                                               crossAxisAlignment: CrossAxisAlignment.end,
                                               children: [
                                                 Container(
                                                   alignment: Alignment.center,
                                                   height: MediaQuery.of(context).size.height/1.2,
                                                   child: Lottie.asset("assets/images/FloatingHeart.json",fit: BoxFit.fill),
                                                 ),
                                               ],
                                             ),
                                             // Spacer(),
                                             Container(
                                               alignment: Alignment.center,
                                               height: 50,
                                               width: 50,
                                               child: Lottie.asset("assets/images/floating_heart2.json"),
                                             ),
                                           ],
                                         )
                                       ],
                                     ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isLoading=true;
                                        });
                                        //Next
                                        profileUpdatePresenter?.doUserOnFloor(floorPage);
                                        /* Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                                        viewType:12,
                                      )));*/
                                      },
                                      child: Container(
                                        height: 46,
                                        width: Responsive()
                                            .getResponsiveValue(
                                            forLargeScreen: size.width / 9.4,
                                            forShortScreen: size.width / 2.6,
                                            forMobLandScapeMode: size.width /
                                                2.6,
                                            forMediumScreen: size.width / 2.6,
                                            forTabletScreen: size.width / 5.0,
                                            context: context),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: HexColor("#FF483C"),
                                            border: Border.all(
                                                color: HexColor("#FF483C")),
                                            borderRadius: BorderRadius
                                                .circular(10)
                                        ),
                                        child: Utils.mediumHeadingNormalText(
                                            text: "SUBMIT",
                                            color: AppColor.white,
                                            fontFamily: 'Poppins',
                                            textSize: 13),
                                      ),),
                                  ],),
                                Gap(Responsive().getResponsiveValue(
                                    forLargeScreen: 12.0,
                                    forShortScreen: 32.0,
                                    context: context)),
                              ],
                            ),
                          ],),
                        ),
                      ):Container(),
                      Gap(Responsive().getResponsiveValue(
                          forLargeScreen: 54.0,
                          forShortScreen: 36.0,
                          context: context)),
                    ],
                  ),
                  Utils.progressDialog(context, isLoading, type: 1)
                ],)
              ),
              ),

            ],
          )


      ),
    );
  }

  validation(BuildContext context) {

  }

  @override
  onDeletePhoto(SuccessResponse response) {
  }

  @override
  onError(String msg, int status) {
    setState(() {
      isLoading=false;
    });
   // Utils.customDialog(msg);
  }

  @override
  onProfileUpdateResponse(UpdateProfileResponse response) {
  }

  @override
  onUpdateusersQuestions(SuccessResponse response) {

  }

  @override
  onUploadMediaFile(PhotoResponse response) {
  }
  @override
  onUpdateVerificationQuestions(SuccessResponse response) {

  }
  @override
  onUpdateFloorStatusData(SuccessResponse response) {
    setState(() {
      isLoading=false;
      if(response.status==200){
        if(widget.comesFrom=="LoginEdit"){
          Navigator.pushAndRemoveUntil<void>(
            context,
            MaterialPageRoute<void>(builder: (BuildContext context) =>  HomeScreen(viewType: 0,)),
            ModalRoute.withName('/'),
          );
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
            viewType:12,
          )));
        }
      }
    });
  }
  @override
  onChooseAnyOne(SuccessResponse response) {
  }


  @override
  onUserProfileData(UserProfileResponse response) {
    setState(() {
      isLoading=false;
      if(response.status==200){
        userData=response.data;
        SessionManager.setString(Preferences.NAME, response.data!.name.toString());
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
        imageList.clear();
        listImageID.clear();
        for (var images in  response.data!.userImagesWhileSignup!) {
          imageList.add(IMAGE_URL+images.imageUrl.toString());
          listImageID.add(images.id.toString());
        }
        SessionManager.setStringList(Preferences.IMAGE_ID, listImageID);
        SessionManager.setStringList(Preferences.IMAGE_LIST, imageList);
      }
    });
  }
  @override
  onVerificationPhoto(SuccessResponse response) {

  }
  @override
  onVerificationFace(SuccessResponse response) {

  }

  @override
  onVerificationPhone(PhoneVerificationResponse response) {

  }
  @override
  onVerificationOtp(SuccessResponse response) {

  }
  @override
  onVerificationFacebook(SuccessResponse response) {

  }
}