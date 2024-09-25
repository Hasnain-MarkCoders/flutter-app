class CountryResponseData {
  String? name;
  String? countryCode;
  String? countryCodeAlpha3;
  String? phone;
  String? currency;
  List<StateProvinces>? stateProvinces;

  CountryResponseData(
      {this.name,
        this.countryCode,
        this.countryCodeAlpha3,
        this.phone,
        this.currency,
        this.stateProvinces});

  CountryResponseData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    countryCode = json['countryCode'];
    countryCodeAlpha3 = json['countryCodeAlpha3'];
    phone = json['phone'];
    currency = json['currency'];
    if (json['stateProvinces'] != null) {
      stateProvinces = <StateProvinces>[];
      json['stateProvinces'].forEach((v) {
        stateProvinces!.add(new StateProvinces.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['countryCode'] = this.countryCode;
    data['countryCodeAlpha3'] = this.countryCodeAlpha3;
    data['phone'] = this.phone;
    data['currency'] = this.currency;
    if (this.stateProvinces != null) {
      data['stateProvinces'] =
          this.stateProvinces!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StateProvinces {
  String? name;

  StateProvinces({this.name});

  StateProvinces.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
