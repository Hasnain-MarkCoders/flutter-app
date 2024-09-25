import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/module/components/footer.dart';
import 'package:likeplay/module/components/header.dart';
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
import 'package:likeplay/widget/common/commontextfield_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/sharedpref/preferences.dart';
import '../../../utils/sharedpref/shared_prefrence.dart';
import '../../../widget/common/commonpassword_screen.dart';
import '../../../widget/common/commontextfield_registerscreen.dart';
import '../../model/phone_verification_response.dart';
import '../../model/update_profile_response.dart';

class UserAboutUsScreen extends StatefulWidget {
  int? viewType;
  String? comesFrom;
  UserAboutUsScreen({Key? key,this.viewType,this.comesFrom}) : super(key: key);
  @override
  State<UserAboutUsScreen> createState() => _UserAboutUsScreenState();
}

class _UserAboutUsScreenState extends State<UserAboutUsScreen> implements ProfileUpdateInterface {
  TextEditingController aboutUsController = TextEditingController();
  ProfileUpdatePresenter? profileUpdatePresenter;
  bool isLoading = false;

  @override
  void initState() {
    profileUpdatePresenter = ProfileUpdatePresenter(this);
    if(widget.comesFrom=="EditProfile"){
      setState(() {
        aboutUsController.text=SessionManager.getString(Preferences.ABOUT_ME);
      });
    }else if(widget.comesFrom=="EditFromProfile"){
      aboutUsController.text=SessionManager.getString(Preferences.ABOUT_ME);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child:
          Stack(children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap:(){
                Utils.hideKeyBoard(context);
              },
              child: Column(
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
                            widget.comesFrom=="EditProfile" || widget.comesFrom=="EditFromProfile"?Container():
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Utils.mediumHeadingNormalText(
                                    text: UtilStrings.six_Complete,
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
                            widget.comesFrom=="EditProfile"|| widget.comesFrom=="EditFromProfile"?Container(): Image.asset(
                              'assets/images/step_six.png',
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
                                      widget.comesFrom=="EditProfile"|| widget.comesFrom=="EditFromProfile"?Container():
                                      Row(
                                       children: [
                                         Utils.mediumHeadingNormalText(
                                           text: UtilStrings.Welcome,
                                           fontFamily: 'Poppins',color: AppColor.black,
                                           fontWeight: FontWeight.bold,
                                           textSize: 18),
                                         Spacer(),
                                         Utils.mediumHeadingNormalText(
                                             text: "Step 5/6",
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
                                          text: "About me",
                                          fontFamily: 'Poppins',color: AppColor.black,
                                          textSize: 12),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(top: 6),
                                        child:  CommonTextfieldRegister(
                                              hint: "Type something...",
                                              controller:  aboutUsController,
                                            maxLines: 15,
                                            height: 200,
                                           length: 2001,
                                          toppadding: 12,
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
                                                viewType:11,
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
            ),

          ],)


    );

  }

    validation(BuildContext context) {
      if(aboutUsController.text.toString().isEmpty){
        Utils.customDialog(context,message:UtilStrings.ENTER_YOUR_About_me);
      }
      else {
        setState(() {
          isLoading=true;
        });
        profileUpdatePresenter!.doProfileUpdateThreeData(aboutUs: aboutUsController.text.toString(),type: 3);

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
      if(widget.comesFrom=="EditProfile"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
          viewType: 19,
        )));
      }else if(widget.comesFrom=="EditFromProfile"){
         Navigator.pop(context);
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
          viewType:11,
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
