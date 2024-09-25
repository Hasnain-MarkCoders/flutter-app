class VerificationTResponse {
  int? status;
  Data? data;
  String? message;

  VerificationTResponse({this.status, this.data, this.message});

  VerificationTResponse.fromJson(Map<String, dynamic> json) {
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
  String? status;
  Null? payee;
  String? dateUpdated;
  String? accountSid;
  String? to;
  Null? amount;
  bool? valid;
  String? sid;
  String? dateCreated;
  String? serviceSid;
  String? channel;

  Data(
      {this.status,
        this.payee,
        this.dateUpdated,
        this.accountSid,
        this.to,
        this.amount,
        this.valid,
        this.sid,
        this.dateCreated,
        this.serviceSid,
        this.channel});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    payee = json['payee'];
    dateUpdated = json['date_updated'];
    accountSid = json['account_sid'];
    to = json['to'];
    amount = json['amount'];
    valid = json['valid'];
    sid = json['sid'];
    dateCreated = json['date_created'];
    serviceSid = json['service_sid'];
    channel = json['channel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['payee'] = this.payee;
    data['date_updated'] = this.dateUpdated;
    data['account_sid'] = this.accountSid;
    data['to'] = this.to;
    data['amount'] = this.amount;
    data['valid'] = this.valid;
    data['sid'] = this.sid;
    data['date_created'] = this.dateCreated;
    data['service_sid'] = this.serviceSid;
    data['channel'] = this.channel;
    return data;
  }
}
