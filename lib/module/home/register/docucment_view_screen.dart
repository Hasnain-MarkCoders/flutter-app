import 'dart:async';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:likeplay/module/components/footer.dart';
import 'package:likeplay/module/home/register/presenter/profile_update_presenter.dart';
import 'package:likeplay/module/home/register/verification_presenter.dart';
import 'package:likeplay/utils/color_utils.dart';
import 'package:likeplay/utils/responsive.dart';
import 'package:likeplay/utils/sharedpref/preferences.dart';
import 'package:likeplay/utils/sharedpref/shared_prefrence.dart';
import 'package:likeplay/utils/snackbar.dart';
import 'package:likeplay/utils/string_utils.dart';
import 'package:likeplay/utils/utils.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../../../utils/constant_lists.dart';
import '../../model/phone_number_verification.dart';
import '../../model/phone_verification_response.dart';
import '../../model/photo_response.dart';
import '../../model/send_otp_response.dart';
import '../../model/success_response.dart';
import '../../model/update_profile_response.dart';
import '../../model/user_profile_response.dart';
import '../../model/verification_t_Response.dart';
import '../home.dart';
import 'camera/cammera_button.dart';
import 'camera/web_camera_screen.dart';
import 'otp_dialog.dart';

class DocumentViewScreen extends StatefulWidget {
  int? viewType;
  String? comesFrom;

  DocumentViewScreen({Key? key, this.viewType, this.comesFrom}) : super(key: key);
  @override
  static String path = '';
  @override
  State<DocumentViewScreen> createState() => _DocumentViewScreenState();
}

