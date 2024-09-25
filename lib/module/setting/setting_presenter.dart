import 'package:likeplay/module/model/all_post_response.dart';
import 'package:likeplay/module/model/alluser_tag_response.dart';
import 'package:likeplay/module/model/block_response.dart';
import 'package:likeplay/module/model/post_comment_users_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import '../../../../utils/rest_ds.dart';
import '../model/cancel_subscription_response.dart';
import '../model/like_users_response.dart';
import '../model/postTag_users_response.dart';
import '../model/user_profile_response.dart';

abstract class SettingInterface {
  onChangePWD(SuccessResponse response);
  onBlockList(BlockResponse response);
  onBlockPost(SuccessResponse response);
  onDeleteAccount(SuccessResponse response);
  onCancelSubscription(CancelSubscriptionResponse response);
  onProfileResponse(UserProfileResponse response);
  onReportResponse(SuccessResponse response);
  onSendRequest(SuccessResponse response);
  onSendRemoveRequest(SuccessResponse response);
  onError(String msg, int status);
  onRequestError(String msg, int status);
}

class SettingPresenter {
  SettingInterface _view;
  RestDatasource api = RestDatasource();

  SettingPresenter(this._view);

  //User change password API.....
  doChangePWD(String oldpassword,String newppassword) {
    api.changePWD(oldpassword,newppassword)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onChangePWD(successResponse);
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
  doDeleteAccountView() {
    api.deleteAccount()
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onDeleteAccount(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      }
      else if (successResponse.status == 404) {
        _view.onError(successResponse.message!, successResponse.status!);
      }
      else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }

  doBlockPost(String userId,bool status) {
    api.blockPost(userId,status)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onBlockPost(successResponse);
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

  doBlockList() {
    api.allBlockUsers()
        .then((BlockResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onBlockList(successResponse);
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

  doCancelSubscription() {
    api.cancelSubscription()
        .then((CancelSubscriptionResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onCancelSubscription(successResponse);
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
        _view.onProfileResponse(successResponse);
      }
      else if (successResponse.status == 404) {
        _view.onError(successResponse.message!, successResponse.status!);
      }
      else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }
  doReportUser(String userID) {
    api.reportUser(userID)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onReportResponse(successResponse);
      }
      else if (successResponse.status == 404) {
        _view.onError(successResponse.message!, successResponse.status!);
      }
      else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }
  onSendRequest(String userId, String status) {
    api.sendRequest(userId, status)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onSendRequest(successResponse);
      } else if (successResponse.status == 400) {
        _view.onRequestError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onRequestError(successResponse.message!, successResponse.status!);
      }else if (successResponse.status == 404) {
        _view.onRequestError(successResponse.message!, successResponse.status!);
      }else {
        _view.onRequestError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onRequestError(error.toString(), 500));
  }
  onSendRemoveRequest(String userId, String status) {
    api.sendRequest(userId, status)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onSendRemoveRequest(successResponse);
      } else if (successResponse.status == 400) {
        _view.onRequestError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onRequestError(successResponse.message!, successResponse.status!);
      }else if (successResponse.status == 404) {
        _view.onRequestError(successResponse.message!, successResponse.status!);
      }else {
        _view.onRequestError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onRequestError(error.toString(), 500));
  }
}
