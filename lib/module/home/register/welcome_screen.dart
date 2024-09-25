import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/module/components/footer.dart';
import 'package:likeplay/module/components/header.dart';
import 'package:likeplay/module/home/home.dart';
import 'package:likeplay/module/home/login_presenter.dart';
import 'package:likeplay/module/model/register_response.dart';
import 'package:likeplay/utils/color_utils.dart';
import 'package:likeplay/utils/constant_lists.dart';
import 'package:likeplay/utils/responsive.dart';
import 'package:likeplay/utils/route/route_name.dart';
import 'package:likeplay/utils/string_utils.dart';
import 'package:likeplay/utils/utils.dart';
import 'package:likeplay/widget/common/commontextfield_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../widget/common/commonpassword_screen.dart';
import '../../../widget/common/commontextfield_registerscreen.dart';

class WelcomeScreen extends StatefulWidget {
  int? viewType;
  WelcomeScreen({Key? key,this.viewType}) : super(key: key);
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    super.initState();
 Timer(const Duration(seconds: 3), () async {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
          viewType: 0
      )));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      margin: EdgeInsets.only(left: 20,right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Gap( size.height/2.8),
          Utils.mediumHeadingNormalText(
              text: UtilStrings.Thank_you_for_completing_the_form,
              fontFamily: 'Poppins',color: AppColor.white,
              fontWeight: FontWeight.bold,
              textSize: 18),
          Gap(8),
          Utils.mediumHeadingNormalText(
              text:  Responsive().getResponsiveValue(
                  forLargeScreen: UtilStrings.The_maximum_period_for_review_of_your_profile_big,
                  forShortScreen: UtilStrings.The_maximum_period_for_review_of_your_profile,
                  forMobLandScapeMode: UtilStrings.The_maximum_period_for_review_of_your_profile,
                  forMediumScreen: UtilStrings.The_maximum_period_for_review_of_your_profile,
                  forTabletScreen: UtilStrings.The_maximum_period_for_review_of_your_profile,
                  context: context), fontFamily: 'Poppins',color: AppColor.white,
              textSize: 12),
        ],
      ),
    );

  }


}
