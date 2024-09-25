import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/utils/constants.dart';
import 'package:likeplay/utils/responsive.dart';
import 'package:likeplay/utils/responsive_value.dart';
import 'package:likeplay/utils/string_utils.dart';
import 'package:likeplay/utils/utils.dart';
import 'package:likeplay/widget/common/commontextfield_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/color_utils.dart';
import '../home/home.dart';
import '../login/login_view.dart';

class Footer extends StatelessWidget {
  int? viewType;
  Footer({Key? key,this.viewType}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return (!isMobile(context)) ? DesktopFooter(viewType:viewType) : MobileFooter(viewType:viewType);
  }
}

class DesktopFooter extends StatelessWidget {
  int? viewType;
  DesktopFooter({Key? key,this.viewType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
      /*  Container(
          margin: EdgeInsets.only(bottom: 14),
          child:  viewType==0?
              SizedBox():
              viewType==1?
              Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child:
                Row(
                  children: [
                    Utils.imageView(image: "assets/images/icon_back.png",height: 36,width: 36),
                    Gap(8),
                    Utils.mediumHeadingNormalText(
                        text: "Back",
                        fontFamily: 'Poppins',color: AppColor.white,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.center,
                        textSize: Responsive().getResponsiveValue(
                            forLargeScreen: 16,
                            forShortScreen: 14,
                            context: context)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                      viewType: 3
                  )));
                },
                child: Row(children: [
                  Gap(4),
                  Utils.imageView(image: "assets/images/bg_next.png",height: 36,width: 36),
                  Gap(8),
                  Utils.mediumHeadingNormalText(
                      text: "Next",
                      fontFamily: 'Poppins',color: AppColor.white,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                      textSize: Responsive().getResponsiveValue(
                          forLargeScreen: 16,
                          forShortScreen: 14,
                          context: context)),
                ],),
              )
            ],
          ):
              viewType!=2?GestureDetector(
                onTap: (){
                  viewType==0?Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                      viewType: 1,
                  ))):Navigator.pop(context);
                },
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Utils.imageView(image: viewType==0?"assets/images/bg_next.png":"assets/images/icon_back.png",height: 36,width: 36),
                    Gap(8),
                    Utils.mediumHeadingNormalText(
                        text: viewType==0?"Next":"Back",
                        fontFamily: 'Poppins',color: AppColor.white,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.center,
                        textSize: Responsive().getResponsiveValue(
                            forLargeScreen: 16,
                            forShortScreen: 14,
                            context: context)),
                  ],
                ),
              ):SizedBox(),
        ),*/
        Container(
          color:viewType==3||viewType==2||viewType==1?HexColor("#242424"):Colors.black26,
          //color:HexColor("#242424"),
          padding: EdgeInsets.only(top: 8,bottom: 12,left: 32),
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(6),
                        Utils.mediumHeadingNormalText(
                            text: UtilStrings.Follow_us_on,
                            fontFamily: 'Poppins',color: AppColor.white,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.center,
                            textSize: 14),
                        Gap(6),
                        Row(
                          children: [
                            GestureDetector(child:Utils.imageView(image: "assets/images/icon_fb.png",width: 22,height: 22),
                              onTap: () async {
                                Utils.openUrl("https://www.linkedin.com/feed/");
                              },),
                            Gap(10),
                            GestureDetector(child:Utils.imageView(image: "assets/images/icon_facebook.png",width: 22,height: 22),
                              onTap: () async {
                                Utils.openUrl("https://www.facebook.com/likeplaylikeplaydating/");
                              },),
                            Gap(10),
                            GestureDetector(child:Utils.imageView(image: "assets/images/icon_instra.png",width: 22,height: 22),
                              onTap: () async {
                                var url = 'https://www.instagram.com/likeplaylikeplaydating_/';
                                Utils.openUrl(url);
                              },),
                            Gap(10),
                            GestureDetector(child:Utils.imageView(image: "assets/images/ic_twitter.png",width: 22,height: 22),
                              onTap: () async {
                                var url = 'https://twitter.com/LikePlaydating_';
                                Utils.openUrl(url);
                              },),
                            Gap(10),
                            GestureDetector(child: Utils.imageView(image: "assets/images/icon_youtube.png",width: 22,height: 22),
                              onTap: () async {
                                var url = 'https://www.youtube.com/channel/UC4MLcFox6aZ8pDt7BrICJSQ';
                                Utils.openUrl(url);
                              },),
                          ],)
                      ],),)
              ),
              Spacer(),
              viewType!=0?Expanded(
                  flex: 1,
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              GestureDetector(
                child:Utils.mediumHeadingNormalText(
                text: UtilStrings.Home,
                fontFamily: 'Poppins',color: AppColor.white,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                textSize: 12),
                onTap: (){
                  launch(home_url_website);
               /* viewType!=0?Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                    viewType: 0
                ))):const SizedBox();*/
              },),
                Gap(8),
        GestureDetector(
            child:Utils.mediumHeadingNormalText(
                      text: UtilStrings.About_us,
                      fontFamily: 'Poppins',color: AppColor.white,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                      textSize: 12),
            onTap: (){
    viewType!=2?Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
    viewType: 2
    ))):const SizedBox();
    },),
                Gap(8),
        GestureDetector(
            child:Utils.mediumHeadingNormalText(
                      text: UtilStrings.Help,
                      fontFamily: 'Poppins',color: AppColor.white,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                      textSize: 12),onTap: () async {
          Utils.openMail("service@likeplaylikeplay.com");
          },),
                Gap(8),
        GestureDetector(
            child:Utils.mediumHeadingNormalText(
                      text: UtilStrings.Contact_us,
                      fontFamily: 'Poppins',color: AppColor.white,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                      textSize: 12),onTap: () async {
          Utils.openMail("hello@likeplaylikeplay.com");
        },),
              ],)
              ):SizedBox(),
              Spacer(),
              viewType!=0?Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Utils.mediumHeadingNormalText(
                          text: UtilStrings.Newsletter,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          textSize: 12),
                      Row(children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 6, bottom: 8),
                          child: Container(
                            width: MediaQuery.of(context).size.width/4,
                            child: CommonTextfield(
                              hint: "dummy@gmail.com",
                              color: Colors.grey,
                            ),),
                        ),
                        Gap(6),
                        Container(
                          height: 45,
                          width:100,
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
                              text: "Submit",
                              color: AppColor.white,
                              fontFamily: 'Poppins',
                              textSize: 13),
                        ),
                      ],),
                      Gap(8),
                      Utils.mediumHeadingNormalText(
                          text: "WhatGodcannotdodoesnotexist",
                          fontFamily: 'Poppins',color: AppColor.white,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                          textSize: 12),
                      Gap(4),
                      Utils.mediumHeadingNormalText(
                          text: "copyright@likeplaylikeplay",
                          fontFamily: 'Poppins',color: AppColor.grey,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                          textSize: 12),
                    ],)
              ):
              Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Utils.mediumHeadingNormalText(
                          text: "WhatGodcannotdodoesnotexist",
                          fontFamily: 'Poppins',color: AppColor.white,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                          textSize: 12),
                      Gap(4),
                      Utils.mediumHeadingNormalText(
                          text: "copyright@likeplaylikeplay",
                          fontFamily: 'Poppins',color: AppColor.grey,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                          textSize: 12),
                    ],)
              ),
            ],
          ),
        )
      ],
    );
  }
}

