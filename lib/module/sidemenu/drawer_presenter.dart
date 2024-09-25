import '../../utils/rest_ds.dart';
import '../model/success_response.dart';

abstract class DrawerResponseInterface {
  onCreateSource(SuccessResponse response);
  onError(String msg, int status);
}

class DrawerResponsePresenter {
  DrawerResponseInterface _view;
  RestDatasource api = RestDatasource();

  DrawerResponsePresenter(this._view);

  //User change password API.....
  doCreateSource(String source) {
    api.createUserBySource(source)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onCreateSource(successResponse);
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