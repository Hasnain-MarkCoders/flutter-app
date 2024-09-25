import 'dart:io';

import 'package:likeplay/module/model/success_response.dart';
import '../../../../utils/rest_ds.dart';
import '../../model/phone_number_verification.dart';
import '../../model/send_otp_response.dart';
import '../../model/verification_t_Response.dart';

abstract class VerificationInterface {
  onPhoneVerification(PhoneNumberVerification response);
  onSendOTP(SendOtpResponse response);
  onVerificationT(VerificationTResponse response);
  onErrorVerification(String msg, int status);
}

class VerificationPresenter {
  VerificationInterface _view;
  RestDatasource api = RestDatasource();

  VerificationPresenter(this._view);

    doPhoneVerification(String countryCode,String mobileNumber) {
    api.phoneVerificationT(countryCode,mobileNumber)
        .then((PhoneNumberVerification successResponse) {
      if (successResponse.status == 200) {
        _view.onPhoneVerification(successResponse);
      } else if (successResponse.status == 400) {
        _view.onErrorVerification(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onErrorVerification(successResponse.message!, successResponse.status!);
      }else {
        _view.onErrorVerification(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onErrorVerification(error.toString(), 500));
  }


  doSendOtp(String countryCode,String mobileNumber) {
    api.sendOtpT(countryCode,mobileNumber)
        .then((SendOtpResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onSendOTP(successResponse);
      } else if (successResponse.status == 400) {
        _view.onErrorVerification(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onErrorVerification(successResponse.message!, successResponse.status!);
      }else {
        _view.onErrorVerification(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onErrorVerification(error.toString(), 500));
  }

  doVerifyPhoneNumber(String countryCode,String mobileNumber,String code) {
    api.verifyPhoneNumberOtpT(countryCode,mobileNumber,code)
        .then((VerificationTResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onVerificationT(successResponse);
      } else if (successResponse.status == 400) {
        _view.onErrorVerification(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onErrorVerification(successResponse.message!, successResponse.status!);
      }else {
        _view.onErrorVerification(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onErrorVerification(error.toString(), 500));
  }

}
