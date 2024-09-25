class SendOtpResponse {
  int? status;
  Data? data;
  String? message;

  SendOtpResponse({this.status, this.data, this.message});

  SendOtpResponse.fromJson(Map<String, dynamic> json) {
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
  List<SendCodeAttempts>? sendCodeAttempts;
  String? accountSid;
  String? to;
  Null? amount;
  bool? valid;
  Lookup? lookup;
  String? url;
  String? sid;
  String? dateCreated;
  String? serviceSid;
  String? channel;

  Data(
      {this.status,
        this.payee,
        this.dateUpdated,
        this.sendCodeAttempts,
        this.accountSid,
        this.to,
        this.amount,
        this.valid,
        this.lookup,
        this.url,
        this.sid,
        this.dateCreated,
        this.serviceSid,
        this.channel});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    payee = json['payee'];
    dateUpdated = json['date_updated'];
    if (json['send_code_attempts'] != null) {
      sendCodeAttempts = <SendCodeAttempts>[];
      json['send_code_attempts'].forEach((v) {
        sendCodeAttempts!.add(new SendCodeAttempts.fromJson(v));
      });
    }
    accountSid = json['account_sid'];
    to = json['to'];
    amount = json['amount'];
    valid = json['valid'];
    lookup =
    json['lookup'] != null ? new Lookup.fromJson(json['lookup']) : null;
    url = json['url'];
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
    if (this.sendCodeAttempts != null) {
      data['send_code_attempts'] =
          this.sendCodeAttempts!.map((v) => v.toJson()).toList();
    }
    data['account_sid'] = this.accountSid;
    data['to'] = this.to;
    data['amount'] = this.amount;
    data['valid'] = this.valid;
    if (this.lookup != null) {
      data['lookup'] = this.lookup!.toJson();
    }
    data['url'] = this.url;
    data['sid'] = this.sid;
    data['date_created'] = this.dateCreated;
    data['service_sid'] = this.serviceSid;
    data['channel'] = this.channel;
    return data;
  }
}

class SendCodeAttempts {
  String? attemptSid;
  String? channel;
  String? time;

  SendCodeAttempts({this.attemptSid, this.channel, this.time});

  SendCodeAttempts.fromJson(Map<String, dynamic> json) {
    attemptSid = json['attempt_sid'];
    channel = json['channel'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attempt_sid'] = this.attemptSid;
    data['channel'] = this.channel;
    data['time'] = this.time;
    return data;
  }
}

class Lookup {
  Carrier? carrier;

  Lookup({this.carrier});

  Lookup.fromJson(Map<String, dynamic> json) {
    carrier =
    json['carrier'] != null ? new Carrier.fromJson(json['carrier']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.carrier != null) {
      data['carrier'] = this.carrier!.toJson();
    }
    return data;
  }
}

class Carrier {
  String? mobileCountryCode;
  String? type;
  Null? errorCode;
  String? mobileNetworkCode;
  String? name;

  Carrier(
      {this.mobileCountryCode,
        this.type,
        this.errorCode,
        this.mobileNetworkCode,
        this.name});

  Carrier.fromJson(Map<String, dynamic> json) {
    mobileCountryCode = json['mobile_country_code'];
    type = json['type'];
    errorCode = json['error_code'];
    mobileNetworkCode = json['mobile_network_code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile_country_code'] = this.mobileCountryCode;
    data['type'] = this.type;
    data['error_code'] = this.errorCode;
    data['mobile_network_code'] = this.mobileNetworkCode;
    data['name'] = this.name;
    return data;
  }
}
