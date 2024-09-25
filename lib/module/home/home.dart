import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:likeplay/module/aboutus/aboutus_screen.dart';
import 'package:likeplay/module/coming_screen/coming_screen.dart';
import 'package:likeplay/module/components/footer.dart';
import 'package:likeplay/module/components/header.dart';
import 'package:likeplay/module/components/side_menu.dart';
import 'package:likeplay/module/forgot/forgot_view.dart';
import 'package:likeplay/module/home/register/aboutus_screen.dart';
import 'package:likeplay/module/home/register/character_question_screen.dart';
import 'package:likeplay/module/home/register/character_questionone_screen.dart';
import 'package:likeplay/module/home/register/character_questiontwo_screen.dart';
import 'package:likeplay/module/home/register/choose_anyone_screen.dart';
import 'package:likeplay/module/home/register/complete_register_form.dart';
import 'package:likeplay/module/home/register/docucment_view_screen.dart';
import 'package:likeplay/module/home/register/partner_attributes_screen.dart';
import 'package:likeplay/module/home/register/physical_attributes_screen.dart';
import 'package:likeplay/module/home/register/profile_photo_screen.dart';
import 'package:likeplay/module/home/register/profile_view_screen.dart';
import 'package:likeplay/module/home/register/register_screen.dart';
import 'package:likeplay/module/home/register/user_address_screen.dart';
import 'package:likeplay/module/home/register/user_info_screen.dart';
import 'package:likeplay/module/home/register/verification_screen.dart';
import 'package:likeplay/module/home/register/welcome_screen.dart';
import 'package:likeplay/module/referral/referal_screen.dart';
import 'package:likeplay/utils/responsive.dart';
import '../login/login_view.dart';
import 'register/personal_info_screen.dart';
import 'register/user_rangepreference_screen.dart';

