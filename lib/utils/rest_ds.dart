import 'dart:async';
import 'dart:io';
import 'package:likeplay/module/model/admiring_response.dart';
import 'package:likeplay/module/model/all_post_response.dart';
import 'package:likeplay/module/model/alluser_tag_response.dart';
import 'package:likeplay/module/model/block_response.dart';
import 'package:likeplay/module/model/photo_response.dart';
import 'package:likeplay/module/model/register_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import 'package:likeplay/module/model/user_profile_response.dart';
import 'package:likeplay/utils/constant/endpoints.dart';
import 'package:likeplay/utils/sharedpref/preferences.dart';
import 'package:likeplay/utils/sharedpref/shared_prefrence.dart';
import '../module/model/admirers_response.dart';
import '../module/model/cancel_subscription_response.dart';
import '../module/model/country_response.dart';
import '../module/model/create-comment_response.dart';
import '../module/model/create_star_response.dart';
import '../module/model/get_star_response.dart';
import '../module/model/like_shorts_response.dart';
import '../module/model/like_users_response.dart';
import '../module/model/login_response.dart';
import '../module/model/match_response.dart';
import '../module/model/notification_response.dart';
import '../module/model/payment_paystack_response.dart';
import '../module/model/phone_number_verification.dart';
import '../module/model/phone_verification_response.dart';
import '../module/model/postTag_users_response.dart';
import '../module/model/post_comment_users_response.dart';
import '../module/model/send_otp_response.dart';
import '../module/model/update_profile_response.dart';
import '../module/model/verification_t_Response.dart';
import 'network_util.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();


  //Getting the Country API
  Future<CountryResponse> countryData() {
    return _netUtil.get(
      "https://api.ipregistry.co/?key=r14is3u9jadrvzrg",
      {
      },
    ).then((dynamic res) {
      return CountryResponse.fromJson(res);
    });
  }
  //End

  Future<RegisterResponse> registerPost(String userName,String email, String password,String referralCode,String type,String country) {
   print("REGISTER_URL=====${Endpoints.REGISTER_URL}");
    return _netUtil.postApi(Endpoints.REGISTER_URL, body: {
      "user_name": userName,
      "email": email,
      "password": password,
      "refer_code": referralCode,
      "profile_status": type,
      "country": country,
    }).then((dynamic res) {
      return RegisterResponse.fromJson(res);
    });
  }

  Future<UpdateProfileResponse> profileUpdatePost(String name,String age, String gender,String interested_in,
      String status,String body_type, String height,String education,String employment,String residence_country,
      String state, String city, String religion, String your_tribe, String age_range_for_date, String tribe_to_date,
      String looking_for, String about_me, int type,String nationality) {
    return _netUtil.putApiWithHeader(Endpoints.PROFILE_UPDATE_URL, body: {
      "name": name,
      "age": age,
      "gender": gender,
      "interested_in": interested_in,
      "status": status,
      "body_type": body_type,
      "height": height,
      "education": education,
      "employment": employment,
      "profile_status": type,
    }).then((dynamic res) {
      return UpdateProfileResponse.fromJson(res);
    });
  }

    Future<UpdateProfileResponse> profileUpdateDataPost(String name,String age, String gender,String interested_in,
        String status,String body_type, String height,String education,String employment,int type) {
      return _netUtil.putApiWithHeader(Endpoints.PROFILE_UPDATE_URL, body: {
        "name": name,
        "age": age,
        "gender": gender,
        "interested_in": interested_in,
        "status": status,
        "body_type": body_type,
        "height": height,
        "education": education,
        "employment": employment,
        "profile_status": type.toString(),

      }).then((dynamic res) {
        return UpdateProfileResponse.fromJson(res);
      });
    }

  Future<UpdateProfileResponse> profileUpdateTwoDataPost(String? residence_country, String? state,
      String? city, String? religion, String? your_tribe,String? age_range_for_date, String? tribe_to_date, String? tribe_irrelevant,
      String? looking_for,String? nationality,int? type) {
    return _netUtil.putApiWithHeader(Endpoints.PROFILE_UPDATE_URL, body: {
      "residence_country": residence_country,
      "state": state,
      "city": city,
      "religion": religion,
      "your_tribe": your_tribe,
      "age_range_for_date": age_range_for_date,
      "tribe_to_date": tribe_to_date,
      "tribe_irrelevant": tribe_irrelevant,
      "looking_for": looking_for,
      "nationality": nationality,
      "profile_status": type.toString(),
    }).then((dynamic res) {
      return UpdateProfileResponse.fromJson(res);
    });
  }
  Future<SuccessResponse> profileVerificationPost(String? taking_hard_drugs, String? criminal_activity,
      String? sexual_harassment, String? domestic_violence, String? financial_crimes,
      String? harassment_domestic_violence,
      String? serious_crime,
      String? additional_details) {
    return _netUtil.putApiWithHeader(Endpoints.updateuserVerification, body: {
      "Taking_hard_drugs": taking_hard_drugs.toString(),
      "criminal_activity": criminal_activity.toString(),
      "sexual_harassment": sexual_harassment.toString(),
      "domestic_violence": domestic_violence.toString(),
      "any_criminal_activity_hard_drugs_and_financial_crimes": financial_crimes.toString(),
      "activity_involving_sexual_harassment_domestic_violence": harassment_domestic_violence.toString(),
      "serious_crime": serious_crime.toString(),
      "additional_details": additional_details.toString(),
      "profile_status": "5",
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }

  Future<UpdateProfileResponse> profileUpdateThreeDataPost(String? aboutUs,int? type) {
    return _netUtil.putApiWithHeader(Endpoints.PROFILE_UPDATE_URL, body: {
      "about_me": aboutUs,
      "profile_status": type.toString(),
    }).then((dynamic res) {
      return UpdateProfileResponse.fromJson(res);
    });
  }

  //For upload documents...
  Future<PhotoResponse> uploadFileWeb(String filePath,List<int>? fileName) {
    return _netUtil
        .multipartUploadWeb(
        Endpoints.PROFILE_PHOTO_UPLOAD_URL,
        {
          "Authorization": "Bearer ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
       },
        filePath,fileName)
        .then((dynamic res) {
      return PhotoResponse.fromJson(res);
    });
  }
  Future<PhotoResponse> uploadMediaMobile(File photo) {
    return _netUtil
        .multipartMobileImage(
        Endpoints.PROFILE_PHOTO_UPLOAD_URL,
        {
          "Authorization": "Bearer ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
        },
        photo)
        .then((dynamic res) {
      return PhotoResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> deletePhoto(String photoID) {
    return _netUtil
        .deleteApiWithHeader(Endpoints.DELETE_PHOTO_URL+"?id="+photoID, /* body: {
         "id": photoID,
         //"user_id":  SessionManager.getString(Preferences.USER_ID),
    }*/).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> showonFloor(bool floor_status) {
   // Utils.customDialog(floor_status.toString());
    return _netUtil.putApiWithHeader(Endpoints.showUserOnFloor,  body: {
         "floor_status": floor_status.toString(),
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }

  Future<UserProfileResponse> userProfileData(String userID) {
    return _netUtil.get(
      Endpoints.userDetailURL+userID,
      {
      "Authorization": "Bearer ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
      },
    ).then((dynamic res) {
      return UserProfileResponse.fromJson(res);
    });
  }
  Future<SuccessResponse> reportUser(String reportTo) {
    return _netUtil.postWithHeader(Endpoints.repostUserUrl, body: {
      "report_to":reportTo,
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }
  Future<LoginResponse> loginPost(String email, String password) {
    return _netUtil.postApi(Endpoints.LOGIN_URL, body: {
      "email": email,
      "password": password,
    }).then((dynamic res) {
      return LoginResponse.fromJson(res);
    });
  }
  Future<SuccessResponse> forgotPost(String email) {
    return _netUtil.postApi(Endpoints.FORGOT_URL, body: {
      "email": email,
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> updateusersQuestions(String? size,String? back_end,String? facial,String? height,String?
  front,String? glasses) {
    return _netUtil.putApiWithHeader(Endpoints.updateusersQuestions, body: {
      "user_physical_size":size,
      "user_physical_backend":back_end,
      "user_physical_facial":facial,
      "user_physical_height":height,
      "user_physical_front":front,
      "user_physical_glasses":glasses,
       "profile_status":"6"
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> updateusersQuestionsOne(
      String? am_dependable_and_reliable,
      String? am_outgoing_and_make_anywhere_exciting,
      String? am_best_under_pressure,
      String? am_forgiving,
      String? am_decisional) {
    return _netUtil.putApiWithHeader(Endpoints.updateusersQuestions, body: {
      "character_am_dependable_and_reliable":am_dependable_and_reliable,
      "character_am_outgoing_and_make_anywhere_exciting":am_outgoing_and_make_anywhere_exciting,
      "character_am_best_under_pressure":am_best_under_pressure,
      "character_am_forgiving":am_forgiving,
      "character_am_decisional":am_decisional,
      "profile_status":"7"
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> updateusersQuestionsTwo(
      String? cannot_date_below_my_socio_economic,
      String? am_prude,
      String? am_judgemental,String? folks_see_me_as_goodguy,
      String? am_rebel_never_do_things_normal_way) {
    return _netUtil.putApiWithHeader(Endpoints.updateusersQuestions, body: {
      "character_cannot_date_below_my_socio_economic":cannot_date_below_my_socio_economic,
      "character_am_prude":am_prude,
      "character_am_judgemental":am_judgemental,
      "character_folks_see_me_as_goodguy":folks_see_me_as_goodguy,
      "character_am_rebel_never_do_things_normal_way":am_rebel_never_do_things_normal_way,
      "profile_status":"7"
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> updateusersQuestionsThree(
      String? i_dont_care_what_people_say_aboutme,
      String? am_strong_willed_person,
      String? am_people_person,
      String? attraction_in_relationship,
      String? attraction_in_individual) {
    return _netUtil.putApiWithHeader(Endpoints.updateusersQuestions, body: {
      "character_i_dont_care_what_people_say_aboutme":i_dont_care_what_people_say_aboutme,
      "character_am_strong_willed_person":am_strong_willed_person,
      "character_am_people_person":am_people_person,
      "character_attraction_in_relationship":attraction_in_relationship,
      "character_attraction_in_individual":attraction_in_individual,
      "profile_status":SessionManager.getString(Preferences.CHOOSE_ANY_ONE)=="1"? "8" :"7"
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> updatePartnersPhysicalQuestions(String? size,String? back_end,String? facial,
      String? height,String? front,String? glasses) {
    return _netUtil.putApiWithHeader(Endpoints.updatePartnersPhysicalQuestions, body: {
      "partner_size":size,
      "partner_back_end":back_end,
      "partner_facial":facial,
      "partner_height":height,
      "partner_front":front,
      "partner_glasses":glasses,
      "profile_status":"8"
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }
  //All Post
  Future<AllPostResponse> allPostData(String page ,String limit) {
    return _netUtil.get(
      Endpoints.ALL_POST_DATA,
          // +"?limit="+limit+"&page="+page,
      {
        "Authorization": "Bearer ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
      },
    ).then((dynamic res) {
      return AllPostResponse.fromJson(res);
    });
  }

  //For upload Post...
  Future<SuccessResponse> uploadPostUpload(String filePath,List<int>? fileName,String caption, List tagIds) {
    return _netUtil
        .multipartUploadPost(
        Endpoints.createPost,
        {
          "Authorization": "Bearer ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
        },
        filePath,fileName,caption,tagIds)
        .then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }
  //For upload Post...
  Future<SuccessResponse> uploadPostUploadMobile(File filePath,String caption, List tagIds) {
    return _netUtil
        .multipartUploadPostMobile(
        Endpoints.createPost,
        {
          "Authorization": "Bearer ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
        },
        filePath,caption,tagIds)
        .then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }
  //Get All Users
  Future<AllUserForTagResponse> allUsers() {
    return _netUtil.get(
      Endpoints.ALL_TAG_URL,
      {
        "Authorization": "Bearer ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
      },
    ).then((dynamic res) {
      return AllUserForTagResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> blockPost(String user_id, bool status) {
    return _netUtil.postWithHeader(Endpoints.BLOCK_POST_USER_URL, body: {
      "user_id": user_id,
      //"status": status.toString(),
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> hidePost(String user_id, bool status) {
    return _netUtil.postWithHeader(Endpoints.HIDE_POST_URL, body: {
      "post_id": user_id,
      "status": status.toString(),
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> deletePost(String postId) {
    return _netUtil.deleteApiWithHeader(Endpoints.DELETE_SHOT_URL+"?post_id="+postId,
      /*  body: {
      "post_id": postId,
    }*/).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }


  Future<SuccessResponse> postReportUser(String postId, String message,String otherUserID) {
    return _netUtil.postWithHeader(Endpoints.REPORT_POST_URL, body: {
      "post_id": postId,
      "user_id": otherUserID,
      "message": message,
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }

  //Get Post Tag Users
  Future<PostTagUsersResponse> postTagUsers(String postID) {
    return _netUtil.get(
      Endpoints.ALL_TAG_DELAIL_URL+postID,
      {
        "Authorization": "Bearer ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
      },
    ).then((dynamic res) {
      return PostTagUsersResponse.fromJson(res);
    });
  }

  Future<LikeUsersResponse> postLikeUsers(String postID,String type) {
    return _netUtil.get(
      Endpoints.ALL_LIKE_DELAIL_URL+postID+"&type="+type,
      {
        "Authorization": "Bearer ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
      },
    ).then((dynamic res) {
      return LikeUsersResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> postComment(String postID,String comment) {
    return _netUtil.postWithHeader(Endpoints.ALL_CREATE_COMMENT_URL, body: {
      "post_id": postID,
      "comment": comment,
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }
  Future<PostCommentUsersResponse> getAllPostComment(String postID) {
    return _netUtil.get(
      Endpoints.ALL_COMMENT_DELAIL_URL+postID,
      {
        "Authorization": "Bearer ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
      },
    ).then((dynamic res) {
      return PostCommentUsersResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> likePost(String postId, bool status,String type) {
    return _netUtil.postWithHeader(Endpoints.LIKE_POST_URL, body: {
      "post_id": postId,
      "type":type,
      "status": status.toString(),
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> changePWD(String oldPassword,String newPassword) {
    return _netUtil.putApiWithHeader(Endpoints.changeUserPassword, body: {
      "old_password": oldPassword,
      "new_password": newPassword,
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> testimonialsPost(String name,String email,String testimonial) {
    return _netUtil.postWithHeader(Endpoints.TESTIMONIAL_URL, body: {
      "name": name,
      "email": email,
      "testimonial": testimonial,
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> deleteAccount() {
    return _netUtil.delete(Endpoints.deleteUserAccount).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> editPost(String caption, List tagIds,String postId) {
    return _netUtil.putApiWithHeader(Endpoints.EDIT_POST_URL, body: {
      "caption":caption,
      "tag_to":tagIds.toString(),
      "post_id":postId,
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }

  //Admirers Users Data
  Future<AllPostResponse> allAdmirers() {
    return _netUtil.get(
      Endpoints.Admirers_Users,
      {
        "Authorization": "Bearer ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
      },
    ).then((dynamic res) {
      return AllPostResponse.fromJson(res);
    });
  }

//Admiring Users Data
  Future<AdmiringDataResponse> allAdmiring(String searchKeyword) {
    return _netUtil.get(
      Endpoints.Admiring_Users+searchKeyword,
      {
        "Authorization": "Bearer ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
        //"Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTQzOSwiaWF0IjoxNjc5ODkwODk5fQ.dmfFrKiOsF6xWoSSCUWxLaZGLrUcdhEQlzB-yoNvrd8",
      },
    ).then((dynamic res) {
      return AdmiringDataResponse.fromJson(res);
    });
  }

  Future<AdmirersResponse> allAdmirer(String searchKeyword) {
    return _netUtil.get(
      Endpoints.Admirers_Users+searchKeyword,
      {
        "Authorization": "Bearer ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
      },
    ).then((dynamic res) {
      return AdmirersResponse.fromJson(res);
    });
  }

  Future<BlockResponse> allBlockUsers() {
    return _netUtil.get(
      Endpoints.Block_Users,
      {
        "Authorization": "Bearer ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
        //"Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTQzOSwiaWF0IjoxNjc4OTUxODY4fQ.X_C1cpG_qL5p8JmR0xmZAkuRcgrEWEPlEG_vLDQikGk",
      },
    ).then((dynamic res) {
      return BlockResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> sendRequest(String userId, String status) {
    return _netUtil.postWithHeader(Endpoints.SEND_REQUEST, body: {
      "user_id":userId,
      "status":status.toString(),
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }

 Future<SuccessResponse> choosePost(int status) {
    return _netUtil.postWithHeader(Endpoints.CHOOSE_ANY_ONE, body: {
      "attributeStatus":status.toString(),
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }


  Future<MatchResponse> matchInfo() {
    return _netUtil.get(
      //Endpoints.MATCH_LIST_URL+ SessionManager.getString(Preferences.CHOOSE_ANY_ONE),
      // SessionManager.setString(Preferences.CHOOSE_ANY_ONE, response.data!.attributeStatus.toString());\
      Endpoints.MATCH_LIST_URL+  SessionManager.getString(Preferences.CHOOSE_ANY_ONE),
      {
        "Authorization": "Bearer ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
      },
    ).then((dynamic res) {
      return MatchResponse.fromJson(res);
    });
  }
  Future<SuccessResponse> uploadVerification(String fileNameFront,List<int>? filePathFront,
      String fileNameBack, List<int>? filePathBack,String verificationStatus) {
    return _netUtil
        .multipartVerifyPost(
        Endpoints.GOVERNMENT_VERIFY_URL,
        {
          "Authorization": "Bearer ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
        },
        fileNameFront,filePathFront,  fileNameBack,filePathBack,verificationStatus)
        .then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }
  Future<SuccessResponse> uploadMediaMobileIds(File fileFront,File fileBack,String verificationStatus) {
    return _netUtil
        .multipartMobileImageIds(
        Endpoints.GOVERNMENT_VERIFY_URL,
        {
          "Authorization": "Bearer ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
        },
        fileFront,fileBack,"")
        .then((dynamic res) {
      print("resss upload image"+res.toString());
      return SuccessResponse.fromJson(res);
    });
  }
  Future<SuccessResponse> uploadFaceVerification(String fileNameFace,List<int>? filePathFace) {
    return _netUtil
        .multipartVerifyFaceVerification(
        Endpoints.FACE_VERIFY_URL,
        {
          "Authorization": "Bearer ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
        },
        fileNameFace,filePathFace, )
        .then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }  Future<SuccessResponse> uploadFaceVerificationMobile(File image) {
    return _netUtil
        .multipartVerifyFaceVerificationMobile(
        Endpoints.FACE_VERIFY_URL,
        {
          "Authorization": "Bearer ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
        },
      image, )
        .then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }
  Future<PhoneVerificationResponse> phoneVerification(String countryCode,String mobileNumber) {
    return _netUtil.putApiWithHeader(Endpoints.PHONE_VERIFY_URL, body: {
      "contry_code":countryCode,
      "mobile_number":mobileNumber
    }).then((dynamic res) {
      return PhoneVerificationResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> OtpVerification(String Otp ) {
    return _netUtil.postWithHeader(Endpoints.OTP_VERIFY_URL, body: {
      "otp":Otp,
      "isUserVerified":"true",
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> facebookVerification(String facebookID,String facebookUserName,String facebookEmail,
      String facebookBio,String facebookImage ) {
    return _netUtil.postWithHeader(Endpoints.FACEBOOK_VERIFY_URL, body: {
      "facebook_id":facebookID,
      "facebook_username":facebookUserName,
      "facebook_email":facebookEmail,
      "facebook_image":facebookImage,
      "facebook_bio":facebookBio,
      "isUserVerified":"true",
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }
  //Payment API implementation
  Future<PaymentPayStackResponse> initiatePayment(String amount,String planCode,String purchaseType,String subscriptionType) {
    return _netUtil.postWithHeader(Endpoints.SUBSCRIPTION, body: {
      "email": SessionManager.getString(Preferences.EMAIL),
      "amount": amount,
      "first_name": SessionManager.getString(Preferences.USER_NAME),
      "last_name": "",
      "plan_code": planCode,
      "purchase_type": purchaseType,
      "subscription_type": subscriptionType,
    }).then((dynamic res) {
      return PaymentPayStackResponse.fromJson(res);
    });
  }

  Future<NotificationResponse> allNotification() {
    return _netUtil.get(
      Endpoints.NOTIFICATION_URL,
      {
        "Authorization": "Bearer ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
        //"Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjUsImlhdCI6MTY4Mzc4MTA4NX0.jgubgATiERrfXFx5CgCWGGRJUCGFlsIKKhKQR6vlF_8",
      },
    ).then((dynamic res) {
      return NotificationResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> clearNotification() {
    return _netUtil
        .deleteApiWithHeader(Endpoints.clearNotifications).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }

  Future<CancelSubscriptionResponse> cancelSubscription() {
    return _netUtil.get(
      Endpoints.cancelSubscription,
      {
        "Authorization": "Bearer ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
      },
    ).then((dynamic res) {
      return CancelSubscriptionResponse.fromJson(res);
    });
  }
  Future<SuccessResponse> verificationToken(String accessToken) {
    return _netUtil.get(
      Endpoints.verifyUserToken+ accessToken,
      {
        "Authorization": "Bearer ${accessToken}",
      },
    ).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }
  Future<SuccessResponse> createUserBySource(String source, ) {
    return _netUtil.postWithHeader(Endpoints.createUserBySource, body: {
      "source":source,
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }
  Future<CreateCommentResponse> createLikeComment(String postId,String commentId,String text,String unicode, ) {
    return _netUtil.postWithHeader(Endpoints.createLikeComment, body: {
      "post_id":postId,
      "comment_id":commentId,
      "text":text,
      "unicode":unicode,
    }).then((dynamic res) {
      return CreateCommentResponse.fromJson(res);
    });
  }
  Future<SuccessResponse> forHeartLike(String postId,String commentId,String status,) {
    return _netUtil.postWithHeader(Endpoints.commentHeartLikes, body: {
      "post_id":postId,
      "comment_id":commentId,
      "status":status
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }
  Future<SuccessResponse> subscriptionAndroid(
      String purchaseToken,
      String productId,
      String subscriptionType,
      String purchaseDate,
      String purchaseType,
      String purchaseAmount,
      ) {
    return _netUtil.postWithHeader(Endpoints.subscriptionAndroid, body: {
      "purchase_token":purchaseToken,
      "product_id":productId,
      "subscription_type":subscriptionType,
      "purchase_date":purchaseDate,
      "purchase_type":purchaseType,
      "purchase_amount":purchaseAmount,
      "platform":"android"
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> subscriptionIos(
      String receiptData,
      String total_amount,
      String subscriptionType,
      String purchaseType,
      ) {
    return _netUtil.postWithHeader(Endpoints.subscriptionIOS, body: {
      "receiptData":receiptData,
      "total_amount":total_amount,
      "subscription_type":subscriptionType,
      "purchase_type":purchaseType,
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }
  Future<LikeShortResponse> userLikeShorts() {
    // print("likeShortsUrl=====${Endpoints.likeShortsUrl}");
    // print("ACCESS_TOKEN=====${SessionManager.getString(Preferences.ACCESS_TOKEN)}");
    return _netUtil.get(
      Endpoints.likeShortsUrl,
      {
        "Authorization": "Bearer ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
      },
    ).then((dynamic res) {
      return LikeShortResponse.fromJson(res);
    });
  }

  Future<PhoneNumberVerification> phoneVerificationT(String countryCode,String mobileNumber) {
    return _netUtil.putApiWithHeader(Endpoints.phoneNumberVerification, body: {
      "phoneNumber":countryCode+mobileNumber,
    }).then((dynamic res) {
      return PhoneNumberVerification.fromJson(res);
    });
  }
  Future<SendOtpResponse> sendOtpT(String countryCode,String mobileNumber) {
    return _netUtil.putApiWithHeader(Endpoints.sendOtp, body: {
      "phoneNumber":countryCode+mobileNumber,
    }).then((dynamic res) {
      return SendOtpResponse.fromJson(res);
    });
  }

  Future<VerificationTResponse> verifyPhoneNumberOtpT(String countryCode,String mobileNumber,String code) {
    return _netUtil.putApiWithHeader(Endpoints.verifyPhoneNumberOtp, body: {
      "mobile_number":mobileNumber,
      "country_code":countryCode,
      "code":code,
    }).then((dynamic res) {
      return VerificationTResponse.fromJson(res);
    });
  }


  Future<CreateStarResponse> postChatStar(String userId,String count) {
    return _netUtil.postWithHeader(Endpoints.createStarChat, body: {
      "user_id":userId,
      "count":count,
    }).then((dynamic res) {
      return CreateStarResponse.fromJson(res);
    });
  }

  Future<GetStarResponse> getStarCount(String userId) {
    return _netUtil.get(
      Endpoints.getStarCount,
      {
        "Authorization": "Bearer ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
      },
    ).then((dynamic res) {
      return GetStarResponse.fromJson(res);
    });
  }
  Future<SuccessResponse> updateChatStar() {
    return _netUtil.putApiWithHeader(Endpoints.updateStarCount).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }
  Future<SuccessResponse> deleteCommentApi(String commentId) {
    return _netUtil.putApiWithHeader(Endpoints.deleteComment+commentId,).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }
}
