import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/module/home/home.dart';
import 'package:likeplay/module/home/login_presenter.dart';
import 'package:likeplay/module/home/register/presenter/country_presenter.dart';
import 'package:likeplay/module/model/login_response.dart';
import 'package:likeplay/module/model/register_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import 'package:likeplay/utils/color_utils.dart';
import 'package:likeplay/utils/responsive.dart';
import 'package:likeplay/utils/route/route_name.dart';
import 'package:likeplay/utils/sharedpref/preferences.dart';
import 'package:likeplay/utils/sharedpref/shared_prefrence.dart';
import 'package:likeplay/utils/string_utils.dart';
import 'package:likeplay/utils/utils.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widget/common/commonpassword_screen.dart';
import '../../../widget/common/commontextfield_registerscreen.dart';
import '../../login/login_view.dart';
import '../../model/country_response.dart';

class RegisterScreen extends StatefulWidget {
  int? viewType;
  RegisterScreen({Key? key,this.viewType}) : super(key: key);
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> implements LoginInterface,CountryInterface {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController referralController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  LoginPresenter? loginPresenter;
  CountryPresenter? countryPresenter;
  bool isLoading = false;
  String countryName="Nigeria";
  bool isCheck = false;
  @override
  void initState() {
    loginPresenter = LoginPresenter(this);
    countryPresenter = CountryPresenter(this);
    //Getting the country Here
    countryPresenter?.doCountryData();
    //End
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
                            Image.asset(
                              'assets/images/app_icon.png',
                              height: Responsive().getResponsiveValue(
                                  forLargeScreen: size.height * 0.2,
                                  forShortScreen: size.height * 0.1,
                                  forTabletScreen: size.height * 0.1,
                                  context: context),
                            ),
                            Gap(22),
                            Utils.mediumHeadingNormalText(
                                text: "The #1 Dating Site in "+countryName,
                                fontFamily: 'Poppins',color: AppColor.white,
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.center,
                                textSize: Responsive().getResponsiveValue(
                                    forLargeScreen: 22.0,
                                    forShortScreen: 18.0,
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
                      /*height:  Responsive().getResponsiveValue(
                          forLargeScreen: MediaQuery.of(context).size.height/1.1,
                          forShortScreen: MediaQuery.of(context).size.height,
                          forMobLandScapeMode: MediaQuery.of(context).size.height/1.2,
                          forMediumScreen: MediaQuery.of(context).size.height/1.2,
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
                              forShortScreen: 22.0,
                              context: context)),
                         Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Utils.mediumHeadingNormalText(
                             text: UtilStrings.first_Complete,
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
                            'assets/images/step_one.png',
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
                                    Row(
                                      children: [
                                      Platform.isIOS?  GestureDetector(
                                          onTap: (){
                                            Navigator.pop(context);
                                          },
                                          child: Icon(Icons.arrow_back,color: Colors.black,)):SizedBox(),
                                        Platform.isIOS?  Gap(8):SizedBox(),
                                        Utils.mediumHeadingNormalText(
                                            text: "Registration",
                                            fontFamily: 'Poppins',color: AppColor.black,
                                            fontWeight: FontWeight.bold,
                                            textSize: 18),
                                      ],
                                    ),
                                    Gap(8),
                                    Utils.mediumHeadingStarNormalText(
                                        text: "Username",
                                        color: AppColor.black,
                                        fontFamily: 'Poppins',
                                        textSize: 12),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 6),
                                      child: CommonTextfieldRegister(
                                          hint: "Username",
                                          controller:  userNameController,
                                        comeFrom: "userName",
                                      ),
                                    ),
                                    Gap(8),
                                    Utils.mediumHeadingStarNormalText(
                                        text: "Email",
                                        color: AppColor.black,
                                        fontFamily: 'Poppins',
                                        textSize: 12),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 6),
                                      child: CommonTextfieldRegister(
                                          hint: "Email",
                                          controller:  emailController,
                                        comeFrom: "email",
                                      ),
                                    ),
                                    Gap(8),
                                    Utils.mediumHeadingNormalText(
                                        text: "Password",
                                        color: AppColor.black,
                                        fontFamily: 'Poppins',
                                        textSize: 12),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 6,),
                                      child: CommonPassword(
                                          hint: "Password",
                                          controller:  passwordController,
                                          bordercolor: Colors.grey,
                                      ),
                                    ),
                                    Gap(8),
                                    Utils.mediumHeadingNormalText(
                                        text: "Enter Referral code if referred by a friend",
                                        color: AppColor.black,
                                        fontFamily: 'Poppins',
                                        textSize: 12),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 6),
                                      child: CommonTextfieldRegister(
                                          hint: "willsmith1234221",
                                          controller:  referralController
                                      ),
                                    ),
                                    Gap(12),
                                    Container(
                                      child: Row(
                                        children: [
                                          Theme(
                                              data: ThemeData(
                                                primarySwatch: Colors.grey,
                                                unselectedWidgetColor: Colors.red, // Your color
                                              ),
                                              child:Checkbox(
                                                checkColor: HexColor("#FF483C"),
                                                value: isCheck,

                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    isCheck = value!;
                                                  });
                                                  if(isCheck==true){
                                                    Utils.hideKeyBoard(context);
                                                  }
                                                },
                                              )),
                                          Utils.mediumHeadingNormalText(text:UtilStrings.i_agree_with,textSize: 13,color:AppColor.black,fontFamily: "Poppins",fontWeight: FontWeight.w400),
                                          InkWell(
                                              onTap: () {
                                                // termconditiondialog();
                                                // launch("https://www.termsfeed.com/live/8dcf5e43-fe7d-4c54-8573-9ffa912cef4e");
                                                Navigator.pushNamed(context, RouteName.TermsAndConditionScreen);
                                              },
                                              child: Utils.mediumHeadingNormalText(text:" " + UtilStrings.terms,textSize: 13, color: Color(0xFFFF483C),fontFamily: "Poppins",fontWeight: FontWeight.w500)),
                                          //Utils.mediumHeadingNormalText(text:" " + UtilStrings.and + " ",textSize: 13, color: Colors.black,fontFamily: "Poppins",fontWeight: FontWeight.w400),

                                          /*     InkWell(
                                            onTap: () {
                                              //privacypolicydialog();

                                            },
                                            child: Utils.mediumHeadingNormalText(text: " " + UtilStrings.privacy,textSize: 13, color: Color(0xFFFF483C),fontFamily: "Poppins",fontWeight: FontWeight.w500),

                                          ),*/
                                        ],
                                      ),
                                    ),
                                    Gap(16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [ GestureDetector(
                                        onTap: (){
                                        /*  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                                            viewType: 6,
                                          )));*/
                                          validation(context);
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
                                  /*  Gap(16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: ()async{
                                            var url = "https://www.google.com/";
                                            Utils.openUrl(url);
                                          },
                                          child: Utils.mediumHeadingNormalText(
                                              text: UtilStrings.Terms_and_Conditions,
                                              color: AppColor.red,
                                              textAlign: TextAlign.center,
                                              fontFamily: 'Poppins',
                                              textSize: 12),
                                        )
                                      ]),
                                    Gap(4),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Utils.mediumHeadingNormalText(
                                              text: UtilStrings.How_it_works,
                                              color: AppColor.black,
                                              textAlign: TextAlign.center,
                                              fontFamily: 'Poppins',
                                              textSize: 12),
                                          Gap(2),
                                          GestureDetector(
                                            onTap: ()async{
                                              var url = "https://www.likeplaylikeplay.com/";
                                              Utils.openUrl(url);
                                            },
                                            child:  Utils.mediumHeadingNormalText(
                                              text: UtilStrings.WEB_SITE_LINK,
                                              color: AppColor.red,
                                              textAlign: TextAlign.center,
                                              fontFamily: 'Poppins',
                                              textSize: 12),)
                                        ]),*/
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
                          Gap(Responsive().getResponsiveValue(
                              forLargeScreen: 42.0,
                              forShortScreen: 32.0,
                              context: context)),
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
    if (userNameController.text.trim().isEmpty) {
      Utils.customDialog(context,message:UtilStrings.ENTER_YOUR_USER_NAME);

    }
    else if (emailController.text.isEmpty) {
      Utils.customDialog(context,message:UtilStrings.ENTER_YOUR_EMAIL);
    }
    else if (!EmailValidator.validate(emailController.text.toString().trim())){
      Utils.customDialog(context,message:UtilStrings.ENTER_YOUR_VALID_EMAIL);
    }
    else if (passwordController.text.isEmpty) {
      Utils.customDialog(context,message:UtilStrings.ENTER_YOUR_PASSWORD);
    }else if(!Utils.validateStructure(passwordController.text.toString())){
      Utils.customDialog(context,message:UtilStrings.password_must_contain_at_least);
    }else if(passwordController.text.length<6){
      Utils.customDialog(context,message:UtilStrings.password_must_more_than_five_charater);
    }
    else if(isCheck==false){
      Utils.customDialog(context,message:UtilStrings.please_check_terms_and_conditions);
    }
    else {
      /* Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
         viewType: 6,
       )));*/
      Utils.hideKeyBoard(context);
      setState(() {
        isLoading=true;
      });

      loginPresenter!.doRegisterPost(userNameController.text.toString().trim(),emailController.text.toString().trim(),passwordController.text.toString().trim(),referralController.text.toString(),"0",countryName);
    }
  }

  @override
  onError(String msg, int status) {
    setState(() {
      isLoading = false;
    });
    print("error==>"+msg);
    if(status==404){
      Utils.customDialog(context,message:msg);
    }
    else if(status == 400)  {
      Utils.customDialog(context,message:msg.toString());
    }
  }

  @override
  onLoginResponse(LoginResponse response) {

  }

  @override
  onRegisterResponse(RegisterResponse response) {
    setState(() {
      isLoading = false;
    });
    if (response.status == 200) {
      SessionManager.setString(Preferences.ACCESS_TOKEN, response.data!.token.toString());
      SessionManager.setString(Preferences.USER_ID, response.data!.id.toString());
      SessionManager.setString(Preferences.profileStatus,"");
      SessionManager.setString(Preferences.government_status, "");
      SessionManager.setString(Preferences.phone_status, "");
      SessionManager.setString(Preferences.pose_status, "");
      SessionManager.setString(Preferences.facebook_status, "");
      //Utils.customDialog(response.message.toString());

      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
        viewType: 22,
        email: response.data!.email.toString(),
      )));

      setState(() {
        userNameController.text="";
        emailController.text="";
        passwordController.text="";
        referralController.text="";
        isCheck = false;

      });
    }
    else {
    }
  }

  @override
  onForgotResponse(SuccessResponse response) {
  }

  @override
  onCountryError(String msg, String status) {
    if(status==500){

    }
  }

  @override
  onCountryResponse(CountryResponse response) {
    setState(() {
      if(response.location!.country!.name.toString().toLowerCase()=="nigeria" || response.location!.country!.name.toString().toLowerCase()=="ghana"
          || response.location!.country!.name.toString().toLowerCase()=="south africa"
          || response.location!.country!.name.toString().toLowerCase()=="cote d'ivoire"
          || response.location!.country!.name.toString().toString().toLowerCase()=="congo"
      ){
        countryName=response.location!.country!.name.toString();
      }
      else{
        countryName="Nigeria";
      }

    });
  }

}
