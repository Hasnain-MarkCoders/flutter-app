import 'package:email_validator/email_validator.dart';
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
import '../../../widget/common/commontextfield_registerscreen.dart';

class UserInfoScreen extends StatefulWidget {
  int? viewType;
  String? comesFrom;
  UserInfoScreen({Key? key,this.viewType,this.comesFrom}) : super(key: key);
  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen>{
  TextEditingController firstNameController = TextEditingController();
  String age="";
  String gender="Female";
  int genderType=0;
  int interested_in=1;
  bool male=false,female=false;
  bool isLoading = false;

  @override
  void initState() {
    if(widget.comesFrom=="EditProfile" || widget.comesFrom=="EditProfileUser"||widget.comesFrom=="EditFromProfile" ){
     setState(() {
       firstNameController.text=SessionManager.getString(Preferences.NAME);
       age= SessionManager.getString(Preferences.AGE);
       genderType=int.parse(SessionManager.getString(Preferences.GENDER));
       // gender:=0-MALE,1-FEMALE
       // interested_in = 1- FEMALE, 2 - MALE
       if(genderType==1){
         female=true;
         male=false;
         gender="Male";
         genderType=1;
         interested_in=2;
       }else{
         female=false;
         male=true;
         gender="Female";
         genderType=0;
         interested_in=1;
       }
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

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.comesFrom=="EditProfile"||widget.comesFrom=="EditProfileUser"|| widget.comesFrom=="EditFromProfile"?Container():
                              Utils.mediumHeadingNormalText(
                                  text: UtilStrings.two_Complete,
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
                          widget.comesFrom=="EditProfile"||  widget.comesFrom=="EditProfileUser"|| widget.comesFrom=="EditFromProfile"?Container():
                          Image.asset(
                            'assets/images/step_two.png',
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
                                    widget.comesFrom=="EditProfile"|| widget.comesFrom=="EditProfileUser"|| widget.comesFrom=="EditFromProfile"?Container():
                                    Row(
                                     children: [
                                       Utils.mediumHeadingNormalText(
                                         text: UtilStrings.Welcome,
                                         fontFamily: 'Poppins',color: AppColor.black,
                                         fontWeight: FontWeight.bold,
                                         textSize: 18),
                                       Spacer(),
                                       Utils.mediumHeadingNormalText(
                                           text: "Step 1/6",
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
                                    Utils.mediumHeadingStarNormalText(
                                        text: "Full Name",
                                        fontFamily: 'Poppins',color: AppColor.black,
                                        textSize: 12),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 6),
                                      child: CommonTextfieldRegister(
                                          hint: "Full Name",
                                          controller:  firstNameController,
                                        comeFrom: "userName",
                                      ),
                                    ),
                                    Gap(8),
                                    Utils.mediumHeadingStarNormalText(
                                        text: "Age",
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
                                              hint: const Text("Select age",style: TextStyle(
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
                                              value: age == "" ? null : age,
                                              items: ageList.map((String items) {
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
                                                  age = newValue!;
                                                });
                                              }),
                                        ),
                                      ),
                                    ),
                                    Gap(8),
                                    Utils.mediumHeadingStarNormalText(
                                        text: "Gender",
                                        color: AppColor.black,
                                        fontFamily: 'Poppins',
                                        textSize: 12),
                                    Gap(6),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            if(widget.comesFrom!="EditFromProfile"){
                                              setState(() {
                                                female=false;
                                                male=true;
                                                gender="Female";
                                                genderType=0;
                                                interested_in=1;
                                              });
                                            }
                                          },
                                          child:Container(
                                            height:46,
                                            width:Responsive().getResponsiveValue(
                                                forLargeScreen:  size.width/9.4,
                                                forShortScreen:  size.width/2.7,
                                                forMobLandScapeMode:  size.width/2.7,
                                                forMediumScreen:  size.width/2.7,
                                                forTabletScreen:  size.width/5.0,
                                                context: context),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color:HexColor(male==false?"#ffffff":"#A8580F"),
                                                border: Border.all(color:HexColor(male==false?AppColor.GREY:"#A8580F")),
                                                borderRadius:BorderRadius.circular(10)
                                            ),
                                            child: Utils.mediumHeadingNormalText(
                                                text: "Male",
                                                color: male==false?AppColor.black:AppColor.white,
                                                fontFamily: 'Poppins',
                                                textSize: 13),
                                          ),),
                                        Gap(12),
                                        GestureDetector(
                                          onTap: (){
                                            if(widget.comesFrom!="EditFromProfile") {
                                              setState(() {
                                                female = true;
                                                male = false;
                                                gender = "Male";
                                                genderType = 1;
                                                interested_in = 2;
                                              });
                                            }
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
                                               color:HexColor(female==true?"#A8580F":"#ffffff"),
                                               border: Border.all(color:HexColor(female==true?"#A8580F":AppColor.GREY)),
                                               borderRadius:BorderRadius.circular(10)
                                           ),
                                            child: Utils.mediumHeadingNormalText(
                                                text: "Female",
                                                color: female==false?AppColor.black:AppColor.white,
                                                fontFamily: 'Poppins',
                                                textSize: 13),
                                          ),),
                                      ],),
                                    Gap(8),
                                    Utils.mediumHeadingNormalText(
                                        text: "Interested In",
                                        color: AppColor.black,
                                        fontFamily: 'Poppins',
                                        textSize: 12),
                                    Gap(6),
                                    Container(
                                        padding: EdgeInsets.all(12),
                                        width:  Responsive().getResponsiveValue(
                                            forLargeScreen: MediaQuery.of(context).size.width/4.5,
                                            forShortScreen: MediaQuery.of(context).size.width/1.2,
                                            forTabletScreen: MediaQuery.of(context).size.width/1.2,
                                            forMediumScreen:  MediaQuery.of(context).size.width/1.2,
                                            context: context),
                                        decoration: BoxDecoration(
                                            color:AppColor.white,
                                            border: Border.all(color:AppColor.grey),
                                            borderRadius:BorderRadius.circular(10)
                                        ),
                                        child: Utils.mediumHeadingNormalText(text: gender,textSize:12,fontWeight: FontWeight.w400,color: AppColor.black,textAlign:TextAlign.start)),
                                    Gap(22),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [ GestureDetector(
                                        onTap: (){
                                         validation(context);
                                         /* Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                                            viewType: 7,
                                          )));*/
                                        },
                                        child:Container(
                                          height:44,
                                          width: 120,
                                          alignment: Alignment.center,
                                          decoration:  BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(8)),
                                            gradient:LinearGradient(
                                                colors: [
                                                  HexColor("#FF483C"),
                                                  HexColor("#FF2C5A"),
                                                  HexColor("#FF483C"),
                                                  HexColor("#FF2C5A"),
                                                  //add more colors for gradient
                                                ],
                                                begin: Alignment.topLeft, //begin of the gradient color
                                                end: Alignment.bottomRight, //end of the gradient color
                                                stops: [0, 0.2, 0.5, 0.8] //stops for individual color
                                              //set the stops number equal to numbers of color
                                            ),
                                          ),
                                          child: Utils.mediumHeadingNormalText(
                                              text: "Next",
                                              color: AppColor.white,
                                              fontFamily: 'Poppins',
                                              textSize: 13),
                                        ),),],
                                    ),
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
   if(firstNameController.text.trim().isEmpty){
      Utils.customDialog(context,message:UtilStrings.ENTER_YOUR_FULL_NAME);
    }
    else if (age=="") {
      Utils.customDialog(context,message:UtilStrings.Please_select_your_age);
      } else if (male==false && female==false) {
      Utils.customDialog(context,message:UtilStrings.Please_select_gender);
      }
    else {
     if (widget.comesFrom == "EditProfile"|| widget.comesFrom=="EditFromProfile"|| widget.comesFrom=="EditProfileUser") {
       Navigator.push(context, MaterialPageRoute(builder: (context) =>
           HomeScreen(
             viewType: 7,
             firstName: firstNameController.text.toString(),
             age: age,
             gender: genderType,
             interestedIns: interested_in,
             comesFrom: widget.comesFrom,
           )));
     }
     else{
       Navigator.push(context, MaterialPageRoute(builder: (context) =>
           HomeScreen(
             viewType: 7,
             firstName: firstNameController.text.toString(),
             age: age,
             gender: genderType,
             interestedIns: interested_in,
             comesFrom: widget.comesFrom,
           )));
     }
   }}}