class MobileFooter extends StatelessWidget {
  int? viewType;
  MobileFooter({Key? key,this.viewType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        /*Container(
          margin: EdgeInsets.only(bottom: 14),
          child: *//* viewType==0?
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                  viewType: 1,
                  referralCode: ""
              )));
            },
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Utils.imageView(image: "assets/images/bg_next.png",height: 36,width: 36),
                Gap(8),
                Utils.mediumHeadingNormalText(
                    text: "Next",
                    fontFamily: 'Poppins',color: AppColor.white,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    textSize: Responsive().getResponsiveValue(
                        forLargeScreen: 16,
                        forShortScreen: 14,
                        context: context)),
              ],
            ),
          ):*//*
          viewType==1?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child:
                Row(
                  children: [
                    Utils.imageView(image: "assets/images/icon_back.png",height: 36,width: 36),
                    Gap(8),
                    Utils.mediumHeadingNormalText(
                        text: "Back",
                        fontFamily: 'Poppins',color: AppColor.white,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.center,
                        textSize: Responsive().getResponsiveValue(
                            forLargeScreen: 16,
                            forShortScreen: 14,
                            context: context)),
                  ],
                ),
              ),
              Gap(10),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                      viewType: 3
                  )));
                },
                child: Row(children: [
                  Gap(8),
                  Utils.imageView(image: "assets/images/bg_next.png",height: 36,width: 36),
                  Gap(8),
                  Utils.mediumHeadingNormalText(
                      text: "Next",
                      fontFamily: 'Poppins',color: AppColor.white,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                      textSize: Responsive().getResponsiveValue(
                          forLargeScreen: 16,
                          forShortScreen: 14,
                          context: context)),
                ],),
              )
            ],
          ):
          viewType!=2?GestureDetector(
            onTap: (){
              viewType==0?Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                  viewType: 1,
              ))):Navigator.pop(context);
            },
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Utils.imageView(image: viewType==0?"assets/images/bg_next.png":"assets/images/icon_back.png",height: 36,width: 36),
                Gap(8),
                Utils.mediumHeadingNormalText(
                    text: viewType==0?"Next":"Back",
                    fontFamily: 'Poppins',color: AppColor.white,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                    textSize: Responsive().getResponsiveValue(
                        forLargeScreen: 16,
                        forShortScreen: 14,
                        context: context)),
              ],
            ),
          ):SizedBox(),
        ),*/
        Container(
          width: double.infinity,
          // color: viewType==3?Colors.black87:Colors.black26,
          //color:HexColor("#242424"),
          color:viewType==3||viewType==2||viewType==1?HexColor("#242424"):Colors.black26,
          padding: const EdgeInsets.only(top: 8,bottom: 12,left: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(4),
                  Utils.mediumHeadingNormalText(
                      text: UtilStrings.Follow_us_on,
                      color: AppColor.white,
                      fontFamily: 'Poppins',
                      textSize: 14),
                  Gap(6),
                  Row(
                    children: [
                      GestureDetector(child:Utils.imageView(image: "assets/images/icon_fb.png",width: 22,height: 22),
                        onTap: () async {
                          Utils.openUrl("https://www.linkedin.com/feed/");
                        },),
                      Gap(10),
                      GestureDetector(child:Utils.imageView(image: "assets/images/icon_facebook.png",width: 22,height: 22),
                        onTap: () async {
                          Utils.openUrl("https://www.facebook.com/likeplaylikeplaydating/");
                        },),
                      Gap(10),
                      GestureDetector(child:
                      Utils.imageView(image: "assets/images/icon_instra.png",width: 22,height: 22),
                        onTap: () async {
                          var url = 'https://www.instagram.com/likeplaylikeplaydating_/';
                          Utils.openUrl(url);
                        },),
                      Gap(10),
                      GestureDetector(child:Utils.imageView(image: "assets/images/ic_twitter.png",width: 22,height: 22),
                        onTap: () async {
                          var url = 'https://twitter.com/LikePlaydating_';
                          Utils.openUrl(url);
                        },),
                      Gap(10),
                      GestureDetector(child: Utils.imageView(image: "assets/images/icon_youtube.png",width: 22,height: 22),
                        onTap: () async {
                          var url = 'https://www.youtube.com/channel/UC4MLcFox6aZ8pDt7BrICJSQ';
                          Utils.openUrl(url);
                        },),
                    ],)
                ],),
              Gap(22),
              viewType!=0? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                  child:Utils.mediumHeadingNormalText(
                      text: UtilStrings.Home,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      textSize: 12),
                    onTap: (){
                      launch(home_url_website);
                     /* viewType!=0?Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                          viewType: 0
                      ))):const SizedBox();*/
                    },
                  ),
                  Gap(8),
                  GestureDetector(child:Utils.mediumHeadingNormalText(
                      text: UtilStrings.About_us,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      textSize: 12),
                    onTap: (){
                      viewType!=2?Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                          viewType: 2
                      ))):const SizedBox();
                    },),
                  Gap(8),
                  GestureDetector(
                    child:Utils.mediumHeadingNormalText(
                        text: UtilStrings.Help,
                        fontFamily: 'Poppins',color: AppColor.white,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                        textSize: 12),onTap: () async {
                    Utils.openMail("service@likeplaylikeplay.com");
                  },),
                  Gap(8),
                 GestureDetector(child:Utils.mediumHeadingNormalText(
                      text: UtilStrings.Contact_us,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      textSize: 12),
                 onTap: () async {
                   Utils.openMail("hello@likeplaylikeplay.com");
                 },),
                  Gap(8),
                ],):SizedBox(),
          Gap(viewType!=0?24:0),
              viewType!=0?Utils.mediumHeadingNormalText(
                  text: UtilStrings.Newsletter,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  textSize: 12):SizedBox(),
              viewType!=0?Padding(
                padding:
                const EdgeInsets.only(top: 6, bottom: 8),
                child: Container(
                  width: MediaQuery.of(context).size.width/1.4,
                  child: CommonTextfield(
                    hint: "dummy@gmail.com",
                    color: Colors.grey,
                  ),),
              ):SizedBox(),
              Gap(4),
              viewType!=0?Container(
                height: 45,
                width: Responsive().getResponsiveValue(
                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                    forShortScreen: 100.0,
                    forMobLandScapeMode: 100.0,
                    forMediumScreen: 100.0,
                    forTabletScreen: 100.0,
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
                    text: "Submit",
                    color: AppColor.white,
                    fontFamily: 'Poppins',
                    textSize: 13),
              ):SizedBox(),
              Gap(8),
              Utils.mediumHeadingNormalText(
                  text: "WhatGodcannotdodoesnotexist",
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  textSize: 12),
              Gap(8),
              Utils.mediumHeadingNormalText(
                  text: "copyright@likeplaylikeplay",
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  textSize: 12),
            ],
          ),
        )
      ],
    );
  }
}
class NavItem extends StatelessWidget {
  const NavItem({
    Key? key,
    required this.title,
    required this.tapEvent
  }) : super(key: key);

  final String title;
  final GestureTapCallback tapEvent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapEvent,
      hoverColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          title,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 12
          ),
        ),
      ),
    );
  }
  Widget buildImage() {
    return Container();
  }
}