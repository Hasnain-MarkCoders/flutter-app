import '../../../../utils/rest_ds.dart';
import '../../model/create_star_response.dart';
import '../../model/get_star_response.dart';
import '../../model/success_response.dart';

abstract class MessageInterface {
  onSuccessCreateStar(CreateStarResponse response);
  onSuccessUpdateStar(SuccessResponse response);
  onSuccessGetStar(GetStarResponse response);
  onError(String msg, int status);
}

class MessagePresenter {
  MessageInterface _view;
  RestDatasource api = RestDatasource();

  MessagePresenter(this._view);

  //On Create Star API.....
  onCreateStar(String userId,String count) {
    api.postChatStar(userId,count)
        .then((CreateStarResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onSuccessCreateStar(successResponse);
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
  //On Get Star API.....
  onGetStar(String userId) {
    api.getStarCount(userId)
        .then((GetStarResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onSuccessGetStar(successResponse);
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
  //On Update Star API.....
  onUpdateStar() {
    api.updateChatStar()
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onSuccessUpdateStar(successResponse);
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
