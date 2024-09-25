import 'dart:io';

import 'package:likeplay/module/model/photo_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import 'package:likeplay/module/model/user_profile_response.dart';
import '../../../../utils/rest_ds.dart';
import '../../../../utils/utils.dart';
import '../../../model/phone_verification_response.dart';
import '../../../model/update_profile_response.dart';

abstract class ProfileUpdateInterface {
  onProfileUpdateResponse(UpdateProfileResponse response);
  onUploadMediaFile(PhotoResponse response);
  onUpdateusersQuestions(SuccessResponse response);
  onUpdateVerificationQuestions(SuccessResponse response);
  onUserProfileData(UserProfileResponse response);
  onUpdateFloorStatusData(SuccessResponse response);
  onDeletePhoto(SuccessResponse response);
  onChooseAnyOne(SuccessResponse response);
  onVerificationPhoto(SuccessResponse response);
  onVerificationFace(SuccessResponse response);
  onVerificationPhone(PhoneVerificationResponse response);
  onVerificationOtp(SuccessResponse response);
  onVerificationFacebook(SuccessResponse response);

  onError(String msg, int status);
}

class ProfileUpdatePresenter {
  ProfileUpdateInterface _view;
  RestDatasource api = RestDatasource();

  ProfileUpdatePresenter(this._view);

