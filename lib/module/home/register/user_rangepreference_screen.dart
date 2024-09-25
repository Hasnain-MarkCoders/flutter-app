import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/module/components/footer.dart';
import 'package:likeplay/module/components/header.dart';
import 'package:likeplay/module/home/home.dart';
import 'package:likeplay/module/home/login_presenter.dart';
import 'package:likeplay/module/home/register/presenter/profile_update_presenter.dart';
import 'package:likeplay/module/model/photo_response.dart';
import 'package:likeplay/module/model/register_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import 'package:likeplay/module/model/user_profile_response.dart';
import 'package:likeplay/utils/color_utils.dart';
import 'package:likeplay/utils/constant_lists.dart';
import 'package:likeplay/utils/responsive.dart';
import 'package:likeplay/utils/route/route_name.dart';
import 'package:likeplay/utils/string_utils.dart';
import 'package:likeplay/utils/utils.dart';
import 'package:likeplay/widget/common/commontextfield_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../model/phone_verification_response.dart';
import '../../../utils/sharedpref/preferences.dart';
import '../../../utils/sharedpref/shared_prefrence.dart';
import '../../../widget/common/commonpassword_screen.dart';
import '../../../widget/common/commontextfield_registerscreen.dart';
import '../../model/update_profile_response.dart';

class RangePreferenceScreen extends StatefulWidget {
  int? viewType;
  String? residence_country,state, city, nationality, religion,your_tribe,comesFrom;
  RangePreferenceScreen({Key? key,this.viewType,this.comesFrom,this.residence_country,this.state,this.city,this.nationality,this.religion,this.your_tribe}) : super(key: key);
  @override
  State<RangePreferenceScreen> createState() => _RangePreferenceScreenState();
}

class _RangePreferenceScreenState extends State<RangePreferenceScreen> implements ProfileUpdateInterface{
  String range="";
  String lookingFor="";
  String tribeToDate="";
  String tribeirrelevant="";
  ProfileUpdatePresenter? profileUpdatePresenter;
  bool isLoading = false;
  bool isSwitched = false;

