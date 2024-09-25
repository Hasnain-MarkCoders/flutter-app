import 'package:likeplay/module/model/success_response.dart';
import '../../../../utils/rest_ds.dart';
import '../model/match_response.dart';
import '../model/payment_paystack_response.dart';
import '../model/user_profile_response.dart';

abstract class SubscriptionInterface {
  onPayStackPayment(PaymentPayStackResponse response);
  onSubscriptionSuccess(SuccessResponse response);
  onProfileResponse(UserProfileResponse response);
  onError(String msg, int status);
}

class SubscriptionPresenter {
  SubscriptionInterface _view;
  RestDatasource api = RestDatasource();

  SubscriptionPresenter(this._view);

  //User change password API.....
  onPaymentPayStack(String amount,String planCode, String purchaseType, String subscriptionType) {
    api.initiatePayment(amount,planCode, purchaseType, subscriptionType)
        .then((PaymentPayStackResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onPayStackPayment(successResponse);
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

  onSubscriptionAndroid(
      String purchaseToken,
      String productId,
      String subscriptionType,
      String purchaseDate,
      String purchaseType,
      String purchaseAmount,) {
    api.subscriptionAndroid(purchaseToken,
      productId,
     subscriptionType,
     purchaseDate,
      purchaseType,
      purchaseAmount,)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onSubscriptionSuccess(successResponse);
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
  onSubscriptionIos(
      String receiptData,
      String total_amount,
      String subscriptionType,
      String purchaseType,) {
    api.subscriptionIos(receiptData,
      total_amount,
     subscriptionType,
      purchaseType,)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onSubscriptionSuccess(successResponse);
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
}
