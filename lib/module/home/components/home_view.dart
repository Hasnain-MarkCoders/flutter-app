import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/module/components/footer.dart';
import 'package:likeplay/module/home/login_presenter.dart';
import 'package:likeplay/module/model/login_response.dart';
import 'package:likeplay/module/model/register_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import 'package:likeplay/utils/color_utils.dart';
import 'package:likeplay/utils/responsive.dart';
import 'package:likeplay/utils/string_utils.dart';
import 'package:likeplay/utils/utils.dart';
import 'package:likeplay/widget/common/commontextfield_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HomeView extends StatefulWidget {
  int? viewType;
  String? referralCode;
  HomeView({Key? key,this.viewType,this.referralCode}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> implements LoginInterface {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController referralController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  LoginPresenter? loginPresenter;
  bool isLoading = false;

  @override
  void initState() {
    loginPresenter = LoginPresenter(this);
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
                                  context: context),
                            ),
                            Gap(22),
                            Utils.mediumHeadingNormalText(
                                text: "The #1 Dating Site in Nigeria",
                                fontFamily: 'Poppins',color: AppColor.white,
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.center,
                                textSize: Responsive().getResponsiveValue(
                                    forLargeScreen: 22,
                                    forShortScreen: 18,
                                    context: context)),
                            Gap(Responsive().getResponsiveValue(
                                forLargeScreen: 0.0,
                                forShortScreen: 12.0,
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
                              forLargeScreen: 72,
                              forShortScreen: 40,
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
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/bg_form.png'),
                                    fit: BoxFit.fill)),
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
                                        text: "Registration",
                                        fontFamily: 'Poppins',color: AppColor.white,
                                        fontWeight: FontWeight.bold,
                                        textSize: 18),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Utils.mediumHeadingNormalText(
                                        text: "Full Name",
                                        fontFamily: 'Poppins',color: AppColor.white,
                                        textSize: 12),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 6, bottom: 8),
                                      child: CommonTextfield(
                                          hint: "Full Name",
                                          controller:  firstNameController
                                      ),
                                    ),
                                    Utils.mediumHeadingNormalText(
                                        text: "Username",
                                        color: AppColor.white,
                                        fontFamily: 'Poppins',
                                        textSize: 12),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 6, bottom: 8),
                                      child: CommonTextfield(
                                          hint: "Username",
                                          controller:  userNameController
                                      ),
                                    ),
                                    Utils.mediumHeadingNormalText(
                                        text: "Email",
                                        color: AppColor.white,
                                        fontFamily: 'Poppins',
                                        textSize: 12),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 6, bottom: 8),
                                      child: CommonTextfield(
                                          hint: "dummy@gmail.com",
                                          controller:  emailController
                                      ),
                                    ),
                                    Utils.mediumHeadingNormalText(
                                        text: "Enter Referral code if referred by a friend",
                                        color: AppColor.white,
                                        fontFamily: 'Poppins',
                                        textSize: 12),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 6, bottom: 8),
                                      child: CommonTextfield(
                                          hint: "willsmith1234221",
                                          controller:  referralController
                                      ),
                                    ),
                                    Gap(12),
                                    GestureDetector(
                                      onTap: (){
                                        validation(context);
                                      },
                                      child:Container(
                                        height:38,
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
                                            text: "Register",
                                            color: AppColor.white,
                                            fontFamily: 'Poppins',
                                            textSize: 13),
                                      ),),
                                    Gap(Responsive().getResponsiveValue(
                                        forLargeScreen: 40.0,
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
                Gap( Responsive().getResponsiveValue(
                    forLargeScreen: 62,
                    forShortScreen: 62,
                    forMobLandScapeMode: 62,
                    forMediumScreen: 62,
                    forTabletScreen: 62,
                    context: context),),
                Responsive().getResponsiveValue(
                    forLargeScreen:  SizedBox(),
                    forShortScreen:  Footer(viewType:widget.viewType),
                    forMobLandScapeMode:  Footer(viewType:widget.viewType),
                    forMediumScreen:  Footer(viewType:widget.viewType),
                    forTabletScreen:  Footer(viewType:widget.viewType),
                    context: context),
              ],),

          ],)


    );

  }

  validation(BuildContext context) {
   if(firstNameController.text.trim().isEmpty){
      Utils.customDialog(context,message:UtilStrings.ENTER_YOUR_FULL_NAME);
    }
    else if (userNameController.text.trim().isEmpty) {
      Utils.customDialog(context,message:UtilStrings.ENTER_YOUR_USER_NAME);
      }
    else if (emailController.text.isEmpty) {
      Utils.customDialog(context,message:UtilStrings.ENTER_YOUR_EMAIL);
      }
    else if (!EmailValidator.validate(emailController.text.toString().trim())){
      Utils.customDialog(context,message:UtilStrings.ENTER_YOUR_VALID_EMAIL);
      }
    else {
      setState(() {
       isLoading=true;
     });
      //loginPresenter!.doRegisterPost(firstNameController.text.toString().trim(),emailController.text.toString().trim(),userNameController.text.toString().trim());
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
      Utils.sessionExpire(context);
    }
    else if(status==404){
      Utils.sessionExpire(context);
    }
  }

  @override
  onRegisterResponse(RegisterResponse response) {
    setState(() {
      isLoading = false;
    });
    if(response.status==200){
    /*  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(
          viewType: 1,
      )));*/
      Utils.customDialog(context,message:response.message!);
    }
  }

  @override
  onLoginResponse(LoginResponse response) {
  }

  @override
  onForgotResponse(SuccessResponse response) {
  }
}
