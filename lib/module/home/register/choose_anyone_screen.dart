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
import 'package:likeplay/utils/sharedpref/preferences.dart';
import 'package:likeplay/utils/sharedpref/shared_prefrence.dart';
import 'package:likeplay/utils/string_utils.dart';
import 'package:likeplay/utils/utils.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../model/phone_verification_response.dart';

class ChooseAnyOneScreen extends StatefulWidget {
  int? viewType;
  ChooseAnyOneScreen({Key? key,this.viewType}) : super(key: key);
  @override
  State<ChooseAnyOneScreen> createState() => _ChooseAnyOneScreenState();
}

class _ChooseAnyOneScreenState extends State<ChooseAnyOneScreen> implements ProfileUpdateInterface {
  bool isPhysical=false,isCharacter=false,isBoth=false;
  bool isLoading=false;
  int chooseType=4;

  int attributeStatus=1;
  ProfileUpdatePresenter? profileUpdatePresenter;
  @override
  void initState() {
    super.initState();
    profileUpdatePresenter=ProfileUpdatePresenter(this);
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
                              Utils.mediumHeadingNormalText(
                                  text: UtilStrings.Choose_Complete,
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
                          Image.asset(
                            'assets/images/step_choose.png',
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
                                    Utils.mediumHeadingStarNormalText(
                                        text: UtilStrings.choose_any_one,
                                        fontFamily: 'Poppins',color: AppColor.black,
                                        textSize: 14),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          SessionManager.setString(Preferences.CHOOSE_ANY_ONE, "0");
                                          isPhysical=true;
                                          isCharacter=false;
                                          isBoth=false;
                                          chooseType=0;
                                          attributeStatus=1;
                                        });
                                      },
                                      child:Container(
                                        height: 45,
                                        width:  Responsive().getResponsiveValue(
                                            forLargeScreen: MediaQuery.of(context).size.width/4.5,
                                            forShortScreen: MediaQuery.of(context).size.width/1.2,
                                            forTabletScreen: MediaQuery.of(context).size.width/1.2,
                                            forMediumScreen:  MediaQuery.of(context).size.width/1.2,
                                            context: context),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color:HexColor(isPhysical==true?"#A8580F":"#F0F0F0"),
                                            border: Border.all(color:HexColor(isPhysical==true?"#A8580F":"#F0F0F0")),
                                            borderRadius:BorderRadius.circular(10)
                                        ),
                                        child: Utils.mediumHeadingNormalText(
                                            text: UtilStrings.Physical_Attributes_Only,
                                            color: isPhysical==true?AppColor.white:HexColor("#242424"),
                                            fontFamily: 'Poppins',
                                            left: 10,
                                            textSize: 12),
                                      ),),
                                    const Gap(10),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          //Next screen according to this type
                                          SessionManager.setString(Preferences.CHOOSE_ANY_ONE, "1");
                                          chooseType=1;
                                          attributeStatus=2;
                                          isPhysical=false;
                                          isCharacter=true;
                                          isBoth=false;
                                        });
                                      },
                                      child:Container(
                                        height: 45,
                                        width:  Responsive().getResponsiveValue(
                                            forLargeScreen: MediaQuery.of(context).size.width/4.5,
                                            forShortScreen: MediaQuery.of(context).size.width/1.2,
                                            forTabletScreen: MediaQuery.of(context).size.width/1.2,
                                            forMediumScreen:  MediaQuery.of(context).size.width/1.2,
                                            context: context),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color:HexColor(isCharacter==true?"#A8580F":"#F0F0F0"),
                                            border: Border.all(color:HexColor(isCharacter==true?"#A8580F":"#F0F0F0")),
                                            borderRadius:BorderRadius.circular(10)
                                        ),
                                        child: Utils.mediumHeadingNormalText(
                                            text: UtilStrings.Character_Attributes_Only,
                                            color: isCharacter==true?AppColor.white:HexColor("#242424"),
                                            fontFamily: 'Poppins',
                                            left: 10,
                                            textSize: 12),
                                      ),),
                                    const Gap(10),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          //Next screen according to this type
                                          SessionManager.setString(Preferences.CHOOSE_ANY_ONE, "2");
                                          isPhysical=false;
                                          isCharacter=false;
                                          isBoth=true;
                                          chooseType=2;
                                          attributeStatus=3;
                                        });
                                      },
                                      child:Container(
                                        height: 45,
                                        width:  Responsive().getResponsiveValue(
                                            forLargeScreen: MediaQuery.of(context).size.width/4.5,
                                            forShortScreen: MediaQuery.of(context).size.width/1.2,
                                            forTabletScreen: MediaQuery.of(context).size.width/1.2,
                                            forMediumScreen:  MediaQuery.of(context).size.width/1.2,
                                            context: context),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color:HexColor(isBoth==true?"#A8580F":"#F0F0F0"),
                                            border: Border.all(color:HexColor(isBoth==true?"#A8580F":"#F0F0F0")),
                                            borderRadius:BorderRadius.circular(10)
                                        ),
                                        child: Utils.mediumHeadingNormalText(
                                            text: UtilStrings.Both_Physical_Attributes_Only,
                                            color:isBoth==true?AppColor.white:HexColor("#242424"),
                                            fontFamily: 'Poppins',
                                            left: 10,
                                            textSize: 12),
                                      ),),
                                    const Gap(16),
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
                                Utils.progressDialog(context, isLoading,type: 0)
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
     if(chooseType==4){
       Utils.customDialog(context,message:UtilStrings.Please_choose_any_one);
     }
     else{
       setState(() {
         isLoading=true;
         profileUpdatePresenter?.doChooseType(attributeStatus);
       });
     }
    }

  @override
  onChooseAnyOne(SuccessResponse response) {
    setState(() {
      isLoading=false;
      if(response.status==200){
        if(chooseType==0){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
            viewType:14,
          )));
        }
        else if(chooseType==1){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
            viewType:16,
          )));
        }
        else if(chooseType==2){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
            viewType:14,
          )));
        }
      }
    });
  }
  @override
  onVerificationFace(SuccessResponse response) {

  }
  @override
  onDeletePhoto(SuccessResponse response) {
  }

  @override
  onError(String msg, int status) {
   setState(() {
     isLoading=false;
   });
  }

  @override
  onProfileUpdateResponse(UpdateProfileResponse response) {

  }

  @override
  onUpdateFloorStatusData(SuccessResponse response) {
  }

  @override
  onUpdateVerificationQuestions(SuccessResponse response) {
  }

  @override
  onUpdateusersQuestions(SuccessResponse response) {

  }

  @override
  onUploadMediaFile(PhotoResponse response) {

  }

  @override
  onUserProfileData(UserProfileResponse response) {
  }
  @override
  onVerificationPhoto(SuccessResponse response) {

  }
  @override
  onVerificationPhone(PhoneVerificationResponse response) {

  }
  @override
  onVerificationOtp(SuccessResponse response) {

  } @override
  onVerificationFacebook(SuccessResponse response) {

  }

}
