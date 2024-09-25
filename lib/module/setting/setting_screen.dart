import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/module/model/block_response.dart';
import 'package:likeplay/module/model/cancel_subscription_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import 'package:likeplay/module/model/user_profile_response.dart';
import 'package:likeplay/module/setting/setting_presenter.dart';
import 'package:likeplay/utils/constant_lists.dart';
import 'package:likeplay/utils/sharedpref/shared_prefrence.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/responsive.dart';
import '../../utils/firebase/authentication_service.dart';
import '../../utils/sharedpref/preferences.dart';
import '../../utils/string_utils.dart';
import '../../utils/utils.dart';
import '../../widget/common/common_password_setting.dart';
import '../home/home.dart';
import '../model/text_bool.dart';
import '../sidemenu/web_side_menu.dart';
import '../subscription/subscription_mobile_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> implements SettingInterface {
  DateTime ?dateTime;
  bool isLoading = false;
  int selectIndex = 0;
  SettingPresenter? settingPresenter;
  TextEditingController matchController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController referController = TextEditingController();
  List<BlockData> blockList=[];
  final _authService = AuthenticationService();
  String reciverId="";
  String senderId="";
  List <TextBool> featuresList=[
    TextBool(text: UtilStrings.Reset_Password, value: true),
    TextBool(text: UtilStrings.Refer_Friends, value: false),
    // TextBool(text: UtilStrings.Upgrade_my_subscription, value: false),
    TextBool(text: UtilStrings.Blocked_Users, value: false),
    // TextBool(text: UtilStrings.Cancel_subscription, value: false),
  ];
  @override
  void initState() {
    super.initState();
    settingPresenter=SettingPresenter(this);
    print("subscription_plan==>"+SessionManager.getString(Preferences.subscription_plan));
    setState(() {
      referController.text = SessionManager.getString(Preferences.REFERAL_CODE);
      settingPresenter?.doBlockList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return /*kIsWeb?*/AppSideMenu(
      pageTitle: UtilStrings.Home,
      screenType: 1,
      body: SingleChildScrollView(
        child: Container(
          /*width: size.width,
          height: size.height,*/
          color: Colors.white,
          child: Container(
            color: Colors.white,
            child: ResponsiveRowColumn(
              rowMainAxisAlignment: MainAxisAlignment.start,
              rowCrossAxisAlignment: CrossAxisAlignment.start,
              layout: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                  ? ResponsiveRowColumnType.COLUMN
                  : ResponsiveRowColumnType.ROW,
              children: [
                ResponsiveRowColumnItem(
                  rowFlex: 1, child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: Responsive().getResponsiveValue(
                              forLargeScreen: EdgeInsets.all(20.0),
                              forShortScreen: EdgeInsets.all(0.0),
                              forMobLandScapeMode: EdgeInsets.all(0.0),
                              forMediumScreen: EdgeInsets.all(0.0),
                              forTabletScreen: EdgeInsets.all(0.0),
                              context: context),
                          color: HexColor("#F0F0F0"),
                          child: Row(
                            children: [
                              //Utils.
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Gap(12),
                                    Utils.mediumHeadingNormalText(
                                        text: Responsive().getResponsiveValue(
                                            forLargeScreen: "",
                                            forShortScreen: UtilStrings
                                                .Settings,
                                            forMobLandScapeMode: UtilStrings
                                                .Settings,
                                            forMediumScreen: UtilStrings
                                                .Settings,
                                            forTabletScreen: UtilStrings
                                                .Settings,
                                            context: context),
                                        textSize: 14,
                                        color: AppColor.APP_TEXT_COLOR),
                                  ],
                                ),
                              ),
                              Gap(12),
                              Responsive().getResponsiveValue(
                                  forLargeScreen: SizedBox(),
                                  forShortScreen: GestureDetector(onTap:(){
                                                        showAlertDeleteAccountDialog(context);
                                                      },child:Container(
                                                        height: 36,
                                                        width: 140,
                                                        margin:EdgeInsets.all(
                                                            8),
                                                        padding: EdgeInsets.all(
                                                            8),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(8),
                                                          color: HexColor(
                                                              '#FF483C'),
                                                        ),
                                                        child: Center(child:
                                                        Row(children: [
                                                          Image.asset(
                                                            'assets/images/ic_trash.png',
                                                            width: 22,
                                                            height: 22,
                                                          ),
                                                          Gap(8),
                                                          Utils
                                                              .mediumHeadingNormalText(
                                                              text: UtilStrings
                                                                  .Delete_Account,
                                                              textSize: 10,
                                                              fontWeight: FontWeight
                                                                  .w400,
                                                              color: Colors
                                                                  .white),

                                                        ],)
                                                        ),
                                                      )),
                                  forMobLandScapeMode:GestureDetector(onTap:(){
                                                        showAlertDeleteAccountDialog(context);
                                                      },child:Container(
                                    height: 36,
                                    width: 140,
                                    margin:EdgeInsets.all(
                                        8),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(8),
                                                          color: HexColor(
                                                              '#FF483C'),
                                                        ),
                                                        child: Center(child:
                                                        Row(children: [
                                                          Image.asset(
                                                            'assets/images/ic_trash.png',
                                                            width: 22,
                                                            height: 22,
                                                          ),
                                                          Gap(8),
                                                          Utils
                                                              .mediumHeadingNormalText(
                                                              text: UtilStrings
                                                                  .Delete_Account,
                                                              textSize: 10,
                                                              fontWeight: FontWeight
                                                                  .w400,
                                                              color: Colors
                                                                  .white),

                                                        ],)
                                                        ),
                                                      )),
                                  forMediumScreen: GestureDetector(onTap:(){
                                                        showAlertDeleteAccountDialog(context);
                                                      },child:Container(
                                    height: 36,
                                    width: 140,
                                    margin:EdgeInsets.all(
                                        8),
                                                        padding: EdgeInsets.all(8),
                                                        
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(8),
                                                          color: HexColor(
                                                              '#FF483C'),
                                                        ),
                                                        child: Center(child:
                                                        Row(children: [
                                                          Image.asset(
                                                            'assets/images/ic_trash.png',
                                                            width: 22,
                                                            height: 22,
                                                          ),
                                                          Gap(8),
                                                          Utils
                                                              .mediumHeadingNormalText(
                                                              text: UtilStrings
                                                                  .Delete_Account,
                                                              textSize: 10,
                                                              fontWeight: FontWeight
                                                                  .w400,
                                                              color: Colors
                                                                  .white),

                                                        ],)
                                                        ),
                                                      )),
                                  forTabletScreen: GestureDetector(onTap:(){
                                                        showAlertDeleteAccountDialog(context);
                                                      },child:Container(
                                                        height: 42,
                                                        width: 200,
                                                        padding: EdgeInsets.all(
                                                            8),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(8),
                                                          color: HexColor(
                                                              '#FF483C'),
                                                        ),
                                                        child: Center(child:
                                                        Row(children: [
                                                          Image.asset(
                                                            'assets/images/ic_trash.png',
                                                            width: 22,
                                                            height: 22,
                                                          ),
                                                          Gap(8),
                                                          Utils
                                                              .mediumHeadingNormalText(
                                                              text: UtilStrings
                                                                  .Delete_Account,
                                                              textSize: 10,
                                                              fontWeight: FontWeight
                                                                  .w400,
                                                              color: Colors
                                                                  .white),

                                                        ],)
                                                        ),
                                                      )),
                                  context: context),
                            ],
                          )),
                      Container(
                        color: Colors.grey,
                        height: 1,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Responsive().getResponsiveValue(
                              forLargeScreen: Gap(32.0),
                              forShortScreen: SizedBox(),
                              forMobLandScapeMode: SizedBox(),
                              forMediumScreen: SizedBox(),
                              forTabletScreen: SizedBox(),
                              context: context),
                          Responsive().getResponsiveValue(
                              forLargeScreen: Container(
                                height: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 1.4,
                                    forShortScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 1.6,
                                    forMobLandScapeMode: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 1.4,
                                    forMediumScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 1.4,
                                    forTabletScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 1.4,
                                    context: context),
                                margin: const EdgeInsets.only(
                                    right: 42, top: 10),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: featuresList.length,
                                    itemBuilder: (BuildContext, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 16),
                                        child: GestureDetector(
                                          onTap: () {
                                            selectIndex = index;
                                            dynamicUiChange(index);
                                          },
                                          child: Row(children: [
                                            Container(height: 70, width: 6,
                                              decoration: BoxDecoration(
                                                color: featuresList[index]
                                                    .value == true ? Color(
                                                    0xffff394c) : AppColor
                                                    .grey2,
                                              ),
                                            ),
                                            Container(height: 70, width: 200,
                                              decoration: BoxDecoration(
                                                color: featuresList[index]
                                                    .value == true ? Color(
                                                    0xffffdad9) : AppColor
                                                    .grey2,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16, right: 16),
                                                child: Row(
                                                  children: [
                                                    Utils
                                                        .mediumHeadingNormalText(
                                                        text: featuresList[index]
                                                            .text,
                                                        textAlign: TextAlign
                                                            .start,
                                                        fontWeight: FontWeight
                                                            .w700,
                                                        color: AppColor.black,
                                                        textSize: 14),
                                                    Spacer(),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: AppColor.black,
                                                      size: 16,)
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],),
                                        ),
                                      );
                                    }),

                              ),
                              forShortScreen: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 10,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: featuresList.length,
                                    itemBuilder: (BuildContext, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          selectIndex = index;
                                          dynamicUiChange(index);
                                        },
                                        child: Row(children: [
                                          Container(height: 70, width: 6,
                                            decoration: BoxDecoration(
                                              color: featuresList[index]
                                                  .value == true ? Color(
                                                  0xffff394c) : AppColor.grey2,
                                            ),
                                          ),
                                          Container(height: 70, width: 200,
                                            decoration: BoxDecoration(
                                              color: featuresList[index]
                                                  .value == true ? Color(
                                                  0xffffdad9) : AppColor.grey2,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16, right: 16),
                                              child: Row(
                                                children: [
                                                  Utils.mediumHeadingNormalText(
                                                      text: featuresList[index]
                                                          .text,
                                                      textAlign: TextAlign
                                                          .start,
                                                      fontWeight: FontWeight
                                                          .w700,
                                                      color: AppColor.black,
                                                      textSize: 14),
                                                  Spacer(),
                                                  Icon(Icons.arrow_forward_ios,
                                                    color: AppColor.black,
                                                    size: 16,)
                                                ],
                                              ),
                                            ),
                                          )
                                        ],),
                                      );
                                    }),

                              ),
                              forMobLandScapeMode: SizedBox(),
                              forMediumScreen: SizedBox(),
                              forTabletScreen: SizedBox(),
                              context: context),
                          Responsive().getResponsiveValue(
                              forLargeScreen: GestureDetector(
                                  onTap:(){
                                    showAlertDeleteAccountDialog(context);
                                  },child:Container(
                                height: 42,
                                width: 200,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: HexColor('#FF483C'),
                                ),
                                child: Center(child:
                                Row(children: [
                                  Image.asset(
                                    'assets/images/ic_trash.png',
                                    width: 22,
                                    height: 22,
                                  ),
                                  Gap(8),
                                  Utils.mediumHeadingNormalText(
                                      text: UtilStrings.Delete_Account,
                                      textSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),

                                ],)
                                ),
                              )),
                              forShortScreen: SizedBox(),
                              forMobLandScapeMode: SizedBox(),
                              forMediumScreen: SizedBox(),
                              forTabletScreen: SizedBox(),
                              context: context),

                        ],)
                    ],
                  ),
                ),),
                ResponsiveRowColumnItem(
                  rowFlex: 2, child: Column(
                  children: [
                    Container(
                      decoration: Responsive().getResponsiveValue(
                          forLargeScreen: const BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      width: 1.0, color: Colors.black26),
                                  left: BorderSide(
                                      width: 1.0, color: Colors.black26))),
                          context: context),
                      width: Responsive().getResponsiveValue(
                          forLargeScreen: MediaQuery
                              .of(context)
                              .size
                              .width,
                          context: context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ResponsiveRowColumn(
                            rowMainAxisAlignment: MainAxisAlignment
                                .spaceBetween,
                            rowCrossAxisAlignment: CrossAxisAlignment.start,
                            layout: ResponsiveWrapper.of(context).isSmallerThan(
                                DESKTOP)
                                ? ResponsiveRowColumnType.COLUMN
                                : ResponsiveRowColumnType.ROW,
                            children: [
                              ResponsiveRowColumnItem(
                                rowFlex: 2, child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Responsive().getResponsiveValue(
                                      forLargeScreen: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(20),
                                              color: HexColor("#F0F0F0"),
                                              child: Row(
                                                children: [
                                                  //Utils.
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .start,
                                                      children: [
                                                        const Gap(12),
                                                        Utils
                                                            .mediumHeadingNormalText(
                                                            text: UtilStrings
                                                                .Settings,
                                                            textSize: 14,
                                                            color: AppColor
                                                                .APP_TEXT_COLOR),
                                                      ],
                                                    ),
                                                  ),
                                                  Gap(12),
                                                  Responsive()
                                                      .getResponsiveValue(
                                                      forLargeScreen: SizedBox(),
                                                      forShortScreen: Container(
                                                        height: 42,
                                                        width: 200,
                                                        padding: EdgeInsets.all(
                                                            8),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(8),
                                                          color: HexColor(
                                                              '#FF483C'),
                                                        ),
                                                        child: Center(child:
                                                        Row(children: [
                                                          Image.asset(
                                                            'assets/images/ic_trash.png',
                                                            width: 22,
                                                            height: 22,
                                                          ),
                                                          Gap(8),
                                                          Utils
                                                              .mediumHeadingNormalText(
                                                              text: UtilStrings
                                                                  .Delete_Account,
                                                              textSize: 10,
                                                              fontWeight: FontWeight
                                                                  .w400,
                                                              color: Colors
                                                                  .white),

                                                        ],))
                                                      ),
                                                      forMobLandScapeMode:  GestureDetector(onTap:(){
                                                        showAlertDeleteAccountDialog(context);
                                                      },child:Container(
                                                        height: 42,
                                                        width: 200,
                                                        padding: EdgeInsets.all(
                                                            8),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(8),
                                                          color: HexColor(
                                                              '#FF483C'),
                                                        ),
                                                        child: Center(child:
                                                        Row(children: [
                                                          Image.asset(
                                                            'assets/images/ic_trash.png',
                                                            width: 22,
                                                            height: 22,
                                                          ),
                                                          Gap(8),
                                                          Utils
                                                              .mediumHeadingNormalText(
                                                              text: UtilStrings
                                                                  .Delete_Account,
                                                              textSize: 10,
                                                              fontWeight: FontWeight
                                                                  .w400,
                                                              color: Colors
                                                                  .white),

                                                        ],)
                                                        ),
                                                      )),
                                                      forMediumScreen: Container(
                                                        height: 42,
                                                        width: 200,
                                                        padding: EdgeInsets.all(
                                                            8),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(8),
                                                          color: HexColor(
                                                              '#FF483C'),
                                                        ),
                                                        child: Center(child:
                                                        Row(children: [
                                                          Image.asset(
                                                            'assets/images/ic_trash.png',
                                                            width: 22,
                                                            height: 22,
                                                          ),
                                                          Gap(8),
                                                          Utils
                                                              .mediumHeadingNormalText(
                                                              text: UtilStrings
                                                                  .Delete_Account,
                                                              textSize: 10,
                                                              fontWeight: FontWeight
                                                                  .w400,
                                                              color: Colors
                                                                  .white),

                                                        ],)
                                                        ),
                                                      ),
                                                      forTabletScreen: Container(
                                                        height: 42,
                                                        width: 200,
                                                        padding: EdgeInsets.all(
                                                            8),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(8),
                                                          color: HexColor(
                                                              '#FF483C'),
                                                        ),
                                                        child: Center(child:
                                                        Row(children: [
                                                          Image.asset(
                                                            'assets/images/ic_trash.png',
                                                            width: 22,
                                                            height: 22,
                                                          ),
                                                          Gap(8),
                                                          Utils
                                                              .mediumHeadingNormalText(
                                                              text: UtilStrings
                                                                  .Delete_Account,
                                                              textSize: 10,
                                                              fontWeight: FontWeight
                                                                  .w400,
                                                              color: Colors
                                                                  .white),

                                                        ],)
                                                        ),
                                                      ),
                                                      context: context),
                                                ],
                                              )),
                                          Container(
                                            color: Colors.grey,
                                            height: 1,
                                          ),
                                        ],
                                      ),
                                      forShortScreen: SizedBox(),
                                      forMobLandScapeMode: SizedBox(),
                                      forMediumScreen: SizedBox(),
                                      forTabletScreen: SizedBox(),
                                      context: context),

                                  selectIndex == 0 ?
                                  Container(
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height,
                                    width: Responsive().getResponsiveValue(
                                        forLargeScreen: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 3.2,
                                        forShortScreen: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 1.2,
                                        forTabletScreen: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 1.2,
                                        forMediumScreen: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 1.4,
                                        forMobLandScapeMode: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 1.4,
                                        context: context),
                                    margin: const EdgeInsets.only(
                                      left: 18, right: 18, top: 60,),
                                    child: Stack(children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          Utils.customTextFeildSetting(context,
                                              UtilStrings.Enter_Old_Password,
                                              UtilStrings.Enter,
                                              oldPasswordController, false,
                                              false),
                                          Gap(20),
                                          Utils.mediumHeadingNormalText(
                                              text: UtilStrings
                                                  .Enter_New_Password,
                                              textSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.black),
                                          CommonPasswordSetting(
                                            hint: "Password",
                                            controller: newPasswordController,
                                            bordercolor: HexColor(
                                                AppColor.settingBorderColor),),
                                          Gap(20),
                                          Utils.mediumHeadingNormalText(
                                              text: UtilStrings
                                                  .Confirm_New_Password,
                                              textSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.black),
                                          CommonPasswordSetting(
                                              hint: "Password",
                                              controller: confirmPasswordController,
                                              bordercolor: HexColor(
                                                  AppColor.settingBorderColor)
                                          ),
                                          Gap(40),
                                          GestureDetector(
                                            onTap: () {
                                              validation(context);
                                            },
                                            child: Center(
                                              child: Container(
                                                height: 44,
                                                width: Responsive()
                                                    .getResponsiveValue(
                                                    forLargeScreen: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width / 4.5,
                                                    forShortScreen: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width / 1.2,
                                                    forTabletScreen: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width / 1.2,
                                                    forMediumScreen: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width / 1.4,
                                                    forMobLandScapeMode: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width / 1.4,
                                                    context: context),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(8)),
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        HexColor("#FF483C"),
                                                        HexColor("#FF2C5A"),
                                                        HexColor("#FF483C"),
                                                        HexColor("#FF2C5A"),
                                                        //add more colors for gradient
                                                      ],
                                                      begin: Alignment.topLeft,
                                                      //begin of the gradient color
                                                      end: Alignment.bottomRight,
                                                      //end of the gradient color
                                                      stops: [
                                                        0,
                                                        0.2,
                                                        0.5,
                                                        0.8
                                                      ] //stops for individual color
                                                    //set the stops number equal to numbers of color
                                                  ),
                                                ),
                                                child: Utils
                                                    .mediumHeadingNormalText(
                                                    text: "Change New Password",
                                                    color: AppColor.white,
                                                    fontFamily: 'Poppins',
                                                    textSize: 13),
                                              ),
                                            ),),
                                        ],),
                                      Utils.progressDialog(context, isLoading,type: 4)
                                    ],),
                                  ) :
                                  selectIndex == 1 ?
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Gap(50),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          Gap(30),
                                          Utils.imageView(
                                              image: "assets/images/referImage.png",
                                              height: size.height / 2,
                                              width: Responsive()
                                                  .getResponsiveValue(
                                                  forShortScreen: size.width /
                                                      1.2,
                                                  forTabletScreen: size.width /
                                                      1.2,
                                                  forMediumScreen: size.width /
                                                      1.2,
                                                  forLargeScreen: size.width /
                                                      4,
                                                  context: context)),
                                        ],
                                      ),
                                      Gap(18),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 30, right: 30),
                                        child: FDottedLine(
                                          strokeWidth: 2.0,
                                          dottedLength: 10.0,
                                          space: 2.0,
                                          corner: FDottedLineCorner.all(10),
                                          color: HexColor(
                                              AppColor.settingBorderColor),
                                          child: SizedBox(
                                            height: Responsive()
                                                .getResponsiveValue(
                                                forLargeScreen: size.height /
                                                    2.6,
                                                forShortScreen: size.height /
                                                    2.4,
                                                forTabletScreen: size.height /
                                                    2.2,
                                                forMediumScreen: size.height /
                                                    2.2,
                                                context: context),
                                            width: Responsive()
                                                .getResponsiveValue(
                                                forLargeScreen: size.width /
                                                    3.4,
                                                forShortScreen: size.width,
                                                forTabletScreen: size.width,
                                                forMediumScreen: size.width,
                                                context: context),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: Responsive()
                                                    .getResponsiveValue(
                                                    forLargeScreen: 12.0,
                                                    forShortScreen: 20.0,
                                                    context: context),
                                                top: Responsive()
                                                    .getResponsiveValue(
                                                    forLargeScreen: 0.0,
                                                    forShortScreen: 0.0,
                                                    context: context),
                                                right: Responsive()
                                                    .getResponsiveValue(
                                                    forLargeScreen: 12.0,
                                                    forShortScreen: 20.0,
                                                    context: context),),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .center,
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center,
                                                children: [
                                                  Gap(12),
                                                  Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8),
                                                      child: Container(
                                                        width: Responsive()
                                                            .getResponsiveValue(
                                                            forLargeScreen: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width / 4,
                                                            forShortScreen: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width / 1.2,
                                                            forTabletScreen: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width / 1.2,
                                                            forMediumScreen: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width / 1.2,
                                                            context: context),
                                                        decoration: BoxDecoration(
                                                            color: HexColor(
                                                                AppColor
                                                                    .settingBorderColor),
                                                            borderRadius: BorderRadius
                                                                .circular(10)
                                                        ),
                                                        child: TextFormField(
                                                          cursorColor: Colors
                                                              .black,
                                                          controller: referController,
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .black),
                                                          decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .circular(
                                                                  8.0),
                                                              borderSide: const BorderSide(
                                                                width: 0,
                                                                style: BorderStyle
                                                                    .none,
                                                              ),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .circular(
                                                                  8.0),
                                                              borderSide: BorderSide(
                                                                width: 0,
                                                                style: BorderStyle
                                                                    .none,
                                                              ),
                                                            ),
                                                            errorBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .circular(
                                                                  8.0),
                                                              borderSide: BorderSide(
                                                                width: 0,
                                                                style: BorderStyle
                                                                    .none,
                                                              ),
                                                            ),
                                                            hintText: "",
                                                            hintStyle: TextStyle(
                                                                fontFamily: "Poppins",
                                                                fontSize: 12,
                                                                color: HexColor(
                                                                    AppColor
                                                                        .textColor)),
                                                          ),
                                                        ),
                                                      )
                                                  ),
                                                  Gap(12),
                                                  Utils.mediumHeadingNormalText(
                                                      text: UtilStrings
                                                          .Refer_to_friends_and_Earn_month_subscription,
                                                      fontFamily: 'Poppins',
                                                      color: AppColor.black,
                                                      textAlign: TextAlign
                                                          .center,
                                                      textSize: 14),
                                                  Gap(12),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .center,
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    children: [
                                                    /*  GestureDetector(
                                                          child: Utils
                                                              .imageView(
                                                              image: "assets/images/icon_fb.png",
                                                              width: 42,
                                                              height: 42)
                                                          *//*ShareButton(shareControllerLinkedIn, "${UtilStrings.Refer_to_5_friends}${widget.referralCode!}.")*//*,
                                                          onTap: () {
                                                            Utils.openUrl(
                                                                "https://www.linkedin.com/feed/");
                                                          }),*/

                                                      Gap(10),

                                                      GestureDetector(
                                                          onTap: () {
                                                            var url = 'https://www.instagram.com/likeplaylikeplaydating_/';
                                                            Utils.openUrl(url);
                                                          },
                                                          child: Utils
                                                              .imageView(
                                                              image: "assets/images/icon_instra.png",
                                                              width: 42,
                                                              height: 42)
                                                        /*ShareButton(shareControllerInsta, "${UtilStrings.Refer_to_5_friends}${widget.referralCode!}.")*/),
                                                      Gap(20),
                                                      GestureDetector(
                                                        child: Utils.imageView(
                                                            image: "assets/images/ic_whatsapp.png",
                                                            width: 42,
                                                            height: 42),
                                                        onTap: () {
                                                          String url = "https://wa.me/?text="+UtilStrings.Refer_to_5_friends+""+SessionManager.getString(Preferences.REFERAL_CODE)+".";
                                                          Utils.openUrl(url);
                                                        },),
                                                      Gap(20),
                                                      GestureDetector(
                                                          onTap: () {
                                                            var url = 'https://twitter.com/LikePlaydating_';
                                                            Utils.openUrl(url);
                                                          },
                                                          child: Utils
                                                              .imageView(
                                                              image: "assets/images/ic_twitter.png",
                                                              width: 42,
                                                              height: 42)),
                                                      Gap(20),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Utils.customDialog(context,message:"Copy");
                                                          Clipboard.setData(
                                                              ClipboardData(
                                                                  text: referController.text));
                                                        },
                                                        child: Utils.imageView(
                                                            image: "assets/images/ic_copy.png",
                                                            width: 42,
                                                            height: 42),)
                                                    ],),
                                                  Gap(18),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .center,
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          // validation(context);
                                                        },
                                                        child: Container(
                                                          height: 46,
                                                          width: 120,
                                                          alignment: Alignment
                                                              .center,
                                                          decoration: const BoxDecoration(
                                                            borderRadius: BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    8)),
                                                            gradient: LinearGradient(
                                                                colors: [
                                                                  Colors
                                                                      .black38,
                                                                  Colors
                                                                      .black26,
                                                                  Colors
                                                                      .black26,
                                                                  Colors.black38
                                                                  //add more colors for gradient
                                                                ],
                                                                begin: Alignment
                                                                    .topLeft,
                                                                //begin of the gradient color
                                                                end: Alignment
                                                                    .bottomRight,
                                                                //end of the gradient color
                                                                stops: [
                                                                  0,
                                                                  0.2,
                                                                  0.5,
                                                                  0.8
                                                                ] //stops for individual color
                                                              //set the stops number equal to numbers of color
                                                            ),
                                                          ),
                                                          child: Utils
                                                              .mediumHeadingNormalText(
                                                              text: "Skip",
                                                              color: AppColor
                                                                  .white,
                                                              fontFamily: 'Poppins',
                                                              textSize: 13),
                                                        ),),
                                                      Gap(12),
                                                      GestureDetector(
                                                        onTap: () {
                                                          // validation(context);
                                                        },
                                                        child: Container(
                                                          height: 46,
                                                          width: 120,
                                                          alignment: Alignment
                                                              .center,
                                                          decoration: const BoxDecoration(
                                                            borderRadius: BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    8)),
                                                            gradient: LinearGradient(
                                                                colors: [
                                                                  Colors
                                                                      .redAccent,
                                                                  Colors
                                                                      .redAccent,
                                                                  Colors
                                                                      .redAccent,
                                                                  Colors
                                                                      .redAccent
                                                                  //add more colors for gradient
                                                                ],
                                                                begin: Alignment
                                                                    .topLeft,
                                                                //begin of the gradient color
                                                                end: Alignment
                                                                    .bottomRight,
                                                                //end of the gradient color
                                                                stops: [
                                                                  0,
                                                                  0.2,
                                                                  0.5,
                                                                  0.8
                                                                ] //stops for individual color
                                                              //set the stops number equal to numbers of color
                                                            ),
                                                          ),
                                                          child: Utils
                                                              .mediumHeadingNormalText(
                                                              text: "Done",
                                                              color: AppColor
                                                                  .white,
                                                              fontFamily: 'Poppins',
                                                              textSize: 13),
                                                        ),),
                                                    ],),
                                                  Gap(Responsive()
                                                      .getResponsiveValue(
                                                      forLargeScreen: 12.0,
                                                      forShortScreen: 32.0,
                                                      context: context)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],) :
                                  selectIndex == 3 ?
                                  SessionManager.getString(Preferences.is_trial)=="true"?
                                  Container(
                                      height: Responsive().getResponsiveValue(
                                          forLargeScreen: MediaQuery.of(context).size.height,
                                          forShortScreen: MediaQuery.of(context).size.height / 1.8,
                                          forTabletScreen: MediaQuery.of(context).size.height / 1.4,
                                          forMediumScreen: MediaQuery.of(context).size.height / 1.6,
                                          context: context),
                                      child: Center(child: Utils.mediumHeadingNormalText(text: "LikePlay-LikePlay free trial is available for 3 days!",textSize: 12,fontWeight: FontWeight.bold,color: Colors.black))):

                                  SessionManager.getString(Preferences.subscription_plan)==""?
                                  Container(
                                     height: Responsive().getResponsiveValue(
                                          forLargeScreen: MediaQuery.of(context).size.height,
                                          forShortScreen: MediaQuery.of(context).size.height / 1.8,
                                          forTabletScreen: MediaQuery.of(context).size.height / 1.4,
                                          forMediumScreen: MediaQuery.of(context).size.height / 1.6,
                                          context: context),
                                      child: Center(child: Utils.mediumHeadingNormalText(text: "No Subscription!",textSize: 12,fontWeight: FontWeight.bold,color: Colors.black))):
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:  EdgeInsets.only(
                                            left: Responsive().getResponsiveValue(
                                                forLargeScreen: 42.0,
                                                forShortScreen: 20.0,
                                                forTabletScreen:20.0,
                                                forMediumScreen:  20.0,
                                                forMobLandScapeMode:  20.0,
                                                context: context), right: Responsive().getResponsiveValue(
                                             forLargeScreen: 42.0,
                                             forShortScreen: 20.0,
                                             forTabletScreen:20.0,
                                             forMediumScreen:  20.0,
                                             forMobLandScapeMode:  20.0,
                                             context: context), top: 32.0),
                                        child: Utils.mediumHeadingNormalText(
                                            text: UtilStrings.Plan_details,
                                            textSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.black),
                                      ),
                                      Container(
                                          margin:  EdgeInsets.only(
                                              left: Responsive().getResponsiveValue(
                                                forLargeScreen: 42.0,
                                                forShortScreen: 20.0,
                                                forTabletScreen:20.0,
                                                forMediumScreen:  20.0,
                                                forMobLandScapeMode:  20.0,
                                                context: context), right: Responsive().getResponsiveValue(
                                                forLargeScreen: 42.0,
                                                forShortScreen: 20.0,
                                                forTabletScreen:20.0,
                                                forMediumScreen:  20.0,
                                                forMobLandScapeMode:  20.0,
                                                context: context), top: 20,bottom:20),
                                          padding: EdgeInsets.all(18),
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          color: HexColor("#F0F0F0"),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Utils.imageView(
                                                          image: "assets/images/ic_diamond.png",
                                                          height: 42,
                                                        width: 42,color: SessionManager.getString(Preferences.subscription_plan)=="1"?Colors.grey
                                                        :SessionManager.getString(Preferences.subscription_plan).toString()=="2"?HexColor("#A8580F")
                                                        :SessionManager.getString(Preferences.subscription_plan)=="3"?HexColor("#F5C553")
                                                          :HexColor("#FF483C")
                                                        ),
                                                      Gap(18),
                                                      Utils.mediumHeadingNormalText(
                                                          text:SessionManager.getString(Preferences.subscription_plan)=="1"?UtilStrings.BASIC
                                                              :SessionManager.getString(Preferences.subscription_plan).toString()=="2"?UtilStrings.Standard
                                                              :SessionManager.getString(Preferences.subscription_plan)=="3"?UtilStrings.GOLD
                                                              : UtilStrings.PLATINUM,
                                                          textSize: 14,
                                                          fontWeight: FontWeight
                                                              .w500,
                                                          color: AppColor
                                                              .black),
                                                    ],
                                                  ),
                                                  Container(
                                                    width: Responsive()
                                                        .getResponsiveValue(
                                                        forLargeScreen: size
                                                            .width / 4,
                                                        forShortScreen: size
                                                            .width / 4,
                                                        forTabletScreen: size
                                                            .width / 4,
                                                        forMediumScreen: size
                                                            .width / 4,
                                                        context: context),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .end,
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .end,
                                                      children: [
                                                        Utils
                                                            .mediumHeadingNormalText(
                                                            text: "\$"+SessionManager.getString(Preferences.plan_ammount),
                                                            textSize: 14,
                                                            fontWeight: FontWeight
                                                                .w500,
                                                            color: HexColor(
                                                                AppColor
                                                                    .RedColor)),
                                                        Utils
                                                            .mediumHeadingNormalText(
                                                            text: UtilStrings
                                                                .Pack_Valid_Till_Date+Utils.convertDateTimeSub(SessionManager.getString(Preferences.subscription_end_date)),
                                                            textSize: 14,
                                                            fontWeight: FontWeight
                                                                .w500,
                                                            color: AppColor
                                                                .nonselectedamenetycolor,
                                                            textAlign: TextAlign
                                                                .end),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Divider(
                                                thickness: 0.5,
                                                color: AppColor
                                                    .nonselectedamenetycolor,
                                              ),
                                                  SessionManager.getString(Preferences.subscription_plan)=="1"?
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    children: [
                                                      Gap(20),
                                                      Utils.customSubscription(
                                                          "Complimentary: 5 Free Days upon Sign-Up",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Unlimited Post on Take the FLOOR",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Unlimited Post on Take the MIC",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Super User Badge",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Favorites", context),
                                                      Utils.customSubscription(
                                                          "Chat Option", context),
                                                      Utils.customSubscriptionText(
                                                          "Admire/Be Admired",
                                                          "2/DAY"),
                                                      Utils.customSubscriptionText(
                                                          "Audio Voice-Note Messages",
                                                          "Nil"),
                                                      Utils.customSubscriptionText(
                                                          "Video", "Nil"),
                                                      Utils.customSubscriptionText(
                                                          "Picture Upload",
                                                          "1 PHOTO"),
                                                      Utils.customSubscriptionText(
                                                          "Opening Matches",
                                                          "5 MATCHES"),
                                                      Utils.customSubscriptionText(
                                                          "Matches Update/Day",
                                                          "1/DAY"),
                                                      Utils.customSubscriptionText(
                                                          "Admired/Day", "1/DAY"),
                                                    ],
                                                  )
                                                  :SessionManager.getString(Preferences.subscription_plan).toString()=="2"?
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    children: [
                                                      Gap(20),
                                                      Utils.customSubscription(
                                                          "Complimentary: 5 Free Days upon Sign-Up",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Unlimited Post on Take the FLOOR",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Unlimited Post on Take the MIC",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Super User Badge",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Favorites", context),
                                                      Utils.customSubscription(
                                                          "Chat Option", context),
                                                      Utils.customSubscription(
                                                          "Admire/Be Admired", context),
                                                      Utils.customSubscriptionText(
                                                          "Audio Voice-Note Messages",
                                                          "Nil"),
                                                      Utils.customSubscriptionText(
                                                          "Video", "Nil"),
                                                      Utils.customSubscriptionText(
                                                          "Picture Upload",
                                                          "3 Photos"),
                                                      Utils.customSubscriptionText(
                                                          "Opening Matches",
                                                          "10 Matches"),
                                                      Utils.customSubscriptionText(
                                                          "Matches Update/Day",
                                                          "3/Day"),
                                                      Utils.customSubscriptionText(
                                                          "Admired/Day", "2/Day"),
                                                    ],
                                                  )
                                                  :SessionManager.getString(Preferences.subscription_plan)=="3"?
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    children: [
                                                      Gap(20),
                                                      Utils.customSubscription(
                                                          "Complimentary: 5 Free Days upon Sign-Up",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Unlimited Post on Take the FLOOR",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Unlimited Post on Take the MIC",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Super User Badge",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Favorites", context),
                                                      Utils.customSubscription(
                                                          "Chat Option", context),
                                                      Utils.customSubscription(
                                                          "Admire/Be Admired", context),
                                                      Utils.customSubscription(
                                                          "Audio Voice-Note Messages",
                                                          context),
                                                      Utils.customSubscriptionText(
                                                          "Video", "Nil"),
                                                      Utils.customSubscriptionText(
                                                          "Picture Upload",
                                                          ""),
                                                      Utils.customSubscriptionText(
                                                          "Opening Matches",
                                                          "15 Matches"),
                                                      Utils.customSubscriptionText(
                                                          "New Matches Update/Day",
                                                          "4/DAY"),
                                                      Utils.customSubscriptionText(
                                                          "Admired/Day", "3/Day"),
                                                    ],
                                                  )
                                                  :Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    children: [
                                                      Gap(20),
                                                      Utils.customSubscription(
                                                          "Complimentary: 5 Free Days upon Sign-Up",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Unlimited Post on Take the FLOOR",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Unlimited Post on Take the MIC",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Super User Badge",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Favorites", context),
                                                      Utils.customSubscription(
                                                          "Chat Option", context),
                                                      Utils.customSubscription(
                                                          "Admire/Be Admired",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Audio Voice-Note Messages",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Video", context),
                                                      Utils.customSubscriptionText(
                                                          "Picture Upload",
                                                          "5 Photos"),
                                                      Utils.customSubscriptionText(
                                                          "Opening Matches",
                                                          "20 Matches"),
                                                      Utils.customSubscriptionText(
                                                          "New Matches Update/Day",
                                                          "5/Day"),
                                                      Utils.customSubscriptionText(
                                                          "Admired/Day", "5/Day"),
                                                    ],
                                                  )

                                            ],
                                          )
                                      ),
                                      GestureDetector(
                                          onTap:
                                              (  ) {
                                           /* setState(() {
                                              isLoading=true;
                                            });
                                           settingPresenter?.doCancelSubscription();
*/

                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SubscriptionMobileScreen(comesFrom: "UpgradeView",)));
                                          },
                                          child: Center(
                                            child:Container(
                                              height:44,
                                              width:Responsive().getResponsiveValue(
                                                  forLargeScreen: MediaQuery.of(context).size.width/6,
                                                  forShortScreen: MediaQuery.of(context).size.width/1.4,
                                                  forTabletScreen: MediaQuery.of(context).size.width/1.4,
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
                                                  text: "Upgrade Subscription",
                                                  color: AppColor.white,
                                                  fontFamily: 'Poppins',
                                                  textSize: 13),
                                            ),)
                                      )
                                    ],) :
                                  selectIndex ==2 ?  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:  EdgeInsets.only(
                                            left: Responsive().getResponsiveValue(
                                                    forLargeScreen: 42.0,
                                                    forShortScreen: 20.0,
                                                    forTabletScreen:20.0,
                                                    forMediumScreen:  20.0,
                                                    forMobLandScapeMode:  20.0,
                                                    context: context), right: Responsive().getResponsiveValue(
                                                    forLargeScreen: 42.0,
                                                    forShortScreen: 20.0,
                                                    forTabletScreen:20.0,
                                                    forMediumScreen:  20.0,
                                                    forMobLandScapeMode:  20.0,
                                                    context: context), top: 32),
                                        child: Utils.mediumHeadingNormalText(
                                            text: UtilStrings.Blocked_Users,
                                            textSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.APP_TEXT_COLOR),
                                      ),
                                      Container(
                                        height: MediaQuery
                                            .of(context)
                                            .size
                                            .height,
                                        margin:  EdgeInsets.only(
                                          left: Responsive().getResponsiveValue(
                                                    forLargeScreen: 42.0,
                                                    forShortScreen: 20.0,
                                                    forTabletScreen:20.0,
                                                    forMediumScreen:  20.0,
                                                    forMobLandScapeMode:  20.0,
                                                    context: context), right: Responsive().getResponsiveValue(
                                                    forLargeScreen: 42.0,
                                                    forShortScreen: 20.0,
                                                    forTabletScreen:20.0,
                                                    forMediumScreen:  20.0,
                                                    forMobLandScapeMode:  20.0,
                                                    context: context), top: 10,),
                                        child: Stack(children: [
                                          Container(
                                            padding: EdgeInsets.all(12),
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height,
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                            color: HexColor("#F0F0F0"),
                                            child: blockList.isNotEmpty?ListView.builder(
                                              shrinkWrap: false,
                                              scrollDirection: Axis.vertical,
                                              itemCount: blockList.length,
                                              itemBuilder: (BuildContext context,
                                                  int index) {
                                                return Column(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .start,
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .start,
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 32,
                                                          height: 32,
                                                          child:  CachedNetworkImage(
                                                            imageUrl:blockList[index].blockTo!.userImagesWhileSignup!.isNotEmpty?IMAGE_URL+blockList[index].blockTo!.userImagesWhileSignup![0].imageUrl.toString():"",
                                                            imageBuilder: (context, imageProvider) => Container(
                                                                decoration: BoxDecoration(
                                                                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                                                                  image: DecorationImage(
                                                                    image:imageProvider,
                                                                    fit: BoxFit.fill,
                                                                  ),
                                                                )),
                                                            placeholder: (context, url) =>  const Image(image: AssetImage("assets/images/icon_loading.png")),
                                                            errorWidget: (context, url, error) =>   const Image(image: AssetImage("assets/images/icon_loading.png")),
                                                            width: 32,
                                                            height: 32,
                                                          ),
                                                        ),
                                                        const Gap(10),
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .start,
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Utils
                                                                .mediumHeadingNormalText(
                                                                text: blockList[index].blockTo!.userName,
                                                                textSize: 14,
                                                                textAlign: TextAlign.center,
                                                                fontWeight: FontWeight
                                                                    .w500,
                                                                color: AppColor
                                                                    .APP_TEXT_COLOR),
                                                          ],
                                                        ),
                                                        const Spacer(),
                                                        GestureDetector(
                                                          onTap: (){
                                                            setState(() {
                                                              isLoading=true;
                                                              reciverId=blockList[index].blockTo!.id.toString();
                                                              senderId=blockList[index].blockBy!.toString();
                                                              settingPresenter?.doBlockPost(blockList[index].blockTo!.id.toString(), true);
                                                            });
                                                          },
                                                          child: Container(
                                                          height: 32,
                                                          width: 80,
                                                          padding: EdgeInsets.all(
                                                              8),
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius
                                                                .circular(8),
                                                            color: HexColor(
                                                                '#FF483C'),
                                                          ),
                                                          child: Center(child:
                                                          Utils
                                                              .mediumHeadingNormalText(
                                                              text: UtilStrings
                                                                  .Unblock,
                                                              textSize: 10,
                                                              fontWeight: FontWeight
                                                                  .w400,
                                                              color: Colors
                                                                  .white),
                                                          ),
                                                        ),),
                                                        const Gap(10),
                                                      ],
                                                    ),
                                                    const Gap(10),
                                                  ],
                                                );
                                              },

                                            ):Container(
                                              height: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height,
                                              alignment: Alignment.center,
                                              child: Utils.mediumHeadingNormalText(
                                                  text: UtilStrings.NO_RECORD,
                                                  textSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.black,
                                                  textAlign: TextAlign.end),
                                            ),
                                          ),
                                          Utils.progressDialog(context, isLoading,type: 4)
                                        ])
                                      ),
                                    ],):
                                  Stack(
                                    children: [
                                      SessionManager.getString(Preferences.is_trial)=="true"?
                                      Container(
                                          height: Responsive().getResponsiveValue(
                                              forLargeScreen: MediaQuery.of(context).size.height,
                                              forShortScreen: MediaQuery.of(context).size.height / 1.8,
                                              forTabletScreen: MediaQuery.of(context).size.height / 1.4,
                                              forMediumScreen: MediaQuery.of(context).size.height / 1.6,
                                              context: context),
                                          child: Center(child: Utils.mediumHeadingNormalText(text: "LikePlay-LikePlay free trial is available for 3 days!",textSize: 12,fontWeight: FontWeight.bold,color: Colors.black))):
                                      SessionManager.getString(Preferences.subscription_plan)==""?
                                      Container(
                                          height: Responsive().getResponsiveValue(
                                              forLargeScreen: MediaQuery.of(context).size.height,
                                              forShortScreen: MediaQuery.of(context).size.height / 1.8,
                                              forTabletScreen: MediaQuery.of(context).size.height / 1.4,
                                              forMediumScreen: MediaQuery.of(context).size.height / 1.6,
                                              context: context),
                                          child: Center(child: Utils.mediumHeadingNormalText(text: "No Subscription!",textSize: 12,fontWeight: FontWeight.bold,color: Colors.black))):
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:  EdgeInsets.only(
                                                left: Responsive().getResponsiveValue(
                                                    forLargeScreen: 42.0,
                                                    forShortScreen: 20.0,
                                                    forTabletScreen:20.0,
                                                    forMediumScreen:  20.0,
                                                    forMobLandScapeMode:  20.0,
                                                    context: context), right: Responsive().getResponsiveValue(
                                                forLargeScreen: 42.0,
                                                forShortScreen: 20.0,
                                                forTabletScreen:20.0,
                                                forMediumScreen:  20.0,
                                                forMobLandScapeMode:  20,
                                                context: context), top: 32),
                                            child: Utils.mediumHeadingNormalText(
                                                text: UtilStrings.Plan_details,
                                                textSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.black),
                                          ),
                                          Container(
                                              margin:  EdgeInsets.only(
                                                  left:  Responsive().getResponsiveValue(
                                                    forLargeScreen: 42.0,
                                                    forShortScreen: 20.0,
                                                    forTabletScreen:20.0,
                                                    forMediumScreen:  20.0,
                                                    forMobLandScapeMode:  20.0,
                                                    context: context), right:  Responsive().getResponsiveValue(
                                                    forLargeScreen: 42.0,
                                                    forShortScreen: 20.0,
                                                    forTabletScreen:20.0,
                                                    forMediumScreen:  20.0, 
                                                    forMobLandScapeMode:  20.0,
                                                    context: context), top: 20,bottom:20),
                                              padding: EdgeInsets.all(18),
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width,
                                              color: HexColor("#F0F0F0"),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Utils.imageView(
                                                              image: "assets/images/ic_diamond.png",
                                                              height: 42,
                                                              width: 42,color: SessionManager.getString(Preferences.subscription_plan)=="1"?Colors.grey
                                                              :SessionManager.getString(Preferences.subscription_plan).toString()=="2"?HexColor("#A8580F")
                                                              :SessionManager.getString(Preferences.subscription_plan)=="3"?HexColor("#F5C553")
                                                              :HexColor("#FF483C")
                                                          ),
                                                          Gap(18),
                                                          Utils.mediumHeadingNormalText(
                                                              text:SessionManager.getString(Preferences.subscription_plan)=="1"?UtilStrings.BASIC
                                                                  :SessionManager.getString(Preferences.subscription_plan).toString()=="2"?UtilStrings.Standard
                                                                  :SessionManager.getString(Preferences.subscription_plan)=="3"?UtilStrings.GOLD
                                                                  : UtilStrings.PLATINUM,
                                                              textSize: 14,
                                                              fontWeight: FontWeight
                                                                  .w500,
                                                              color: AppColor
                                                                  .black),
                                                        ],
                                                      ),
                                                      Container(
                                                        width: Responsive()
                                                            .getResponsiveValue(
                                                            forLargeScreen: size
                                                                .width / 4,
                                                            forShortScreen: size
                                                                .width / 4,
                                                            forTabletScreen: size
                                                                .width / 4,
                                                            forMediumScreen: size
                                                                .width / 4,
                                                            context: context),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .end,
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .end,
                                                          children: [
                                                            Utils
                                                                .mediumHeadingNormalText(
                                                                text: "\$"+SessionManager.getString(Preferences.plan_ammount),
                                                                textSize: 14,
                                                                fontWeight: FontWeight
                                                                    .w500,
                                                                color: HexColor(
                                                                    AppColor
                                                                        .RedColor)),
                                                            Utils
                                                                .mediumHeadingNormalText(
                                                                text: UtilStrings
                                                                    .Pack_Valid_Till_Date,
                                                                textSize: 14,
                                                                fontWeight: FontWeight
                                                                    .w500,
                                                                color: AppColor
                                                                    .nonselectedamenetycolor,
                                                                textAlign: TextAlign
                                                                    .end),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Divider(
                                                    thickness: 0.5,
                                                    color: AppColor
                                                        .nonselectedamenetycolor,
                                                  ),
                                                  SessionManager.getString(Preferences.subscription_plan)=="1"?
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    children: [
                                                      Gap(20),
                                                      Utils.customSubscription(
                                                          "Complimentary: 5 Free Days upon Sign-Up",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Unlimited Post on Take the FLOOR",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Unlimited Post on Take the MIC",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Super User Badge",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Favorites", context),
                                                      Utils.customSubscription(
                                                          "Chat Option", context),
                                                      Utils.customSubscriptionText(
                                                          "Admire/Be Admired",
                                                          "2/DAY"),
                                                      Utils.customSubscriptionText(
                                                          "Audio Voice-Note Messages",
                                                          "Nil"),
                                                      Utils.customSubscriptionText(
                                                          "Video", "Nil"),
                                                      Utils.customSubscriptionText(
                                                          "Picture Upload",
                                                          "1 PHOTO"),
                                                      Utils.customSubscriptionText(
                                                          "Opening Matches",
                                                          "5 MATCHES"),
                                                      Utils.customSubscriptionText(
                                                          "Matches Update/Day",
                                                          "1/DAY"),
                                                      Utils.customSubscriptionText(
                                                          "Admired/Day", "1/DAY"),
                                                    ],
                                                  )
                                                      :SessionManager.getString(Preferences.subscription_plan).toString()=="2"?
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    children: [
                                                      Gap(20),
                                                      Utils.customSubscription(
                                                          "Complimentary: 5 Free Days upon Sign-Up",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Unlimited Post on Take the FLOOR",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Unlimited Post on Take the MIC",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Super User Badge",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Favorites", context),
                                                      Utils.customSubscription(
                                                          "Chat Option", context),
                                                      Utils.customSubscription(
                                                          "Admire/Be Admired", context),
                                                      Utils.customSubscriptionText(
                                                          "Audio Voice-Note Messages",
                                                          "Nil"),
                                                      Utils.customSubscriptionText(
                                                          "Video", "Nil"),
                                                      Utils.customSubscriptionText(
                                                          "Picture Upload",
                                                          "3 Photos"),
                                                      Utils.customSubscriptionText(
                                                          "Opening Matches",
                                                          "10 Matches"),
                                                      Utils.customSubscriptionText(
                                                          "Matches Update/Day",
                                                          "3/Day"),
                                                      Utils.customSubscriptionText(
                                                          "Admired/Day", "2/Day"),
                                                    ],
                                                  )
                                                      :SessionManager.getString(Preferences.subscription_plan)=="3"?
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    children: [
                                                      Gap(20),
                                                      Utils.customSubscription(
                                                          "Complimentary: 5 Free Days upon Sign-Up",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Unlimited Post on Take the FLOOR",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Unlimited Post on Take the MIC",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Super User Badge",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Favorites", context),
                                                      Utils.customSubscription(
                                                          "Chat Option", context),
                                                      Utils.customSubscription(
                                                          "Admire/Be Admired", context),
                                                      Utils.customSubscription(
                                                          "Audio Voice-Note Messages",
                                                          context),
                                                      Utils.customSubscriptionText(
                                                          "Video", "Nil"),
                                                      Utils.customSubscriptionText(
                                                          "Picture Upload",
                                                          ""),
                                                      Utils.customSubscriptionText(
                                                          "Opening Matches",
                                                          "15 Matches"),
                                                      Utils.customSubscriptionText(
                                                          "New Matches Update/Day",
                                                          "4/DAY"),
                                                      Utils.customSubscriptionText(
                                                          "Admired/Day", "3/Day"),
                                                    ],
                                                  )
                                                      :Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    children: [
                                                      Gap(20),
                                                      Utils.customSubscription(
                                                          "Complimentary: 5 Free Days upon Sign-Up",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Unlimited Post on Take the FLOOR",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Unlimited Post on Take the MIC",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Super User Badge",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Favorites", context),
                                                      Utils.customSubscription(
                                                          "Chat Option", context),
                                                      Utils.customSubscription(
                                                          "Admire/Be Admired",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Audio Voice-Note Messages",
                                                          context),
                                                      Utils.customSubscription(
                                                          "Video", context),
                                                      Utils.customSubscriptionText(
                                                          "Picture Upload",
                                                          "5 Photos"),
                                                      Utils.customSubscriptionText(
                                                          "Opening Matches",
                                                          "20 Matches"),
                                                      Utils.customSubscriptionText(
                                                          "New Matches Update/Day",
                                                          "5/Day"),
                                                      Utils.customSubscriptionText(
                                                          "Admired/Day", "5/Day"),
                                                    ],
                                                  )
                                                ],
                                              )
                                          ),
                                                  GestureDetector(
                                            onTap:
                                          (  ) {
                              setState(() {
                              isLoading=true;
                              });
                              settingPresenter?.doCancelSubscription();

                              },
                                              child: Center(
                                              child:Container(
                                                height:44,
                                                width:Responsive().getResponsiveValue(
                                                    forLargeScreen: MediaQuery.of(context).size.width/6,
                                                    forShortScreen: MediaQuery.of(context).size.width/1.4,
                                                    forTabletScreen: MediaQuery.of(context).size.width/1.4,
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
                                                    text: "Cancel Subscription",
                                                    color: AppColor.white,
                                                    fontFamily: 'Poppins',
                                                    textSize: 13),
                                              ),)
                                          )
                                        ],),
                                      Utils.progressDialog(context, isLoading,type: 4)
                                    ],
                                  )
                                ],
                              ),
                              ),
                            ],
                          ),
                          Gap(20),
                        ],
                      ),
                    )
                  ],
                ),)
              ],
            ),
          ),
        ),
      ),);
  }

  dynamicUiChange(int index) {
    for (int i = 0; i < featuresList.length; i++) {
      if (i == index) {
        setState(() {
          featuresList[i].value = true;
        });
      } else {
        setState(() {
          featuresList[i].value = false;
        });
      }
    }
  }

  void validation(BuildContext context) {
    if (oldPasswordController.text
        .trim()
        .isEmpty) {
      Utils.customDialog(context,message:UtilStrings.ENTER_YOUR_OLD_PASSWORD);
    }
    else if (newPasswordController.text
        .trim()
        .isEmpty) {
      Utils.customDialog(context,message:UtilStrings.ENTER_YOUR_NEW_PASSWORD);
    } else if (confirmPasswordController.text
        .trim()
        .isEmpty) {
      Utils.customDialog(context,message:UtilStrings.ENTER_YOUR_CONFIRM_PASSWORD);
    } else if (confirmPasswordController.text.toString() !=
        newPasswordController.text) {
      Utils.customDialog(context,message:UtilStrings.NOT_MATCH);
    } else {
      //Api call
      setState(() {
        isLoading=true;
      });
      settingPresenter?.doChangePWD(oldPasswordController.text.toString().trim(),confirmPasswordController.text.toString().trim());
    }

  }

  @override
  onChangePWD(SuccessResponse response) {
    setState(() {
      isLoading = false;
      if(response.status==200){
        Utils.customDialog(context,message:response.message.toString());
        oldPasswordController.text="";
        confirmPasswordController.text="";
        newPasswordController.text="";
      }
    });
  }

  @override
  onError(String msg, int status) {
    print("onError==>"+msg);
   setState(() {
     isLoading=false;
   });
   if(status==400) {
     Utils.customDialog(context,message:msg);
   }
  else if(status==401){
     Utils.sessionExpire(context);
   }
  }

  showAlertDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
          contentPadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          actions: [
            Container(
              alignment: Alignment.center,
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
                  forTabletScreen: MediaQuery.of(context).size.width/2.2,
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
                      child: Utils.mediumHeadingNormalText(text:UtilStrings.delete_account,textSize: 16,fontWeight: FontWeight.bold,color: HexColor("#242424")),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  /* Container(
                    alignment: Alignment.center,
                      width:  Responsive().getResponsiveValue(
                          forLargeScreen: MediaQuery.of(context).size.width/4.5,
                          forShortScreen: MediaQuery.of(context).size.width/1.6,
                          forTabletScreen: MediaQuery.of(context).size.width/1.6,
                          forMediumScreen:  MediaQuery.of(context).size.width/1.6,
                          context: context),
                      child:*/Center(
                    child:Utils.mediumHeadingNormalText(text:UtilStrings.want_to_delete_account,textSize: 12,fontWeight: FontWeight.normal,color: HexColor("#7B7F91"),textAlign: TextAlign.center),
                    // )
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child:Container(
                              width: 120,
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(top: 30.0,bottom: 20),
                              decoration: BoxDecoration(
                                color: HexColor("#F0F0F0"),
                                borderRadius: BorderRadius.circular(8),/*
                                border: Border.all(color: HexColor("#FF483C"))*/
                              ),
                              child: Text("Cancel",textAlign:TextAlign.center,style: TextStyle(color: Colors.black),),
                            )),
                        SizedBox(width: 12,),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              isLoading=true;
                              settingPresenter?.doDeleteAccountView();
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 120,
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.only(top: 30.0,bottom: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: HexColor("#FF483C"),
                            ),
                            child: Text("Yes",textAlign:TextAlign.center,style: TextStyle(color: Colors.white),),
                          ),
                        ),
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

  @override
  onBlockList(BlockResponse response) {
    setState(() {
      isLoading = false;
      blockList.clear();
      if(response.status==200){
        blockList.addAll(response.data!);
      }
    });
  }

  @override
  onDeleteAccount(SuccessResponse response) {
    setState(() {
      isLoading = false;
      if(response.status==200){
        Utils.customDialog(context,message:response.message.toString());
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
          viewType:0,
        )));
      }
    });
  }

  @override
  onBlockPost(SuccessResponse response) {
    setState(() {
      isLoading = false;
      blockList.clear();
      if(response.status==200){
        Utils.customDialog(context,message:response.message.toString());
        _authService.updateBlockStatus(senderId, reciverId, false);
        settingPresenter?.doBlockList();
      }
    });
  }

  @override
  onCancelSubscription(CancelSubscriptionResponse response) {
    setState(() {
      isLoading = false;
      if(response.status==200){
        Utils.customDialog(context,message:response.message.toString());
      }
    });
    settingPresenter!.doUserResponseData("");
  }

  @override
  onProfileResponse(UserProfileResponse response) {
    if(response.status==200){
      //Utils.customDialog(response.message!);
      SessionManager.setString(Preferences.USER_NAME, response.data!.name.toString());
      SessionManager.setString(Preferences.EMAIL, response.data!.email.toString());
      SessionManager.setString(Preferences.REFERAL_CODE, response.data!.referCode.toString());
      SessionManager.setString(Preferences.USER_ID, response.data!.id.toString());
      SessionManager.setString(Preferences.CHOOSE_ANY_ONE, response.data!.chooseAnyOne.toString());
      SessionManager.setString(Preferences.PROFILE_IMAGE, response.data!.userImagesWhileSignup!.isNotEmpty?response.data!.userImagesWhileSignup![0].imageUrl.toString():"");
      SessionManager.setString(Preferences.INDEX,"0");
      SessionManager.setString(Preferences.profileStatus,response.data!.profileStatus.toString());
      SessionManager.setString(Preferences.verification_status,response.data!.userVerification.toString());
      SessionManager.setString(Preferences.government_status, "");
      SessionManager.setString(Preferences.phone_status, "");
      SessionManager.setString(Preferences.pose_status, "");
      SessionManager.setString(Preferences.facebook_status, "");
      SessionManager.setString(Preferences.subscription_status, response.data!.subscriptionStatus.toString());
      //1=> Basic ,2=> Standard ,3=> Gold ,4=>Platinum
      // subscription type(1,2,3,4) 1 : basic, 2:standard, 3:gold, 4:platinum
      if(response.data!.subscriptionStatus==false && response.data!.subscriptions!.isEmpty){
        SessionManager.setString(Preferences.subscription_plan, "");
        SessionManager.setString(Preferences.plan_ammount, "");
        SessionManager.setString(Preferences.plan_id, "");
      }else
      if(response.data!.subscriptionStatus==true && response.data!.subscriptions!.isNotEmpty){
        SessionManager.setString(Preferences.subscription_plan, response.data!.subscriptions![0].supscriptionType.toString());
        SessionManager.setString(Preferences.plan_ammount, response.data!.subscriptions![0].amount.toString());
        SessionManager.setString(Preferences.plan_id, response.data!.subscriptions![0].productId.toString());
      }else{
        SessionManager.setString(Preferences.subscription_plan, "");
        SessionManager.setString(Preferences.plan_ammount, "");
        SessionManager.setString(Preferences.plan_id, "");
      }
  }
}

  @override
  onReportResponse(SuccessResponse response) {

  }

  @override
  onRequestError(String msg, int status) {

  }

  @override
  onSendRequest(SuccessResponse response) {

  }

  @override
  onSendRemoveRequest(SuccessResponse response) {

  }}