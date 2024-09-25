import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/responsive.dart';
import '../../../utils/string_utils.dart';
import '../../../utils/utils.dart';
class GuildelinesInfo extends StatefulWidget {
  const GuildelinesInfo({Key? key}) : super(key: key);

  @override
  State<GuildelinesInfo> createState() => _GuildelinesInfoState();
}

class _GuildelinesInfoState extends State<GuildelinesInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Dialog(
        elevation: 0,
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
                        forLargeScreen: 30.0,
                        forShortScreen: 10.0,
                        forTabletScreen: 10.0,
                        forMediumScreen:  10.0,
                        context: context) ,
                        bottom: Responsive().getResponsiveValue(
                        forLargeScreen: 60.0,
                        forShortScreen: 10.0,
                        forTabletScreen: 10.0,
                        forMediumScreen:  10.0,
                        context: context),left: Responsive().getResponsiveValue(
                        forLargeScreen: 70.0,
                        forShortScreen: 8.0,
                        forTabletScreen: 10.0,
                        forMediumScreen:  8.0,
                        context: context),right:Responsive().getResponsiveValue(
                        forLargeScreen: 20.0,
                        forShortScreen: 8.0,
                        forTabletScreen: 10.0,
                        forMediumScreen:  8.0,
                        context: context) ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Gap(Responsive().getResponsiveValue(
                            forLargeScreen: 8.0,
                            forShortScreen: 28.0,
                            forTabletScreen: 28.0,
                            forMediumScreen:  28.0,
                            context: context)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.GUIDELINES_FOR_THE_FLOOR_AND_MIC,textSize: 18,fontWeight: FontWeight.w500,color: AppColor.APP_TEXT_COLOR,textAlign: TextAlign.center))
                          ],
                        ),
                        Gap(15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.favorite,size: 12,color: Colors.red,),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.Please_Mind_Your_Language,textSize: 13,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.favorite,size: 12,color: Colors.red,),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.Avoid_Abusiva_Language,textSize: 13,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.favorite,size: 12,color: Colors.red,),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.This_Is_A_Secular_enviroment,textSize: 13,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.favorite,size: 12,color: Colors.red,),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.Please_do_not_post,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.favorite,size: 12,color: Colors.red,),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.No_Solicitation_are,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.favorite,size: 12,color: Colors.red,),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.It_is_ok_to,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.favorite,size: 12,color: Colors.red,),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.Spamming_is_unacceptable,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.favorite,size: 12,color: Colors.red,),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.All_topices_are_open,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.favorite,size: 12,color: Colors.red,),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.Zero_tolerance_for_harassement,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.favorite,size: 12,color: Colors.red,),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.Zero_tolerance_for_body,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.favorite,size: 12,color: Colors.red,),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.Hate_speech_is_not,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.favorite,size: 12,color: Colors.red,),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.Political_speech_is_not_allowed,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.favorite,size: 12,color: Colors.red,),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.Zero_tolerance_for_scammers,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.favorite,size: 12,color: Colors.red,),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.Content_must_not_be_original_when_you,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(35),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.Show_off_guidelines,textSize: 14,fontWeight: FontWeight.w500,color: AppColor.APP_TEXT_COLOR,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.favorite,size: 12,color: Colors.red,),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.Any_photos_that_dont_feature_yourself,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.favorite,size: 12,color: Colors.red,),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.The_Floor_is_NOT_for_commercial_business,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.favorite,size: 12,color: Colors.red,),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.Extreme_Closeup_photos_photos_focused_solely,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.favorite,size: 12,color: Colors.red,),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.Photos_including_children,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.favorite,size: 12,color: Colors.red,),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.Nude_or_sexually_explicit_photos,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.favorite,size: 12,color: Colors.red,),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.Photos_containing_or_depicting_illegal_content,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.favorite,size: 12,color: Colors.red,),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.Duplicate_photos,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.favorite,size: 12,color: Colors.red,),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.Improperly_rotated_or_cropped_images,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.favorite,size: 12,color: Colors.red,),
                            Gap(9),
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.Picture_with_another_person_are_not_allowed,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,textAlign: TextAlign.start))
                          ],
                        ),
                        Gap(20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                                    forShortScreen: MediaQuery.of(context).size.width/1.5,
                                    forTabletScreen: MediaQuery.of(context).size.width/1.5,
                                    forMediumScreen:  MediaQuery.of(context).size.width/1.5,
                                    context: context),
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.Admin_will_be_monitoring_the_Floor_and_the_Mic,textSize: 14,fontWeight: FontWeight.w400,color: AppColor.red,textAlign: TextAlign.start))
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