class HomeScreen  extends StatefulWidget {
  int? viewType,genderType,gender,interestedIns;
  String? firstName,age;
  String? referralCode;
  String? residenceCountry;
  String? state, city, nationality, religion,your_tribe;
  String? comesFrom;
  String? email;
  HomeScreen({Key? key,this.viewType,this.referralCode, this.firstName,this.gender,this.age,this.genderType,this.interestedIns,
    this.residenceCountry,this.state,this.city,this.nationality,this.religion,this.your_tribe,this.comesFrom,this.email}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      endDrawer: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 300
        ),
        child: SideMenu(viewType:widget.viewType),
      ),
      body: Container(
          decoration:  widget.viewType==2? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_background.jpg'),
                  fit:  Responsive().getResponsiveValue(
                      forLargeScreen: BoxFit.cover,
                      forShortScreen: BoxFit.cover,
                      forMediumScreen: BoxFit.cover,
                      forTabletScreen: BoxFit.cover,
                      context: context)
              )):
          widget.viewType==5? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_one.jpg'),
                  fit:  Responsive().getResponsiveValue(
                      forLargeScreen: BoxFit.cover,
                      forShortScreen: BoxFit.cover,
                      forMediumScreen: BoxFit.cover,
                      forTabletScreen: BoxFit.cover,
                      context: context)
              )):
          widget.viewType==6? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_two.jpg'),
                  fit:  Responsive().getResponsiveValue(
                      forLargeScreen: BoxFit.cover,
                      forShortScreen: BoxFit.cover,
                      forMediumScreen: BoxFit.cover,
                      forTabletScreen: BoxFit.cover,
                      context: context)
              )):
          widget.viewType==7? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_three.jpg'),
                  fit:  Responsive().getResponsiveValue(
                      forLargeScreen: BoxFit.cover,
                      forShortScreen: BoxFit.cover,
                      forMediumScreen: BoxFit.cover,
                      forTabletScreen: BoxFit.cover,
                      context: context)
              )):
          widget.viewType==8? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_four.jpg'),
                  fit:  Responsive().getResponsiveValue(
                      forLargeScreen: BoxFit.cover,
                      forShortScreen: BoxFit.cover,
                      forMediumScreen: BoxFit.cover,
                      forTabletScreen: BoxFit.cover,
                      context: context)
              )):
          widget.viewType==9? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_five.jpg'),
                  fit:  Responsive().getResponsiveValue(
                      forLargeScreen: BoxFit.cover,
                      forShortScreen: BoxFit.cover,
                      forMediumScreen: BoxFit.cover,
                      forTabletScreen: BoxFit.cover,
                      context: context)
              )):
          widget.viewType==10? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_six.jpg'),
                  fit:  Responsive().getResponsiveValue(
                      forLargeScreen: BoxFit.cover,
                      forShortScreen: BoxFit.cover,
                      forMediumScreen: BoxFit.cover,
                      forTabletScreen: BoxFit.cover,
                      context: context)
              )):
          widget.viewType==11? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_photo.jpg'),
                  fit:  Responsive().getResponsiveValue(
                      forLargeScreen: BoxFit.cover,
                      forShortScreen: BoxFit.cover,
                      forMediumScreen: BoxFit.cover,
                      forTabletScreen: BoxFit.cover,
                      context: context)
              )):
          widget.viewType==13? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_chooseone.jpg'),
                  fit:  Responsive().getResponsiveValue(
                      forLargeScreen: BoxFit.cover,
                      forShortScreen: BoxFit.cover,
                      forMediumScreen: BoxFit.cover,
                      forTabletScreen: BoxFit.cover,
                      context: context)
              )):
          widget.viewType==14? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_physicalone.jpg'),
                  fit:  Responsive().getResponsiveValue(
                      forLargeScreen: BoxFit.cover,
                      forShortScreen: BoxFit.cover,
                      forMediumScreen: BoxFit.cover,
                      forTabletScreen: BoxFit.cover,
                      context: context)
              )):
          widget.viewType==15? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_physicaltwo.jpg'),
                  fit:  Responsive().getResponsiveValue(
                      forLargeScreen: BoxFit.cover,
                      forShortScreen: BoxFit.cover,
                      forMediumScreen: BoxFit.cover,
                      forTabletScreen: BoxFit.cover,
                      context: context)
              )):
          widget.viewType==16? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_characterone.jpg'),
                  fit:  Responsive().getResponsiveValue(
                      forLargeScreen: BoxFit.cover,
                      forShortScreen: BoxFit.cover,
                      forMediumScreen: BoxFit.cover,
                      forTabletScreen: BoxFit.cover,
                      context: context)
              )):
          widget.viewType==17? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_charactertwo.jpg'),
                  fit:  Responsive().getResponsiveValue(
                      forLargeScreen: BoxFit.cover,
                      forShortScreen: BoxFit.cover,
                      forMediumScreen: BoxFit.cover,
                      forTabletScreen: BoxFit.cover,
                      context: context)
              )):
          widget.viewType==19? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_profile.jpg'),
                  fit:  Responsive().getResponsiveValue(
                      forLargeScreen: BoxFit.cover,
                      forShortScreen: BoxFit.cover,
                      forMediumScreen: BoxFit.cover,
                      forTabletScreen: BoxFit.cover,
                      context: context)
              )):
          widget.viewType==20? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_verification.jpg'),
                  fit:  Responsive().getResponsiveValue(
                      forLargeScreen: BoxFit.cover,
                      forShortScreen: BoxFit.cover,
                      forMediumScreen: BoxFit.cover,
                      forTabletScreen: BoxFit.cover,
                      context: context)
              )):
          widget.viewType==18? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_characterthree.jpg'),
                  fit:  Responsive().getResponsiveValue(
                      forLargeScreen: BoxFit.cover,
                      forShortScreen: BoxFit.cover,
                      forMediumScreen: BoxFit.cover,
                      forTabletScreen: BoxFit.cover,
                      context: context)
              )):
          widget.viewType==21? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_documentverify.jpg'),
                  fit:  Responsive().getResponsiveValue(
                      forLargeScreen: BoxFit.cover,
                      forShortScreen: BoxFit.cover,
                      forMediumScreen: BoxFit.cover,
                      forTabletScreen: BoxFit.cover,
                      context: context)
              )):
          widget.viewType==12? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_welcome.jpg'),
                  fit:  Responsive().getResponsiveValue(
                      forLargeScreen: BoxFit.cover,
                      forShortScreen: BoxFit.cover,
                      forMediumScreen: BoxFit.cover,
                      forTabletScreen: BoxFit.cover,
                      context: context)
              )):widget.viewType==0? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_login.jpg'),
                  fit:  Responsive().getResponsiveValue(
                      forLargeScreen: BoxFit.cover,
                      forShortScreen: BoxFit.cover,
                      forMediumScreen: BoxFit.cover,
                      forTabletScreen: BoxFit.cover,
                      context: context)
              )):
          widget.viewType==4? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_forgot.jpg'),
                  fit:  Responsive().getResponsiveValue(
                      forLargeScreen: BoxFit.cover,
                      forShortScreen: BoxFit.cover,
                      forMediumScreen: BoxFit.cover,
                      forTabletScreen: BoxFit.cover,
                      context: context)
              )):
          widget.viewType==3?
           BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_coming.jpg'),
                  fit:  Responsive().getResponsiveValue(
                      forLargeScreen: BoxFit.cover,
                      forShortScreen: BoxFit.cover,
                      forMediumScreen: BoxFit.cover,
                      forTabletScreen: BoxFit.cover,
                      context: context))):
          widget.viewType==22?
          BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_one.jpg'),
                  fit:  Responsive().getResponsiveValue(
                      forLargeScreen: BoxFit.cover,
                      forShortScreen: BoxFit.cover,
                      forMediumScreen: BoxFit.cover,
                      forTabletScreen: BoxFit.cover,
                      context: context))):
           BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_latest.jpg'),
                  fit: Responsive().getResponsiveValue(
                      forLargeScreen: BoxFit.cover,
                      forShortScreen: BoxFit.cover,
                      forMediumScreen: BoxFit.cover,
                      forTabletScreen: BoxFit.cover,
                      context: context))),
          width: size.width,
          constraints: BoxConstraints(
              minHeight: size.height
          ),
          child: Column(children: [
            Header(viewType:widget.viewType),
            Expanded(
              child: ListView(
                physics: widget.viewType==12?NeverScrollableScrollPhysics():null,
                children:  <Widget>[
                  widget.viewType==0?LoginScreen(viewType:widget.viewType):
                  widget.viewType==4?ForgotScreen(viewType:widget.viewType):
                  widget.viewType==1?ReferralScreen(referralCode:widget.referralCode,viewType:widget.viewType):
                  widget.viewType==2?AboutUsScreen(viewType:widget.viewType):
                  widget.viewType==3?ComingScreen(viewType:widget.viewType):
                  widget.viewType==5?RegisterScreen(viewType:widget.viewType):
                  widget.viewType==6?UserInfoScreen(viewType:widget.viewType,comesFrom: widget.comesFrom,):
                  widget.viewType==7?PersonalInfoScreen(viewType:widget.viewType,firstName:widget.firstName, age:widget.age, gender:widget.gender, interestedIns:widget.interestedIns,comesFrom: widget.comesFrom):
                  widget.viewType==8?UserAddressScreen(viewType:widget.viewType,comesFrom: widget.comesFrom,):
                  widget.viewType==9?RangePreferenceScreen(viewType:widget.viewType, residence_country:widget.residenceCountry,state:widget.state, city:widget.city, nationality:widget.nationality, religion:widget.religion,your_tribe:widget.your_tribe,comesFrom: widget.comesFrom):
                  widget.viewType==10?UserAboutUsScreen(viewType:widget.viewType,comesFrom: widget.comesFrom):
                  widget.viewType==11?ProfilePhotoUsScreen(viewType:widget.viewType,comesFrom: widget.comesFrom):
                  widget.viewType==12?WelcomeScreen(viewType:widget.viewType):
                  widget.viewType==13?ChooseAnyOneScreen(viewType:widget.viewType):
                  widget.viewType==14?PhysicalAttributesScreen(viewType:widget.viewType):
                  widget.viewType==15?PartnerAttributesScreen(viewType:widget.viewType):
                  widget.viewType==16?CharacterQuestionsScreen(viewType:widget.viewType):
                  widget.viewType==17?CharacterQuestionsOneScreen(viewType:widget.viewType):
                  widget.viewType==18?CharacterQuestionsTwoScreen(viewType:widget.viewType):
                  widget.viewType==19?ProfileViewScreen(viewType:widget.viewType,comesFrom: widget.comesFrom):
                  widget.viewType==20?VerificationScreen(viewType:widget.viewType):
                  widget.viewType==21?DocumentViewScreen(viewType:widget.viewType,comesFrom: widget.comesFrom,):
                  widget.viewType==22?CompleteRegisterScreen(viewType:widget.viewType,email: widget.email,):
                  Container(),
                  Container(),
                ],
              ),),
            widget.viewType==3||widget.viewType==1?Responsive().getResponsiveValue(
                forLargeScreen: Footer(viewType:widget.viewType),
                forShortScreen: SizedBox(),
                forMobLandScapeMode: SizedBox(),
                forMediumScreen: SizedBox(),
                forTabletScreen: SizedBox(),
                context: context):
               SizedBox(),
        /*  Responsive().getResponsiveValue(
              forLargeScreen: Footer(viewType:widget.viewType),
              context: context),*/
          ],)

      ),
    );
  }


}