import 'package:likeplay/module/model/success_response.dart';
import '../../../../utils/rest_ds.dart';
import '../model/match_response.dart';

abstract class MatchInterface {
  onMatch(MatchResponse response);
  onSendRequest(SuccessResponse response);
  onError(String msg, int status);
  onRequestError(String msg, int status);
}

class MatchPresenter {
  MatchInterface _view;
  RestDatasource api = RestDatasource();

  MatchPresenter(this._view);

  //User change password API.....
  onMatchData() {
    api.matchInfo()
        .then((MatchResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onMatch(successResponse);
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

  onSendRequest(String userId, String status) {
    api.sendRequest(userId, status)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onSendRequest(successResponse);
      } else if (successResponse.status == 400) {
        _view.onRequestError(successResponse.message!, successResponse.status!);
      }
      else if (successResponse.status == 404) {
        _view.onRequestError(successResponse.message!, successResponse.status!);
      }
      else if (successResponse.status == 401) {
        _view.onRequestError(successResponse.message!, successResponse.status!);
      }else {
        _view.onRequestError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onRequestError(error.toString(), 500));
  }

}
