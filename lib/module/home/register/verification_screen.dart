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
import 'package:likeplay/utils/string_utils.dart';
import 'package:likeplay/utils/utils.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../model/phone_verification_response.dart';
import '../../model/verification_model.dart';



class VerificationScreen extends StatefulWidget {
  int? viewType;
  VerificationScreen({Key? key,this.viewType}) : super(key: key);
  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> implements ProfileUpdateInterface{
  bool isLoading = false;
  ProfileUpdatePresenter? profileUpdatePresenter;
  TextEditingController additionalController = TextEditingController();
  bool isSwitched = false;
  int hardDrug=0;
  int criminal=0;
  int sexualHarassment=0;
  int violence=0;
  int financialCrime=0;
  int domesticViolence=0;
  int seriousCrimes=0;
  final List <VerificationModel> verification=[
    VerificationModel(text: "Have you ever been involved in taking hard drugs?", valueNo: false,valueYes: false),
    VerificationModel(text: "Have you been involved in criminal activity?",  valueNo: false,valueYes: false),
    VerificationModel(text: "Have you been involved in sexual harassment?",  valueNo: false,valueYes: false),
    VerificationModel(text: "Have you been involved in domestic violence?", valueNo: false,valueYes: false),
    VerificationModel(text: "Have you been convicted of any criminal activity involving hard drugs and financial crimes?",  valueNo: false,valueYes: false),
    VerificationModel(text: "Have you been convicted in activity involving sexual harassment or domestic violence?", valueNo: false,valueYes: false),
    VerificationModel(text: "Have you been involved in other serious crimes? ", valueNo: false,valueYes: false),
  ];
  @override
  void initState() {
    super.initState();
    profileUpdatePresenter=ProfileUpdatePresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return SingleChildScrollView(
        child:
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
                      child: Column(
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
                              child:Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Utils.mediumHeadingNormalText(
                                      text: UtilStrings.complete_verification,
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
                            'assets/images/step_verification.png',
                            width: Responsive().getResponsiveValue(
                                forLargeScreen: size.width / 2,
                                forShortScreen: size.width / 1.1,
                                forMobLandScapeMode: size.width / 2,
                                forMediumScreen: size.width / 2,
                                forTabletScreen: size.width / 2,
                                context: context),
                          )),
                          Gap(10),
                          Stack(children: [
                            Container(
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Utils.mediumHeadingStarNormalText(
                                            text: UtilStrings.Verification,
                                            fontFamily: 'Poppins',
                                            color: AppColor.black,
                                            textSize: 14),
                                        Gap(16),
                                        Container(
                                          margin: EdgeInsets.only(right: Responsive().getResponsiveValue(
                                              forLargeScreen: 16.0,
                                              forShortScreen: 0.0,
                                              forMobLandScapeMode: 0.0,
                                              forMediumScreen: 0.0,
                                              forTabletScreen: 0.0,
                                              context: context),),
                                          child: ListView.builder(

                                              itemCount: verification.length,
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemBuilder: (BuildContext context,int index){
                                                return  Container(
                                                  margin: EdgeInsets.only(bottom: 12),
                                                  height: Responsive().getResponsiveValue(
                                                      forLargeScreen: 54.0,
                                                      forShortScreen: 72.0,
                                                      forMobLandScapeMode: 0.0,
                                                      forMediumScreen: 72.0,
                                                      forTabletScreen:62.0,
                                                      context: context),width: size.width,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(color: Colors.grey),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left:8,right: 8),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                            width:Responsive().getResponsiveValue(
                                                                forLargeScreen: MediaQuery.of(context).size.width/5.2,
                                                                forShortScreen: MediaQuery.of(context).size.width/2.6,
                                                                forMobLandScapeMode: 0.0,
                                                                forMediumScreen: MediaQuery.of(context).size.width/2.8,
                                                                forTabletScreen:MediaQuery.of(context).size.width/3.2,
                                                                context: context) ,
                                                            child:
                                                            Text("${verification[index].text}",style:  const TextStyle(color: Colors.black,fontSize: 8,
                                                              fontFamily: 'Poppins',),)),
                                                        // Text("*", style: TextStyle(color: Colors.red,fontSize: 12)),
                                                        Spacer(),
                                                        Theme(
                                                            data: Theme.of(context).copyWith(
                                                              unselectedWidgetColor: Colors.grey,
                                                            ),
                                                            child:Checkbox(
                                                                activeColor: Color(0xffA8580F),
                                                                value: verification[index].valueNo, onChanged: (value){
                                                              if(verification[index].valueNo==false){
                                                                setState(() {
                                                                  verification[index].valueNo=true;
                                                                  verification[index].valueYes=false;
                                                                });
                                                                setState(() {
                                                                  if(index==0){
                                                                    hardDrug=1;
                                                                  }else if(index==1){
                                                                    criminal=1;
                                                                  }else if(index==2){
                                                                    sexualHarassment=1;
                                                                  }else if(index==3){
                                                                    violence=1;
                                                                  }else if(index==4){
                                                                    financialCrime=1;
                                                                  }else if(index==5){
                                                                    domesticViolence=0;
                                                                  }else if(index==6){
                                                                    seriousCrimes=1;
                                                                  }
                                                                });
                                                              }
                                                            })),
                                                        Utils.mediumHeadingNormalText(
                                                            text: "No",
                                                            color: AppColor.black,
                                                            fontFamily: 'Poppins',
                                                            textSize: 8),
                                                        Gap(8),
                                                        Theme(
                                                            data: Theme.of(context).copyWith(
                                                              unselectedWidgetColor: Colors.grey,
                                                            ),
                                                            child:Checkbox(
                                                                activeColor: Color(0xffA8580F),
                                                                value: verification[index].valueYes, onChanged: (value){
                                                              if(verification[index].valueYes==false){
                                                                setState(() {
                                                                  verification[index].valueYes=true;
                                                                  verification[index].valueNo=false;

                                                                });
                                                                setState(() {
                                                                  if(index==0){
                                                                    hardDrug=1;
                                                                  }else if(index==1){
                                                                    criminal=1;
                                                                  }else if(index==2){
                                                                    sexualHarassment=1;
                                                                  }else if(index==3){
                                                                    violence=1;
                                                                  }else if(index==4){
                                                                    financialCrime=1;
                                                                  }else if(index==5){
                                                                    domesticViolence=0;
                                                                  }else if(index==6){
                                                                    seriousCrimes=1;
                                                                  }
                                                                });
                                                              }
                                                            })),
                                                        Utils.mediumHeadingNormalText(
                                                            text: "Yes",
                                                            color: AppColor.black,
                                                            fontFamily: 'Poppins',
                                                            textSize: 8),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }) ,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                                onTap: (){
                                                  Navigator.pop(context);
                                                },
                                                child:Container(
                                                  height: 100,
                                                  width:  Responsive().getResponsiveValue(
                                                      forLargeScreen: MediaQuery.of(context).size.width/5.4,
                                                      forShortScreen: MediaQuery.of(context).size.width/2.0,
                                                      forTabletScreen: MediaQuery.of(context).size.width/3.2,
                                                      forMediumScreen:  MediaQuery.of(context).size.width/2.0,
                                                      context: context),
                                                  decoration: BoxDecoration(
                                                      color:AppColor.white,
                                                      border: Border.all(color:AppColor.grey),
                                                      borderRadius:BorderRadius.circular(10)
                                                  ),
                                                  child: TextField(
                                                    controller: additionalController,
                                                    cursorColor:Colors.black,
                                                    style: TextStyle(color:Colors.black,fontFamily: 'Poppins',fontSize: 14),
                                                    maxLines: 5,
                                                    decoration:const InputDecoration(
                                                        counterText:'',
                                                        contentPadding: EdgeInsets.only(left:16,bottom:4,right: 10,top: 12),
                                                        border: InputBorder.none,
                                                        hintText:"Add Additional details...",
                                                        hintStyle:TextStyle(color:Colors.grey,fontFamily: 'Poppins',fontSize: 12)
                                                    ),
                                                  ),
                                                )),
                                            Gap(12),
                                            GestureDetector(
                                              onTap: (){
                                                validation();
                                                /* Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                                         viewType:13,
                                       )));*/
                                              },
                                              child:Container(
                                                height:45,
                                                width:Responsive().getResponsiveValue(
                                                    forLargeScreen: 100.0,
                                                    forShortScreen: 86.0,
                                                    forTabletScreen: 86.0,
                                                    forMediumScreen: 86.0,
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
                                              ),)
                                          ],),
                                      ]),
                                ],),
                              ),
                            ),
                            Utils.progressDialog(context, isLoading, type: 1)
                          ],),
                          Gap(Responsive().getResponsiveValue(
                              forLargeScreen: 54.0,
                              forShortScreen: 36.0,
                              context: context)),
                        ],
                      ),
                    ),
                    ),

                  ],
                ),
                Gap(36)
              ],),
          ),
    );
  }
  validation() {
    var contain = verification.where((element) => element.valueYes == true);
    if(hardDrug==0 && criminal==0 && sexualHarassment==0){
      Utils.customDialog(context,message:UtilStrings.Please_select_verification);
    }else if(violence==0 && financialCrime==0){
      Utils.customDialog(context,message:UtilStrings.Please_select_verification);
    }else if(domesticViolence==0 && seriousCrimes==0){
      Utils.customDialog(context,message:UtilStrings.Please_select_verification);
    }
    else if(contain.isNotEmpty){
      if( additionalController.text.trim().toString().isEmpty){
        Utils.customDialog(context,message:UtilStrings.Please_add_Additional_details);
      } else {
        setState(() {
          isLoading=true;
        });
        profileUpdatePresenter?.doProfileUpdateVerifictionData(
            taking_hard_drugs: verification[0].valueYes==true?"Yes":"No",
            criminal_activity: verification[0].valueYes==true?"Yes":"No",
            sexual_harassment:verification[0].valueYes==true?"Yes":"No",
            domestic_violence:verification[0].valueYes==true?"Yes":"No",
            financial_crimes:verification[0].valueYes==true?"Yes":"No",
            harassment_domestic_violence:verification[0].valueYes==true?"Yes":"No",
            serious_crime:verification[0].valueYes==true?"Yes":"No",
            additional_details:additionalController.text.toString()
        );
      }
    }
    else{
      profileUpdatePresenter?.doProfileUpdateVerifictionData(
          taking_hard_drugs: verification[0].valueYes==true?"Yes":"No",
          criminal_activity: verification[0].valueYes==true?"Yes":"No",
          sexual_harassment:verification[0].valueYes==true?"Yes":"No",
          domestic_violence:verification[0].valueYes==true?"Yes":"No",
          financial_crimes:verification[0].valueYes==true?"Yes":"No",
          harassment_domestic_violence:verification[0].valueYes==true?"Yes":"No",
          serious_crime:verification[0].valueYes==true?"Yes":"No",
          additional_details:additionalController.text.toString()
      );
    }
  }

  @override
  onDeletePhoto(SuccessResponse response) {
  }

  @override
  onError(String msg, int status) {
    setState(() {
      isLoading=false;
    });
    Utils.customDialog(context,message:msg);
  }

  @override
  onProfileUpdateResponse(UpdateProfileResponse response) {
  }

  @override
  onUpdateusersQuestions(SuccessResponse response) {
    setState(() {
      isLoading=false;
      if(response.status==200){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
          viewType:13,
        )));
      }
    });
  }

  @override
  onUploadMediaFile(PhotoResponse response) {
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
