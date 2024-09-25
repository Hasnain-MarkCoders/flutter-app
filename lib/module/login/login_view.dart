import 'package:email_validator/email_validator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/module/home/login_presenter.dart';
import 'package:likeplay/module/model/register_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import 'package:likeplay/utils/color_utils.dart';
import 'package:likeplay/utils/responsive.dart';
import 'package:likeplay/utils/snackbar.dart';
import 'package:likeplay/utils/string_utils.dart';
import 'package:likeplay/utils/utils.dart';
import 'package:likeplay/widget/common/commontextfield_registerscreen.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../utils/route/route_name.dart';
import '../../utils/sharedpref/preferences.dart';
import '../../utils/sharedpref/shared_prefrence.dart';
import '../../widget/common/commonpassword_screen.dart';
import '../home/home.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class LoginScreen extends StatefulWidget {
  int? viewType;
  String? referralCode;
  LoginScreen({Key? key,this.viewType,this.referralCode}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginInterface {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  LoginPresenter? homePresenter;
  bool isLoading = false;

  @override
  void initState() {
    homePresenter = LoginPresenter(this);
    _readFromStorage();
    super.initState();
  }
  // Create storage
  final _storage = const FlutterSecureStorage();
  // Read values
  Future<void> _readFromStorage() async {
    userNameController.text = await _storage.read(key: "KEY_USERNAME") ?? '';
    passwordController.text = await _storage.read(key: "KEY_PASSWORD") ?? '';
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
                          forLargeScreen: 64.0,
                          forShortScreen: 0.0,
                          context: context)),
                      Gap(Responsive().getResponsiveValue(
                          forLargeScreen: 64.0,
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
                              text: "The #1 Dating Site in Nigeria",
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
                    height:  Responsive().getResponsiveValue(
                        forLargeScreen: MediaQuery.of(context).size.height/1.1,
                        forShortScreen: MediaQuery.of(context).size.height/1.2,
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
                      children: [
                        Gap(Responsive().getResponsiveValue(
                            forLargeScreen: 72.0,
                            forShortScreen: 40.0,
                            context: context)),
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
                                  Utils.mediumHeadingNormalText(
                                      text: "Login",
                                      fontFamily: 'Poppins',color: AppColor.black,
                                      fontWeight: FontWeight.bold,
                                      textSize: 18),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Utils.mediumHeadingNormalText(
                                      text: "Email",
                                      //text: "Username/Email",
                                      color: AppColor.black,
                                      fontFamily: 'Poppins',
                                      textSize: 12),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 6, bottom: 8),
                                    child: CommonTextfieldRegister(
                                        //hint: "Username/Email",
                                        hint: "Email",
                                        controller:  userNameController,
                                      color: Colors.black,
                                      comeFrom: "email",
                                    ),
                                  ),
                                  Utils.mediumHeadingNormalText(
                                      text: "Password",
                                      color: AppColor.black,
                                      fontFamily: 'Poppins',
                                      textSize: 12),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 6, bottom: 8),
                                    child: CommonPassword(
                                        hint: "Password",
                                        controller:  passwordController,
                                      bordercolor: Colors.grey,
                                    ),
                                  ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.end,
                                   children: [
                                     GestureDetector(
                                       onTap: (){
                                         Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                                           viewType: 4,
                                         )));
                                       },
                                         child: Utils.mediumHeadingNormalText(
                                       text: "Forgot Password?",
                                       color: AppColor.black,
                                       fontFamily: 'Poppins',
                                       textSize: 12)),
                                     Gap(18),
                                 ],),
                                  Gap(16),
                                  GestureDetector(
                                    onTap: (){
                                     validation(context);
                                     /* Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                                        viewType: 20,
                                       )));*/

                                    /* Navigator.pushReplacementNamed(
                                          context, RouteName.feed_screen, arguments: 1);*/
                                    },
                                    child:Container(
                                      height:44,
                                      width:Responsive().getResponsiveValue(
                                          forLargeScreen: MediaQuery.of(context).size.width/4.5,
                                          forShortScreen: MediaQuery.of(context).size.width/1.2,
                                          forTabletScreen: MediaQuery.of(context).size.width/1.2,
                                          forMediumScreen:  MediaQuery.of(context).size.width/1.4,
                                          forMobLandScapeMode:  MediaQuery.of(context).size.width/1.4,
                                          context: context),
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
                                          text: "Login",
                                          color: AppColor.white,
                                          fontFamily: 'Poppins',
                                          textSize: 13),
                                    ),),
                                  Gap(32),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Utils.mediumHeadingNormalText(
                                            text: UtilStrings.Alredy_have_an_account,
                                            color: Colors.grey,
                                            textSize: 14,
                                            fontFamily: 'Poppins'),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                                              viewType: 5,
                                            )));
                                          },
                                          child: Utils.mediumHeadingNormalText(
                                              text: UtilStrings.Register,
                                              color: Colors.red,
                                              textSize: 14,
                                              fontFamily: 'Poppins',
                                              underline: false),
                                        ),
                                      ],),
                                  ),
                                  Gap(Responsive().getResponsiveValue(
                                      forLargeScreen: 16.0,
                                      forShortScreen: 22.0,
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
    if(userNameController.text.trim().isEmpty){
      Utils.customDialog(context,message:UtilStrings.ENTER_YOUR_USERNAME_EMAIL);
    }
    else if (passwordController.text.isEmpty) {
      Utils.customDialog(context,message:UtilStrings.ENTER_YOUR_PASSWORD);
    }/*else if(passwordController.text.length<6){
      Utils.customDialog(UtilStrings.password_must_more_than_five_charater);
    }*/
    /*else if(!Utils.validateStructure(passwordController.text.toString())){
      Utils.customDialog(UtilStrings.password_must_contain_at_least);
    }*/
    else {
      setState(() {
        isLoading=true;
      });
      homePresenter!.doLoginPost(userNameController.text.toString().trim(),passwordController.text.toString().trim());
    }
    //}

  }

  @override
  onError(String msg, int status) {
    setState(() {
      isLoading = false;
    });
    if (status == 400) {
      Utils.customDialog(context,message:msg.toString());
    }
    else if(status==401){
      Utils.customDialog(context,message:msg.toString());
    }else if(status==404){
      Utils.customDialog(context,message:msg.toString());
    }
    else {
    }
  }

  @override
  onRegisterResponse(RegisterResponse response) {

  }

  @override
  onLoginResponse(response) async {
    setState(() {
      isLoading = false;
    });
    if(response.status==200){
      Utils.hideKeyBoard(context);
      _onFormSubmit();
      //Subscribe Topic here
       //End
      //Utils.customDialog(response.message!);
      SessionManager.setString(Preferences.ACCESS_TOKEN, response.data!.token.toString());
      SessionManager.setString(Preferences.USER_NAME, response.data!.name.toString());
      SessionManager.setString(Preferences.REFERAL_CODE, response.data!.referCode.toString());
      SessionManager.setString(Preferences.USER_ID, response.data!.id.toString());
      SessionManager.setString(Preferences.CHOOSE_ANY_ONE, response.data!.chooseAnyOne.toString());
      SessionManager.setString(Preferences.PROFILE_IMAGE, response.data!.userImagesWhileSignup!.isNotEmpty?response.data!.userImagesWhileSignup![0].imageUrl.toString():"");
      SessionManager.setString(Preferences.INDEX,"0");
      SessionManager.setString(Preferences.profileStatus,response.data!.profileStatus.toString());
      SessionManager.setString(Preferences.verification_status,response.data!.userVerification.toString());
      SessionManager.setString(Preferences.government_status, "");
      SessionManager.setString(Preferences.phone_status, "");
      SessionManager.setString(Preferences.pose_status, "");
      SessionManager.setString(Preferences.facebook_status, "");
      SessionManager.setString(Preferences.login_created_date, response.data!.createdAt.toString());
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
           DateTime resultDate = Utils.calculate28DaysFromDate(int.parse(response.data!.subscriptions![0].purchaseDate));
           SessionManager.setString(Preferences.subscription_end_date,resultDate.toString());
         }else if(response.data!.subscriptions![0].purchaseType.toString()=="2"){
           DateTime resultDate = Utils.calculate3MonthFromDate(int.parse(response.data!.subscriptions![0].purchaseDate));
           SessionManager.setString(Preferences.subscription_end_date,resultDate.toString());
         }else if(response.data!.subscriptions![0].purchaseType.toString()=="3"){
           DateTime resultDate = Utils.calculate12MonthFromDate(int.parse(response.data!.subscriptions![0].purchaseDate));
           SessionManager.setString(Preferences.subscription_end_date,resultDate.toString());
         }
        SessionManager.setString(Preferences.is_trial, "false");
      }else{
        SessionManager.setString(Preferences.subscription_status, response.data!.subscriptionStatus.toString());
        SessionManager.setString(Preferences.subscription_plan, "");
        SessionManager.setString(Preferences.plan_ammount, "");
        SessionManager.setString(Preferences.is_trial, "false");
        SessionManager.setString(Preferences.plan_id, "");
      }

/*Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
        // viewType: 9,
        viewType:19,
        // viewType: 19,
      )));*/
    /* Navigator.pushReplacementNamed(
          context, RouteName.feed_screen, arguments: 1);*/
      if(response.data!.profileStatus==0){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
          viewType: 6,
        )));
      }
      else if(response.data!.profileStatus==1){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
          viewType: 8,
        )));
      }
      else if(response.data!.profileStatus==2){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
          viewType: 10,
        )));
      }
      else if(response.data!.profileStatus==3){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
          viewType: 11,
        )));
      }else if(response.data!.isUserVerified==false){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
          viewType: 21,
        )));
      }
      else if(response.data!.profileStatus==4){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
          viewType: 20,
        )));
      }
      else if(response.data!.profileStatus==5){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
          viewType: 13,
        )));
      }
      else if(response.data!.profileStatus==6 && response.data!.chooseAnyOne=="1"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
          viewType: 15,
        )));
      } else if(response.data!.profileStatus==6 && response.data!.chooseAnyOne=="3"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
          viewType: 16,
        )));
      }
      else if(response.data!.profileStatus==7 && response.data!.chooseAnyOne=="2"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
            viewType: 15
        )));

      }else if(response.data!.profileStatus==7 && response.data!.chooseAnyOne=="3"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
            viewType: 15
        )));

      } else if(response.data!.profileStatus==8 ){
        if(response.data!.userVerification.toString()=="2"){
          Utils.customDialog(context,message:"Your profile information is submitted but under review. You will be able to access the information for edits.");
        }else{
          Utils.customDialog(context,message:"Your profile information is submitted but under review. You will not be able to access the information for edits.");
        }
        //user_verification: DataTypes.ENUM('0', '1', '2'),  //0-PENDING(default),1-VERIFIED,2-RETURN_TO_EDIT
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
          viewType: 19,
          comesFrom: "LoginEdit",
        )));

      }
      else if(response.data!.profileStatus==9){
        Utils.signInAnonymously();
        SessionManager.setBools(Preferences.IS_USER_LOGIN, true);
        await FirebaseMessaging.instance.subscribeToTopic("user_${response.data!.id.toString()}");
        await FirebaseMessaging.instance.subscribeToTopic("chatId_${response.data!.id.toString()}");
        await FirebaseMessaging.instance.subscribeToTopic("is_admin");
        Utils.onUserLogin(response.data!.id.toString(),response.data!.name.toString());
        Navigator.pushReplacementNamed(context, RouteName.feed_screen, arguments: 1);
      }else if(response.data!.profileStatus==10 ){
        if(response.data!.userVerification.toString()=="2"){
          Utils.customDialog(context,message:"Your profile information is submitted but under review.\nYou will be able to access the information for edits!");
        }else{
          Utils.customDialog(context,message:"Your profile information is submitted but under review.\nYou will not be able to access the information for edits!");
        }
        //user_verification: DataTypes.ENUM('0', '1', '2'),  //0-PENDING(default),1-VERIFIED,2-RETURN_TO_EDIT
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
          viewType: 19,
          comesFrom: "LoginEdit",
        )));

      }

    }
    else{
      Utils.customDialog(context,message:response.message.toString());
    }
  }

  @override
  onForgotResponse(SuccessResponse response) {

  }
  bool _savePassword = true;
  _onFormSubmit() async {
    if (_savePassword==true) {
      // Write values
      await _storage.write(key: "KEY_USERNAME", value: userNameController.text);
      await _storage.write(key: "KEY_PASSWORD", value: passwordController.text);
    }

  }

}
