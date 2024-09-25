import 'package:likeplay/module/model/user_profile_response.dart';
import '../../../../utils/rest_ds.dart';
import '../model/like_shorts_response.dart';
import '../model/success_response.dart';

abstract class ProfileInterface {
  onProfileResponse(UserProfileResponse response);
  onUpdateFloorStatusData(SuccessResponse response);
  onLikeShortsData(LikeShortResponse response);
  onError(String msg, int status);
}

class ProfilePresenter {
  ProfileInterface _view;
  RestDatasource api = RestDatasource();

  ProfilePresenter(this._view);

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
  doLikeShortsResponseData() {
    api.userLikeShorts()
        .then((LikeShortResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onLikeShortsData(successResponse);
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
}
