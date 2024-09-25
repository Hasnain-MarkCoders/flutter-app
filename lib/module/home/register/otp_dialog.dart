import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/module/home/register/presenter/profile_update_presenter.dart';
import 'package:likeplay/module/home/register/verification_presenter.dart';
import 'package:likeplay/module/model/photo_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import 'package:likeplay/module/model/update_profile_response.dart';
import 'package:likeplay/module/model/user_profile_response.dart';
import 'package:likeplay/utils/color_utils.dart';

import '../../../utils/responsive.dart';
import '../../../utils/sharedpref/preferences.dart';
import '../../../utils/sharedpref/shared_prefrence.dart';
import '../../../utils/string_utils.dart';
import '../../../utils/utils.dart';
import '../../model/phone_number_verification.dart';
import '../../model/phone_verification_response.dart';
import '../../model/send_otp_response.dart';
import '../../model/verification_t_Response.dart';

class OtpDialog extends StatefulWidget {
  String countryCode;
  String phoneNumber;
  OtpDialog({super.key, required this.countryCode,required this.phoneNumber});
  @override
  State<OtpDialog> createState() => _OtpDialogState();
}

class _OtpDialogState extends State<OtpDialog> implements ProfileUpdateInterface,VerificationInterface{
  ProfileUpdatePresenter? profileUpdatePresenter;
  VerificationPresenter? verificationPresenter;
  TextEditingController otpController = TextEditingController();
  bool checkIsEmpty=false;
 String otpCode="";
  @override
  void initState() {
    profileUpdatePresenter = ProfileUpdatePresenter(this);
    verificationPresenter = VerificationPresenter(this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      actions: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(width: 1.0, color: Colors.black26)),
          // padding: const EdgeInsets.only(left: 16, right: 16),
          width: Responsive().getResponsiveValue(
              forLargeScreen: MediaQuery.of(context).size.width / 3.8,
              forShortScreen: MediaQuery.of(context).size.width,
              forMobLandScapeMode: MediaQuery.of(context).size.width,
              forMediumScreen: MediaQuery.of(context).size.width,
              forTabletScreen: MediaQuery.of(context).size.width / 2.2,
              context: context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 14,left: 30),
                child: Utils.mediumHeadingNormalText(
                    text: UtilStrings.otp_Verification,
                    textSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.start),
              ),
              Container(
                margin: EdgeInsets.only(top:14 ,bottom: 4,left: 30),
                child: Utils.mediumHeadingNormalText(
                    text: UtilStrings.Enter_OTP,
                    textSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.start),
              ),
              Container(
                height:Responsive().getResponsiveValue(
                    forLargeScreen: 60.0,
                    forShortScreen: 45.0,
                    forMobLandScapeMode: 45.0,
                    forMediumScreen: 45.0,
                    forTabletScreen: 45.0,
                    context: context),
                child: OtpTextField(
                  numberOfFields: 6,
               fieldWidth:Responsive().getResponsiveValue(
                   forLargeScreen: 40.0,
                   forShortScreen: 34.0,
                   forMobLandScapeMode: 34.0,
                   forMediumScreen: 34.0,
                   forTabletScreen: 34.0,
                   context: context),
                  styles: const [
                    TextStyle(
                      color: Colors.black,  fontSize: 8,
                    ),  TextStyle(
                      color: Colors.black,  fontSize: 8,
                    ),  TextStyle(
                      color: Colors.black,
                      fontSize: 8,
                    ),  TextStyle(
                      color: Colors.black,
                      fontSize: 8,
                    ),  TextStyle(
                      color: Colors.black,
                      fontSize: 8,
                    ),  TextStyle(
                      color: Colors.black,
                      fontSize: 8,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8),
                  inputFormatters:<TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  borderColor: Colors.grey,
                  showFieldAsBox: true,
                  onCodeChanged: (String code) {
                    final isDigitsOnly = int.tryParse(code);
                     isDigitsOnly == null
                        ?'Input needs to be digits only'
                        : null;
                    setState(() {
                     if(code.isEmpty){
                         checkIsEmpty=false;
                     }else{
                       checkIsEmpty=true;
                     }
                    });

                  },
                  onSubmit: (String verificationCode){
                  setState(() {
                    otpCode=verificationCode;
                    verificationPresenter?.doVerifyPhoneNumber(widget.countryCode, widget.phoneNumber, otpCode);
                  });
                  }, // end onSubmit
                ),
              ),
              Gap(14),
              Container(
                margin: EdgeInsets.only(bottom: 4,left: 30,right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(""),
                    GestureDetector(
                      onTap: (){
                        verificationPresenter!
                            .doSendOtp(
                            widget.countryCode
                                .toString(),
                            widget.phoneNumber);
                      },
                      child: Utils.mediumHeadingNormalText(
                          text: UtilStrings.Resend,
                          textSize: 12,
                          color: HexColor(AppColor.textColor),
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.start),
                    ),
                  ],
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center,
                  crossAxisAlignment: CrossAxisAlignment
                      .center,
                  children: [
                    GestureDetector(
                        onTap: () {
                    Navigator.pop(context);
                        },
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.all(
                              10.0),
                          margin: const EdgeInsets.only(
                              top: 30.0),
                          decoration: BoxDecoration(
                            color: HexColor(
                                "#F0F0F0"),
                            borderRadius: BorderRadius
                                .circular(
                                8), /*
                                border: Border.all(color: HexColor("#FF483C"))*/
                          ),
                          child: const Text(
                            "Cancel",
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
                        if(checkIsEmpty==false){
                          Utils.customDialog(context,message:UtilStrings.Please_enter_otp);
                        }else{
                          profileUpdatePresenter!.doOtpVerification(otpCode);
                        }
                      },
                      child: Container(
                        width: 100,
                        padding: const EdgeInsets.all(
                            10.0),
                        margin: const EdgeInsets.only(
                            top: 30.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius
                              .circular(8),
                          color: HexColor("#FF483C"),
                        ),
                        child: const Text(
                          "Verify",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(14),
            ],
          ),
        ),
      ],
    );
  }

