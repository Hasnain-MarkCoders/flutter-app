import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:likeplay/utils/route/route_name.dart';
import 'package:likeplay/utils/sharedpref/preferences.dart';
import 'package:likeplay/utils/sharedpref/shared_prefrence.dart';
import 'package:likeplay/utils/string_utils.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';
import '../module/home/home.dart';
import '../widget/custom_app_bar.dart';
import 'color_utils.dart';
import 'responsive.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
class Utils {
  static double getHeight(BuildContext context) {
    return MediaQuery
        .of(context)
        .size
        .height;
  }

  static getWidth(BuildContext context) {
    return MediaQuery
        .of(context)
        .size
        .width;
  }

  static Widget customTextFeild(BuildContext context, String hintText,TextEditingController controller){
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: HexColor(AppColor.WHITE)),
          borderRadius: BorderRadius.circular(8.0)
      ),
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.black,
        decoration:  InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            focusedBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            fillColor: HexColor(AppColor.WHITE),
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(fontFamily: "Montserrat",fontSize: 16)
        ),
      ),
    );
  }


  static Widget regularHeadingText({String? text,
    double? textSize,
    Color? color,
    TextAlign? textAlign,
    int? value,
    TextOverflow? textOverflow}) {
    return Text(
      text ?? '',
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
        color: color,
        fontWeight: value == 0 ? FontWeight.bold : FontWeight.normal,
        fontSize: 18,
        fontFamily: 'Jost',
      ),
    );
  }

  static Widget mediumHeadingNormalText({String? text,
    double? textSize,
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    String? fontFamily,
    double? left,
    double? right,
    bool? underline,
    TextOverflow? overflow}) {
    return Container(
      margin: EdgeInsets.only(left: left ?? 0, right: right ?? 0),
      child: Text(
        text ?? '',
        textAlign: textAlign ?? TextAlign.center,
        style: TextStyle(
          overflow: overflow,
          decoration: underline == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color??Colors.black,

          fontWeight: fontWeight ?? FontWeight.normal,
          fontSize: textSize ?? 16,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }


  static Widget mediumHeadingStarNormalText({String? text,
    double? textSize,
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    String? fontFamily,
    double? left,
    double? right,
    double? width,
    bool? underline,
    TextOverflow? overflow}) {
    return Container(
      margin: EdgeInsets.only(left: left ?? 0, right: right ?? 0),
      child: Row(children: [
        Text(
          text ?? '',
          textAlign: textAlign ?? TextAlign.center,
          style: TextStyle(
            overflow: overflow,
            decoration: underline == true
                ? TextDecoration.underline
                : TextDecoration.none,
            color: color,
            fontWeight: fontWeight ?? FontWeight.normal,
            fontSize: textSize ?? 16,
            fontFamily: 'Poppins',
          ),
        ),
        Text("*", style: TextStyle(color: Colors.red,fontSize: 12))
      ],),
    );
  }


  static Widget mediumTWhite({String? text,
    double? textSize,
    Color? color = const Color(0xffFFFFFF),
    TextAlign? textAlign,
    FontWeight? fontWeight,
    String? fontFamily,
    double? left,
    double? right,
    bool? underline,
    bool isNeedOverflow = false}) {
    return Container(
      margin: EdgeInsets.only(right: left ?? 0),
      child: Text(
        text ?? '',
        textAlign: textAlign ?? TextAlign.center,
        style: isNeedOverflow ? TextStyle(
          decoration: underline == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontSize: textSize ?? 16,
          fontFamily: fontFamily,
          overflow: TextOverflow.ellipsis,
        ) : TextStyle(
          decoration: underline == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontSize: textSize ?? 16,
          fontFamily: fontFamily,
        ),
      ),
    );
  }

  static Widget smallHeadingText(
      {required String text, double? textSize, Color? color}) {
    return Text(text,
        style: TextStyle(
          color: HexColor(AppColor.COLOR_BLACK),
          fontWeight: FontWeight.bold,
          fontSize: textSize ?? 10,
          fontFamily: 'Jost',
        ));
  }

  static Widget imageView(
      {required String image, double? width, double? height, Color? color}) {
    return Image.asset(
      image,
      width: width,
      height: height,
      color: color,
    );
  }

  static Widget aboutText({required String? name,int? type,double? size,BuildContext? context}) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
    /*  type==0?Utils.imageView(image:"assets/images/icon_heart.png",height: 14,width: 14):Container(),
      Gap(size!),*/
     Container(
         width:  Responsive().getResponsiveValue(
             forLargeScreen: MediaQuery.of(context!).size.width/1.5,
             forShortScreen: MediaQuery.of(context!).size.width/1.2,
             context: context!),
         child:
     Utils.mediumHeadingNormalText(
         text: name,
         fontFamily: 'Poppins',
         color: AppColor.white,
         textAlign: TextAlign.center,
         textSize: 14),)
    ],);
  }


  static Widget headingTextwithContainer(
      {required String text, double? textSize, Color? color}) {
    return Container(
        height: 41,
        width: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: HexColor(AppColor.LIGHT_GRAY),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
                style: TextStyle(
                  color: HexColor(AppColor.COLOR_BLACK),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                )),
          ],
        ));
  }

  static Widget boldSubHeadingText({required String text,
    double? textSize,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign}) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Jost',
        fontSize: textSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.w900,
        color: color ?? AppColor.black_2,
      ),
      textAlign: textAlign ?? TextAlign.center,
    );
  }

  static AppBar customAppBar({String? text,
    Color? color,
    bool? isCenter = false,
    IconData? icon,
    Color? textColor,
    Color? iconColor,
    void Function()? onTap}) {
    return AppBar(
      backgroundColor: color ?? Colors.teal,
      title: Text(
        text ?? "",
        style: TextStyle(color: textColor ?? Colors.white),
      ),
      centerTitle: isCenter == false ? true : false,
      leading: isCenter == false
          ? InkWell(
        onTap: onTap,
        child: const Icon(
          Icons.arrow_back_ios_outlined,
        ),
      )
          : Container(),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Icon(
            icon,
            color: iconColor ?? AppColor.white,
          ),
        ),
      ],
    );
  }

  static Widget customAppBarNew(
      {required BuildContext context, required String title}) {
    return CustomAppBar(
      child: Padding(
        padding:
        const EdgeInsets.only(top: 30, left: 12, right: 12, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    "assets/images/icon_left.png",
                    width: 20,
                    height: 20,
                  ),
                ),
                Text(title,
                    style: TextStyle(
                        color: AppColor.TITLE_COLOR,
                        fontSize: 18,
                        fontFamily: "Jost",
                        fontWeight: FontWeight.bold)),
                const Icon(
                  Icons.info_outlined,
                  color: AppColor.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget customVerticalDivider() {
    return const VerticalDivider(
      color: AppColor.grey,
      width: 1,
    );
  }

  static Widget customIcon({IconData? icon, Color? color, double? size}) {
    return Icon(
      icon,
      color: color ?? Colors.black,
      size: size ?? 20,
    );
  }

  static Widget customDivider({double? indent, double? endent, Color?color}) {
    return Divider(
      thickness: 1,
      color: color,
      height: 2,
      indent: indent ?? 0,
      endIndent: endent ?? 0,
    );
  }

  static Widget smallText(
      {required String text, double? textSize, Color? color, int? fontsize}) {
    return Text(text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.normal,
          fontSize: 12,
          fontFamily: 'Jost',
        ));
  }

  static Widget smallBoldText(
      {required String text, double? textSize, Color? color, int? fontsize}) {
    return Text(text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
          fontFamily: 'Jost',
        ));
  }

  static Widget boldSubHeadingTextWhite({required String text,
    double? textSize,
    Color? color,
    TextAlign? textAlign}) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Jost',
        fontSize: textSize ?? 12,
        fontWeight: FontWeight.w900,
        color: color ?? AppColor.white,
      ),
      textAlign: textAlign ?? TextAlign.center,
    );
  }

  static Widget smallHeadingTextWhite(
      {required String text, double? textSize, Color? color, int? value}) {
    return Text(text,
        style: TextStyle(
          color: value == 1 ? AppColor.black : AppColor.white,
          fontWeight: FontWeight.normal,
          fontSize: 10,
          fontFamily: 'Jost',
        ));
  }

  static Widget boldSubHeadingListText({
    required String text,
    double? textSize,
    Color? color,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Jost',
        fontSize: textSize ?? 12,
        fontWeight: FontWeight.w900,
        color: color ?? AppColor.black_2,
      ),
    );
  }

  static Widget normalHeadingText(
      {required String text, double? textSize, Color? color}) {
    return Text(text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.normal,
          fontSize: 12,
          fontFamily: 'Jost',
        ));
  }

  static Widget regularHeadingListText({String? text,
    double? textSize,
    Color? color,
    int? value,
    TextAlign? textAlign,
    TextOverflow? textOverflow}) {
    return Text(
      text ?? '',
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
        color: color,
        fontWeight: value == 0 ? FontWeight.bold : FontWeight.normal,
        fontSize: 14,
        fontFamily: 'Jost',
      ),
    );
  }

  static Widget headingTextwithContaine(
      {required String text, double? textSize, Color? color}) {
    return Container(
        height: 41,
        width: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
                style: TextStyle(
                  color: HexColor(AppColor.COLOR_BLACK),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'Jost',
                )),
          ],
        ));
  }

  static Widget rectangleButton(String name, BuildContext context) {
    return Container(
      height: 54,
      width: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: AssetImage("assets/images/bg_create.png"))),
      child: Center(
          child: Text(name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
    );
  }

  static Widget cupertinoSwitchButton({required bool value,
    required Color thumbColor,
    required Color activeColor,
    required void Function(bool)? onChanged,
    BuildContext? context}) {
    return Transform.scale(
      scale: 0.6,
      child: CupertinoSwitch(
          value: value,
          thumbColor: thumbColor,
          activeColor: activeColor,
          onChanged: onChanged),
    );
  }

  static Widget switchButton({required bool value,
    required Color activeTrackColor,
    required Color inactiveTrackColor,
    required Color inactiveThumbColor,
    required Color activeColor,
    required void Function(bool)? onChanged,
    BuildContext? context}) {
    return Switch(
      onChanged: onChanged,
      value: value,
      activeColor: activeColor,
      activeTrackColor: activeTrackColor,
      inactiveThumbColor: inactiveThumbColor,
      inactiveTrackColor: inactiveTrackColor,
    );
  }

  static Widget checkBox(
      {required value, required void Function(dynamic)? onChanged}) {
    return Checkbox(
      splashRadius: 8,
      value: value,
      onChanged: onChanged,
    );
  }

  static Future<void> openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  static Future<void> openMail(String email) async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Hello Team',
      }),
    );

    launchUrl(emailLaunchUri);
  }

  static Widget subHeadingText(
      {required String text, double? textSize, Color? color}) {
    return Text(text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.normal,
          fontSize: 10,
          fontFamily: 'Jost',
        ));
  }

  static hideKeyBoard(BuildContext context) {
    return FocusScope.of(context).requestFocus(new FocusNode());
  }

  static Widget appBarNew(
      {required BuildContext context, required String title, bool? isHide}) {
    return CustomAppBar(
      child: Container(
        padding: EdgeInsets.only(top: 12, left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/icon_left.png",
                      color: Colors.black,
                      height: 19,
                      width: 9,
                      //fit: BoxFit.fill,
                    ),
                  ),
                ),
                Gap(13),
                Text(title,
                    style: TextStyle(
                        color: AppColor.TITLE_COLOR,
                        fontSize: 18,
                        fontFamily: "Jost",
                        fontWeight: FontWeight.bold)),
                new Spacer(),
                isHide == true
                    ? const Icon(
                  Icons.info_outlined,
                  color: AppColor.transpernt,
                )
                    : Icon(
                  Icons.arrow_forward,
                  color: AppColor.TITLE_COLOR,
                ),
                Gap(12)
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget thinSubHeadingText({required String text,
    double? textSize,
    Color? color,
    TextAlign? textAlign}) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Jost',
        fontSize: textSize ?? 16,
        fontWeight: FontWeight.w300,
        color: color ?? AppColor.TITLE_COLOR,
      ),
      textAlign: textAlign ?? TextAlign.center,
    );
  }
  static Widget profileView({required String title,required String name}) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Container(
        width: 140,
        child: Utils.mediumHeadingNormalText(
            text: title,
            textAlign: TextAlign.left,
            fontFamily: 'Poppins',
            color: AppColor.black,
            textSize: 12),
      ),
      Utils.mediumHeadingNormalText(
      text: name,
      fontFamily: 'Poppins',
      color: AppColor.APP_TEXT_COLOR_SECOND,
          textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      textSize: 12),
    ],);
  }

  static Widget profileViewSignUp({required String title,required String name}) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Utils.mediumHeadingNormalText(
          text: title,
          fontFamily: 'Poppins',
          color: AppColor.black,
          textSize: 10),
      Container(
          width: 80,
          child:Utils.mediumHeadingNormalText(
          text: name,
          fontFamily: 'Poppins',
          color: AppColor.APP_TEXT_COLOR_SECOND,
              textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          textSize: 10)),
    ],);
  }

  static Widget normalboldSubHeadingText({required String text,
    double? textSize,
    Color? color,
    TextAlign? textAlign}) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Jost',
        fontSize: textSize ?? 16,
        fontWeight: FontWeight.w500,
        color: color ?? AppColor.TITLE_COLOR,
      ),
      textAlign: textAlign ?? TextAlign.center,
    );
  }

  static Widget followersboldText({required String text,
    double? textSize,
    Color? color,
    TextAlign? textAlign}) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Jost',
        fontSize: textSize ?? 15,
        fontWeight: FontWeight.w600,
        color: color ?? AppColor.TITLE_COLOR,
      ),
      textAlign: textAlign ?? TextAlign.center,
    );
  }

  static Widget profileAppBar(
      {required BuildContext context, required String title}) {
    return CustomAppBar(
      child: Container(
        padding: EdgeInsets.only(top: 32, left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: AppColor.TITLE_COLOR,
                        fontSize: 18,
                        fontFamily: "Jost",
                        fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Utils.imageView(
                        image: "assets/images/icon_plus.png",
                        width: 26,
                        height: 26),
                    Gap(16),
                    GestureDetector(
                        onTap: () {},
                        child: Utils.imageView(
                            image: "assets/images/ic_profle_menu.png",
                            width: 20,
                            height: 20)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget regularHeading({String? text,
    double? textSize,
    Color? color,
    int? value,
    TextOverflow? textOverflow}) {
    return Text(
      text ?? '',
      textAlign: TextAlign.left,
      style: TextStyle(
        color: color,
        fontWeight: value == 0 ? FontWeight.bold : FontWeight.normal,
        fontSize: 14,
        fontFamily: 'Jost',
      ),
    );
  }

  static Widget featureWidget({required String title, String? imageUrl,BuildContext? context}){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
            imageUrl!,
          height: 32,
          width: 32
        ),
        Gap(10),
        Utils.mediumHeadingNormalText(
            text: title,
            fontFamily: 'Poppins',color: AppColor.white,
            fontWeight: FontWeight.normal,
            textAlign: TextAlign.center,
            textSize: Responsive().getResponsiveValue(
                forLargeScreen: 10,
                forShortScreen: 10,
                forMobLandScapeMode: 10,
                forMediumScreen: 10,
                forTabletScreen: 10,
                context: context!)),
      ],);
  }


  static Widget uploadButton({required String text, String? imageUrl}) {
    return Container(
      height: 50,
      width: 150,
      decoration: BoxDecoration(border: Border.all(color: AppColor.black)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imageUrl!,
            height: 20,
            width: 20,
          ),
          Gap(20),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              fontFamily: 'Jost',
            ),
          ),
        ],
      ),
    );
  }

  static Widget get_chip(name) {
    return FilterChip(
      selectedColor: Colors.blue.shade800,
      disabledColor: Colors.blue.shade400,
      backgroundColor: HexColor(AppColor.LIGHT_GRAY),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      label: Utils.mediumHeadingNormalText(text: "x${name}", textSize: 12),
      onSelected: (bool value) {},
    );
  }

  static Widget progressDialog(BuildContext context, bool isLoading,{int? type}) {
    return Visibility(
        visible: isLoading,
        child: Container(
          color: Colors.transparent,
          width: Responsive().getResponsiveValue(
              forLargeScreen: type==3?MediaQuery.of(context).size.width/1.7:MediaQuery.of(context).size.width/4,
              forShortScreen: MediaQuery.of(context).size.width,
              context: context),
          height: type==1?MediaQuery.of(context).size.height:type==0?MediaQuery.of(context).size.height/3:type==3?MediaQuery.of(context).size.height:MediaQuery.of(context).size.height/2.2,
          child: CircularProgressIndicator(
            valueColor:
            AlwaysStoppedAnimation<Color>(HexColor(AppColor.TEXT_COLOR)),
          ),
          alignment: Alignment.center,
        ));
  }

  static Widget progressDialogFullScreen(BuildContext context, bool isLoading) {
    return Visibility(
        visible: isLoading,
        child: Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: CircularProgressIndicator(
            valueColor:
            AlwaysStoppedAnimation<Color>(HexColor(AppColor.TEXT_COLOR)),
          ),
          alignment: Alignment.center,
        ));
  }

  static DecorationImage commonBGImageDecoration(
      {String passValue = "assets/images/bg_add_goal.jpg"}) {
    return DecorationImage(
        image: AssetImage(
          passValue,
        ),
        fit: BoxFit.fill);
  }


  static BoxDecoration commonBGDecoration(
      {String passValue = "assets/images/bg_add_goal.jpg", bool value = true}) {
    return value ? BoxDecoration(
        image: Utils.commonBGImageDecoration()
    ) : const BoxDecoration(
      color: AppColor.appDarkColor,
    );
  }

  static DecorationImage fileDecoration(
      {required String ? passPath, BoxFit? fit = BoxFit.cover }) {
    return DecorationImage(
        image: FileImage(File(passPath!)), fit: fit);
  }

  // ignore: non_constant_identifier_names
  static String covert_Timestamp_To_VisibleTime({required int? timestamp}) {
    var time = DateTime.fromMillisecondsSinceEpoch(timestamp! * 1000);
    var dateFormat = DateFormat('hh:mm a').format(time);
    return dateFormat.toString();
  }

  static String getCreateDateToTime(String createdDate) {
    DateTime y = DateTime.parse(createdDate);
    final DateFormat formatter = DateFormat('hh:mm a');
    final String formatted = formatter.format(y);
    return formatted;
  }
  static String getCreateDate(String createdDate) {
    DateTime y = DateTime.parse(createdDate);
    final DateFormat formatter = DateFormat('dd MMM, yyyy');
    final String formatted = formatter.format(y);
    return formatted;
  }


  static String convertDateTimeToYYYMMDD({required DateTime passDate}) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return dateFormat.format(passDate).toString();
  }

  static String convertDateToVisible(
      {required int passDate, String showFormat = 'dd MMM, yyyy'}) {
    int fromMillisecondsSinceEpoch = passDate * 1000;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        fromMillisecondsSinceEpoch);
    String value = DateFormat(showFormat).format(dateTime);
    return value;
  }

  static String convertDateSmallDate({required DateTime passDate}) {
    DateFormat dateFormat = DateFormat("dd MMM");
    return dateFormat.format(passDate).toString();
  }

  static customRowProfile({ String? title,String? subtitle,double? fontSize,fontWeight,color}){
    return Padding(
      padding: const EdgeInsets.only(right: 14.0,left: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(title!,style:TextStyle(fontSize: fontSize , fontWeight: fontWeight, fontFamily: 'Poppins',color: AppColor.APP_TEXT_COLOR),),
          Spacer(),
          Text(subtitle!,style:TextStyle(fontSize: fontSize??14, fontWeight: fontWeight??FontWeight.w400, fontFamily: 'Poppins',color: AppColor.APP_TEXT_COLOR_SECOND)),
          Text(""),

        ],
      ),
    );

  }

  static customBlackDot(){
    return Row(
      children: [
        Gap(4),
        Container(
          height: 3,
          width: 3,
          margin: EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            color: AppColor.APP_TEXT_COLOR_SECOND,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        Gap(4),
      ],
    );

  }
  static showAlertLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
          backgroundColor: Colors.transparent,
          actions: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(width: 1.0, color: Colors.black26)),
             // margin: const EdgeInsets.only(left: 20,right: 20),
              width:  Responsive().getResponsiveValue(
                  forLargeScreen:  MediaQuery.of(context).size.width/3.8,
                  forShortScreen:  MediaQuery.of(context).size.width,
                  forMobLandScapeMode: MediaQuery.of(context).size.width,
                  forMediumScreen: MediaQuery.of(context).size.width,
                  forTabletScreen: MediaQuery.of(context).size.width/1.1,
                  context: context),
              height:  Responsive().getResponsiveValue(
                  forLargeScreen:  MediaQuery.of(context).size.height/4,
                  forShortScreen:  MediaQuery.of(context).size.height/4.2,
                  forMobLandScapeMode: MediaQuery.of(context).size.height/4,
                  forMediumScreen: MediaQuery.of(context).size.height/4.2,
                  forTabletScreen: MediaQuery.of(context).size.height/4,
                  context: context),
              child: Wrap(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20,bottom: 10.0),
                    child: Center(
                      child: Utils.mediumHeadingNormalText(text:"Logout",textSize: 16,fontWeight: FontWeight.bold,color: HexColor("#242424")),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                   Center(
                    child:Utils.mediumHeadingNormalText(text:"Are you sure want to log out?",textSize: 12,fontWeight: FontWeight.normal,color: HexColor("#7B7F91")),

                  ),
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.only(top: 30.0,bottom: 20),
                            decoration: BoxDecoration(
                                color: HexColor("#F0F0F0"),
                                borderRadius: BorderRadius.circular(8),
                                //border: Border.all(color: HexColor("#FF483C"))
                            ),
                            child: Text("Cancel",textAlign:TextAlign.center,style: TextStyle(color: Colors.black),),
                          ),
                          SizedBox(width: 12,),
                          GestureDetector(
                            onTap: () async{
                             /* Timer.periodic(Duration(seconds: 4), (timer) {

                              });*/
                              await FirebaseMessaging.instance.unsubscribeFromTopic("user_${SessionManager.getString(Preferences.USER_ID)}");
                              await FirebaseMessaging.instance.unsubscribeFromTopic("chatId_${SessionManager.getString(Preferences.USER_ID)}");
                              SessionManager.setString(Preferences.profileStatus,"");
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                                viewType: 0,
                              )));
                            },
                            child: Container(
                              width: 120,
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(top: 30.0,bottom: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: HexColor("#FF483C"),
                              ),
                              child: Text("LogOut",textAlign:TextAlign.center,style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }


  static  customDialog(BuildContext context,{String? message, int milliseconds = 1500,SnackBarBehavior snackBarBehavior = SnackBarBehavior.floating}){
    return /*kIsWeb?*/
   ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColor.appDarkColor,
        behavior: snackBarBehavior,
        action: SnackBarAction(
            textColor: Colors.white,
            label: 'DISMISS',
            onPressed: () => _dismissCurrentSnackBar(context)),
        duration: Duration(seconds: 2),
        content: SelectableText(
          message ?? 'An error occured',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  static void showErrorSnackBar(BuildContext context,
      { String? message,
        int milliseconds = 1500,
        SnackBarBehavior snackBarBehavior = SnackBarBehavior.floating}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColor.btn_red,
        behavior: snackBarBehavior,
        action: SnackBarAction(
            textColor: Colors.white,
            label: 'DISMISS',
            onPressed: () => _dismissCurrentSnackBar(context)),
        duration: Duration(milliseconds: milliseconds),
        content: SelectableText(
          message ?? 'An error occured',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  static void _dismissCurrentSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  static  String convertDate(String createdDate){
    DateTime y = DateTime.parse(createdDate);
    final DateFormat formatter = DateFormat('dd MMMM');
    final DateFormat time = DateFormat('hh:mm a');
    final String formatted = formatter.format(y);
    final String formattedTime = time.format(y);
    final String compare = formatted +" at "+formattedTime;
    return compare;
  }
  static  String convertDateTime(String createdDate){
    var parsedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(createdDate);
    var finalDate = DateFormat("MMM dd").format(parsedDate);
    var finalTime = DateFormat.jm().format(parsedDate);
    var allDate = DateFormat("MMM dd hh:mm a").format(parsedDate);
    return finalTime;
  }
  static  String convertDateTimeSub(String createdDate){
    var parsedDate = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(createdDate);
    var allDate = DateFormat("dd MMM yyyy").format(parsedDate);
    return allDate;
  }
  static Widget customTextFeildSetting(BuildContext context,String text, String hintText,TextEditingController controller,
      bool? isHide,bool? isReadOnly){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // margin: EdgeInsets.only(top: 20,left: 20,right: 20),
          child: Utils.mediumHeadingNormalText(text: text,
              textSize: 12,fontWeight: FontWeight.w500,color: AppColor.black),
        ),
        Container(
          height: 45,
          // margin: EdgeInsets.only(top: 2,left: 20,right: 20),
          decoration: BoxDecoration(
              border: Border.all(color: HexColor(AppColor.settingBorderColor)),
              borderRadius: BorderRadius.circular(8.0)
          ),
          child: TextFormField(
            controller: controller,
            cursorColor: Colors.black,
            obscureText: isHide?? false,
            readOnly: isReadOnly?? false,
            style: TextStyle(color: Colors.black),
            maxLines: 1,
            decoration:  InputDecoration(
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              focusedBorder:OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              hintText: hintText,
              hintStyle: TextStyle(fontFamily: "Poppins",fontSize: 12,color:  HexColor(AppColor.textColor)),
            ),
          ),
        ),
      ],
    );
  }
  static Widget customTextFeildTestMonials(BuildContext context,String text, String hintText,TextEditingController controller,
      bool? isHide,bool? isReadOnly){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // margin: EdgeInsets.only(top: 20,left: 20,right: 20),
          child: Utils.mediumHeadingNormalText(text: text,
              textSize: 12,fontWeight: FontWeight.w500,color: AppColor.black),
        ),
        Container(
          height:140,
          width:  Responsive().getResponsiveValue(
              forLargeScreen: MediaQuery.of(context).size.width/1.2,
              forShortScreen: MediaQuery.of(context).size.width,
              forTabletScreen: MediaQuery.of(context).size.width,
              forMediumScreen:  MediaQuery.of(context).size.width,
              context: context),
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              color:AppColor.white,
              border: Border.all(color: HexColor(AppColor.settingBorderColor)),
              borderRadius:BorderRadius.circular(10),
          ),
          child: TextField(
            controller:controller,
            textInputAction:TextInputAction.next,
            cursorColor:Colors.black,
            style: const TextStyle(color:Colors.black,fontFamily: 'Poppins',fontSize: 12,fontWeight: FontWeight.normal),
            maxLines:6,
            decoration:InputDecoration(
                counterText:'',
                contentPadding: EdgeInsets.only(left:16,bottom:4,right: 10,top:8.0),
                border: InputBorder.none,
                hintText:hintText,
                hintStyle:const TextStyle(color:Colors.grey,fontFamily: 'Poppins',fontSize: 12)
            ),
          ),
        )
      ],
    );
  }

  static Widget customSubscription(String text,BuildContext context){
    return  Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Responsive().getResponsiveValue(
                forMobLandScapeMode: MediaQuery.of(context).size.width/1.5,
                forLargeScreen: MediaQuery.of(context).size.width/2.2,
                forShortScreen:MediaQuery.of(context).size.width/1.5,
                forTabletScreen: MediaQuery.of(context).size.width/1.5,
                forMediumScreen: MediaQuery.of(context).size.width/1.5,
                context: context),
            child: Utils.mediumHeadingNormalText(text: text,
                textSize:  Responsive().getResponsiveValue(
                    forLargeScreen: 14.0,
                    forShortScreen: 12.0,
                    forTabletScreen:12.0,
                    forMediumScreen:  12.0,
                    forMobLandScapeMode:  12.0,
                    context: context),fontWeight: FontWeight.w500,color: AppColor.black,textAlign: TextAlign.start),
          ),
          Icon(Icons.check,color: HexColor(AppColor.SIDE_TEXT_COLOR),)
        ],
      ),
    );
  }
  static Widget customSubscriptionText(String text,String subText){
    return  Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Utils.mediumHeadingNormalText(text: text,
              textSize: 14,fontWeight: FontWeight.w500,color: AppColor.black),
          Utils.mediumHeadingNormalText(text: subText,
            textSize: 14,fontWeight: FontWeight.w500,color:  AppColor.nonselectedamenetycolor,),
        ],
      ),
    );
  }

  static void scroll(ScrollController controller) {
    Timer(
      Duration(seconds: 1),
          () => controller.jumpTo(controller.position.maxScrollExtent),
    );
  }

  static String readTimestamp(int timestamp) {
    var format = new DateFormat('hh:mm a');
    var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    var diff = date.difference(date);
    var time = '';
    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + 'DAY AGO';
      } else {
        time = diff.inDays.toString() + 'DAYS AGO';
      }
    }
    return time;
  }

  static chatDialog(BuildContext context, String senderId, String receiverId,
      String senderName, String receiverName, String receiverImage, String senderImage){
    showGeneralDialog(
      barrierDismissible: false,
      context: context,
      pageBuilder: (context, _,__) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.bottomRight,
                    width: MediaQuery.of(context).size.width/3,
                    child: Container(
                        alignment: Alignment.bottomRight,
                        padding:  const EdgeInsets.all(16),
                        decoration:  const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                                padding:  const EdgeInsets.all(10),
                                color: Colors.white,
                                child:Row(
                                  children:  [
                                    Expanded(
                                      child:  Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height : 27,
                                            width: 27,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(20.0),
                                                child: Image.asset('assets/images/icon_profile.png',fit: BoxFit.fill,)),
                                          ),
                                          const Gap(5),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Utils.mediumHeadingNormalText(text: 'Vivek Sharma',textSize: 10,fontWeight: FontWeight.w500,color: AppColor.grey,textAlign: TextAlign.start,),
                                                Utils.mediumHeadingNormalText(text: 'Last active at 5:00PM',textSize: 10,color: AppColor.grey,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start),
                                              ],
                                            ),
                                          ),
                                          const Spacer(),
                                          Image.asset('assets/images/icon_voiceCall.png',height: 17,),
                                          const Gap(5),
                                          Image.asset('assets/images/icon_video.png',height: 17,),
                                          const Gap(10),
                                          GestureDetector(
                                              onTap: (){
                                                Navigator.pop(context);
                                              },
                                              child: const Icon(Icons.close_sharp,size: 19,)),
                                        ],
                                      ),
                                    ),
                                    const Gap(5),
                                  ],
                                )),
                            const Gap(5),
                            const Divider(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height/3.5,
                              width: MediaQuery.of(context).size.width,

                            ),
                            Row(
                              children: [
                                Image.asset('assets/images/gallery.png',height: 25,),
                                const Gap(10),
                                Expanded(
                                  child: Container(
                                    height: 46,
                                    decoration: BoxDecoration(
                                      color:HexColor(AppColor.WHITE),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Material(
                                       color: Colors.white,
                                        child:TextField(
                                      style:  TextStyle(
                                        color:HexColor(AppColor.BLACK),
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        enabledBorder:  const OutlineInputBorder(
                                            borderSide: BorderSide(color:  AppColor.grey)
                                        ),
                                        focusedBorder:  const OutlineInputBorder(
                                            borderSide: BorderSide(color:  AppColor.grey)
                                        ),
                                        hintText: UtilStrings.TypeAmessage,
                                        hintStyle:  const TextStyle(
                                          color:AppColor.grey,
                                          fontSize: 14,
                                        ),
                                        contentPadding:const EdgeInsets.all(13),
                                        suffixIcon: SizedBox(
                                          width: 100,
                                          child: Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                },
                                                icon: Image.asset('assets/images/ic_happy.png'),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: Image.asset('assets/images/ic_send.png'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                    ),
                  ),
                ],
              ),
            ],
          );
      },

    );
  }

  static viewPhoto(BuildContext context, String image) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 20),
                    child: Hero(
                      tag: "customTag",
                      child:  Image.network(
                        image,
                        errorBuilder: (context, exception, stackTrace) {
                          return Image.asset(
                            "assets/images/gallery.png",
                          );
                        },
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin:   EdgeInsets.only(right: 20,top:42),
                      child: Image.asset(
                        "assets/images/ic_close.png",
                        height:24,
                        width: 24,
                        fit: BoxFit.fill,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void sessionExpire(BuildContext context) {
    SessionManager.setString(Preferences.ACCESS_TOKEN, "");
    SessionManager.setBools(Preferences.IS_USER_LOGIN, false);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen(
      viewType:0,
    )));
  }
  static bool validateStructure(String value){String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
  }

  //redirect to mail
  static launchMailto() async {
    final mailtoLink = Mailto(
      to: ['hello@likeplaylikeplay.com'],
    );
    await launch('$mailtoLink');
  }
  static String convertTimestamp(int timestamp) {
    var format = new DateFormat('hh:mm a');
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = date.difference(date);
    var time = '';
    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + 'DAY AGO';
      } else {
        time = diff.inDays.toString() + 'DAYS AGO';
      }
    }
    return time;
  }
  static String convertDateTimestamp(int timestamp) {
    var format = new DateFormat('yyyy-MM-dd');
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = date.difference(date);
    var time = '';
    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + 'DAY AGO';
      } else {
        time = diff.inDays.toString() + 'DAYS AGO';
      }
    }
    return time;
  }
  static String formatDateToTimeAgo(String dateString) {
    final inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ');
    final dateTime = inputFormat.parseUtc(dateString);
    final now = DateTime.now().toUtc();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}min';
    } else {
      return '0s';
    }
}
static showAlertSubscriptionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return  AlertDialog(
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 20,right: 20),
            width:  Responsive().getResponsiveValue(
                forLargeScreen: MediaQuery.of(context).size.width/4,
                context: context),
            height:  Responsive().getResponsiveValue(
                forLargeScreen: MediaQuery.of(context).size.height/4,
                context: context),
            child: Wrap(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40,bottom: 10.0),
                  child: Center(
                    child: Utils.mediumHeadingNormalText(text:"Subscription",textSize: 14,fontWeight: FontWeight.bold,color: AppColor.APP_TEXT_COLOR,textAlign: TextAlign.start),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Center(
                  child:
                  Text("You have no plan. Buy premium plan to access likeplay-likeplay app.",style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600),),
                ),
                Center(
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child:Container(
                            width: 120,
                            padding: EdgeInsets.all(8.0),
                            margin: EdgeInsets.only(top: 30.0,bottom: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: HexColor("#FF483C"))
                            ),
                            child: Text("Ok",textAlign:TextAlign.center,style: TextStyle(color: HexColor("#112153")),),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
 static  void onUserLogin(String userId,String userName) {
    /// 4/5. initialized ZegoUIKitPrebuiltCallInvitationService when account is logged in or re-logged in
    //clientKey  //App ID : 1627834917
    //  AppSign : 3b08c0a5351125e4e75fb35071698fbc7fa27ec59d4bda0b025d50e97f0f1dd2
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: 1627834917 ,
      appSign: "3b08c0a5351125e4e75fb35071698fbc7fa27ec59d4bda0b025d50e97f0f1dd2",
      /*  appID: 1547516677,
      appSign: "240add1e63ff2fd307e360592192050deee6a96874cb3a13a746f53f2c3a5143",*/
      userID:userId,
      userName: userName,
     // notifyWhenAppRunningInBackgroundOrQuit: true,
      //appName:"LikePlay-LikePlay",
      plugins: [ZegoUIKitSignalingPlugin()],
        // androidNotificationConfig:ZegoAndroidNotificationConfig(channelID:"",channelName: "",sound: ""),
      requireConfig: (ZegoCallInvitationData data) {
        final config = (data.invitees.length > 1)
            ? ZegoCallType.videoCall == data.type
            ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
            : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
            : ZegoCallType.videoCall == data.type
            ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
            : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

        /// support minimizing, show minimizing button
        config.topMenuBarConfig.isVisible = true;
        config.topMenuBarConfig.buttons
            .insert(0, ZegoMenuBarButtonName.minimizingButton);

        return config;
      },
    );
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
  }

  static DateTime calculate28DaysFromDate(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime newDate = date.add(Duration(days: 28));
    return newDate;
  }

  static DateTime calculate3MonthFromDate(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime threeMonthsLater = DateTime(date.year, date.month + 3, date.day);
    return threeMonthsLater;
  }

  static DateTime calculate12MonthFromDate(int timestamp) {
     DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    DateTime twelveMonthsLater = DateTime(date.year + 1, date.month, date.day);
      return twelveMonthsLater;
  }

  static  void signInAnonymously() async{
    var user = await FirebaseAuth.instance.signInAnonymously();
  }
  static String calculateDay(){
    DateTime date = DateTime.now();
    var day= DateFormat('EEEE').format(date);
    return day;
  }
}
