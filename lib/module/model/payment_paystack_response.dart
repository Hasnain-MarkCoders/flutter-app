class PaymentPayStackResponse {
  int? status;
  Data? data;
  String? message;

  PaymentPayStackResponse({this.status, this.data, this.message});

  PaymentPayStackResponse.fromJson(Map<String, dynamic> json) {
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
  bool? status;
  String? message;
  PayStackPaymentData? data;

  Data({this.status, this.message, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new PayStackPaymentData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PayStackPaymentData {
  String? authorizationUrl;
  String? accessCode;
  String? reference;

  PayStackPaymentData({this.authorizationUrl, this.accessCode, this.reference});

  PayStackPaymentData.fromJson(Map<String, dynamic> json) {
    authorizationUrl = json['authorization_url'];
    accessCode = json['access_code'];
    reference = json['reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authorization_url'] = this.authorizationUrl;
    data['access_code'] = this.accessCode;
    data['reference'] = this.reference;
    return data;
  }
}
