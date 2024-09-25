import 'package:likeplay/module/admire/admirers_screen.dart';
import 'package:likeplay/module/model/admirers_response.dart';
import 'package:likeplay/module/model/admiring_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import '../../../../utils/rest_ds.dart';

abstract class AdmireInterface {
  onAdmiring(AdmiringDataResponse response);
  onAdmirers(AdmirersResponse response);
  onSendRequest(SuccessResponse response);
  onError(String msg, int status);
}

class AdmirePresenter {
  AdmireInterface _view;
  RestDatasource api = RestDatasource();

  AdmirePresenter(this._view);

  //User change password API.....
  onAdmiringData(String searchKeyword) {
    api.allAdmiring(searchKeyword)
        .then((AdmiringDataResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onAdmiring(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }
      else if (successResponse.status == 404) {
        _view.onError(successResponse.message!, successResponse.status!);
      }
      else {
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
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }
  doAdmirer(String searchKeyword) {
    api.allAdmirer(searchKeyword)
        .then((AdmirersResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onAdmirers(successResponse);
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