class _DocumentViewScreenState extends State<DocumentViewScreen>
    implements ProfileUpdateInterface ,VerificationInterface{
  bool isLoading = false;
  String? mobile,
      countrycode = "+91";
  final phonefocus = FocusNode();
  TextEditingController phoneController = new TextEditingController();
  ProfileUpdatePresenter? profileUpdatePresenter;
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  VerificationPresenter? verificationPresenter;
  bool? _checking = true;
  ScrollController _mycontroller1 = new ScrollController();
  ScrollController _mycontroller2 = new ScrollController();

  @override
  void initState() {
    profileUpdatePresenter = ProfileUpdatePresenter(this);
    verificationPresenter = VerificationPresenter(this);

    if(widget.comesFrom=="CameraScreen"){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showFaceVefificationialog(context);
    });}
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  PlatformFile? importFile;
  PlatformFile? importFileBack;
  PlatformFile? importFileFace;
  String fileName = "null";
  String fileNameFace = "null";
  String fileNameBack = "null";
  String fileType = "null";
  String fileTypeFace = "null";
  String fileTypeBack = "null";
  var imageName;
  File? uploadFileMobile;
  File? uploadFileMobileBack;
  File? uploadFileMobileface;
  var imageNameFace;
  var imageNameBack;
  static List<int>? file;
  static List<int>? fileFace;
  static List<int>? fileBack;

  var verificationId;
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
          behavior: HitTestBehavior.translucent,
      onTap:(){
        Utils.hideKeyBoard(context);
      },
            child: Stack(
              alignment: Alignment.bottomCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: Responsive().getResponsiveValue(
                          forLargeScreen: MediaQuery
                              .of(context)
                              .size
                              .height / 1.4,
                          forShortScreen: MediaQuery
                              .of(context)
                              .size
                              .height / 1.2,
                          forMobLandScapeMode: MediaQuery
                              .of(context)
                              .size
                              .height / 1.2,
                          forMediumScreen: MediaQuery
                              .of(context)
                              .size
                              .height / 1.2,
                          forTabletScreen: MediaQuery
                              .of(context)
                              .size
                              .height / 1.4,
                          context: context),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Utils.mediumHeadingNormalText(
                                  text: UtilStrings.complete_verification,
                                  fontFamily: 'Poppins',
                                  color: AppColor.white,
                                  textSize: 12
                              ),
                              Image.asset(
                                'assets/images/step_six.png',
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: size.width / 4,
                                    forShortScreen: size.width / 1.4,
                                    forMobLandScapeMode: size.width / 2,
                                    forMediumScreen: size.width / 2,
                                    forTabletScreen: size.width / 2.1,
                                    context: context),
                              ),
                              Gap(16),
                              Utils.mediumHeadingStarNormalText(
                                  text: UtilStrings
                                      .Use_any_one_or_more_to_verify_yourself,
                                  fontFamily: 'Poppins',
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w800,
                                  textAlign: TextAlign.center,
                                  textSize: 16),
                              Gap(8),
                              Center(
                                child: Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 1.2,
                                    height: Responsive().getResponsiveValue(
                                        forLargeScreen: MediaQuery
                                            .of(context)
                                            .size
                                            .height / 1.8,
                                        forShortScreen: MediaQuery
                                            .of(context)
                                            .size
                                            .height / 1.8,
                                        forMediumScreen: MediaQuery
                                            .of(context)
                                            .size
                                            .height / 1.4,
                                        forMobLandScapeMode: MediaQuery
                                            .of(context)
                                            .size
                                            .height / 1.4,
                                        forTabletScreen: MediaQuery
                                            .of(context)
                                            .size
                                            .height / 1.4,
                                        context: context),
                                    margin: EdgeInsets.only(left: 20, right: 20),
                                    padding: EdgeInsets.only(left: 20,
                                        top: 20,
                                        bottom: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        ResponsiveGridList(
                                        listViewBuilderOptions:ListViewBuilderOptions(
                                          controller: ScrollController(),
                                        ),
                                          maxItemsPerRow: Responsive()
                                              .getResponsiveValue(
                                              forLargeScreen: 4,
                                              forShortScreen: 1,
                                              forMobLandScapeMode: 1,
                                              forMediumScreen: 1,
                                              forTabletScreen: 1,
                                              context: context),
                                          minItemWidth: Responsive()
                                              .getResponsiveValue(
                                              forLargeScreen: 160.0,
                                              forShortScreen: 58.0,
                                              forMobLandScapeMode: 160.0,
                                              forMediumScreen: 160.0,
                                              forTabletScreen: 140.0,
                                              context: context),
                                          children: List.generate(
                                              docTitle.length,
                                                  (i) =>
                                                  Container(
                                                    height: Responsive()
                                                        .getResponsiveValue(
                                                        forLargeScreen: 240.0,
                                                        forShortScreen: 272.0,
                                                        forMobLandScapeMode: 272.0,
                                                        forMediumScreen: 260.0,
                                                        forTabletScreen: 260.0,
                                                        context: context),
                                                    alignment: Alignment.topLeft,
                                                    padding: EdgeInsets.all(12),
                                                    margin: EdgeInsets.only(
                                                        right: 20),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(12),
                                                      border: Border.all(
                                                          color: Colors.black12),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Gap(10),
                                                        Utils.imageView(
                                                            image: docIcon[i],
                                                            height: 30,
                                                            width: 30),
                                                        Gap(20),
                                                        Utils.mediumHeadingNormalText(
                                                            text: docTitle[i],
                                                            fontFamily: "Poppins",
                                                            textSize: 10,
                                                            color: AppColor.grey),
                                                        i == 3 ? Container(
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
                                                              context: context),
                                                          height: 42,
                                                          margin: EdgeInsets.only(
                                                              top: 12),
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: AppColor
                                                                    .texteditorborder),
                                                            borderRadius: BorderRadius
                                                                .circular(10.0),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                width: 80,
                                                                child: CountryCodePicker(
                                                                  padding: const EdgeInsets
                                                                      .all(2),
                                                                  dialogTextStyle: const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: 14),
                                                                  flagWidth: 12,
                                                                  textStyle: const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: 10),
                                                                  searchDecoration:const InputDecoration(
                                                                enabledBorder:  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppColor
                                                                    .DIVIDER_COLOR)
                                                          ),
                                                          focusedBorder:  OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: AppColor
                                                                      .DIVIDER_COLOR)
                                                          ),
                                                          hintText: "Search",
                                                          hintStyle: TextStyle(
                                                            color: AppColor
                                                                .APP_TEXT_COLOR_SECOND,
                                                            fontSize: 14),
                                                                    contentPadding: EdgeInsets
                                                              .all(
                                                              13),
                                                        ),
                                                                  onChanged: (e) =>
                                                                  {
                                                                    setState(() {
                                                                      countrycode =
                                                                          e.dialCode
                                                                              .toString();
                                                                    })
                                                                  },
                                                                  initialSelection: 'mt',
                                                                  favorite: [
                                                                    '+91',
                                                                    'IN'
                                                                  ],
                                                                  showCountryOnly: false,
                                                                  showOnlyCountryWhenClosed: false,
                                                                  alignLeft: false,
                                                                ),
                                                              ),
                                                              Icon(Icons
                                                                  .keyboard_arrow_down_outlined,
                                                                color: Colors.grey,
                                                                size: 12,),
                                                              Container(
                                                                margin: const EdgeInsets
                                                                    .only(left: 2.0),
                                                                height: 20,
                                                                width: 1,
                                                                color: Colors.grey,
                                                              ),
                                                              Container(
                                                                  alignment: Alignment
                                                                      .topLeft,
                                                                  width: Responsive()
                                                                      .getResponsiveValue(
                                                                      forLargeScreen: 80.0,
                                                                      forShortScreen: MediaQuery
                                                                          .of(context)
                                                                          .size
                                                                          .width / 4,
                                                                      context: context),
                                                                  margin: const EdgeInsets
                                                                      .only(
                                                                    left: 8,
                                                                    right: 8,
                                                                  ),
                                                                  child: TextFormField(
                                                                    autofocus: false,
                                                                    inputFormatters: <
                                                                        TextInputFormatter>[
                                                                      FilteringTextInputFormatter
                                                                          .allow(
                                                                          RegExp(
                                                                              r'[0-9]')),
                                                                      FilteringTextInputFormatter
                                                                          .digitsOnly

                                                                    ],
                                                                    focusNode: phonefocus,
                                                                    controller: phoneController,
                                                                    keyboardType: TextInputType
                                                                        .phone,
                                                                    textInputAction:
                                                                    TextInputAction
                                                                        .next,
                                                                    validator: (val) {
                                                                      if (val
                                                                          ?.length ==
                                                                          0)
                                                                        return "Enter Phone Number";
                                                                      else
                                                                        return null;
                                                                    },
                                                                    // onSaved: (val) => price1 = val,
                                                                    onChanged: (
                                                                        value) {
                                                                      final isDigitsOnly = int
                                                                          .tryParse(
                                                                          value);
                                                                      isDigitsOnly ==
                                                                          null
                                                                          ? 'Input needs to be digits only'
                                                                          : null;
                                                                    },
                                                                    textAlign: TextAlign
                                                                        .left,
                                                                    cursorColor: Colors
                                                                        .black,
                                                                    style: const TextStyle(
                                                                        fontSize: 10,
                                                                        letterSpacing: 1.0,
                                                                        color: Colors
                                                                            .black87),
                                                                    decoration: InputDecoration(
                                                                        contentPadding: const EdgeInsets
                                                                            .only(
                                                                            bottom: 8),
                                                                        fillColor: Colors
                                                                            .white,
                                                                        border: InputBorder
                                                                            .none,
                                                                        hintStyle: TextStyle(
                                                                            fontSize: 10,
                                                                            color: AppColor
                                                                                .texteditorthintcolor),
                                                                        hintText: "Phone Number"),
                                                                  )),
                                                            ],
                                                          ),
                                                        ) : SizedBox(),
                                                        Spacer(),
                                                        Center(
                                                          child: GestureDetector(
                                                            onTap: () {
                                                              if(i == 0){
                                                               // print("facebook_status=======>${SessionManager.getString(Preferences.facebook_status)}");
                                                                if( SessionManager.getString(Preferences.facebook_status)== "true"){
                                                                  Utils.customDialog(context,message:UtilStrings.You_already_complete_this_verificaton);
                                                                }else {
                                                                   _ifUserIsLoggedIn();
                                                                }
                                                              }
                                                              else if (i == 1) {
                                                                if( SessionManager.getString(Preferences.government_status)== "true"){
                                                                  Utils.customDialog(context,message:UtilStrings.You_already_complete_this_verificaton);
                                                                }else{
                                                                  showPhotoDialog(context);
                                                                }
                                                              }
                                                              else if (i == 2) {
                                                                if( SessionManager.getString(Preferences.pose_status)== "true"){
                                                                  Utils.customDialog(context,message:UtilStrings.You_already_complete_this_verificaton);
                                                                }else{
                                                                showFaceVefificationialog(context);
                                                                }
                                                              }
                                                              else if (i == 3) {
                                                                if( SessionManager.getString(Preferences.phone_status)== "true"){
                                                                  Utils.customDialog(context,message:UtilStrings.You_already_complete_this_verificaton);
                                                                }else{
                                                                  if (phoneController
                                                                      .text.isEmpty) {
                                                                    Utils.customDialog(
                                                                        context,message: UtilStrings
                                                                            .ENTER_YOUR_PHONE_NUMBER);
                                                                  } else
                                                                  if (phoneController
                                                                      .text.length <
                                                                      10) {
                                                                    Utils.customDialog(
                                                                        context,message:UtilStrings
                                                                            .PLEASE_ENETR_TEN_DIGIT_NUMBER);
                                                                  } else {
                                                                    setState(() {
                                                                      isLoading = true;
                                                                    });
                                                                    if( SessionManager.getString(Preferences.phone_status)== "true"){
                                                                      Utils.customDialog(context,message:UtilStrings.You_already_complete_this_verificaton);
                                                                    }else{
                                                                      verificationPresenter!
                                                                          .doPhoneVerification(
                                                                          countrycode
                                                                              .toString(),
                                                                          phoneController
                                                                              .text
                                                                              .toString());
                                                                    }

                                                                  }
                                                                }
                                                              } else{
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (
                                                                            context) =>
                                                                            HomeScreen(
                                                                              viewType: 20,
                                                                            )));
                                                              }
                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets.all(
                                                                  8.0),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(
                                                                    Radius.circular(
                                                                        8)),
                                                                gradient: LinearGradient(
                                                                    colors: [
                                                                      HexColor(
                                                                          "#FF483C"),
                                                                      HexColor(
                                                                          "#FF2C5A"),
                                                                      HexColor(
                                                                          "#FF483C"),
                                                                      HexColor(
                                                                          "#FF2C5A"),
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
                                                              child: Text(
                                                                docSubTitle[i],
                                                                textAlign: TextAlign
                                                                    .center,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize: 10),),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                          ),
                                        ),
                                        Responsive().getResponsiveValue(
                                            forLargeScreen: Positioned(
                                              bottom: 1,
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .center,
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          if (SessionManager.getString(Preferences.profileStatus).toString() == "4") {
                                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                                HomeScreen(
                                                                  viewType: 20,
                                                                )));
                                                          } else
                                                          if (SessionManager.getString(Preferences.profileStatus).toString() == "5") {
                                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                                HomeScreen(
                                                                  viewType: 13,
                                                                )));
                                                          }
                                                          else
                                                          if (SessionManager.getString(Preferences.profileStatus).toString() == "6") {
                                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                                HomeScreen(
                                                                  viewType: 16,
                                                                )));
                                                          } else
                                                          if (SessionManager.getString(Preferences.profileStatus).toString() == "7" ||
                                                              SessionManager.getString(Preferences.profileStatus).toString() == "8") {
                                                            Navigator.pop(context);
                                                          }
                                                          else {
                                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                                HomeScreen(
                                                                  viewType: 20,
                                                                )));
                                                          }
                                                        },
                                                        child: Container(
                                                          width: 100,
                                                          padding: const EdgeInsets.all(
                                                              10.0),
                                                          margin: const EdgeInsets.only(
                                                              bottom: 10 , top: 30.0, ),
                                                          decoration: BoxDecoration(
                                                            color: HexColor(
                                                                "#F0F0F0"),
                                                            borderRadius: BorderRadius
                                                                .circular(
                                                                8), /*
                                        border: Border.all(color: HexColor("#FF483C"))*/
                                                          ),
                                                          child: const Text(
                                                            "Later",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Colors.black),
                                                          ),
                                                        )),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                       if(SessionManager.getString(Preferences.government_status)== "true"|| SessionManager.getString(Preferences.pose_status)== "true"){
                                                         if (SessionManager.getString(Preferences.profileStatus).toString() == "4") {
                                                           Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                               HomeScreen(
                                                                 viewType: 20,
                                                               )));
                                                         } else
                                                         if (SessionManager.getString(Preferences.profileStatus).toString() == "5") {
                                                           Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                               HomeScreen(
                                                                 viewType: 13,
                                                               )));
                                                         }
                                                         else
                                                         if (SessionManager.getString(Preferences.profileStatus).toString() == "6") {
                                                           Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                               HomeScreen(
                                                                 viewType: 16,
                                                               )));
                                                         } else
                                                         if (SessionManager.getString(Preferences.profileStatus).toString() == "7" ||
                                                             SessionManager.getString(Preferences.profileStatus).toString() == "8") {
                                                           Navigator.pop(context);
                                                         }
                                                         else {
                                                           Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                               HomeScreen(
                                                                 viewType: 20,
                                                               )));
                                                         }
                                                       }else if(SessionManager.getString(Preferences.phone_status)== "true" || SessionManager.getString(Preferences.facebook_status)== "true"){
                                                         if (SessionManager.getString(Preferences.profileStatus).toString() == "4") {
                                                           Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                               HomeScreen(
                                                                 viewType: 20,
                                                               )));
                                                         } else
                                                         if (SessionManager.getString(Preferences.profileStatus).toString() == "5") {
                                                           Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                               HomeScreen(
                                                                 viewType: 13,
                                                               )));
                                                         }
                                                         else
                                                         if (SessionManager.getString(Preferences.profileStatus).toString() == "6") {
                                                           Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                               HomeScreen(
                                                                 viewType: 16,
                                                               )));
                                                         } else
                                                         if (SessionManager.getString(Preferences.profileStatus).toString() == "7" ||
                                                             SessionManager.getString(Preferences.profileStatus).toString() == "8") {
                                                           Navigator.pop(context);
                                                         }
                                                         else {
                                                           Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                               HomeScreen(
                                                                 viewType: 20,
                                                               )));
                                                         }
                                                       }else{
                                                         Utils.customDialog(context,message:UtilStrings.Please_do_verification);
                                                       }
                                                      },
                                                      child: Container(
                                                        width: 100,
                                                        padding: const EdgeInsets.all(
                                                            10.0),
                                                        margin: const EdgeInsets.only(
                                                            top: 30.0, bottom: 10),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(8),
                                                          color: HexColor("#FF483C"),
                                                        ),
                                                        child: const Text(
                                                          "Save",
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              color: Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            forShortScreen:  Text(""),
                                            forMobLandScapeMode: Text(""),
                                            forMediumScreen: Text(""),
                                            forTabletScreen: Text(""),
                                            context: context),

                                      ],
                                    )
                                ),
                              ),
                            ],)
                        ],)),
                ],),
              Responsive().getResponsiveValue(
                  forLargeScreen: Text(""),
                  forShortScreen: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center,
                      crossAxisAlignment: CrossAxisAlignment
                          .center,
                      children: [
                       /* GestureDetector(
                            onTap: () {
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "4") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 20,
                                    )));
                              } else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "5") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 13,
                                    )));
                              }
                              else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "6") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 16,
                                    )));
                              } else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "7" ||
                                  SessionManager.getString(Preferences.profileStatus).toString() == "8") {
                                Navigator.pop(context);
                              }
                              else {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 20,
                                    )));
                              }
                            },
                            child: Container(
                              width: 100,
                              padding: const EdgeInsets.all(
                                  10.0),
                              margin: const EdgeInsets.only(
                                  top: 30.0,bottom:30),
                              decoration: BoxDecoration(
                                color: HexColor(
                                    "#F0F0F0"),
                                borderRadius: BorderRadius
                                    .circular(
                                    8), *//*
                                        border: Border.all(color: HexColor("#FF483C"))*//*
                              ),
                              child: const Text(
                                "Later",
                                textAlign: TextAlign
                                    .center,
                                style: TextStyle(
                                    color: Colors.black),
                              ),
                            )),
                        const SizedBox(
                          width: 12,
                        ),*/
                        GestureDetector(
                          onTap: () {
                            if(SessionManager.getString(Preferences.government_status)== "true"|| SessionManager.getString(Preferences.pose_status)== "true"){
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "4") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 20,
                                    )));
                              } else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "5") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 13,
                                    )));
                              }
                              else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "6") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 16,
                                    )));
                              } else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "7" ||
                                  SessionManager.getString(Preferences.profileStatus).toString() == "8") {
                                Navigator.pop(context);
                              }
                              else {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 20,
                                    )));
                              }
                            }else if(SessionManager.getString(Preferences.phone_status)== "true" || SessionManager.getString(Preferences.facebook_status)== "true"){
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "4") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 20,
                                    )));
                              } else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "5") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 13,
                                    )));
                              }
                              else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "6") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 16,
                                    )));
                              } else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "7" ||
                                  SessionManager.getString(Preferences.profileStatus).toString() == "8") {
                                Navigator.pop(context);
                              }
                              else {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 20,
                                    )));
                              }
                            }else{
                              Utils.customDialog(context,message:UtilStrings.Please_do_verification);
                            }
                          },
                          child: Container(
                            width: 100,
                            padding: const EdgeInsets.all(
                                10.0),
                            margin: const EdgeInsets.only(
                                top: 30.0,bottom:30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius
                                  .circular(8),
                              color: HexColor("#FF483C"),
                            ),
                            child: const Text(
                              "Save",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  forMobLandScapeMode: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center,
                      crossAxisAlignment: CrossAxisAlignment
                          .center,
                      children: [
                       /* GestureDetector(
                            onTap: () {
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "4") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 20,
                                    )));
                              } else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "5") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 13,
                                    )));
                              }
                              else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "6") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 16,
                                    )));
                              } else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "7" ||
                                  SessionManager.getString(Preferences.profileStatus).toString() == "8") {
                                Navigator.pop(context);
                              }
                              else {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 20,
                                    )));
                              }
                            },
                            child: Container(
                              width: 100,
                              padding: const EdgeInsets.all(
                                  10.0),
                              margin: const EdgeInsets.only(
                                  top: 30.0,bottom:30),
                              decoration: BoxDecoration(
                                color: HexColor(
                                    "#F0F0F0"),
                                borderRadius: BorderRadius
                                    .circular(
                                    8), *//*
                                        border: Border.all(color: HexColor("#FF483C"))*//*
                              ),
                              child: const Text(
                                "Later",
                                textAlign: TextAlign
                                    .center,
                                style: TextStyle(
                                    color: Colors.black),
                              ),
                            )),
                        const SizedBox(
                          width: 12,
                        ),*/
                        GestureDetector(
                          onTap: () {
                            if(SessionManager.getString(Preferences.government_status)== "true"|| SessionManager.getString(Preferences.pose_status)== "true"){
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "4") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 20,
                                    )));
                              } else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "5") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 13,
                                    )));
                              }
                              else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "6") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 16,
                                    )));
                              } else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "7" ||
                                  SessionManager.getString(Preferences.profileStatus).toString() == "8") {
                                Navigator.pop(context);
                              }
                              else {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 20,
                                    )));
                              }
                            }else if(SessionManager.getString(Preferences.phone_status)== "true" || SessionManager.getString(Preferences.facebook_status)== "true"){
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "4") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 20,
                                    )));
                              } else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "5") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 13,
                                    )));
                              }
                              else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "6") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 16,
                                    )));
                              } else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "7" ||
                                  SessionManager.getString(Preferences.profileStatus).toString() == "8") {
                                Navigator.pop(context);
                              }
                              else {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 20,
                                    )));
                              }
                            }else{
                              Utils.customDialog(context,message:UtilStrings.Please_do_verification);
                            }
                          },
                          child: Container(
                            width: 100,
                            padding: const EdgeInsets.all(
                                10.0),
                            margin: const EdgeInsets.only(
                                top: 30.0,bottom:30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius
                                  .circular(8),
                              color: HexColor("#FF483C"),
                            ),
                            child: const Text(
                              "Save",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  forMediumScreen: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center,
                      crossAxisAlignment: CrossAxisAlignment
                          .center,
                      children: [
                       /* GestureDetector(
                            onTap: () {
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "4") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 20,
                                    )));
                              } else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "5") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 13,
                                    )));
                              }
                              else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "6") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 16,
                                    )));
                              } else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "7" ||
                                  SessionManager.getString(Preferences.profileStatus).toString() == "8") {
                                Navigator.pop(context);
                              }
                              else {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 20,
                                    )));
                              }
                            },
                            child: Container(
                              width: 100,
                              padding: const EdgeInsets.all(
                                  10.0),
                              margin: const EdgeInsets.only(
                                  top: 30.0,bottom:30),
                              decoration: BoxDecoration(
                                color: HexColor(
                                    "#F0F0F0"),
                                borderRadius: BorderRadius
                                    .circular(
                                    8), *//*
                                        border: Border.all(color: HexColor("#FF483C"))*//*
                              ),
                              child: const Text(
                                "Later",
                                textAlign: TextAlign
                                    .center,
                                style: TextStyle(
                                    color: Colors.black),
                              ),
                            )),
                        const SizedBox(
                          width: 12,
                        ),*/
                        GestureDetector(
                          onTap: () {
                            if(SessionManager.getString(Preferences.government_status)== "true"|| SessionManager.getString(Preferences.pose_status)== "true"){
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "4") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 20,
                                    )));
                              } else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "5") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 13,
                                    )));
                              }
                              else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "6") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 16,
                                    )));
                              } else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "7" ||
                                  SessionManager.getString(Preferences.profileStatus).toString() == "8") {
                                Navigator.pop(context);
                              }
                              else {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 20,
                                    )));
                              }
                            }else if(SessionManager.getString(Preferences.phone_status)== "true" || SessionManager.getString(Preferences.facebook_status)== "true"){
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "4") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 20,
                                    )));
                              } else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "5") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 13,
                                    )));
                              }
                              else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "6") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 16,
                                    )));
                              } else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "7" ||
                                  SessionManager.getString(Preferences.profileStatus).toString() == "8") {
                                Navigator.pop(context);
                              }
                              else {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 20,
                                    )));
                              }
                            }else{
                              Utils.customDialog(context,message:UtilStrings.Please_do_verification);
                            }
                          },
                          child: Container(
                            width: 100,
                            padding: const EdgeInsets.all(
                                10.0),
                            margin: const EdgeInsets.only(
                                top: 30.0,bottom:30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius
                                  .circular(8),
                              color: HexColor("#FF483C"),
                            ),
                            child: const Text(
                              "Save",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  forTabletScreen: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center,
                      crossAxisAlignment: CrossAxisAlignment
                          .center,
                      children: [
                      /*  GestureDetector(
                            onTap: () {
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "4") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 20,
                                    )));
                              } else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "5") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 13,
                                    )));
                              }
                              else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "6") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 16,
                                    )));
                              } else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "7" ||
                                  SessionManager.getString(Preferences.profileStatus).toString() == "8") {
                                Navigator.pop(context);
                              }
                              else {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 20,
                                    )));
                              }
                            },
                            child: Container(
                              width: 100,
                              padding: const EdgeInsets.all(
                                  10.0),
                              margin: const EdgeInsets.only(
                                  top: 30.0,bottom:30),
                              decoration: BoxDecoration(
                                color: HexColor(
                                    "#F0F0F0"),
                                borderRadius: BorderRadius
                                    .circular(
                                    8), *//*
                                        border: Border.all(color: HexColor("#FF483C"))*//*
                              ),
                              child: const Text(
                                "Later",
                                textAlign: TextAlign
                                    .center,
                                style: TextStyle(
                                    color: Colors.black),
                              ),
                            )),
                        const SizedBox(
                          width: 12,
                        ),*/
                        GestureDetector(
                          onTap: () {
                            if(SessionManager.getString(Preferences.government_status)== "true"|| SessionManager.getString(Preferences.pose_status)== "true"){
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "4") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 20,
                                    )));
                              } else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "5") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 13,
                                    )));
                              }
                              else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "6") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 16,
                                    )));
                              } else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "7" ||
                                  SessionManager.getString(Preferences.profileStatus).toString() == "8") {
                                Navigator.pop(context);
                              }
                              else {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 20,
                                    )));
                              }
                            }else if(SessionManager.getString(Preferences.phone_status)== "true" || SessionManager.getString(Preferences.facebook_status)== "true"){
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "4") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 20,
                                    )));
                              } else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "5") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 13,
                                    )));
                              }
                              else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "6") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 16,
                                    )));
                              } else
                              if (SessionManager.getString(Preferences.profileStatus).toString() == "7" ||
                                  SessionManager.getString(Preferences.profileStatus).toString() == "8") {
                                Navigator.pop(context);
                              }
                              else {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    HomeScreen(
                                      viewType: 20,
                                    )));
                              }
                            }else{
                              Utils.customDialog(context,message:UtilStrings.Please_do_verification);
                            }
                          },
                          child: Container(
                            width: 100,
                            padding: const EdgeInsets.all(
                                10.0),
                            margin: const EdgeInsets.only(
                                top: 30.0,bottom:30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius
                                  .circular(8),
                              color: HexColor("#FF483C"),
                            ),
                            child: const Text(
                              "Save",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  context: context),
            ],
    ),
          ),
                Utils.progressDialogFullScreen(context, isLoading)
        ],
      ),);
  }
  Future<bool> _onWillPopPhoto() async {
    setState(() {
      isLoading = false;
      imageNameBack = null;
      fileName = "";
      fileNameBack = "";
      imageName = null;
      uploadFileMobile=null;
      uploadFileMobileBack=null;

    });
    return true; //<-- SEE HERE
  }
  Future<bool> _onWillPopFace() async {
    setState(() {
      isLoading = false;
      imageNameFace = null;
      fileNameFace = "";
      uploadFileMobileface=null;
      SessionManager.setString(Preferences.camera_photo,"");
      CammeraButton.path="";
    });
    return true; //<-- SEE HERE
  }
  showPhotoDialog(BuildContext context,) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return WillPopScope(
                onWillPop: _onWillPopPhoto,
                child: AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  actions: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(width: 1.0, color: Colors.black26)),
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      width: Responsive().getResponsiveValue(
                          forLargeScreen: MediaQuery
                              .of(context)
                              .size
                              .width / 3.8,
                          forShortScreen: MediaQuery
                              .of(context)
                              .size
                              .width,
                          forMobLandScapeMode: MediaQuery
                              .of(context)
                              .size
                              .width,
                          forMediumScreen: MediaQuery
                              .of(context)
                              .size
                              .width,
                          forTabletScreen: MediaQuery
                              .of(context)
                              .size
                              .width / 2.2,
                          context: context),
                      child: Wrap(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 14),
                            child: Utils.mediumHeadingNormalText(
                                text: UtilStrings.Verification_of_Government_ID,
                                textSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.start),
                          ),
                          InkWell(
                            onTap: () async {
                              if(kIsWeb){
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
                                }
                              });
                              PlatformFile platformFile = importFile!;
                              if (kIsWeb) {
                                setState(() {
                                  file = platformFile.bytes;
                                  imageName = platformFile.bytes;
                                });
                              }else{
                                File uploadFile = File(platformFile.path.toString());
                                setState(() {
                                  uploadFileMobile=uploadFile;
                                  file = platformFile.bytes;
                                  imageName = platformFile.bytes;
                                });
                              }}else{
                                showPhotoDialogForMobile(context, "Upload Image", setState, 2);
                              }
                            },
                            child:kIsWeb? imageName != null ? Container(
                                height: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 4.8,
                                    forShortScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 6,
                                    forMobLandScapeMode: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 6,
                                    forMediumScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 6,
                                    forTabletScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 6,
                                    context: context),
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 2,
                                    forShortScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    forMobLandScapeMode: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    forMediumScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    forTabletScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 1.2,
                                    context: context),
                                margin: EdgeInsets.only(
                                    top: 12),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: MemoryImage(imageName),
                                        fit: BoxFit.fill),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: HexColor('#E2E2E2')))) :
                                  Container(
                              margin: EdgeInsets.only(
                                  top: 12),
                              width: Responsive().getResponsiveValue(
                                  forLargeScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 2,
                                  forShortScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  forMobLandScapeMode: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  forMediumScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  forTabletScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 1.2,
                                  context: context),
                              decoration: BoxDecoration(
                                  color: AppColor.adddocumentbgcolor,
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      20))),
                              alignment: Alignment.center,
                              height: Responsive().getResponsiveValue(
                                  forLargeScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 4.8,
                                  forShortScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 6,
                                  forMobLandScapeMode: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 6,
                                  forMediumScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 6,
                                  forTabletScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 6,
                                  context: context),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Utils.imageView(
                                    image: "assets/images/add-circle.png",
                                    height: 32,
                                    width: 32,
                                  ),
                                  Gap(4),
                                  Utils.mediumHeadingNormalText(
                                      text: UtilStrings.Front_Side,
                                      textSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      textAlign: TextAlign.start)
                                ],
                              ),
                            ):
                            uploadFileMobile != null ? Container(
                                height: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 4.8,
                                    forShortScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 6,
                                    forMobLandScapeMode: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 6,
                                    forMediumScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 6,
                                    forTabletScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 6,
                                    context: context),
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 2,
                                    forShortScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    forMobLandScapeMode: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    forMediumScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    forTabletScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 1.2,
                                    context: context),
                                margin: EdgeInsets.only(
                                    top: 12),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(File(uploadFileMobile!.path)),
                                        fit: BoxFit.fill),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: HexColor('#E2E2E2')))) :
                            Container(
                              margin: EdgeInsets.only(
                                  top: 12),
                              width: Responsive().getResponsiveValue(
                                  forLargeScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 2,
                                  forShortScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  forMobLandScapeMode: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  forMediumScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  forTabletScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 1.2,
                                  context: context),
                              decoration: BoxDecoration(
                                  color: AppColor.adddocumentbgcolor,
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      20))),
                              alignment: Alignment.center,
                              height: Responsive().getResponsiveValue(
                                  forLargeScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 4.8,
                                  forShortScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 6,
                                  forMobLandScapeMode: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 6,
                                  forMediumScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 6,
                                  forTabletScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 6,
                                  context: context),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Utils.imageView(
                                    image: "assets/images/add-circle.png",
                                    height: 32,
                                    width: 32,
                                  ),
                                  Gap(4),
                                  Utils.mediumHeadingNormalText(
                                      text: UtilStrings.Front_Side,
                                      textSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      textAlign: TextAlign.start)
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              if(kIsWeb){
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
                                importFileBack = finalOutput!.files[0];
                                fileNameBack = importFileBack!.name;
                                if (fileNameBack.contains(".png")) {
                                  fileTypeBack = "png";
                                } else if (fileNameBack.contains(".jpeg")) {
                                  fileTypeBack = "jpeg";
                                } else if (fileNameBack.contains(".jpg")) {
                                  fileTypeBack = "jpg";
                                }
                              });
                              PlatformFile platformFile = importFileBack!;
                              if (kIsWeb) {
                                setState(() {
                                  fileBack = platformFile.bytes;
                                  imageNameBack = platformFile.bytes;
                                });
                              }else{
                                File uploadFile = File(platformFile.path.toString());
                                setState(() {
                                  uploadFileMobileBack=uploadFile;
                                  fileBack = platformFile.bytes;
                                  imageNameBack = platformFile.bytes;
                                });
                              }}else{
                                showPhotoDialogForMobile(context, "Upload Image", setState, 3);
                              }
                            },
                            child:kIsWeb?
                            imageNameBack != null ? Container(
                                margin: EdgeInsets.only(
                                    top: 12),
                                height: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 4.8,
                                    forShortScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 6,
                                    forMobLandScapeMode: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 6,
                                    forMediumScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 6,
                                    forTabletScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 6,
                                    context: context),
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 2,
                                    forShortScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    forMobLandScapeMode: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    forMediumScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    forTabletScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 1.2,
                                    context: context),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: MemoryImage(imageNameBack),
                                        fit: BoxFit.fill),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: HexColor('#E2E2E2')))) :
                            Container(
                              margin: EdgeInsets.only(
                                  top: 12),
                              width: Responsive().getResponsiveValue(
                                  forLargeScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 2,
                                  forShortScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  forMobLandScapeMode: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  forMediumScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  forTabletScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 1.2,
                                  context: context),
                              decoration: BoxDecoration(
                                  color: AppColor.adddocumentbgcolor,
                                  /* image: DecorationImage(
                                    image: AssetImage("assets/images/upload_document.png"),
                                    fit: BoxFit.fill
                                  ),*/
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      20))),
                              alignment: Alignment.center,
                              height: Responsive().getResponsiveValue(
                                  forLargeScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 4.8,
                                  forShortScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 6,
                                  forMobLandScapeMode: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 6,
                                  forMediumScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 6,
                                  forTabletScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 6,
                                  context: context),
                              //assets/images/upload_document.png
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Utils.imageView(
                                    image: "assets/images/add-circle.png",
                                    height: 32,
                                    width: 32,
                                  ),
                                  Gap(4),
                                  Utils.mediumHeadingNormalText(
                                      text: UtilStrings.Back_Side,
                                      textSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      textAlign: TextAlign.start)
                                ],
                              ),
                            ):
                            uploadFileMobileBack != null ? Container(
                                height: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 4.8,
                                    forShortScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 6,
                                    forMobLandScapeMode: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 6,
                                    forMediumScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 6,
                                    forTabletScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 6,
                                    context: context),
                                width: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 2,
                                    forShortScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    forMobLandScapeMode: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    forMediumScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    forTabletScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 1.2,
                                    context: context),
                                margin: EdgeInsets.only(
                                    top: 12),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(File(uploadFileMobileBack!.path)),
                                        fit: BoxFit.fill),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: HexColor('#E2E2E2')))) :
                            Container(
                              margin: EdgeInsets.only(
                                  top: 12),
                              width: Responsive().getResponsiveValue(
                                  forLargeScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 2,
                                  forShortScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  forMobLandScapeMode: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  forMediumScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  forTabletScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 1.2,
                                  context: context),
                              decoration: BoxDecoration(
                                  color: AppColor.adddocumentbgcolor,
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      20))),
                              alignment: Alignment.center,
                              height: Responsive().getResponsiveValue(
                                  forLargeScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 4.8,
                                  forShortScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 6,
                                  forMobLandScapeMode: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 6,
                                  forMediumScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 6,
                                  forTabletScreen: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 6,
                                  context: context),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Utils.imageView(
                                    image: "assets/images/add-circle.png",
                                    height: 32,
                                    width: 32,
                                  ),
                                  Gap(4),
                                  Utils.mediumHeadingNormalText(
                                      text: UtilStrings.Back_Side,
                                      textSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      textAlign: TextAlign.start)
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child:GestureDetector(
                              onTap: () {
                                validation();
                              },
                              child: Container(
                                width: 100,
                                padding: const EdgeInsets.all(10.0),
                                margin: const EdgeInsets.only(
                                    top: 30.0, bottom: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: HexColor("#FF483C"),
                                ),
                                child: const Text(
                                  "Save",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }

  showFaceVefificationialog(BuildContext context,) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return WillPopScope(
                onWillPop:_onWillPopFace ,
                child: AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  actions: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(width: 1.0, color: Colors.black26)),
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      width: Responsive().getResponsiveValue(
                          forLargeScreen: MediaQuery
                              .of(context)
                              .size
                              .width / 3.8,
                          forShortScreen: MediaQuery
                              .of(context)
                              .size
                              .width,
                          forMobLandScapeMode: MediaQuery
                              .of(context)
                              .size
                              .width,
                          forMediumScreen: MediaQuery
                              .of(context)
                              .size
                              .width,
                          forTabletScreen: MediaQuery
                              .of(context)
                              .size
                              .width / 2.2,
                          context: context),
                      child: Wrap(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 14),
                            child: Utils.mediumHeadingNormalText(
                                text: UtilStrings.face_Verification,
                                textSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.start),
                          ),
                          CammeraButton.path.isEmpty?
                          Container(
                            width: Responsive().getResponsiveValue(
                                forLargeScreen: MediaQuery.of(context).size.width / 1.8,
                                forShortScreen: MediaQuery.of(context).size.width,
                                forMobLandScapeMode: MediaQuery.of(context).size.width,
                                forMediumScreen: MediaQuery.of(context).size.width,
                                forTabletScreen: MediaQuery.of(context).size.width /1.2,
                                context: context),
                            height: Responsive().getResponsiveValue(
                                forLargeScreen: MediaQuery.of(context).size.height / 4.8,
                                forShortScreen: MediaQuery.of(context).size.height / 6,
                                forMobLandScapeMode: MediaQuery.of(context).size.height / 6,
                                forMediumScreen: MediaQuery.of(context).size.height / 6,
                                forTabletScreen: MediaQuery.of(context).size.height / 6,
                                context: context),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.all(Radius.circular(
                                    20))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: Responsive().getResponsiveValue(
                                      forLargeScreen: MediaQuery.of(context).size.width /6.6,
                                      forShortScreen: MediaQuery.of(context).size.width/2.4,
                                      forMobLandScapeMode: MediaQuery.of(context).size.width/2,
                                      forMediumScreen: MediaQuery.of(context).size.width/2.4,
                                      forTabletScreen: MediaQuery.of(context).size.width / 2.2,
                                      context: context),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(
                                          20)),
                                      image: DecorationImage(
                                          image:AssetImage("assets/images/pose_image.jpg"),fit: BoxFit.fill
                                      )),
                                  alignment: Alignment.center,
                                  height: Responsive().getResponsiveValue(
                                      forLargeScreen: MediaQuery.of(context).size.height / 4.8,
                                      forShortScreen: MediaQuery.of(context).size.height / 6,
                                      forMobLandScapeMode: MediaQuery.of(context).size.height / 6,
                                      forMediumScreen: MediaQuery.of(context).size.height / 6,
                                      forTabletScreen: MediaQuery.of(context).size.height / 6,
                                      context: context),
                                ),
                                // Spacer(),
                                Container(
                                  width: Responsive().getResponsiveValue(
                                      forLargeScreen: MediaQuery.of(context).size.width /15,
                                      forShortScreen: MediaQuery.of(context).size.width/6,
                                      forMobLandScapeMode: MediaQuery.of(context).size.width/6,
                                      forMediumScreen: MediaQuery.of(context).size.width/6,
                                      forTabletScreen: MediaQuery.of(context).size.width / 6.2,
                                      context: context),
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> CameraScreenNew()));
                                    },
                                    child: Utils.imageView(
                                      image: "assets/images/add-circle.png",
                                      height: 32,
                                      width: 32,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ):
                          Container(
                              height: Responsive().getResponsiveValue(
                                  forLargeScreen: MediaQuery.of(context).size.height / 4.8,
                                  forShortScreen: MediaQuery.of(context).size.height / 6,
                                  forMobLandScapeMode: MediaQuery.of(context).size.height / 6,
                                  forMediumScreen: MediaQuery.of(context).size.height / 6,
                                  forTabletScreen: MediaQuery.of(context).size.height / 6,
                                  context: context),
                              width: Responsive().getResponsiveValue(
                                  forLargeScreen: MediaQuery.of(context).size.width / 2,
                                  forShortScreen: MediaQuery.of(context).size.width,
                                  forMobLandScapeMode: MediaQuery.of(context).size.width,
                                  forMediumScreen: MediaQuery.of(context).size.width,
                                  forTabletScreen: MediaQuery.of(context).size.width / 1.2,
                                  context: context),
                              margin: EdgeInsets.only(top: 12),
                          decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(File(CammeraButton.path)),
                                      // image: NetworkImage(SessionManager.getString(Preferences.camera_photo)),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: HexColor('#E2E2E2')))
                          // child:Image.file(File(uploadFileMobileface!.path)),
                          ),
                          Center(
                            child:  GestureDetector(
                              onTap: () {
                                validationFaceVerification();
                              },
                              child: Container(
                                width: 100,
                                padding: const EdgeInsets.all(10.0),
                                margin: const EdgeInsets.only(
                                    top: 30.0, bottom: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: HexColor("#FF483C"),
                                ),
                                child: const Text(
                                  "Save",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }

  validationFaceVerification() {
      // Api call
      if(kIsWeb){
        if (CammeraButton.path.isEmpty) {
          Utils.customDialog(context,message:UtilStrings.Please_select_photo);
        }else {
          setState(() {
            isLoading = true;
          });
          Navigator.pop(context);
          profileUpdatePresenter!.doFaceVerification(fileNameFace, imageNameFace);
        }
      }else{
        if (CammeraButton.path.isEmpty) {
          Utils.customDialog(context,message:UtilStrings.Please_select_photo);
        }else {
          setState(() {
            isLoading = true;
          });
          Navigator.pop(context);
          profileUpdatePresenter!.doFaceVerificationMobile(File(CammeraButton.path));
        }
      }
  }

  validation() {
      if(kIsWeb){
    if (imageName == null) {
    Utils.customDialog(context,message:UtilStrings.Please_select_front_side_photo);
    } else if (imageNameBack == null) {
    Utils.customDialog(context,message:UtilStrings.Please_select_back_side_photo);
    } else {
      setState(() {
        isLoading = true;
      });
      Navigator.pop(context);
      profileUpdatePresenter!.doVerificationFromIds(
          fileName, imageName, fileNameBack, imageNameBack, "1");
    }

      }else{
        if (uploadFileMobile == null) {
          Utils.customDialog(context,message:UtilStrings.Please_select_front_side_photo);
        } else if (uploadFileMobileBack == null) {
          Utils.customDialog(context,message:UtilStrings.Please_select_back_side_photo);
        } else {
          setState(() {
            isLoading = true;
          });
          Navigator.pop(context);
          profileUpdatePresenter!.doVerificationFromIdsMobile(
              uploadFileMobile!, uploadFileMobileBack!, "1");
        }
      }
    }

  showPhotoDialogForMobile(BuildContext context,String title,StateSetter setState,int type) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            backgroundColor: Colors.white,
            child: Container(
              margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.height / 100 * 2,
                  left: MediaQuery.of(context).size.height / 100 * 2),
              width: 300.0,
              height: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 100 * 4,
                    ),
                    child: Row(
                      children: [
                      /*  Container(
                          margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.height / 100 * 2,
                          ),
                          child: Image.asset(
                            "assets/images/uploadimageicon.png",
                            height:
                            MediaQuery.of(context).size.height / 100 * 4,
                          ),
                        ),*/
                        Text(
                          title,
                          style: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          //captureImage(ImageSource.camera);
                          fromFrontImage(2,context,setState,type);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height / 100 * 1.5,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(color: AppColor.checkboxicon,width: 1),
                            color: AppColor.dialogbgcolor,
                            borderRadius: BorderRadius.all(new Radius.circular(10.0)),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.camera_alt_outlined,
                                size: MediaQuery.of(context).size.width / 100 * 12,),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  UtilStrings.From_Camera,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "Poppins",
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          fromFrontImage(1,context,setState,type);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height / 100 * 1.5,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: AppColor.dialogbgcolor,
                            border: Border.all(color: AppColor.checkboxicon,width: 1),
                            borderRadius:
                            new BorderRadius.all(new Radius.circular(10.0)),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.folder_copy_outlined,
                                size: MediaQuery.of(context).size.width /
                                    100 *
                                    12,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  UtilStrings.From_Gallery,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "Poppins",
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 100 * 5,
                        left: MediaQuery.of(context).size.width / 100 * 5,
                        right: MediaQuery.of(context).size.width / 100 * 5,
                      ),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height / 100 * 6,
                      width: MediaQuery.of(context).size.width / 100 * 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height / 100 * 5,
                          )),
                          border: Border.all(color: Colors.black,width:  1)
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          );
        });
  }

  PickedFile? pickImage;
  final _imagePicker = ImagePicker();
  Future fromFrontImage(int type,BuildContext context,StateSetter setState,int comeForm) async {
    //Check Permissions
    if(comeForm==1){
      if(type==1){
        pickImage = await _imagePicker.getImage(source: ImageSource.gallery,imageQuality: 40);
      }else{
        pickImage = await _imagePicker.getImage(source: ImageSource.camera,imageQuality: 40);
      }
      setState(() {
        uploadFileMobileface = File(pickImage!.path);
      });
    }else if(comeForm==2){
      if(type==1){
        pickImage = await _imagePicker.getImage(source: ImageSource.gallery,imageQuality: 40);
      }else{
        pickImage = await _imagePicker.getImage(source: ImageSource.camera,imageQuality: 40);
      }
      setState(() {
        uploadFileMobile=File(pickImage!.path);
      });
    }else if(comeForm==3){
      if(type==1){
        pickImage = await _imagePicker.getImage(source: ImageSource.gallery,imageQuality: 40);
      }else{
        pickImage = await _imagePicker.getImage(source: ImageSource.camera,imageQuality: 40);
      }
      setState(() {
        uploadFileMobileBack=File(pickImage!.path);
      });
    }

  }
  @override
  onError(String msg, int status) {
    setState(() {
      isLoading = false;
    });
    if (status == 400) {
      Utils.customDialog(context,message:msg.toString());
    }
    else {}
  }

  @override
  onProfileUpdateResponse(UpdateProfileResponse response) {
    setState(() {
      isLoading = false;
    });
  }

  @override
  onUploadMediaFile(PhotoResponse response) {

  }

  @override
  onDeletePhoto(SuccessResponse response) async {
  }

  @override
  onUpdateusersQuestions(SuccessResponse response) {
  }

  @override
  onUpdateVerificationQuestions(SuccessResponse response) {

  }

  @override
  onUpdateFloorStatusData(SuccessResponse response) {

  }

  @override
  onUserProfileData(UserProfileResponse response) {

  }

  @override
  onChooseAnyOne(SuccessResponse response) {
  }

  @override
  onVerificationPhoto(SuccessResponse response) {
    setState(() {
      isLoading = false;
      imageNameBack = null;
      fileName = "";
      fileNameBack = "";
      imageName = null;
      SessionManager.setString(Preferences.government_status, "true");
    });
    Utils.customDialog(context,message:response.message!);
  }


  @override
  onVerificationFace(SuccessResponse response) {
    setState(() {
      isLoading = false;
      imageNameFace = null;
      fileNameFace = "";
      uploadFileMobileface=null;
      SessionManager.setString(Preferences.camera_photo,"");
      SessionManager.setString(Preferences.pose_status, "true");
      CammeraButton.path="";
    });
    Utils.customDialog(context,message:response.message!);
  }

  @override
  onVerificationPhone(PhoneVerificationResponse response) {
    setState(() {
      isLoading = false;
    });
    if (response.status == 200) {
      showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
                builder: (context, StateSetter setInnerState) {
                  return OtpDialog(phoneNumber: phoneController.text.toString(), countryCode: countrycode.toString(),);
                });
          });
    }
  }

  @override
  onVerificationOtp(SuccessResponse response) {

  }
  _ifUserIsLoggedIn() async {
    _logOut();
    final accessToken = await FacebookAuth.instance.accessToken;
    setState(() {
      _checking = false;
    });
    if (accessToken != null) {
      final userData = await FacebookAuth.instance.getUserData();
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    } else {
      _login();
    }
  }
  _login() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    if (loginResult.status == LoginStatus.success) {
      _accessToken = loginResult.accessToken;
      final userInfo = await FacebookAuth.instance.getUserData();
      setState(() {
        _userData = userInfo;
        print('ResultStatus: ------${_userData!['id']}');
        print('ResultStatus: ${_userData!['name']}');
        print('ResultStatus: ${_userData!['email']}');
        profileUpdatePresenter!.doFacebookVerification(_userData!['id'],
            _userData!['name']=="" ||_userData!['name'].toString()=="null"?"":
            _userData!['name'], _userData!['email']=="" ||_userData!['email'].toString()=="null"?"":
            _userData!['email'],_userData!['bio']=="" ||_userData!['bio'].toString()=="null"?"":
            _userData!['bio'], _userData!['picture']['data']['url']=="" ||_userData!['picture']['data']['url'].toString()=="null"?"":
            _userData!['picture']['data']['url']);


      });
    } else {
      print('ResultStatus: ${loginResult.status}');
      print('Message: ${loginResult.message}');
      print('accessToken: ${loginResult.accessToken}');
    }
  }

  _logOut() async {
    await FacebookAuth.instance.logOut();
    setState(() {
      _accessToken = null;
      _userData = null;
    });
  }

  @override
  onVerificationFacebook(SuccessResponse response) {
    if(response.status==200){
      print("SuccessResponse==========");
      SessionManager.setString(Preferences.facebook_status, "true");
      Utils.customDialog(context,message:response.message!);

    }
  }
  @override
  onVerifyUserToken(SuccessResponse response) {

  }

  @override
  onErrorVerification(String msg, int status) {
    setState(() {
      isLoading=false;
    });
    if(status==400) {
      Utils.customDialog(context,message:msg);
    }
  }

  @override
  onPhoneVerification(PhoneNumberVerification response) {
    setState(() {
      isLoading=false;
    });
    if(response.status==200){
      verificationPresenter!
          .doSendOtp(
          countrycode
              .toString(),
          phoneController
              .text
              .toString());
      showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
                builder: (context, StateSetter setInnerState) {
                  return OtpDialog(phoneNumber: phoneController.text.toString(), countryCode: countrycode.toString(),);
                });
          });
    }
  }

  @override
  onSendOTP(SendOtpResponse response) {
    setState(() {
      isLoading=false;

      if(response.status==200){
        phoneController.text="";
        Utils.customDialog(context,message:response.message.toString());
      }
    });
  }

  @override
  onVerificationT(VerificationTResponse response) {
    setState(() {
      isLoading=false;
    });
  }
}
