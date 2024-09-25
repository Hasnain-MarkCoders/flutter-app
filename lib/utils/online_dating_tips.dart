import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/responsive.dart';
import '../../../utils/string_utils.dart';
import '../../../utils/utils.dart';
class OnlineDatingTips extends StatefulWidget {
  const OnlineDatingTips({Key? key}) : super(key: key);

  @override
  State<OnlineDatingTips> createState() => _OnlineDatingTipsState();
}

class _OnlineDatingTipsState extends State<OnlineDatingTips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Dialog(
        elevation: 0,
        backgroundColor: Colors.limeAccent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0)),
        child: Stack(children: [
          Container(
              height: MediaQuery.of(context).size.height/1.1,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top:Responsive().getResponsiveValue(
                        forLargeScreen: 60.0,
                        forShortScreen: 10.0,
                        forTabletScreen: 10.0,
                        forMediumScreen:  10.0,
                        context: context) ,bottom: Responsive().getResponsiveValue(
                        forLargeScreen: 60.0,
                        forShortScreen: 10.0,
                        forTabletScreen: 10.0,
                        forMediumScreen:  10.0,
                        context: context),left: Responsive().getResponsiveValue(
                        forLargeScreen: 70.0,
                        forShortScreen: 10.0,
                        forTabletScreen: 10.0,
                        forMediumScreen:  10.0,
                        context: context),right:Responsive().getResponsiveValue(
                        forLargeScreen: 20.0,
                        forShortScreen: 10.0,
                        forTabletScreen: 10.0,
                        forMediumScreen:  10.0,
                        context: context) ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      kIsWeb?  Gap(Responsive().getResponsiveValue(
                            forLargeScreen: 8,
                            forShortScreen: 28,
                            forTabletScreen: 28,
                            forMediumScreen:  28,
                            context: context)):SizedBox(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: Icon(Icons.favorite,size: 12,color: Colors.red,),
                            ),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.OnlineDatingtips,textSize: 13,fontWeight: FontWeight.w600,color: AppColor.APP_TEXT_COLOR,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(3),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: Icon(Icons.favorite,size: 12,color: Colors.red,),
                            ),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.WeWantToMakeSure,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: Icon(Icons.favorite,size: 12,color: Colors.red,),
                            ),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.GeneralSafetyTipa,textSize: 13,fontWeight: FontWeight.w600,color: AppColor.APP_TEXT_COLOR,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: Icon(Icons.favorite,size: 12,color: Colors.red,),
                            ),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.KeppYourFullName,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: Icon(Icons.favorite,size: 12,color: Colors.red,),
                            ),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.DontMixOnline,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: Icon(Icons.favorite,size: 12,color: Colors.red,),
                            ),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.CatchAGlimpse,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(8 ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: Icon(Icons.favorite,size: 12,color: Colors.red,),
                            ),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.DontShareAny,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(8 ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: Icon(Icons.favorite,size: 12,color: Colors.red,),
                            ),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.NipUncomfortable,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(8 ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: Icon(Icons.favorite,size: 12,color: Colors.red,),
                            ),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.BeCaution,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: Icon(Icons.favorite,size: 12,color: Colors.red,),
                            ),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.NeverEverUnder,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: Icon(Icons.favorite,size: 12,color: Colors.red,),
                            ),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.KeepPrivateDetail,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: Icon(Icons.favorite,size: 12,color: Colors.red,),
                            ),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.WhereYouLive,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: Icon(Icons.favorite,size: 12,color: Colors.red,),
                            ),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.AlwaysMeetInPublicPlace,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: Icon(Icons.favorite,size: 12,color: Colors.red,),
                            ),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.NeverMeetOnline,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: Icon(Icons.favorite,size: 12,color: Colors.red,),
                            ),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.BeObservant,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: Icon(Icons.favorite,size: 12,color: Colors.red,),
                            ),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.AlwaysKeepAnEye,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: Icon(Icons.favorite,size: 12,color: Colors.red,),
                            ),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.MakeSureYOuWatch,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: Icon(Icons.favorite,size: 12,color: Colors.red,),
                            ),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.EnsureYourCellPhone,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: Icon(Icons.favorite,size: 12,color: Colors.red,),
                            ),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.RepostAllSuspicious,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: Icon(Icons.favorite,size: 12,color: Colors.red,),
                            ),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.ArrangeYourOwn,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: Icon(Icons.favorite,size: 12,color: Colors.red,),
                            ),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.AlwayesHaveEnough,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: Icon(Icons.favorite,size: 12,color: Colors.red,),
                            ),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.IMPORTANT,textSize: 13,fontWeight: FontWeight.w600,color: AppColor.APP_TEXT_COLOR,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(3),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Gap(20),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.IfaMemberHasThreatened,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ),
          Positioned(
             top: 12,
              right: 12,
              child: GestureDetector(onTap: (){
                Navigator.pop(context);
              },child: Icon(Icons.close,color: Colors.black,size: 22,),))
        ],),
      ),
    );
  }
}
