import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:likeplay/module/home/login_presenter.dart';
import 'package:likeplay/module/home/register/presenter/country_presenter.dart';
import 'package:likeplay/utils/color_utils.dart';
import 'package:likeplay/utils/responsive.dart';
import 'package:likeplay/utils/string_utils.dart';
import 'package:likeplay/utils/utils.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../model/country_response.dart';
import '../home.dart';

class CompleteRegisterScreen extends StatefulWidget {
  int? viewType;
  String? email;
  CompleteRegisterScreen({Key? key,this.viewType,this.email}) : super(key: key);
  @override
  State<CompleteRegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<CompleteRegisterScreen> implements CountryInterface {
  final _formKey = GlobalKey<FormState>();
  LoginPresenter? loginPresenter;
  CountryPresenter? countryPresenter;
  bool isCheck = false;
  bool isLoading = false;
  String countryName="Nigeria";
  TextStyle defaultStyle = TextStyle(color: AppColor.black,
      fontFamily: 'Poppins',
      fontSize: 12);
  TextStyle linkStyle = TextStyle(color: Colors.red);
  @override
  void initState() {
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
                  /*  height:  Responsive().getResponsiveValue(
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
                            forLargeScreen: 62.0,
                            forShortScreen: 22.0,
                            context: context)),
                        Container(
                          width:  Responsive().getResponsiveValue(
                              forLargeScreen: MediaQuery.of(context).size.width/3.2,
                              forShortScreen: MediaQuery.of(context).size.width,
                              forMobLandScapeMode: MediaQuery.of(context).size.height/3.1,
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                /*  Utils.mediumHeadingNormalText(
                                      text: "Registration",
                                      fontFamily: 'Poppins',color: AppColor.black,
                                      fontWeight: FontWeight.bold,
                                      textSize: 18),*/
                                  Image.asset(
                                    'assets/images/icon_email.png',
                                    height: 32,width: 32,
                                  ),
                                  Gap(16),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          style: defaultStyle,
                                          children: <TextSpan>[
                                            TextSpan(text: UtilStrings.Please_click_the_link_sent_to_One),
                                            TextSpan(
                                                text: widget.email,
                                                style: linkStyle,
                                                recognizer: TapGestureRecognizer()
                                                  ..onTap = () {
                                                  }),
                                            // TextSpan(text: ' and that you have read our '),
                                            TextSpan(text: UtilStrings.Please_click_the_link_sent_to_Two),
                                          ],
                                        ),
                                      )
                                    ],),
                                  Gap(22),
                                GestureDetector(onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                                    viewType: 0,
                                  )));
                                },child:   Utils.mediumHeadingNormalText(
                                    text: "Back",
                                    color: AppColor.black,
                                    fontFamily: 'Poppins',
                                    underline: true,
                                    fontWeight: FontWeight.bold,
                                    textSize: 12),),
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

  @override
  onError(String msg, int status) {
    setState(() {
      isLoading = false;
    });
    if(status==404){
      Utils.customDialog(context,message:msg);
    }
    else if(status == 400)  {
      Utils.customDialog(context,message:msg.toString());
    }
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
