import 'package:likeplay/module/model/all_post_response.dart';
import 'package:likeplay/module/model/alluser_tag_response.dart';
import 'package:likeplay/module/model/block_response.dart';
import 'package:likeplay/module/model/notification_response.dart';
import 'package:likeplay/module/model/post_comment_users_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import '../../../../utils/rest_ds.dart';
import '../model/like_users_response.dart';
import '../model/postTag_users_response.dart';

abstract class NotificationInterface {
  onNotificationData(NotificationResponse response);
  onNotificationClear(SuccessResponse response);
  onError(String msg, int status);
}

class NotificationPresenter {
  NotificationInterface _view;
  RestDatasource api = RestDatasource();

  NotificationPresenter(this._view);

  //User notification.
  doNotificationsData() {
    api.allNotification()
        .then((NotificationResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onNotificationData(successResponse);
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

  doNotificationsClear() {
    api.clearNotification()
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onNotificationClear(successResponse);
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