    doProfileUpdateOneData({String? name,String? age, String? gender,String? interestedIn,String? status,String? body_type,
    String? height,String? education,String? employment,int? type}) {
    api.profileUpdateDataPost(name!,age!,gender!,interestedIn!,status!,body_type!,
        height!,education!,employment!,type!)
        .then((UpdateProfileResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onProfileUpdateResponse(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }

  doProfileUpdateTwoData({String? residence_country, String? state,
    String? city, String? religion, String? your_tribe,String? age_range_for_date, String? tribe_to_date,
    String? tribe_irrelevant,String? looking_for,String? nationality,int? type}) {
    api.profileUpdateTwoDataPost(residence_country!,state!,
        city!,religion!,your_tribe!,age_range_for_date!, tribe_to_date!,tribe_irrelevant,
        looking_for!,nationality!,type!)
        .then((UpdateProfileResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onProfileUpdateResponse(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }


  doProfileUpdateVerifictionData({String? taking_hard_drugs, String? criminal_activity,
    String? sexual_harassment, String? domestic_violence, String? financial_crimes,
    String? harassment_domestic_violence,
    String? serious_crime,
    String? additional_details}) {
    api.profileVerificationPost(taking_hard_drugs, criminal_activity,
        sexual_harassment,domestic_violence,financial_crimes,
        harassment_domestic_violence,
        serious_crime,
        additional_details)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onUpdateusersQuestions(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }

  doProfileUpdateThreeData({String? aboutUs,int? type}) {
    api.profileUpdateThreeDataPost(aboutUs!,type!)
        .then((UpdateProfileResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onProfileUpdateResponse(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }

  doUserResponseData(String userID) {
    api.userProfileData(userID)
        .then((UserProfileResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onUserProfileData(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }

  doUserOnFloor(bool floor_status){
    api.showonFloor(floor_status).then((SuccessResponse response){
      if(response.status==200){
        _view.onUpdateFloorStatusData(response);
      }
      else if(response.status==400){
        _view.onError(response.message.toString(),response.status!);
      }else if (response.status == 401) {
        _view.onError(response.message!, response.status!);
      }
      else{
        _view.onError(response.message.toString(),response.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(),500));
  }



  doUploadMediaWeb(String mediaPath,List<int>? fileName){
    api.uploadFileWeb(mediaPath,fileName).then((PhotoResponse response){
      if(response.status==200){
        _view.onUploadMediaFile(response);
      }
      else if(response.status==400){
        _view.onError(response.message.toString(),response.status!);
      }else if (response.status == 401) {
        _view.onError(response.message!, response.status!);
      }
      else{
        _view.onError(response.message.toString(),response.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(),500));
  }
   doUploadMediaMobile(File mediaPath){
    api.uploadMediaMobile(mediaPath).then((PhotoResponse response){
      if(response.status==200){
        _view.onUploadMediaFile(response);
      }
      else if(response.status==400){
        _view.onError(response.message.toString(),response.status!);
      }else if (response.status == 401) {
        _view.onError(response.message!, response.status!);
      }
      else{
        _view.onError(response.message.toString(),response.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(),500));
  }

  doDeleteUploadMedia(String photoID){
    api.deletePhoto(photoID).then((SuccessResponse response){
      if(response.status==200){
        _view.onDeletePhoto(response);
      }
      else if(response.status==400){
        _view.onError(response.message.toString(),response.status!);
      }else if (response.status == 401) {
        _view.onError(response.message!, response.status!);
      }
      else{
        _view.onError(response.message.toString(),response.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(),500));
  }
 doChooseType(int attributeStatus){
    api.choosePost(attributeStatus).then((SuccessResponse response){
      if(response.status==200){
        _view.onChooseAnyOne(response);
      }
      else if(response.status==400){
        _view.onError(response.message.toString(),response.status!);
      }else if (response.status == 401) {
        _view.onError(response.message!, response.status!);
      }
      else{
        _view.onError(response.message.toString(),response.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(),500));
  }



  doUpdateusersQuestions({String? size,String? back_end,String? facial,String? height,String?
  front,String? glasses}) {
    api.updateusersQuestions(size,back_end,facial,height,front,glasses).then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onUpdateusersQuestions(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }
  doUpdateusersQuestions1({
    String? am_dependable_and_reliable,
    String? am_outgoing_and_make_anywhere_exciting,
    String? am_best_under_pressure,
    String? am_forgiving,
    String? am_decisional}) {
    api.updateusersQuestionsOne(am_dependable_and_reliable,
        am_outgoing_and_make_anywhere_exciting,
        am_best_under_pressure,
        am_forgiving,
        am_decisional).then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onUpdateusersQuestions(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }

  doUpdateusersQuestions2({
    String? cannot_date_below_my_socio_economic,
    String? am_prude,
    String? am_judgemental,String? folks_see_me_as_goodguy,
    String? am_rebel_never_do_things_normal_way}) {
    api.updateusersQuestionsTwo(
        cannot_date_below_my_socio_economic,
        am_prude,
        am_judgemental,
        folks_see_me_as_goodguy,
        am_rebel_never_do_things_normal_way).then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onUpdateusersQuestions(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }

  doUpdateusersQuestions3({
    String? i_dont_care_what_people_say_aboutme,
    String? am_strong_willed_person,
    String? am_people_person,
    String? attraction_in_relationship,
    String? attraction_in_individual}) {
    api.updateusersQuestionsThree(
        i_dont_care_what_people_say_aboutme,
       am_strong_willed_person,
       am_people_person,
        attraction_in_relationship,
        attraction_in_individual).then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onUpdateusersQuestions(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }

  doUpdatePartnersPhysicalQuestions({String? size,String? back_end,String? facial,
    String? height,String? front,String? glasses}) {
    api.updatePartnersPhysicalQuestions(
        size,back_end,facial,
        height,front,glasses).then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onUpdateusersQuestions(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }

  //Upload verification photo
  doVerificationFromIds(String fileNameFront,List<int>? filePathFront,
      String fileNameBack, List<int>? filePathBack,String verificationStatus) {
    api.uploadVerification(fileNameFront,filePathFront,fileNameBack,filePathBack,verificationStatus)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onVerificationPhoto(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }
  //Upload verification photo
  doVerificationFromIdsMobile(File fileFront,File fileBack,String verificationStatus) {
    api.uploadMediaMobileIds(fileFront,fileBack,verificationStatus)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onVerificationPhoto(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }
  //Upload verification photo
  doFaceVerification(String fileNameFace,List<int>? filePathFace) {
    api.uploadFaceVerification(fileNameFace,filePathFace)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onVerificationFace(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }
  //Upload verification photo
  doFaceVerificationMobile(File faceImage) {
    api.uploadFaceVerificationMobile(faceImage)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onVerificationFace(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }
  //phone number verificaton
  doPhoneVerification(String countryCode,String mobileNumber) {
    api.phoneVerification(countryCode,mobileNumber)
        .then((PhoneVerificationResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onVerificationPhone(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.data!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.data!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.data.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }
  //phone number verificaton
  doOtpVerification(String Otp) {
    api.OtpVerification(Otp)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onVerificationOtp(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }
  //facebook verificaton
  doFacebookVerification(String facebookID,String facebookUserName,String facebookEmail,
      String facebookBio,String facebookImage ) {
    api.facebookVerification(facebookID,facebookUserName,facebookEmail,facebookBio,facebookImage)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onVerificationFacebook(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }
}
