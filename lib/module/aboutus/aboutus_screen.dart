import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/module/components/footer.dart';
import 'package:likeplay/module/home/login_presenter.dart';
import 'package:likeplay/module/model/register_response.dart';
import 'package:likeplay/utils/color_utils.dart';
import 'package:likeplay/utils/constant_lists.dart';
import 'package:likeplay/utils/responsive.dart';
import 'package:likeplay/utils/snackbar.dart';
import 'package:likeplay/utils/string_utils.dart';
import 'package:likeplay/utils/utils.dart';
import 'package:likeplay/widget/common/commontextborder_screen.dart';
import 'package:likeplay/widget/common/commontextfield_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AboutUsScreen extends StatefulWidget {
  int? viewType;
  AboutUsScreen({Key? key,this.viewType}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  TextEditingController referralController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return
    Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Container(
         /* height:  Responsive().getResponsiveValue(
              forLargeScreen: MediaQuery.of(context).size.height/1.2,
              forMobLandScapeMode: MediaQuery.of(context).size.height/1.2,
              forMediumScreen: MediaQuery.of(context).size.height/1.2,
              forTabletScreen: MediaQuery.of(context).size.height/1.2,
              context: context),*/
          child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Gap(Responsive().getResponsiveValue(
                forLargeScreen:40.0,
                forShortScreen: 22.0,
                context: context),),
            Utils.mediumHeadingNormalText(
                text: "About Us",
                fontFamily: 'Poppins',color: AppColor.white,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                textSize: 24),
            Gap(4),
            Utils.mediumHeadingNormalText(
                text: "LikePlay-LikePlay",
                fontFamily: 'Poppins',color: AppColor.white,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                textSize: 16),
            Gap(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Utils.aboutText(name: UtilStrings.about_us1,type: 1,size: 0,context:context),
                Gap(10),
                Utils.aboutText(name: UtilStrings.about_us2,type: 0,size: 8,context:context),
                Gap(10),
                Utils.aboutText(name: UtilStrings.about_us3,type: 0,size: 8,context:context),
                Gap(10),
                Utils.aboutText(name: UtilStrings.about_us4,type: 0,size: 8,context:context),
                Gap(10),
                Utils.aboutText(name: UtilStrings.about_us5,type: 0,size: 8,context:context),
                Gap(10),
                Utils.aboutText(name: UtilStrings.about_us6,type: 0,size: 8,context:context),
                Gap(10),
                Utils.aboutText(name: UtilStrings.about_us7,type: 0,size: 8,context:context),
                Gap(10),
                Utils.aboutText(name: UtilStrings.about_us8,type: 1,size: 0,context:context),
                Gap(10),
                Utils.aboutText(name: UtilStrings.about_us9,type: 1,size: 0,context:context),

              ],)
          ],
        ),)
        ],),
      Gap(62),
      Responsive().getResponsiveValue(
          forLargeScreen:  Footer(viewType:widget.viewType),
          forShortScreen:  Footer(viewType:widget.viewType),
          forMobLandScapeMode:  Footer(viewType:widget.viewType),
          forMediumScreen:  Footer(viewType:widget.viewType),
          forTabletScreen:  Footer(viewType:widget.viewType),
          context: context),
    ],);


  }

  validation(BuildContext context) {
    if(referralController.text.trim().isEmpty){
      Utils.customDialog(context,message:UtilStrings.ENTER_YOUR_REFERRAL_CODE);
    }
    else {

    }

  }
}