  @override
  onChooseAnyOne(SuccessResponse response) {

  }

  @override
  onDeletePhoto(SuccessResponse response) {

  }

  @override
  onError(String msg, int status) {
    if(status==400){
      Utils.customDialog(context,message:msg);
    }
    else if(status==401){
      Utils.sessionExpire(context);
    }
  }

  @override
  onProfileUpdateResponse(UpdateProfileResponse response) {

  }

  @override
  onUpdateFloorStatusData(SuccessResponse response) {

  }

  @override
  onUpdateVerificationQuestions(SuccessResponse response) {

  }

  @override
  onUpdateusersQuestions(SuccessResponse response) {

  }

  @override
  onUploadMediaFile(PhotoResponse response) {

  }

  @override
  onUserProfileData(UserProfileResponse response) {

  }

  @override
  onVerificationFace(SuccessResponse response) {

  }

  @override
  onVerificationPhone(PhoneVerificationResponse response) {
    setState(() {
      // isLoading = false;
    });
    if (response.status == 200) {
      Utils.customDialog(context,message:response.data.toString());
    }
  }

  @override
  onVerificationPhoto(SuccessResponse response) {

  }

  @override
  onVerificationOtp(SuccessResponse response) {
    if(response.status==200){
      SessionManager.setString(Preferences.phone_status, "true");
      Utils.customDialog(context,message:response.message.toString());
      Navigator.pop(context);
    }
  }
  @override
  onVerificationFacebook(SuccessResponse response) {

  }

  @override
  onVerifyUserToken(SuccessResponse response) {

  }

  @override
  onErrorVerification(String msg, int status) {
    setState(() {
    });
    if(status==400){
      Utils.customDialog(context,message:msg.toString());
    }
  }

  @override
  onPhoneVerification(PhoneNumberVerification response) {
    setState(() {
    });
  }

  @override
  onSendOTP(SendOtpResponse response) {
    setState(() {
    });
    if(response.status==200){
      Utils.customDialog(context,message:response.message.toString());
    }
  }

  @override
  onVerificationT(VerificationTResponse response) {
    setState(() {
    });
    if(response.status==200){
      SessionManager.setString(Preferences.phone_status, "true");
      Utils.customDialog(context,message:response.message.toString());
      Navigator.pop(context);
    }
  }
}
