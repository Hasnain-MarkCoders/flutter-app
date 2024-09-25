import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:likeplay/module/components/footer.dart';
import 'package:likeplay/module/home/home.dart';
import 'package:likeplay/utils/color_utils.dart';
import 'package:likeplay/utils/responsive.dart';
import 'package:likeplay/utils/string_utils.dart';
import 'package:likeplay/utils/utils.dart';
import 'package:share_everywhere/share_everywhere.dart';
import 'package:url_launcher/url_launcher.dart';

class ReferralScreen extends StatefulWidget {
  String? referralCode;
  int? viewType;
  ReferralScreen({Key? key,this.referralCode,this.viewType}) : super(key: key);
  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  TextEditingController referralController = TextEditingController();
  bool isLoading = false;
  ShareController shareControllerInsta = ShareController(
    title: "Share on:",
    // elevatedButtonText: Utils.imageView(image: "assets/images/icon_instra.png",width: 42,height: 42),
    networks: [
      SocialConfig(type: "insta"),
    ],
  );

  ShareController shareControllerLinkedIn = ShareController(
    title: "Share on:",
    // elevatedButtonText: Utils.imageView(image: "assets/images/icon_fb.png",width: 42,height: 42),
    networks: [
      SocialConfig(type: "linkedin"),
    ],
  );
  ShareController shareControllerTwitter = ShareController(
    title: "Share on:",
    // elevatedButtonText:  Utils.imageView(image: "assets/images/ic_twitter.png",width: 42,height: 42),
    networks: [
      SocialConfig(type: "twitter"),
    ],
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gap(Responsive().getResponsiveValue(
                  forLargeScreen: 80.0,
                  forShortScreen: 14.0,
                  context: context)),
              Utils.mediumHeadingNormalText(
                  text: "Refer to friends",
                  fontFamily: 'Poppins',color: AppColor.white,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  textSize: 20),
              Gap(4),
              Container(
                  width:  Responsive().getResponsiveValue(
                      forLargeScreen: MediaQuery.of(context).size.width/1.2,
                      forShortScreen: MediaQuery.of(context).size.width/1.6,
                      context: context),
                  child:Utils.mediumHeadingNormalText(
                      text: "Congratulations! You have successfully registered",
                      fontFamily: 'Poppins',color: AppColor.white,
                      textAlign: TextAlign.center,
                      textSize: 16)),
              Gap(12),
              Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/bg_border.png'),
                        fit: BoxFit.contain)),
                width:  Responsive().getResponsiveValue(
                    forLargeScreen: MediaQuery.of(context).size.width/4.2,
                    forShortScreen: MediaQuery.of(context).size.width/1.2,
                    forMobLandScapeMode: MediaQuery.of(context).size.height/2,
                    forMediumScreen: MediaQuery.of(context).size.height/2,
                    forTabletScreen: MediaQuery.of(context).size.height/2,
                    context: context),
                height:  Responsive().getResponsiveValue(
                    forLargeScreen: MediaQuery.of(context).size.height/2.3,
                    forShortScreen: MediaQuery.of(context).size.height/2,
                    forMobLandScapeMode: MediaQuery.of(context).size.height/2,
                    forMediumScreen: MediaQuery.of(context).size.height/2,
                    forTabletScreen: MediaQuery.of(context).size.height/2,
                    context: context),
                child: Padding(
                  padding:  EdgeInsets.only(
                    left: Responsive().getResponsiveValue(
                        forLargeScreen: 22.0,
                        forShortScreen: 20.0,
                        context: context),
                    top: Responsive().getResponsiveValue(
                        forLargeScreen: 0.0,
                        forShortScreen: 0.0,
                        context: context),
                    right: Responsive().getResponsiveValue(
                        forLargeScreen:22.0,
                        forShortScreen: 20.0,
                        context: context),),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 6, bottom: 8),
                        child: Container(
                            padding: EdgeInsets.all(12),
                            width:  Responsive().getResponsiveValue(
                                forLargeScreen: MediaQuery.of(context).size.width/4.2,
                                forShortScreen: MediaQuery.of(context).size.width/1.2,
                                forTabletScreen: MediaQuery.of(context).size.width/1.2,
                                forMediumScreen:  MediaQuery.of(context).size.width/1.2,
                                context: context),
                            decoration: BoxDecoration(
                                color:AppColor.white,
                                border: Border.all(color:AppColor.white),
                                borderRadius:BorderRadius.circular(10)
                            ),
                            child: Utils.mediumHeadingNormalText(text: widget.referralCode,textSize:14,fontWeight: FontWeight.w400,color: AppColor.black,textAlign:TextAlign.start)),
                      ),
                      Gap(12),
                      Utils.mediumHeadingNormalText(
                          text: UtilStrings.Refer_to_friends_and_Earn_month_subscription,
                          fontFamily: 'Poppins',
                          color: AppColor.white,
                          textAlign: TextAlign.center,
                          textSize: 14),
                      Gap(12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              child:Utils.imageView(image: "assets/images/icon_fb.png",width: 32,height: 32)
                              /*ShareButton(shareControllerLinkedIn, "${UtilStrings.Refer_to_5_friends}${widget.referralCode!}.")*/,
                              onTap: (){
                                Utils.openUrl("https://www.linkedin.com/feed/");
                              }),

                          Gap(10),

                          GestureDetector(
                              onTap: (){
                                var url = 'https://www.instagram.com/likeplaylikeplaydating_/';
                                Utils.openUrl(url);
                              },
                              child:Utils.imageView(image: "assets/images/icon_instra.png",width: 32,height: 32)
                              /*ShareButton(shareControllerInsta, "${UtilStrings.Refer_to_5_friends}${widget.referralCode!}.")*/),
                          Gap(10),
                          GestureDetector(
                            child: Utils.imageView(image: "assets/images/ic_whatsapp.png",width: 32,height: 32),
                            onTap: ()  {
                              String url = "https://wa.me/?text="+UtilStrings.Refer_to_5_friends+""+widget.referralCode!+".";
                              Utils.openUrl(url);
                            },),
                          Gap(10), GestureDetector(
                              onTap: (){
                                var url = 'https://twitter.com/LikePlaydating_';
                                Utils.openUrl(url);
                              },
                              child:Utils.imageView(image: "assets/images/ic_twitter.png",width: 32,height: 32)),
                          Gap(10),
                          GestureDetector(
                            onTap: (){
                              Utils.customDialog(context,message:"Copy");
                              Clipboard.setData(ClipboardData(text: widget.referralCode.toString()));
                            },
                            child:Utils.imageView(image: "assets/images/ic_copy.png",width: 32,height: 32),)
                        ],),
                      Gap(18),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        GestureDetector(
                          onTap: (){
                            validation(context);
                          },
                          child:Container(
                            height:46,
                            width:120,
                            alignment: Alignment.center,
                            decoration:  const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              gradient:LinearGradient(
                                  colors: [
                                    Colors.black38,
                                    Colors.black26,
                                    Colors.black26,
                                    Colors.black38
                                    //add more colors for gradient
                                  ],
                                  begin: Alignment.topLeft, //begin of the gradient color
                                  end: Alignment.bottomRight, //end of the gradient color
                                  stops: [0, 0.2, 0.5, 0.8] //stops for individual color
                                //set the stops number equal to numbers of color
                              ),
                            ),
                            child: Utils.mediumHeadingNormalText(
                                text: "Skip",
                                color: AppColor.white,
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
                            width:120,
                            alignment: Alignment.center,
                            decoration:  const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              gradient:LinearGradient(
                                  colors: [
                                    Colors.redAccent,
                                    Colors.redAccent,
                                    Colors.redAccent,
                                    Colors.redAccent
                                    //add more colors for gradient
                                  ],
                                  begin: Alignment.topLeft, //begin of the gradient color
                                  end: Alignment.bottomRight, //end of the gradient color
                                  stops: [0, 0.2, 0.5, 0.8] //stops for individual color
                                //set the stops number equal to numbers of color
                              ),
                            ),
                            child: Utils.mediumHeadingNormalText(
                                text: "Done",
                                color: AppColor.white,
                                fontFamily: 'Poppins',
                                textSize: 13),
                          ),),
                      ],),
                      Gap(Responsive().getResponsiveValue(
                          forLargeScreen: 40.0,
                          forShortScreen: 32.0,
                          context: context)),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],),
      Gap(64),
      Responsive().getResponsiveValue(
          forLargeScreen:  SizedBox(),
          forShortScreen:  Footer(viewType:widget.viewType),
          forMobLandScapeMode:  Footer(viewType:widget.viewType),
          forMediumScreen:  Footer(viewType:widget.viewType),
          forTabletScreen:  Footer(viewType:widget.viewType),
          context: context),
    ],);

  }

  validation(BuildContext context) {
    /*if(referralController.text.trim().isEmpty){
      Utils.customDialog(UtilStrings.ENTER_YOUR_REFERRAL_CODE);
    }
    else {*/
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
        viewType: 3
    )));
    // }

  }
}