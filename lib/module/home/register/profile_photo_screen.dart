import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/module/home/home.dart';
import 'package:likeplay/module/home/register/presenter/profile_update_presenter.dart';
import 'package:likeplay/module/model/photo_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import 'package:likeplay/module/model/update_profile_response.dart';
import 'package:likeplay/module/model/user_profile_response.dart';
import 'package:likeplay/utils/color_utils.dart';
import 'package:likeplay/utils/constant_lists.dart';
import 'package:likeplay/utils/responsive.dart';
import 'package:likeplay/utils/string_utils.dart';
import 'package:likeplay/utils/utils.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../../../utils/firebase/authentication_service.dart';
import '../../model/phone_verification_response.dart';
import '../../../utils/sharedpref/preferences.dart';
import '../../../utils/sharedpref/shared_prefrence.dart';

class ProfilePhotoUsScreen extends StatefulWidget {
  int? viewType;
  String? comesFrom;

  ProfilePhotoUsScreen({Key? key, this.viewType, this.comesFrom})
      : super(key: key);

  @override
  State<ProfilePhotoUsScreen> createState() => _ProfilePhotoUsScreenState();
}

class _ProfilePhotoUsScreenState extends State<ProfilePhotoUsScreen>
    implements ProfileUpdateInterface {
  TextEditingController aboutUsController = TextEditingController();
  String status = "";
  String education = "";
  ProfileUpdatePresenter? profileUpdatePresenter;
  var listImage = ["", "", "", "", ""];
  var listImageID = ["", "", "", "", ""];
  var show;
  bool isLoading = false;
  PlatformFile? importFile;
  String fileName = "null";
  String fileType = "null";
  int selectIndex = 0;
  int selectValue = 0;
  int removeindex = 0;

  @override
  void initState() {
    profileUpdatePresenter = ProfileUpdatePresenter(this);
    if (widget.comesFrom == "EditProfile" ||
        widget.comesFrom == "EditFromProfile") {
      var listImageTemp = ["", "", "", "", ""];
      var listImageIDTemp = ["", "", "", "", ""];
      setState(() {
        listImageTemp = SessionManager.getStringList(Preferences.IMAGE_LIST);
        listImageIDTemp = SessionManager.getStringList(Preferences.IMAGE_ID);
        for (int i = 0; i < listImageTemp.length; i++) {
          listImage.insert(i, listImageTemp[i].toString());
          listImageID.insert(i, listImageIDTemp[i].toString());
        }
      });
    }
    super.initState();
  }
  final _authService = AuthenticationService();
  Future<bool> _onWillPop() async {
    bool value;
    if(widget.comesFrom=="EditProfile"){
      if(listImage.toString()=="[, , , , , ]"){
        value=false;
        Utils.customDialog(context,message:UtilStrings.please_upload_your_image);
      }else{
        value=true;
        Navigator.pop(context);
      }
    }else if(widget.comesFrom=="EditFromProfile"){
      if(listImage.toString()=="[, , , , , ]"){
        value=false;
        Utils.customDialog(context,message:UtilStrings.please_upload_your_image);
      }else{
        value=true;
        Navigator.pop(context);
      }
    }else{
      value=true;
      Navigator.pop(context);
    }
  return value;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: WillPopScope(
          onWillPop: _onWillPop,
          child: Stack(
      children: [
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
                      rowFlex: 2,
                      child: Row(
                        mainAxisAlignment: Responsive().getResponsiveValue(
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
                              Gap(
                                Responsive().getResponsiveValue(
                                    forLargeScreen: 0.0,
                                    forShortScreen: 8.0,
                                    context: context),
                              ),
                            ],
                          )
                        ],
                      )),
                  ResponsiveRowColumnItem(
                    rowFlex: 1,
                    child: SizedBox(
                      /*  height:  Responsive().getResponsiveValue(
                          forLargeScreen: MediaQuery.of(context).size.height,
                          forShortScreen: MediaQuery.of(context).size.height,
                          forMobLandScapeMode: MediaQuery.of(context).size.height/1.2,
                          forMediumScreen: MediaQuery.of(context).size.height/1.2,
                          forTabletScreen: MediaQuery.of(context).size.height,
                          context: context),*/
                      width: Responsive().getResponsiveValue(
                          forLargeScreen: MediaQuery.of(context).size.width / 1.2,
                          forShortScreen: MediaQuery.of(context).size.width,
                          forMobLandScapeMode:
                              MediaQuery.of(context).size.width / 2,
                          forMediumScreen: MediaQuery.of(context).size.width / 2,
                          forTabletScreen: MediaQuery.of(context).size.width / 2,
                          context: context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Gap(Responsive().getResponsiveValue(
                              forLargeScreen: 32.0,
                              forShortScreen: 22.0,
                              context: context)),
                          widget.comesFrom == "EditProfile" ||
                                  widget.comesFrom == "EditFromProfile"
                              ? Container()
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Utils.mediumHeadingNormalText(
                                        text: UtilStrings.seven_Complete,
                                        fontFamily: 'Poppins',
                                        color: AppColor.white,
                                        left: Responsive().getResponsiveValue(
                                            forLargeScreen: 64.0,
                                            forShortScreen: 22.0,
                                            forMobLandScapeMode: 22.0,
                                            forMediumScreen: 22.0,
                                            forTabletScreen: 22.0,
                                            context: context),
                                        textSize: 12),
                                  ],
                                ),
                          Gap(4),
                          widget.comesFrom == "EditProfile" ||
                                  widget.comesFrom == "EditFromProfile"
                              ? Container()
                              : Image.asset(
                                  'assets/images/seven_step.png',
                                  width: Responsive().getResponsiveValue(
                                      forLargeScreen: size.width / 4,
                                      forShortScreen: size.width / 1.1,
                                      forMobLandScapeMode: size.width / 2,
                                      forMediumScreen: size.width / 2,
                                      forTabletScreen: size.width / 2.1,
                                      context: context),
                                ),
                          Gap(8),
                          Container(
                            width: Responsive().getResponsiveValue(
                                forLargeScreen:
                                    MediaQuery.of(context).size.width / 4,
                                forShortScreen: MediaQuery.of(context).size.width,
                                forMobLandScapeMode:
                                    MediaQuery.of(context).size.height / 4.2,
                                forMediumScreen:
                                    MediaQuery.of(context).size.width / 2,
                                forTabletScreen:
                                    MediaQuery.of(context).size.width / 2,
                                context: context),
                            padding: EdgeInsets.only(
                              left: Responsive().getResponsiveValue(
                                  forLargeScreen: 12.0,
                                  forShortScreen: 12.0,
                                  forMobLandScapeMode: 12.0,
                                  forMediumScreen: 12.0,
                                  forTabletScreen: 12.0,
                                  context: context),
                              top: Responsive().getResponsiveValue(
                                  forLargeScreen: 26.0,
                                  forShortScreen: 22.0,
                                  context: context),
                              bottom: Responsive().getResponsiveValue(
                                  forLargeScreen: 12.0,
                                  forShortScreen: 32.0,
                                  forMobLandScapeMode: 12.0,
                                  forMediumScreen: 12.0,
                                  forTabletScreen: 12.0,
                                  context: context),
                            ),
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
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white,
                                  width: 1.0,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: Responsive().getResponsiveValue(
                                    forLargeScreen: 8.0,
                                    forShortScreen: 8.0,
                                    context: context),
                                top: Responsive().getResponsiveValue(
                                    forLargeScreen: 0.0,
                                    forShortScreen: 0.0,
                                    context: context),
                                right: Responsive().getResponsiveValue(
                                    forLargeScreen: 0.0,
                                    forShortScreen: 20.0,
                                    context: context),
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      widget.comesFrom == "EditProfile" ||
                                              widget.comesFrom ==
                                                  "EditFromProfile"
                                          ? Container()
                                          : Row(
                                              children: [
                                                Utils.mediumHeadingNormalText(
                                                    text: UtilStrings.Welcome,
                                                    fontFamily: 'Poppins',
                                                    color: AppColor.black,
                                                    fontWeight: FontWeight.bold,
                                                    textSize: 18),
                                                Spacer(),
                                                Utils.mediumHeadingNormalText(
                                                    text: "Step 6/6",
                                                    fontFamily: 'Poppins',
                                                    color: AppColor.red,
                                                    fontWeight: FontWeight.bold,
                                                    textSize: 14),
                                                Gap(12),
                                              ],
                                            ),
                                      Gap(14),
                                      Utils.mediumHeadingNormalText(
                                          text: UtilStrings
                                              .please_upload_as_many_pictures,
                                          color: Colors.grey,
                                          fontFamily: 'Poppins',
                                          textAlign: TextAlign.start,
                                          right: Responsive().getResponsiveValue(
                                              forLargeScreen: 16.0,
                                              forShortScreen: 0.0,
                                              forMobLandScapeMode: 0.0,
                                              forMediumScreen: 0.0,
                                              forTabletScreen: 0.0,
                                              context: context),
                                          textSize: 10),
                                      Gap(14),
                                      Utils.mediumHeadingNormalText(
                                          text: UtilStrings
                                              .It_important_to_note_that_violating,
                                          color: Colors.grey,
                                          fontFamily: 'Poppins',
                                          textAlign: TextAlign.start,
                                          right: Responsive().getResponsiveValue(
                                              forLargeScreen: 16.0,
                                              forShortScreen: 0.0,
                                              forMobLandScapeMode: 0.0,
                                              forMediumScreen: 0.0,
                                              forTabletScreen: 0.0,
                                              context: context),
                                          textSize: 10),
                                      Gap(18),
                                      Utils.mediumHeadingNormalText(
                                          text: UtilStrings
                                              .This_includes_stock_celebrity_photos,
                                          fontFamily: 'Poppins',
                                          color: AppColor.grey,
                                          textAlign: TextAlign.start,
                                          textSize: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Utils.mediumHeadingNormalText(
                                              text: UtilStrings.photo_desc1,
                                              fontFamily: 'Poppins',
                                              color: AppColor.grey,
                                              textSize: 10),
                                          Gap(4),
                                          Utils.mediumHeadingNormalText(
                                              text: UtilStrings.photo_desc2,
                                              fontFamily: 'Poppins',
                                              color: AppColor.grey,
                                              textAlign: TextAlign.center,
                                              textSize: 10),
                                          Gap(4),
                                          Utils.mediumHeadingNormalText(
                                              text: UtilStrings.photo_desc3,
                                              fontFamily: 'Poppins',
                                              color: AppColor.grey,
                                              textSize: 10),
                                          Gap(4),
                                          Utils.mediumHeadingNormalText(
                                              text: UtilStrings.photo_desc4,
                                              fontFamily: 'Poppins',
                                              color: AppColor.grey,
                                              textSize: 10),
                                          Gap(4),
                                          Utils.mediumHeadingNormalText(
                                              text: UtilStrings.photo_desc5,
                                              fontFamily: 'Poppins',
                                              color: AppColor.grey,
                                              textSize: 10),
                                          Gap(4),
                                          Utils.mediumHeadingNormalText(
                                              text: UtilStrings.photo_desc6,
                                              fontFamily: 'Poppins',
                                              color: AppColor.grey,
                                              textSize: 10),
                                          Gap(4),
                                          Utils.mediumHeadingNormalText(
                                              text: UtilStrings.photo_desc7,
                                              fontFamily: 'Poppins',
                                              color: AppColor.grey,
                                              textSize: 10),
                                          Gap(4),
                                          Utils.mediumHeadingNormalText(
                                              text: UtilStrings.photo_desc8,
                                              fontFamily: 'Poppins',
                                              color: AppColor.grey,
                                              textSize: 10),
                                          Gap(4),
                                          Utils.mediumHeadingNormalText(
                                              text: UtilStrings.photo_desc9,
                                              fontFamily: 'Poppins',
                                              color: AppColor.grey,
                                              textSize: 10),
                                        ],
                                      ),
                                      Gap(18),
                                      Utils.mediumHeadingStarNormalText(
                                          text: UtilStrings.Upload_Images,
                                          fontFamily: 'Poppins',
                                          color: AppColor.black,
                                          textSize: 12),
                                      Gap(8),
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: Responsive()
                                                .getResponsiveValue(
                                                    forLargeScreen: 16,
                                                    forShortScreen: 0.0,
                                                    forMobLandScapeMode: 0.0,
                                                    forMediumScreen: 0.0,
                                                    forTabletScreen: 0.0,
                                                    context: context)),
                                        child: GridView.builder(
                                            itemCount: 5,
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    crossAxisSpacing: 6,
                                                    mainAxisSpacing: 10),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return listImage[index]
                                                      .toString()
                                                      .isEmpty
                                                  ? GestureDetector(
                                                      onTap: () async {
                                                        // 1 : basic, 2:standard, 3:gold, 4:platinum
                                                        if (widget.comesFrom == "EditProfile" ||widget.comesFrom == "EditFromProfile") {
                                                          if (SessionManager.getString(Preferences.subscription_status) == "true")
                                                          {
                                                            if (SessionManager
                                                                    .getString(
                                                                        Preferences
                                                                            .subscription_plan) ==
                                                                "1") {
                                                              if (index == 0 ||
                                                                  index == 1) {
                                                                uploadImage(
                                                                    index);
                                                              }
                                                            } else if (SessionManager
                                                                    .getString(
                                                                        Preferences
                                                                            .subscription_plan) ==
                                                                "2") {
                                                              if (index == 0 ||
                                                                  index == 1 ||
                                                                  index == 2) {
                                                                uploadImage(
                                                                    index);
                                                              }
                                                            } else if (SessionManager
                                                                    .getString(
                                                                        Preferences
                                                                            .subscription_plan) ==
                                                                "3") {
                                                              if (index == 0 ||
                                                                  index == 1 ||
                                                                  index == 2 ||
                                                                  index == 3) {
                                                                uploadImage(
                                                                    index);
                                                              }
                                                            } else if (SessionManager.getString(Preferences.subscription_plan) =="4")
                                                            {if (index == 0 ||
                                                                 index == 1 ||
                                                                 index == 2 ||
                                                                 index == 3 ||
                                                                 index == 4) {
                                                                uploadImage(
                                                                    index);
                                                              }
                                                            }else{
                                                              if (index == 0) {
                                                                uploadImage(index);
                                                              }
                                                            }
                                                          }else{
                                                            if (index == 0) {
                                                              uploadImage(index);
                                                            }
                                                          }
                                                        }
                                                        else if (index == 0) {
                                                          uploadImage(index);
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 80,
                                                        width: 80,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                          color:widget.comesFrom == "EditProfile" ||widget.comesFrom == "EditFromProfile"?
                                                          Colors
                                                              .grey.shade300: index == 0? Colors
                                                              .grey.shade300:Colors
                                                              .white,
                                                        ),
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      height: 80,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                16),
                                                        color:
                                                            Colors.grey.shade300,
                                                        image:
                                                            // DecorationImage(image: MemoryImage(listImage[index]),fit: BoxFit.cover)
                                                            DecorationImage(
                                                                image: NetworkImage(listImage[
                                                                  index]),
                                                                fit:
                                                                    BoxFit.cover),
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.bottomRight,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  isLoading =
                                                                      true;
                                                                  removeindex =
                                                                      index;
                                                                  profileUpdatePresenter
                                                                      ?.doDeleteUploadMedia(
                                                                          listImageID[
                                                                              index]);
                                                                });
                                                              },
                                                              child: Container(
                                                                height: 24,
                                                                width: 24,
                                                                decoration: const BoxDecoration(
                                                                    color: Colors
                                                                        .red,
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft: Radius
                                                                            .circular(
                                                                                12),
                                                                        bottomRight:
                                                                            Radius.circular(
                                                                                12))),
                                                                child: const Center(
                                                                    child: Icon(
                                                                        Icons
                                                                            .close,
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                            }),
                                      ),
                                      Gap(16),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (widget.comesFrom ==
                                                  "EditProfile") {
                                                if (listImage.toString() ==
                                                    "[, , , , , ]") {
                                                  Utils.customDialog(context,
                                                      message: UtilStrings
                                                          .please_upload_your_image);
                                                } else {
                                                  Navigator.pop(context);
                                                }
                                              } else if (widget.comesFrom ==
                                                  "EditFromProfile") {
                                                if (listImage.toString() ==
                                                    "[, , , , , ]") {
                                                  Utils.customDialog(context,
                                                      message: UtilStrings
                                                          .please_upload_your_image);
                                                } else {
                                                  Navigator.pop(context);
                                                }
                                              } else {
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: Container(
                                              height: 46,
                                              width:
                                                  Responsive()
                                                      .getResponsiveValue(
                                                          forLargeScreen:
                                                              size.width / 9.4,
                                                          forShortScreen:
                                                              size.width / 2.6,
                                                          forMobLandScapeMode:
                                                              size.width / 2.6,
                                                          forMediumScreen:
                                                              size.width / 2.6,
                                                          forTabletScreen:
                                                              size.width / 5.0,
                                                          context: context),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: HexColor("#F0F0F0"),
                                                  border: Border.all(
                                                      color: HexColor("#F0F0F0")),
                                                  borderRadius:
                                                      BorderRadius.circular(10)),
                                              child:
                                                  Utils.mediumHeadingNormalText(
                                                      text: "Back",
                                                      color: AppColor.black,
                                                      fontFamily: 'Poppins',
                                                      textSize: 13),
                                            ),
                                          ),
                                          Gap(12),
                                          GestureDetector(
                                            onTap: () {
                                              if (listImage.isEmpty) {
                                                Utils.customDialog(context,
                                                    message: UtilStrings
                                                        .please_upload_your_image);
                                              } else if (listImage.toString() ==
                                                  "[, , , , ]") {
                                                Utils.customDialog(context,
                                                    message: UtilStrings
                                                        .please_upload_your_image);
                                              } else {
                                                if (widget.comesFrom ==
                                                    "EditProfile") {
                                                  if (listImage.toString() ==
                                                      "[, , , , , ]") {
                                                    Utils.customDialog(context,
                                                        message: UtilStrings
                                                            .please_upload_your_image);
                                                  } else {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                HomeScreen(
                                                                  viewType: 19,
                                                                )));
                                                    SessionManager.setStringList(
                                                        Preferences.IMAGE_ID, []);
                                                    SessionManager.setStringList(
                                                        Preferences.IMAGE_LIST,
                                                        []);
                                                  }
                                                } else if (widget.comesFrom ==
                                                    "EditFromProfile") {
                                                  if (listImage.toString() ==
                                                      "[, , , , , ]") {
                                                    Utils.customDialog(context,
                                                        message: UtilStrings
                                                            .please_upload_your_image);
                                                  } else {
                                                    SessionManager.setStringList(Preferences.IMAGE_ID, []);
                                                    SessionManager.setStringList(Preferences.IMAGE_LIST, []);
                                                    _authService.updateImage(listImage[0].toString());
                                                    Navigator.pop(context);
                                                  }
                                                } else {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomeScreen(
                                                                viewType: 21,
                                                              )));
                                                }
                                              }
                                            },
                                            child: Container(
                                              height: 46,
                                              width:
                                                  Responsive()
                                                      .getResponsiveValue(
                                                          forLargeScreen:
                                                              size.width / 9.4,
                                                          forShortScreen:
                                                              size.width / 2.6,
                                                          forMobLandScapeMode:
                                                              size.width / 2.6,
                                                          forMediumScreen:
                                                              size.width / 2.6,
                                                          forTabletScreen:
                                                              size.width / 5.0,
                                                          context: context),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: HexColor("#FF483C"),
                                                  border: Border.all(
                                                      color: HexColor("#FF483C")),
                                                  borderRadius:
                                                      BorderRadius.circular(10)),
                                              child:
                                                  Utils.mediumHeadingNormalText(
                                                      text: "Next",
                                                      color: AppColor.white,
                                                      fontFamily: 'Poppins',
                                                      textSize: 13),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Gap(Responsive().getResponsiveValue(
                                          forLargeScreen: 12.0,
                                          forShortScreen: 32.0,
                                          context: context)),
                                    ],
                                  ),
                                  Utils.progressDialog(context, isLoading,
                                      type: 1)
                                ],
                              ),
                            ),
                          ),
                          Gap(60)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
      ],
    ),
        ));
  }

  uploadImage(int index) async {
    var output = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'png',
        'jpeg',
        'jpg',
      ],
      allowMultiple: false,
    );
    FilePickerResult? finalOutput = output;
    setState(() {
      importFile = finalOutput!.files[0];
      fileName = importFile!.name;
      if (fileName.contains(".png")) {
        fileType = "png";
      } else if (fileName.contains(".jpeg")) {
        fileType = "jpeg";
      } else if (fileName.contains(".jpg")) {
        fileType = "jpg";
      }else if(fileName.contains(".mp4")){
        fileType = "mp4";
      }
    });
    PlatformFile platformFile = importFile!;
    if (kIsWeb) {
      if(fileType=="mp4"){
      }else{
        setState(() {
          isLoading = true;
          selectIndex = index;
          print(selectIndex);
          profileUpdatePresenter?.doUploadMediaWeb(
              platformFile.name, platformFile.bytes);
        });
      }
    } else {
      if(fileType=="mp4"){
      }else{
        File uploadFile = File(platformFile.path.toString());
        setState(() {
          isLoading = true;
        });
        profileUpdatePresenter?.doUploadMediaMobile(uploadFile);
      }
    }
  }

  @override
  onError(String msg, int status) {
    setState(() {
      isLoading = false;
    });
    if (status == 400) {
      Utils.customDialog(context, message: msg.toString());
    } else {}
  }

  @override
  onProfileUpdateResponse(UpdateProfileResponse response) {}

  @override
  onUploadMediaFile(PhotoResponse response) {
    setState(() {
      isLoading = false;
      selectValue++;
/*
     listImage.insert(selectIndex,IMAGE_URL+response.data!.imageUrl.toString());
*/
      for (int i = 0; i < listImage.length; i++) {
        if (listImage[i].isEmpty) {
          listImage[i] = IMAGE_URL + response.data!.imageUrl.toString();
          listImageID[i] = response.data!.id.toString();
          break;
        }
      }
      /*  for(int i=0;i<listImage.length;i++){
       if(i==selectIndex){
         listImage[i]=IMAGE_URL+response.data!.imageUrl.toString();
       }
     }*/
    });
  }

  @override
  onDeletePhoto(SuccessResponse response) {
    setState(() {
      isLoading = false;
      Utils.customDialog(context, message: response.message!);
      setState(() {
        listImage.removeAt(removeindex);
        listImage.insert(removeindex, "");
        listImageID.removeAt(removeindex);
        listImageID.insert(removeindex, "");
        removeindex = 0;
        selectValue++;
      });
      imageIndexChanged();
    });
  }

  @override
  onUpdateusersQuestions(SuccessResponse response) {}

  @override
  onUpdateVerificationQuestions(SuccessResponse response) {}

  @override
  onUpdateFloorStatusData(SuccessResponse response) {}

  @override
  onUserProfileData(UserProfileResponse response) {}

  imageIndexChanged() {
    String temp = "";
    String tempId = "";
    for (int i = 0; i < listImage.length; i++) {
      for (int j = 0; j < listImage.length - 1; j++) {
        if (listImage[j].isEmpty) {
          setState(() {
            temp = listImage[j];
            listImage[j] = listImage[j + 1];
            listImage[j + 1] = temp;

            tempId = listImageID[j];
            listImageID[j] = listImageID[j + 1];
            listImageID[j + 1] = temp;

            /* listImageID[j]=listImage[j+1];
            listImageID[j+1]=temp;*/
          });
        }
      }
    }
  }

  @override
  onChooseAnyOne(SuccessResponse response) {}

  @override
  onVerificationPhoto(SuccessResponse response) {}

  @override
  onVerificationFace(SuccessResponse response) {}

  @override
  onVerificationPhone(PhoneVerificationResponse response) {}

  @override
  onVerificationOtp(SuccessResponse response) {}

  @override
  onVerificationFacebook(SuccessResponse response) {}
}
