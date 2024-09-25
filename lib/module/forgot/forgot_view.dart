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

import '../../utils/route/route_name.dart';
import '../../widget/common/commonpassword_screen.dart';
import '../../widget/common/commontextfield_registerscreen.dart';
import '../home/home.dart';



class ForgotScreen extends StatefulWidget {
  int? viewType;
  ForgotScreen({Key? key,this.viewType}) : super(key: key);

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> implements LoginInterface {
  TextEditingController emailController = TextEditingController();
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
                          Gap(22),
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
                        forLargeScreen: MediaQuery.of(context).size.height/2,
                        forShortScreen: MediaQuery.of(context).size.height/1.2,
                        forMobLandScapeMode: MediaQuery.of(context).size.height/1.2,
                        forMediumScreen: MediaQuery.of(context).size.height/1.2,
                        forTabletScreen: MediaQuery.of(context).size.height,
                        context: context),
                    width:  Responsive().getResponsiveValue(
                        forLargeScreen: MediaQuery.of(context).size.width/1.4,
                        forShortScreen: MediaQuery.of(context).size.width,
                        forMobLandScapeMode: MediaQuery.of(context).size.width/2,
                        forMediumScreen: MediaQuery.of(context).size.width/2,
                        forTabletScreen: MediaQuery.of(context).size.width/2,
                        context: context),
                    child: Stack(children: [
                      Column(
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
                              child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Utils.mediumHeadingNormalText(
                                      text: "Forgot Password",
                                      fontFamily: 'Poppins',color: AppColor.black,
                                      fontWeight: FontWeight.bold,
                                      textSize: 18),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Utils.mediumHeadingNormalText(
                                      text: "Email",
                                      color: AppColor.black,
                                      fontFamily: 'Poppins',
                                      textSize: 12),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 6, bottom: 8),
                                    child: CommonTextfieldRegister(
                                        hint: "dummy@gmail.com",
                                        controller:  emailController
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
                                          text: "Send",
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
                            ),
                          ),
                        ],
                      ),
                      Utils.progressDialog(context, isLoading)
                    ],),
                  ),
                  ),

                ],
              ),
             /* Gap( Responsive().getResponsiveValue(
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
                  context: context),*/
            ],),
        ],)


    );

  }

  validation(BuildContext context) {
   if (emailController.text.isEmpty) {
      Utils.customDialog(context,message:UtilStrings.ENTER_YOUR_EMAIL);
    }
    else if (!EmailValidator.validate(emailController.text.toString().trim())){
      Utils.customDialog(context,message:UtilStrings.ENTER_YOUR_VALID_EMAIL);
    }
    else {
      setState(() {
        isLoading=true;
      });
      loginPresenter?.doForgotPost(emailController.text.toString());
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
    else {
    }
  }

  @override
  onRegisterResponse(RegisterResponse response) {
  }

  @override
  onLoginResponse(LoginResponse response) {

  }

  @override
  onForgotResponse(SuccessResponse response) {
    setState(() {
      isLoading = false;
    });
    if (response.status == 200) {
      emailController.text="";
      Utils.customDialog(context,message:response.message.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
        viewType: 0,
      )));
    }
    else {
    }
  }
}