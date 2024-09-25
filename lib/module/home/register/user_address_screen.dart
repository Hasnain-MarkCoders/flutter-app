import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/module/home/home.dart';
import 'package:likeplay/utils/color_utils.dart';
import 'package:likeplay/utils/constant_lists.dart';
import 'package:likeplay/utils/responsive.dart';
import 'package:likeplay/utils/string_utils.dart';
import 'package:likeplay/utils/utils.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/sharedpref/preferences.dart';
import '../../../utils/sharedpref/shared_prefrence.dart';

class UserAddressScreen extends StatefulWidget {
  int? viewType;
 String? comesFrom;
  UserAddressScreen({Key? key,this.viewType,this.comesFrom,}) : super(key: key);
  @override
  State<UserAddressScreen> createState() => _UserAddressScreenState();
}

class _UserAddressScreenState extends State<UserAddressScreen> {
  /*String country="";
  String state="";
  String city="";*/
  TextEditingController country=TextEditingController();
  TextEditingController state=TextEditingController();
  TextEditingController city=TextEditingController();
  TextEditingController nationality=TextEditingController();
  // String nationality="";
  String religion="";
  String yourTribe="";
  String? countryValue;
  String? stateValue;
  String? cityValue;
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    if(widget.comesFrom=="EditProfile" || widget.comesFrom=="EditFromProfile"|| widget.comesFrom=="EditProfileAddress" ){
      setState(() {
        country.text=SessionManager.getString(Preferences.RESIDENCE_COUNTRY);
        state.text=SessionManager.getString(Preferences.STATE);
        city.text=SessionManager.getString(Preferences.CITY);
        nationality.text=SessionManager.getString(Preferences.NATIONALITY);
        religion=SessionManager.getString(Preferences.RELIGION);
        yourTribe=SessionManager.getString(Preferences.TRIBE);
      });
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
                     /* height:  Responsive().getResponsiveValue(
                          forLargeScreen: MediaQuery.of(context).size.height,
                          //forLargeScreen: MediaQuery.of(context).size.height/1.1,
                          forShortScreen: MediaQuery.of(context).size.height,
                          forMobLandScapeMode: MediaQuery.of(context).size.height,
                          forMediumScreen: MediaQuery.of(context).size.height,
                          forTabletScreen: MediaQuery.of(context).size.height,
                          context: context),*/
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
                              forShortScreen: 16.0,
                              context: context)),

                          widget.comesFrom=="EditProfile"|| widget.comesFrom=="EditFromProfile"|| widget.comesFrom=="EditProfileAddress"?Container() :
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Utils.mediumHeadingNormalText(
                                  text: UtilStrings.four_Complete,
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
                          widget.comesFrom=="EditProfile"|| widget.comesFrom=="EditFromProfile"|| widget.comesFrom=="EditProfileAddress"?Container() :   Image.asset(
                            'assets/images/step_four.png',
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
                                           text: "Step 3/6",
                                           fontFamily: 'Poppins',color: AppColor.red,
                                           fontWeight: FontWeight.bold,
                                           right: Responsive().getResponsiveValue(
                                               forLargeScreen:  12,
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
                                    /*Utils.mediumHeadingNormalText(
                                        text: "Country of Residence",
                                        fontFamily: 'Poppins',color: AppColor.black,
                                        textSize: 12),
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
                                              color: AppColor.oneOff),
                                        ),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(left: 16),
                                          child: DropdownButton(
                                            dropdownColor: Colors.white,
                                              hint: const Text("Select Country",style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  color: AppColor.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14),),
                                              isExpanded: true,
                                              underline: Container(),
                                              icon: const Padding(
                                                padding:
                                                EdgeInsets.only(right: 16),
                                                child: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.black,),
                                              ),
                                              value: country == "" ? null : country,
                                              items: statusList.map((String items) {
                                                return DropdownMenuItem(
                                                    value: items,
                                                    child: Text(items,style: TextStyle(color: Colors.black),));
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  country = newValue!;
                                                });
                                              }),
                                        ),
                                      ),
                                    ),
                                    Gap(12),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Utils.mediumHeadingNormalText(
                                                text: "State",
                                                fontFamily: 'Poppins',color: AppColor.black,
                                                textSize: 12),
                                            Gap(8),
                                            GestureDetector(
                                              onTap: (){
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
                                                    border: Border.all(color:Colors.grey),
                                                    borderRadius:BorderRadius.circular(10)
                                                ),
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.only(left: 16),
                                                  child: DropdownButton(
                                                      dropdownColor: Colors.white,
                                                      hint: const Text("Select State",style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          color: AppColor.black,
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 14),),
                                                      isExpanded: true,
                                                      underline: Container(),
                                                      icon: const Padding(
                                                        padding:
                                                        EdgeInsets.only(right: 16),
                                                        child: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.black,),
                                                      ),
                                                      value: state == "" ? null : state,
                                                      items: educationList.map((String items) {
                                                        return DropdownMenuItem(
                                                            value: items,
                                                            child: Text(items,style: TextStyle(color: Colors.black),));
                                                      }).toList(),
                                                      onChanged: (String? newValue) {
                                                        setState(() {
                                                          state = newValue!;
                                                        });
                                                      }),
                                                ),
                                              ),),
                                          ],),
                                        Gap(12),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Utils.mediumHeadingNormalText(
                                                text: "City",
                                                fontFamily: 'Poppins',color: AppColor.black,
                                                textSize: 12),
                                            Gap(8),
                                            GestureDetector(
                                              onTap: (){

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
                                                    border: Border.all(color:Colors.grey),
                                                    borderRadius:BorderRadius.circular(10)
                                                ),
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.only(left: 16),
                                                  child: DropdownButton(
                                                      dropdownColor: Colors.white,
                                                      hint: const Text("Select City",style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          color: AppColor.black,
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 14),),
                                                      isExpanded: true,
                                                      underline: Container(),
                                                      icon: const Padding(
                                                        padding:
                                                        EdgeInsets.only(right: 16),
                                                        child: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.black,),
                                                      ),
                                                      value: city == "" ? null : city,
                                                      items: educationList.map((String items) {
                                                        return DropdownMenuItem(
                                                            value: items,
                                                            child: Text(items,style: TextStyle(color: Colors.black),));
                                                      }).toList(),
                                                      onChanged: (String? newValue) {
                                                        setState(() {
                                                          city = newValue!;
                                                        });
                                                      }),
                                                ),
                                              ),),
                                          ],)
                                      ],),*/
                                     Column(
                                          children: [
                                            Container(
                                              width:  Responsive().getResponsiveValue(
                                                  forLargeScreen: MediaQuery.of(context).size.width/4.5,
                                                  forShortScreen: MediaQuery.of(context).size.width/1.2,
                                                  forTabletScreen: MediaQuery.of(context).size.width/1.2,
                                                  forMediumScreen:  MediaQuery.of(context).size.width/1.2,
                                                  context: context),
                                              child: /*  SelectState(
                                                onCountryChanged: (value) {
                                                  setState(() {
                                                    countryValue = value;
                                                    country=value;
                                                  });
                                                },
                                                onStateChanged:(value) {
                                                  setState(() {
                                                    stateValue = value;
                                                    state=value;
                                                  });
                                                },
                                                onCityChanged:(value) {
                                                  setState(() {
                                                    cityValue = value;
                                                    city=value;
                                                  });
                                                },
                                                style:TextStyle(color:Colors.black,fontSize: 12),
                                                dropdownColor: Colors.white,
                                              )*/
                                              CountryStateCityPicker(
                                                country: country,
                                                state: state,
                                                city: city,
                                              ),
                                            )
                                          ],
                                        ),
                                    Utils.mediumHeadingStarNormalText(
                                        text: "Nationality",
                                        color: AppColor.black,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        textSize: 12),
                                    Gap(10),
                                  /*  Padding(
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

                                              hint: const Text("Select Nationality",style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  color: AppColor.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12),),
                                              isExpanded: true,
                                              underline: Container(),
                                              icon: const Padding(
                                                padding:
                                                EdgeInsets.only(right: 16),
                                                child: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.black,),
                                              ),
                                              value: nationality == "" ? null : nationality,
                                              items: nationalityList.map((String items) {
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
                                                  nationality = newValue!;
                                                });
                                              }),
                                        ),
                                      ),
                                    ),*/
                                    Container(
                                      height: 45,
                                      width: MediaQuery.of(context).size.width/1.2,
                                      decoration: BoxDecoration(
                                          color:Colors.white,
                                          border: Border.all(color:Colors.grey),
                                          borderRadius:BorderRadius.circular(10)
                                      ),
                                      child:   TextField(
                                        controller: nationality,
                                        onTap: (){
                                         showPopInformation(context);
                                        },
                                        style: const TextStyle(color:Colors.black,fontSize: 12,fontWeight: FontWeight.normal),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintText: 'Select Nationality',
                                          contentPadding: EdgeInsets.only(left:16,bottom:4,right: 10,top:18.0),
                                          suffixIcon: Icon(Icons.keyboard_arrow_down,color: Colors.black,),
                                          border:  InputBorder.none,
                                          hintStyle: TextStyle(fontSize: 12),
                                        ),
                                        readOnly: true,
                                      ),
                                    ),
                                    Gap(10),
                                    Utils.mediumHeadingStarNormalText(
                                        text: "Religion",
                                        color: AppColor.black,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        textSize: 12),
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
                                              hint: const Text("Select Religion",style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  color: AppColor.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12),),
                                              isExpanded: true,
                                              underline: Container(),
                                              icon: const Padding(
                                                padding:
                                                EdgeInsets.only(right: 16),
                                                child: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.black,),
                                              ),
                                              value: religion == "" ? null : religion,
                                              items: religionlist.map((String items) {
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
                                                  religion = newValue!;
                                                });
                                              }),
                                        ),
                                      ),
                                    ),
                                    Gap(10),
                                    Utils.mediumHeadingStarNormalText(
                                        text: "Your Tribe",
                                        color: AppColor.black,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        textSize: 12),
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
                                              hint: const Text("Select your tribe",style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  color: AppColor.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12),),
                                              isExpanded: true,
                                              underline: Container(),
                                              icon: const Padding(
                                                padding:
                                                EdgeInsets.only(right: 16),
                                                child: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.black,),
                                              ),
                                              value: yourTribe == "" ? null : yourTribe,
                                              items: ghanaTribe.map((String items) {
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
                                                  yourTribe = newValue!;
                                                });
                                              }),
                                        ),
                                      ),
                                    ),
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
                                           /* Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                                                viewType: 9,
                                                residenceCountry:country,
                                                state: state,
                                                city: city,
                                                nationality: nationality,
                                                religion: religion,
                                                your_tribe: yourTribe
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
                Gap( Responsive().getResponsiveValue(
                    forLargeScreen: 60.0,
                    forShortScreen: 82.0,
                    forMobLandScapeMode: 62.0,
                    forMediumScreen: 82.0,
                    forTabletScreen: 62.0,
                    context: context),),
              ],),
          ],)
    );
  }

    validation(BuildContext context) {
      if(country.text.isEmpty/*==""*/){
        Utils.customDialog(context,message:UtilStrings.Select_Country);
      }
      else if(state.text.isEmpty/*==""*/){
        Utils.customDialog(context,message:UtilStrings.Select_State);
      }
      else if(city.text.isEmpty/*==""*/){
        Utils.customDialog(context,message:UtilStrings.Select_City);
      }
      else if(nationality.text.isEmpty){
        Utils.customDialog(context,message:UtilStrings.Select_Nationality);
      }
      else if(religion==""){
        Utils.customDialog(context,message:UtilStrings.Select_Religion);
      }
      else if(yourTribe==""){
        Utils.customDialog(context,message:UtilStrings.Select_your_tribe);
      }
      else {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
            viewType: 9,
            residenceCountry:country.text,
            state: state.text,
            city: city.text,
            nationality: nationality.text,
            religion: religion,
            your_tribe: yourTribe,
          comesFrom: widget.comesFrom,
        )));

      }


    }
  void _searchingData(String value,StateSetter setState) {
    // List<AllUsers> results = [];
    List<String> results = [];
    if (value.isEmpty) {
      setState(() {
        nationalityList = nationalityListTemp;
      });
      // nationalityList=nationalityListTemp;
    } else {
      results = nationalityList.where((user) {
        final title = user.toLowerCase();// added
        final searchLower = value.toLowerCase();
        return title.contains(searchLower); //changed
      }).toList();
      setState(() {
        nationalityList = results;
      });
    }

  }
  void showPopInformation(BuildContext context){
    showGeneralDialog(
      barrierLabel: "Nationality",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (context,__,___){
        return Material(
          color: Colors.transparent,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return Align(
                alignment: Alignment.topCenter,
                child:  Container(
                  height: MediaQuery.of(context).size.height*.7,
                  width: MediaQuery.of(context).size.width/1.2,
                  margin: EdgeInsets.only(top: 60, left: 12, right: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text("Nationality",style: TextStyle(color:Colors.grey.shade800,
                          fontSize: 17,fontWeight: FontWeight.w500)),
                      SizedBox(height: 10),
                      ///Text Field
                      TextField(
                        controller: searchController,
                        onChanged: (value) => _searchingData(value,setState),
                        style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 16.0
                        ),
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: "Search here...",
                            contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 5),
                            isDense: true,
                            prefixIcon: Icon(Icons.search)
                        ),
                      ),
                      ///Dropdown Items
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                            itemCount: nationalityList.length,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context,index){
                              return InkWell(
                                onTap: (){
                                  setState((){
                                    nationality.text=nationalityList[index];
                                    nationalityList=nationalityListTemp;
                                    searchController.text="";
                                  });
                                  Navigator.pop(context);
                                  setState((){
                                    nationalityList=nationalityListTemp;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 20.0,left: 10.0,right: 10.0),
                                  child: Text(nationalityList[index],
                                      style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 16.0
                                      )),
                                ),
                              );
                            },
                        ),
                      ),),
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text('Close'),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      transitionBuilder: (_,anim,__,child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, -1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }
  List <String> nationalityListTemp = ["Afghanistan", "Albania", "Algeria", "American Samoa", "Andorra", "Angola", "Anguilla",

    "Antarctica", "Antigua and Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria",

    "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium",

    "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia and Herzegovina", "Botswana",

    "Brazil", "British Indian Ocean Territory", "British Virgin Islands", "Brunei", "Bulgaria",

    "Burkina Faso", "Burma (Myanmar)", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde",

    "Cayman Islands", "Central African Republic", "Chad", "Chile", "China", "Christmas Island",

    "Cocos (Keeling) Islands", "Colombia", "Comoros", "Cook Islands", "Costa Rica",

    "Croatia", "Cuba", "Cyprus", "Czech Republic", "Democratic Republic of the Congo",

    "Denmark", "Djibouti", "Dominica", "Dominican Republic",

    "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia",

    "Ethiopia", "Falkland Islands", "Faroe Islands", "Fiji", "Finland", "France", "French Polynesia",

    "Gabon", "Gambia", "Gaza Strip", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece",

    "Greenland", "Grenada", "Guam", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana",

    "Haiti", "Holy See (Vatican City)", "Honduras", "Hong Kong", "Hungary", "Iceland", "India",

    "Indonesia", "Iran", "Iraq", "Ireland", "Isle of Man", "Israel", "Italy", "Ivory Coast", "Jamaica",

    "Japan", "Jersey", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Kosovo", "Kuwait",

    "Kyrgyzstan", "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein",

    "Lithuania", "Luxembourg", "Macau", "Macedonia", "Madagascar", "Malawi", "Malaysia",

    "Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania", "Mauritius", "Mayotte", "Mexico",

    "Micronesia", "Moldova", "Monaco", "Mongolia", "Montenegro", "Montserrat", "Morocco",

    "Mozambique", "Namibia", "Nauru", "Nepal", "Netherlands", "Netherlands Antilles", "New Caledonia",

    "New Zealand", "Nicaragua", "Niger", "Nigeria", "Niue", "Norfolk Island", "North Korea",

    "Northern Mariana Islands", "Norway", "Oman", "Pakistan", "Palau", "Panama",

    "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Pitcairn Islands", "Poland",

    "Portugal", "Puerto Rico", "Qatar", "Republic of the Congo", "Romania", "Russia", "Rwanda",

    "Saint Barthelemy", "Saint Helena", "Saint Kitts and Nevis", "Saint Lucia", "Saint Martin",

    "Saint Pierre and Miquelon", "Saint Vincent and the Grenadines", "Samoa", "San Marino",

    "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone",

    "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Korea",

    "Spain", "Sri Lanka", "Sudan", "Suriname", "Swaziland", "Sweden", "Switzerland",

    "Syria", "Taiwan", "Tajikistan", "Tanzania", "Thailand", "Timor-Leste", "Togo", "Tokelau",

    "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Turks and Caicos Islands",

    "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "Uruguay", "US Virgin Islands", "Uzbekistan", "Vanuatu", "Venezuela", "Vietnam",

    "Wallis and Futuna", "West Bank", "Yemen", "Zambia", "Zimbabwe"];
}
