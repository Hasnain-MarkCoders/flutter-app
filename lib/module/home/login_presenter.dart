import 'package:likeplay/module/model/register_response.dart';
import '../../../utils/rest_ds.dart';
import '../model/login_response.dart';
import '../model/success_response.dart';

abstract class LoginInterface {
  onRegisterResponse(RegisterResponse response);
  onLoginResponse(LoginResponse response);
  onForgotResponse(SuccessResponse response);
  onError(String msg, int status);
}

class LoginPresenter {
  LoginInterface _view;
  RestDatasource api = RestDatasource();

  LoginPresenter(this._view);

  doRegisterPost(String userName,String email, String password,String referralCode,String type,String country) {
    api.registerPost(userName,email,password,referralCode,type,country)
        .then((RegisterResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onRegisterResponse(successResponse);
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

  doForgotPost(String email) {
    api.forgotPost(email)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onForgotResponse(successResponse);
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

  doLoginPost(String email, String password) {
    api.loginPost(email,password)
        .then((LoginResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onLoginResponse(successResponse);
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
