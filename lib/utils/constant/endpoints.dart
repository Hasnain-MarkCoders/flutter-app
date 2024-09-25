class Endpoints {
  Endpoints._();
  // receiveTimeouts
  static const int receiveTimeout = 20000;
  // connectTimeout
  static const int connectionTimeout = 20000;
  static const int retryAttempts = 3;
  static const Duration retryInterval = Duration(seconds: 10);
  // base url
  static final String baseUrl = Endpoints._getBaseURL();
  //Live URL
  static String _getBaseURL() {
    //Live
    return 'https://devapi.likeplaylikeplay.com/';

    //Stage
    //  return 'https://stageapi.likeplaylikeplay.com/';

    //   return 'http://192.168.1.73:8000/';
    // return 'http://192.168.1.73:8000/';
    //  return 'http://192.168.1.74:8000/';
    //   return 'http://192.168.1.116:8000/';
    // return 'http://192.168.1.132:9000/';
  }

  //Live server
  static final REGISTER_URL = "${baseUrl}user/register";
  static final LOGIN_URL = "${baseUrl}user/login";
  static final FORGOT_URL = "${baseUrl}user/forgotPassword";
  static final PROFILE_UPDATE_URL = "${baseUrl}user/updateProfile";
  static final PROFILE_PHOTO_UPLOAD_URL = "${baseUrl}user/uploadMediaFile";
  static final DELETE_PHOTO_URL = "${baseUrl}user/deleteMediaFile";
  static final updateusersQuestions = "${baseUrl}user/updateusersQuestions";
  static final updatePartnersPhysicalQuestions = "${baseUrl}user/updatePartnersPhysicalQuestions";
  static final updateuserVerification = "${baseUrl}user/userVerification";
  static final userDetailURL = "${baseUrl}user/profileView?user_id=";
  static final showUserOnFloor = "${baseUrl}user/showUserOnFloor";
  //User Account API
  static final changeUserPassword = "${baseUrl}user/changeUserPassword";
  static final deleteUserAccount = "${baseUrl}user/deleteUserAccount";

  //Create Post Data
  static final createPost = "${baseUrl}post/createPost";
  static final ALL_POST_DATA = "${baseUrl}post/getPostsOnHomePageWithCount";
  static final DELETE_SHOT_URL = "${baseUrl}post/deleteShot";
  static final BLOCK_POST_USER_URL = "${baseUrl}post/blockUser";
  static final HIDE_POST_URL = "${baseUrl}post/hidePost";
  static final REPORT_POST_URL = "${baseUrl}post/reportUserPost";
  static final EDIT_POST_URL = "${baseUrl}post/editPost";
  static final ALL_TAG_URL = "${baseUrl}post/getAllUserForTag";
  static final LIKE_POST_URL = "${baseUrl}post/createLikeOnPost";
  static final ALL_TAG_DELAIL_URL = "${baseUrl}post/getTagsDetails?post_id=";
  static final ALL_LIKE_DELAIL_URL = "${baseUrl}post/getsLikesDetail?post_id=";
  static final ALL_CREATE_COMMENT_URL = "${baseUrl}post/createCommentOnPost";
  static final ALL_COMMENT_DELAIL_URL = "${baseUrl}post/getCommentsDetails?post_id=";

  //Admiring
  static final Admiring_Users = "${baseUrl}user/admiringUsers";
  static final Admirers_Users = "${baseUrl}user/admirersUsers";
  static final Block_Users = "${baseUrl}user/blockUsersListing";
  static final SEND_REQUEST = "${baseUrl}user/sendRequest";
  static final MATCH_LIST_URL = "${baseUrl}user/getMatchedUsers?attributeStatus=";
  static final CHOOSE_ANY_ONE = "${baseUrl}user/chooseAnyOne";
  static final TESTIMONIAL_URL = "${baseUrl}user/testimonials";
  static final GOVERNMENT_VERIFY_URL = "${baseUrl}user/governmentIdVerification";
  static final FACE_VERIFY_URL = "${baseUrl}user/cameraVerification";
  static final PHONE_VERIFY_URL = "${baseUrl}user/phoneNumberVerification";
  static final OTP_VERIFY_URL = "${baseUrl}user/otpVerification";
  static final FACEBOOK_VERIFY_URL = "${baseUrl}user/facebookVerification";
  static final SUBSCRIPTION = "${baseUrl}payment/initiatePayment";

  static final NOTIFICATION_URL = "${baseUrl}user/notificationsListing";
  static final clearNotifications = "${baseUrl}user/clearNotifications";
  static final cancelSubscription = "${baseUrl}payment/cancelSubscription";
  static final verifyUserToken = "${baseUrl}user/verifyUser?token=";
  static final verifyTransaction = "${baseUrl}payment/verifyTransaction";
  static final createUserBySource = "${baseUrl}user/createUserBySource";
  static final createLikeComment = "${baseUrl}post/createCommentAction";
  static final commentHeartLikes = "${baseUrl}post/commentHeartLikes";

  //Subscription
  static final subscriptionAndroid = "${baseUrl}payment/subscriptionAndroid";
  static final subscriptionIOS = "${baseUrl}payment/appleReceipt";
  static final likeShortsUrl = "${baseUrl}user/getlikeShots";
  static final repostUserUrl = "${baseUrl}user/reportUser";
  static final phoneNumberVerification = "${baseUrl}user/phoneNumberVerification";
  static final sendOtp = "${baseUrl}user/sendOtp";
  static final verifyPhoneNumberOtp = "${baseUrl}user/verifyPhoneNumberOtp";

  static final createStarChat = "${baseUrl}user/createStarChat";
  static final getStarCount = "${baseUrl}user/getStarCount";/*?user_id=*/
  static final updateStarCount = "${baseUrl}user/updateStarCount";
  static final deleteComment = "${baseUrl}post/deleteComment?comment_id=";


}
