class CancelSubscriptionResponse {
  int? status;
  SubscriptionData? data;
  String? message;

  CancelSubscriptionResponse({this.status, this.data, this.message});

  CancelSubscriptionResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = (json['data'] != null ? new Data.fromJson(json['data']) : null) as SubscriptionData?;
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

class SubscriptionData {
  bool? status;
  String? message;
  Data? data;

  SubscriptionData({this.status, this.message, this.data});

  SubscriptionData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  String? status;

  Data({this.status});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
}
