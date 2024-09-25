import 'package:likeplay/module/model/country_response.dart';
import 'package:likeplay/module/model/register_response.dart';

import '../../../../utils/rest_ds.dart';

abstract class CountryInterface {
  onCountryResponse(CountryResponse response);
  onCountryError(String msg, String status);
}

class CountryPresenter {
  CountryInterface _view;
  RestDatasource api = RestDatasource();

  CountryPresenter(this._view);

  doCountryData() {
    api.countryData()
        .then((CountryResponse successResponse) {
        _view.onCountryResponse(successResponse);
    }).catchError((Object error) => _view.onCountryError(error.toString(), "500"));
  }
}
