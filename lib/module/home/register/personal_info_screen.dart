import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/module/home/home.dart';
import 'package:likeplay/module/home/register/presenter/profile_update_presenter.dart';
import 'package:likeplay/module/model/photo_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import 'package:likeplay/module/model/user_profile_response.dart';
import 'package:likeplay/utils/color_utils.dart';
import 'package:likeplay/utils/constant_lists.dart';
import 'package:likeplay/utils/responsive.dart';
import 'package:likeplay/utils/route/route_name.dart';
import 'package:likeplay/utils/string_utils.dart';
import 'package:likeplay/utils/utils.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../utils/firebase/authentication_service.dart';
import '../../model/phone_verification_response.dart';
import '../../../utils/sharedpref/preferences.dart';
import '../../../utils/sharedpref/shared_prefrence.dart';
import '../../model/update_profile_response.dart';

class PersonalInfoScreen extends StatefulWidget {
  int? viewType;
  int? genderType,gender,interestedIns;
  String? firstName,age;
  String? comesFrom;
  PersonalInfoScreen({Key? key,this.viewType,this.firstName,this.gender,this.age,
    this.genderType,this.interestedIns,this.comesFrom}) : super(key: key);
  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> implements ProfileUpdateInterface{
  String status="";
  String bodyType="";
  String heights="";
  String education="";
  String employment="";
 ProfileUpdatePresenter? profileUpdatePresenter;
  bool isLoading = false;

  @override
  void initState() {
   /* interestedIn:widget.interestedIns.toString(),
    gender:widget.interestedIns==1?"0":"1".toString()*/
    profileUpdatePresenter = ProfileUpdatePresenter(this);
    setState(() {
      if(widget.comesFrom=="EditProfile"){
        widget.firstName=SessionManager.getString(Preferences.NAME);
        widget.age=SessionManager.getString(Preferences.AGE);
        widget.gender=int.parse(SessionManager.getString(Preferences.GENDER));
        widget.interestedIns=int.parse(SessionManager.getString(Preferences.INTERESTED_IN));
        status=SessionManager.getString(Preferences.STATUS);
        bodyType=SessionManager.getString(Preferences.BODY_TYPE);
        heights=SessionManager.getString(Preferences.HEIGHT);
        education=SessionManager.getString(Preferences.EDUCATION);
        employment=SessionManager.getString(Preferences.EMPLOYMENT);
      }else if(widget.comesFrom=="EditProfileUser"){
        status=SessionManager.getString(Preferences.STATUS);
        bodyType=SessionManager.getString(Preferences.BODY_TYPE);
        heights=SessionManager.getString(Preferences.HEIGHT);
        education=SessionManager.getString(Preferences.EDUCATION);
        employment=SessionManager.getString(Preferences.EMPLOYMENT);
    } else if(widget.comesFrom=="EditFromProfile"){
        if(SessionManager.getString(Preferences.VALUE)=="1"){
          status=SessionManager.getString(Preferences.STATUS);
          bodyType=SessionManager.getString(Preferences.BODY_TYPE);
          heights=SessionManager.getString(Preferences.HEIGHT);
          education=SessionManager.getString(Preferences.EDUCATION);
          employment=SessionManager.getString(Preferences.EMPLOYMENT);
        }else{
          widget.firstName=SessionManager.getString(Preferences.NAME);
          widget.age=SessionManager.getString(Preferences.AGE);
          widget.gender=int.parse(SessionManager.getString(Preferences.GENDER));
          widget.interestedIns=int.parse(SessionManager.getString(Preferences.INTERESTED_IN));
          status=SessionManager.getString(Preferences.STATUS);
          bodyType=SessionManager.getString(Preferences.BODY_TYPE);
          heights=SessionManager.getString(Preferences.HEIGHT);
          education=SessionManager.getString(Preferences.EDUCATION);
          employment=SessionManager.getString(Preferences.EMPLOYMENT);
        }

      }
    });
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
                          widget.comesFrom=="EditProfile"|| widget.comesFrom=="EditFromProfile"|| widget.comesFrom=="EditProfileUser"?Container():
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Utils.mediumHeadingNormalText(
                                  text: UtilStrings.three_Complete,
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
                          widget.comesFrom=="EditProfile"|| widget.comesFrom=="EditFromProfile"|| widget.comesFrom=="EditProfileUser"?Container():
                          Image.asset(
                            'assets/images/step_three.png',
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
                                    widget.comesFrom=="EditProfile"|| widget.comesFrom=="EditFromProfile"|| widget.comesFrom=="EditProfileUser"?Container():
                                    Row(
                                     children: [
                                       Utils.mediumHeadingNormalText(
                                         text: UtilStrings.Welcome,
                                         fontFamily: 'Poppins',color: AppColor.black,
                                         fontWeight: FontWeight.bold,
                                         textSize: 18),
                                       Spacer(),
                                       Utils.mediumHeadingNormalText(
                                           text: "Step 2/6",
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
                                    Utils.mediumHeadingStarNormalText(
                                        text: "Status",
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
                                                color:AppColor.grey),
                                        ),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(left: 16),
                                          child: DropdownButton(
                                            dropdownColor: Colors.white,
                                              hint: const Text("Select Status",style: TextStyle(
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
                                              value: status == "" ? null : status,
                                              items: statusList.map((String items) {
                                                return DropdownMenuItem(
                                                    value: items,
                                                    child:  Utils.mediumHeadingNormalText(
                                                        text: items,
                                                        fontFamily: "Poppins",
                                                        color: AppColor.black,
                                                        textSize: 12),);
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  status = newValue!;
                                                });
                                              }),
                                        ),
                                      ),
                                    ),
                                    Gap(10),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                          Utils.mediumHeadingStarNormalText(
                                              text: "Body Type",
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
                                                const EdgeInsets.only(left: 12),
                                                child: DropdownButton(
                                                    dropdownColor: Colors.white,
                                                    hint: const Text("Select Body Type",style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        color: AppColor.black,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12),),
                                                    isExpanded: true,
                                                    underline: Container(),
                                                    icon: const Padding(
                                                      padding:
                                                      EdgeInsets.only(right: 4),
                                                      child: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.black,),
                                                    ),
                                                    value: bodyType == "" ? null : bodyType,
                                                    items: bodyTypes.map((String items) {
                                                      return DropdownMenuItem(
                                                          value: items,
                                                          child:  Utils.mediumHeadingNormalText(
                                                              text: items,
                                                              fontFamily: "Poppins",
                                                              color: AppColor.black,
                                                              textSize: 12),);
                                                    }).toList(),
                                                    onChanged: (String? newValue) {
                                                      setState(() {
                                                        bodyType = newValue!;
                                                      });
                                                    }),
                                              ),
                                            ),),
                                        ],),
                                        Gap(12),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Utils.mediumHeadingStarNormalText(
                                                text: "Height",
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
                                                const EdgeInsets.only(left: 12),
                                                child: DropdownButton(
                                                    dropdownColor: Colors.white,
                                                    hint: const Text("Select Height",style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        color: AppColor.black,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12),),
                                                    isExpanded: true,
                                                    underline: Container(),
                                                    icon: const Padding(
                                                      padding:
                                                      EdgeInsets.only(right: 4),
                                                      child: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.black,),
                                                    ),
                                                    value: heights == "" ? null : heights,
                                                    items: height.map((String items) {
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
                                                        heights = newValue!;
                                                      });
                                                    }),
                                              ),
                                            ),),
                                        ],)
                                      ],),
                                    Gap(8),
                                    Utils.mediumHeadingStarNormalText(
                                        text: "Education",
                                        color: AppColor.black,
                                        fontFamily: 'Poppins',
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
                                              hint: const Text("Select Education",style: TextStyle(
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
                                              value: education == "" ? null : education,
                                              items: educationList.map((String items) {
                                                return DropdownMenuItem(
                                                    value: items,
                                                    child:Utils.mediumHeadingNormalText(
                                                        text: items,
                                                        fontFamily: "Poppins",
                                                        color: AppColor.black,
                                                        textSize: 12),);
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  education = newValue!;
                                                });
                                              }),
                                        ),
                                      ),
                                    ),
                                    Gap(8),
                                    Utils.mediumHeadingStarNormalText(
                                        text: "Employment",
                                        color: AppColor.black,
                                        fontFamily: 'Poppins',
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
                                              hint: const Text("Select Employment",style: TextStyle(
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
                                              value: employment == "" ? null : employment,
                                              items: employmentList.map((String items) {
                                                return DropdownMenuItem(
                                                    value: items,
                                                    child: Utils.mediumHeadingNormalText(
                                                        text: items,
                                                        fontFamily: "Poppins",
                                                        color: AppColor.black,
                                                        textAlign: TextAlign.left,
                                                        textSize: 12),);
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  employment = newValue!;
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
                                              viewType: 8,
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
   if(status==""){
      Utils.customDialog(context,message:UtilStrings.Select_Status);
    }
   else if(bodyType==""){
     Utils.customDialog(context,message:UtilStrings.Select_Body_Type);
   }
   else if(heights==""){
     Utils.customDialog(context,message:UtilStrings.Select_Height);
   }
   else if(education==""){
     Utils.customDialog(context,message:UtilStrings.Select_Education);
   }
   else if(employment==""){
     Utils.customDialog(context,message:UtilStrings.Select_Employment);
   }
    else {
    /* Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
       viewType: 8,
     )));*/
     setState(() {
       isLoading=true;
     });
      // gender:=0-MALE,1-FEMALE
      // interested_in = 1- FEMALE, 2 - MALE
     profileUpdatePresenter?.doProfileUpdateOneData(status:status,body_type: bodyType,
         height: heights,education: education,employment: employment,
         name:widget.firstName.toString(),age:widget.age,interestedIn:widget.interestedIns.toString(),
         gender:widget.gender==0?"0":"1",type:1);
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
  final _authService = AuthenticationService();
  @override
  onProfileUpdateResponse(UpdateProfileResponse response) {
    setState(() {
      isLoading = false;
    });
    if(response.status==200){
      if(widget.comesFrom=="EditProfile" || widget.comesFrom=="EditProfileUser"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
          viewType: 19,
        )));
      }else if(widget.comesFrom=="EditFromProfile"){
        _authService.updateName(widget.firstName.toString());
        if(SessionManager.getString(Preferences.VALUE)=="1"){
          Navigator.pop(context);
          Navigator.pop(context);
          // Navigator.pushReplacementNamed(context, RouteName.profile_screen);
        }else{
          // Navigator.pushReplacementNamed(context, RouteName.profile_screen);
          Navigator.pop(context);
        }
  }else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
          viewType: 8,
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
