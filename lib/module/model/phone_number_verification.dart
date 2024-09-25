class PhoneNumberVerification {
  int? status;
  Data? data;
  String? message;

  PhoneNumberVerification({this.status, this.data, this.message});

  PhoneNumberVerification.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  Null? callerName;
  String? countryCode;
  String? phoneNumber;
  String? nationalFormat;
  Carrier? carrier;
  Null? addOns;
  String? url;

  Data(
      {this.callerName,
        this.countryCode,
        this.phoneNumber,
        this.nationalFormat,
        this.carrier,
        this.addOns,
        this.url});

  Data.fromJson(Map<String, dynamic> json) {
    callerName = json['caller_name'];
    countryCode = json['country_code'];
    phoneNumber = json['phone_number'];
    nationalFormat = json['national_format'];
    carrier =
    json['carrier'] != null ? new Carrier.fromJson(json['carrier']) : null;
    addOns = json['add_ons'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['caller_name'] = this.callerName;
    data['country_code'] = this.countryCode;
    data['phone_number'] = this.phoneNumber;
    data['national_format'] = this.nationalFormat;
    if (this.carrier != null) {
      data['carrier'] = this.carrier!.toJson();
    }
    data['add_ons'] = this.addOns;
    data['url'] = this.url;
    return data;
  }
}

class Carrier {
  String? mobileCountryCode;
  String? mobileNetworkCode;
  String? name;
  String? type;
  Null? errorCode;

  Carrier(
      {this.mobileCountryCode,
        this.mobileNetworkCode,
        this.name,
        this.type,
        this.errorCode});

  Carrier.fromJson(Map<String, dynamic> json) {
    mobileCountryCode = json['mobile_country_code'];
    mobileNetworkCode = json['mobile_network_code'];
    name = json['name'];
    type = json['type'];
    errorCode = json['error_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile_country_code'] = this.mobileCountryCode;
    data['mobile_network_code'] = this.mobileNetworkCode;
    data['name'] = this.name;
    data['type'] = this.type;
    data['error_code'] = this.errorCode;
    return data;
  }
}