  @override
  void initState() {
    profileUpdatePresenter = ProfileUpdatePresenter(this);
    if(widget.comesFrom=="EditProfile"){
      setState(() {
        widget.residence_country=SessionManager.getString(Preferences.RESIDENCE_COUNTRY);
        widget.state=SessionManager.getString(Preferences.STATE);
        widget.city=SessionManager.getString(Preferences.CITY);
        widget.nationality=SessionManager.getString(Preferences.NATIONALITY);
        widget.religion=SessionManager.getString(Preferences.RELIGION);
        widget.your_tribe=SessionManager.getString(Preferences.TRIBE);
        range= SessionManager.getString(Preferences.AGE_RANGE);
        lookingFor= SessionManager.getString(Preferences.LOOKING_FOR);
        tribeToDate= SessionManager.getString(Preferences.TRIBE_TO_DATE);
        tribeirrelevant= SessionManager.getString(Preferences.TRIBE_IRRELAVANT)=="null"?
        "":SessionManager.getString(Preferences.TRIBE_IRRELAVANT);
        if(tribeirrelevant=="true"){
          isSwitched=true;
        }else if(tribeirrelevant=="false"){
          isSwitched=false;
        }else{
          isSwitched=false;
        }
      });
    }else if(widget.comesFrom=="EditProfileAddress"){
      range= SessionManager.getString(Preferences.AGE_RANGE);
      lookingFor= SessionManager.getString(Preferences.LOOKING_FOR);
      tribeToDate= SessionManager.getString(Preferences.TRIBE_TO_DATE);
      tribeirrelevant= SessionManager.getString(Preferences.TRIBE_IRRELAVANT)=="null"?
      "":SessionManager.getString(Preferences.TRIBE_IRRELAVANT);
      if(tribeirrelevant=="true"){
        isSwitched=true;
      }else if(tribeirrelevant=="false"){
        isSwitched=false;
      }else{
        isSwitched=false;
      }
  } else if(widget.comesFrom=="EditFromProfile"){
      if(SessionManager.getString(Preferences.VALUE_ADDRESS)== "1"){
        range= SessionManager.getString(Preferences.AGE_RANGE);
        lookingFor= SessionManager.getString(Preferences.LOOKING_FOR);
        tribeToDate= SessionManager.getString(Preferences.TRIBE_TO_DATE);
        tribeirrelevant= SessionManager.getString(Preferences.TRIBE_IRRELAVANT)=="null"?
        "":SessionManager.getString(Preferences.TRIBE_IRRELAVANT);
        if(tribeirrelevant=="true"){
          isSwitched=true;
        }else if(tribeirrelevant=="false"){
          isSwitched=false;
        }else{
          isSwitched=false;
        }
      }else{
        widget.residence_country=SessionManager.getString(Preferences.RESIDENCE_COUNTRY);
        widget.state=SessionManager.getString(Preferences.STATE);
        widget.city=SessionManager.getString(Preferences.CITY);
        widget.nationality=SessionManager.getString(Preferences.NATIONALITY);
        widget.religion=SessionManager.getString(Preferences.RELIGION);
        widget.your_tribe=SessionManager.getString(Preferences.TRIBE);
        range= SessionManager.getString(Preferences.AGE_RANGE);
        lookingFor= SessionManager.getString(Preferences.LOOKING_FOR);
        tribeToDate= SessionManager.getString(Preferences.TRIBE_TO_DATE);
        tribeirrelevant= SessionManager.getString(Preferences.TRIBE_IRRELAVANT)=="null"?
        "":SessionManager.getString(Preferences.TRIBE_IRRELAVANT);
        if(tribeirrelevant=="true"){
          isSwitched=true;
        }else if(tribeirrelevant=="false"){
          isSwitched=false;
        }else{
          isSwitched=false;
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child:
          Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ResponsiveRowColumn(
                  rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                  rowCrossAxisAlignment: CrossAxisAlignment.center,
                  layout: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                      ? ResponsiveRowColumnType.COLUMN
                      : ResponsiveRowColumnType.ROW,
                  children: [
                    ResponsiveRowColumnItem(
                        rowFlex: 2, child:Row(
                      mainAxisAlignment:  Responsive().getResponsiveValue(
                          forLargeScreen: MainAxisAlignment.start,
                          forShortScreen: MainAxisAlignment.center,
                          context: context),
                      children: [
                        Gap(Responsive().getResponsiveValue(
                            forLargeScreen: 42.0,
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
                      rowFlex:1, child:SizedBox(
                      height:  Responsive().getResponsiveValue(
                          forLargeScreen: MediaQuery.of(context).size.height/1.1,
                          forShortScreen: MediaQuery.of(context).size.height,
                          forMobLandScapeMode: MediaQuery.of(context).size.height/1.2,
                          forMediumScreen: MediaQuery.of(context).size.height/1.2,
                          forTabletScreen: MediaQuery.of(context).size.height,
                          context: context),
                      width:  Responsive().getResponsiveValue(
                          forLargeScreen: MediaQuery.of(context).size.width/1.2,
                          forShortScreen: MediaQuery.of(context).size.width,
                          forMobLandScapeMode: MediaQuery.of(context).size.width/2,
                          forMediumScreen: MediaQuery.of(context).size.width/2,
                          forTabletScreen: MediaQuery.of(context).size.width/2,
                          context: context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Gap(Responsive().getResponsiveValue(
                              forLargeScreen: 32.0,
                              forShortScreen: 22.0,
                              context: context)),
                          widget.comesFrom=="EditProfile"|| widget.comesFrom=="EditFromProfile"|| widget.comesFrom=="EditProfileAddress"?Container():   Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Utils.mediumHeadingNormalText(
                                  text: UtilStrings.five_Complete,
                                  fontFamily: 'Poppins',color: AppColor.white,
                                  left: Responsive().getResponsiveValue(
                                      forLargeScreen:64.0,
                                      forShortScreen: 22.0,
                                      forMobLandScapeMode: 22.0,
                                      forMediumScreen: 22.0,
                                      forTabletScreen: 22.0,
                                      context: context),
                                  textSize: 12),],),
                          Gap(4),
                          widget.comesFrom=="EditProfile"|| widget.comesFrom=="EditFromProfile"|| widget.comesFrom=="EditProfileAddress"?Container():  Image.asset(
                            'assets/images/step_five.png',
                            width: Responsive().getResponsiveValue(
                                forLargeScreen: size.width/4,
                                forShortScreen: size.width/1.1,
                                forMobLandScapeMode: size.width/2,
                                forMediumScreen: size.width/2,
                                forTabletScreen: size.width/2.1,
                                context: context),
                          ),
                          Gap(8),
                          Container(
                            width:  Responsive().getResponsiveValue(
                                forLargeScreen: MediaQuery.of(context).size.width/4,
                                forShortScreen: MediaQuery.of(context).size.width,
                                forMobLandScapeMode: MediaQuery.of(context).size.height/4.2,
                                forMediumScreen: MediaQuery.of(context).size.width/2,
                                forTabletScreen: MediaQuery.of(context).size.width/2,
                                context: context),
                            padding:  EdgeInsets.only(left: Responsive().getResponsiveValue(
                                forLargeScreen: 12.0,
                                forShortScreen: 12.0,
                                forMobLandScapeMode: 12.0,
                                forMediumScreen: 12.0,
                                forTabletScreen: 12.0,
                                context: context),
                              top:  Responsive().getResponsiveValue(
                                  forLargeScreen:26.0,
                                  forShortScreen: 22.0,
                                  context: context),
                              bottom:  Responsive().getResponsiveValue(
                                  forLargeScreen:12.0,
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
                                  forLargeScreen: 0.0,
                                  forShortScreen: 16.0,
                                  forMobLandScapeMode: 0.0,
                                  forMediumScreen: 0.0,
                                  forTabletScreen: 0.0,
                                  context: context),
                            ),
                            decoration:BoxDecoration(
                              border: Border.all(
                                  color: Colors.white,
                                  width: 1.0,
                                  style: BorderStyle.solid
                              ),
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding:  EdgeInsets.only(
                                left: Responsive().getResponsiveValue(
                                    forLargeScreen: 8.0,
                                    forShortScreen: 8.0,
                                    context: context),
                                top: Responsive().getResponsiveValue(
                                    forLargeScreen: 0.0,
                                    forShortScreen: 0.0,
                                    context: context),
                                right: Responsive().getResponsiveValue(
                                    forLargeScreen:0.0,
                                    forShortScreen: 20.0,
                                    context: context),),
                              child:Stack(children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    widget.comesFrom=="EditProfile"|| widget.comesFrom=="EditFromProfile"|| widget.comesFrom=="EditProfileAddress"?Container():
                                    Row(
                                     children: [
                                       Utils.mediumHeadingNormalText(
                                         text: UtilStrings.Welcome,
                                         fontFamily: 'Poppins',color: AppColor.black,
                                         fontWeight: FontWeight.bold,
                                         textSize: 18),
                                       Spacer(),
                                       Utils.mediumHeadingNormalText(
                                           text: "Step 4/6",
                                           fontFamily: 'Poppins',color: AppColor.red,
                                           fontWeight: FontWeight.bold,
                                           right: Responsive().getResponsiveValue(
                                               forLargeScreen:  12.0,
                                               forShortScreen:  0.0,
                                               forMobLandScapeMode:  0.0,
                                               forMediumScreen:  0.0,
                                               forTabletScreen:  0.0,
                                               context: context),
                                           textSize: 14),
                                       Gap(12),
                                     ],
                                   ),
                                    Gap(10),
                                    Utils.mediumHeadingNormalText(
                                        text: "Age Range preferred to date?",
                                        fontFamily: 'Poppins',color: AppColor.black,
                                        textSize: 12),
                                    /*Utils.mediumHeadingStarNormalText(
                                        text: "Age Range preferred to date?",
                                        fontFamily: 'Poppins',color: AppColor.black,
                                        textSize: 12),*/
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 6),
                                      child: Container(
                                        height: 45,
                                        width:  Responsive().getResponsiveValue(
                                            forLargeScreen: MediaQuery.of(context).size.width/4.5,
                                            forShortScreen: MediaQuery.of(context).size.width/1.2,
                                            forTabletScreen: MediaQuery.of(context).size.width/1.2,
                                            forMediumScreen:  MediaQuery.of(context).size.width/1.2,
                                            context: context),
                                        decoration: BoxDecoration(
                                          color:  AppColor.white,
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          border: Border.all(
                                              color: AppColor.grey),
                                        ),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(left: 16),
                                          child: DropdownButton(
                                            dropdownColor: Colors.white,
                                              hint: const Text("Select Range",style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  color: AppColor.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12),),
                                              isExpanded: true,
                                              underline: Container(),
                                              icon: const Padding(
                                                padding:
                                                EdgeInsets.only(right: 16),
                                                child: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.black,),
                                              ),
                                              value: range == "" ? null : range,
                                              items: ranges.map((String items) {
                                                return DropdownMenuItem(
                                                    value: items,
                                                    child: Utils.mediumHeadingNormalText(
                                                        text: items,
                                                        fontFamily: "Poppins",
                                                        color: AppColor.black,
                                                        textSize: 12),);
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  range = newValue!;
                                                });
                                              }),
                                        ),
                                      ),
                                    ),
                                    Gap(8),
                                    Utils.mediumHeadingNormalText(
                                        text: "Tribe to date",
                                        color: AppColor.black,
                                        fontFamily: 'Poppins',
                                        textSize: 12),
                                    /*Utils.mediumHeadingStarNormalText(
                                        text: "Tribe to date",
                                        color: AppColor.black,
                                        fontFamily: 'Poppins',
                                        textSize: 12),*/
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 6),
                                      child: Container(
                                        height: 45,
                                        width:  Responsive().getResponsiveValue(
                                            forLargeScreen: MediaQuery.of(context).size.width/4.5,
                                            forShortScreen: MediaQuery.of(context).size.width/1.2,
                                            forTabletScreen: MediaQuery.of(context).size.width/1.2,
                                            forMediumScreen:  MediaQuery.of(context).size.width/1.2,
                                            context: context),
                                        decoration: BoxDecoration(
                                          color:  AppColor.white,
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          border: Border.all(
                                              color:AppColor.grey),
                                        ),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(left: 16),
                                          child: DropdownButton(
                                              dropdownColor: Colors.white,
                                              hint: const Text("Select Tribe",style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  color: AppColor.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12),),
                                              isExpanded: true,
                                              underline: Container(),
                                              icon: const Padding(
                                                padding:
                                                EdgeInsets.only(right: 16),
                                                child: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.black,),
                                              ),
                                              value: tribeToDate == "" ? null : tribeToDate,
                                              items: ghanaTribe.map((String items) {
                                                return DropdownMenuItem(
                                                    value: items,
                                                    child: Utils.mediumHeadingNormalText(
                                                        text: items,
                                                        fontFamily: "Poppins",
                                                        color: AppColor.black,
                                                        textSize: 12),);
                                              }).toList(),
                                              onChanged: isSwitched==false?(String? newValue) {
                                                  setState(() {
                                                    tribeToDate = newValue!;
                                                  });
                                              }:null),
                                        ),
                                      ),
                                    ),
                                    Gap(8),
                                   /* Utils.mediumHeadingNormalText(
                                        text: "Tribe irrelevant",
                                        color: AppColor.black,
                                        fontFamily: 'Poppins',
                                        textSize: 12),
                                    *//*Utils.mediumHeadingStarNormalText(
                                        text: "Tribe irrelevant",
                                        color: AppColor.black,
                                        fontFamily: 'Poppins',
                                        textSize: 12),*//*
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 6),
                                      child: Container(
                                        height: 45,
                                        width:  Responsive().getResponsiveValue(
                                            forLargeScreen: MediaQuery.of(context).size.width/4.5,
                                            forShortScreen: MediaQuery.of(context).size.width/1.2,
                                            forTabletScreen: MediaQuery.of(context).size.width/1.2,
                                            forMediumScreen:  MediaQuery.of(context).size.width/1.2,
                                            context: context),
                                        decoration: BoxDecoration(
                                          color:  AppColor.white,
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          border: Border.all(
                                              color: AppColor.grey),
                                        ),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(left: 16),
                                          child: DropdownButton(
                                              dropdownColor: Colors.white,
                                              hint: const Text("Select Tribe irrelevant",style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  color: AppColor.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12),),
                                              isExpanded: true,
                                              underline: Container(),
                                              icon: const Padding(
                                                padding:
                                                EdgeInsets.only(right: 16),
                                                child: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.black,),
                                              ),
                                              value: tribeirrelevant == "" ? null : tribeirrelevant,
                                              items: tribeToDateList.map((String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Utils.mediumHeadingNormalText(
                                                      text: items,
                                                      fontFamily: "Poppins",
                                                      color: AppColor.black,
                                                      textSize: 12),);
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  tribeirrelevant = newValue!;
                                                });
                                              }),
                                        ),
                                      ),
                                    ),*/
                                    Utils.mediumHeadingNormalText(
                                        text: "Looking for?",
                                        color: AppColor.black,
                                        fontFamily: 'Poppins',
                                        textSize: 12),
                                   /* Utils.mediumHeadingStarNormalText(
                                        text: "Looking for?",
                                        color: AppColor.black,
                                        fontFamily: 'Poppins',
                                        textSize: 12),*/
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 6),
                                      child: Container(
                                        height: 45,
                                        width:  Responsive().getResponsiveValue(
                                            forLargeScreen: MediaQuery.of(context).size.width/4.5,
                                            forShortScreen: MediaQuery.of(context).size.width/1.2,
                                            forTabletScreen: MediaQuery.of(context).size.width/1.2,
                                            forMediumScreen:  MediaQuery.of(context).size.width/1.2,
                                            context: context),
                                        decoration: BoxDecoration(
                                          color:  AppColor.white,
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          border: Border.all(
                                              color:AppColor.grey),
                                        ),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(left: 16),
                                          child: DropdownButton(
                                              dropdownColor: Colors.white,
                                              hint: const Text("Select Looking for?",style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  color: AppColor.black,
                                                  fontSize: 12),),
                                              isExpanded: true,
                                              underline: Container(),
                                              icon: const Padding(
                                                padding:
                                                EdgeInsets.only(right: 16),
                                                child: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.black,),
                                              ),
                                              value: lookingFor == "" ? null : lookingFor,
                                              items: lookingforList.map((String items) {
                                                return DropdownMenuItem(
                                                    value: items,
                                                    child: Utils.mediumHeadingNormalText(
                                                        text: items,
                                                        fontFamily: "Poppins",
                                                        color: AppColor.black,
                                                        textSize: 12),);
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  lookingFor = newValue!;
                                                });
                                              }),
                                        ),
                                      ),
                                    ),
                                    Gap(8),
                                    Row(
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
                                            text: UtilStrings.Tribe_irrelevant,
                                            fontFamily: 'Poppins',
                                            color: AppColor.black,
                                            textSize: 12),
                                        Gap(8),
                                       /* Transform.scale(
                                            scale: 0.4,
                                            child:CupertinoSwitch(
                                              value: isSwitched,
                                              activeColor: HexColor("#A8580F"),
                                              onChanged: (value) {
                                                setState(() {
                                                  isSwitched=value;
                                                });
                                              },
                                            )),*/
                                       /* Checkbox(
                                          splashRadius: 8,
                                          value: isSwitched,
                                          activeColor: HexColor("#A8580F"),
                                          fillColor:HexColor(AppColor.checkColor),
                                          onChanged: (value){
                                            setState(() {
                                              isSwitched=value!;
                                            });
                                          },
                                        ),*/
                                        GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              isSwitched=!isSwitched;
                                              if(isSwitched==true){
                                                setState(() {
                                                  tribeToDate = "";
                                                });
                                              }
                                            });
                                          },
                                          child: Container(
                                            height:22,
                                            width:22,
                                            decoration: BoxDecoration(
                                                color:HexColor(AppColor.checkColor),
                                                borderRadius: BorderRadius.circular(4)
                                            ),
                                            child:isSwitched==true?
                                            Center(child:Icon(Icons.check,size:14)):SizedBox(),
                                          ))
                                      ],),
                                    Gap(16),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                        Navigator.pop(context);
                                          },
                                          child:Container(
                                            height:46,
                                            width:Responsive().getResponsiveValue(
                                                forLargeScreen:  size.width/9.4,
                                                forShortScreen:  size.width/2.6,
                                                forMobLandScapeMode:  size.width/2.6,
                                                forMediumScreen:  size.width/2.6,
                                                forTabletScreen:  size.width/5.0,
                                                context: context),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color:HexColor("#F0F0F0"),
                                                border: Border.all(color:HexColor("#F0F0F0")),
                                                borderRadius:BorderRadius.circular(10)
                                            ),
                                            child: Utils.mediumHeadingNormalText(
                                                text: "Back",
                                                color: AppColor.black,
                                                fontFamily: 'Poppins',
                                                textSize: 13),
                                          ),),
                                        Gap(12),
                                        GestureDetector(
                                          onTap: (){
                                            validation(context);
                                           /* Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                HomeScreen(
                                                  viewType: 10,
                                                )));*/
                                          },
                                          child:Container(
                                            height:46,
                                            width:Responsive().getResponsiveValue(
                                                forLargeScreen:  size.width/9.4,
                                                forShortScreen:  size.width/2.6,
                                                forMobLandScapeMode:  size.width/2.6,
                                                forMediumScreen:  size.width/2.6,
                                                forTabletScreen:  size.width/5.0,
                                                context: context),
                                            alignment: Alignment.center,
                                           decoration: BoxDecoration(
                                               color:HexColor("#FF483C"),
                                               border: Border.all(color:HexColor("#FF483C")),
                                               borderRadius:BorderRadius.circular(10)
                                           ),
                                            child: Utils.mediumHeadingNormalText(
                                                text: "Next",
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
                                Utils.progressDialog(context, isLoading)
                              ],),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ),

                  ],
                ),
              ],),

          ],)


    );

  }

    validation(BuildContext context) {
      if(range==""){
        Utils.customDialog(context,message:UtilStrings.Select_Range);
      }
      else if(tribeToDate=="" && isSwitched==false){
        Utils.customDialog(context,message:UtilStrings.Select_your_tribe_Or_irrelevant);
        // Utils.customDialog(UtilStrings.Select_your_tribe);
      }
    /*  else if(tribeirrelevant==""){
        Utils.customDialog(UtilStrings.Select_your_tribe_irrelevant);
      }*/
      else if(lookingFor==""){
        Utils.customDialog(context,message:UtilStrings.Select_Lookingfor);
      }
      else {
       setState(() {
          isLoading=true;
        });
        profileUpdatePresenter!.doProfileUpdateTwoData(age_range_for_date: range,tribe_to_date:
        tribeToDate,tribe_irrelevant: isSwitched.toString(),looking_for: lookingFor,residence_country:widget.residence_country,
            state: widget.state,city: widget.city,nationality: widget.nationality,religion: widget.religion,your_tribe: widget.your_tribe, type: 2);

      }
    }

  @override
  onError(String msg, int status) {
    setState(() {
      isLoading = false;
    });
    if (status == 400) {
      Utils.customDialog(context,message:msg.toString());
    }
    else {
    }
  }

  @override
  onProfileUpdateResponse(UpdateProfileResponse response) {
    setState(() {
      isLoading = false;
    });
    if(response.status==200){
      if(widget.comesFrom=="EditProfile" || widget.comesFrom=="EditProfileAddress"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
          viewType: 19,
        )));
      }else if(widget.comesFrom=="EditFromProfile"){
        if(SessionManager.getString(Preferences.VALUE_ADDRESS)== "1"){
          Navigator.pop(context);
          Navigator.pop(context);
        }else{
          Navigator.pop(context);
        }
  }else{
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            HomeScreen(
              viewType: 10,
            )));
      }
    }
  }

  @override
  onUploadMediaFile(PhotoResponse response) {

  }

  @override
  onDeletePhoto(SuccessResponse response) {
  }

  @override
  onUpdateusersQuestions(SuccessResponse response) {
  }
  @override
  onUpdateVerificationQuestions(SuccessResponse response) {

  }

  @override
  onUpdateFloorStatusData(SuccessResponse response) {

  }

  @override
  onUserProfileData(UserProfileResponse response) {

  }

  @override
  onChooseAnyOne(SuccessResponse response) {
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
