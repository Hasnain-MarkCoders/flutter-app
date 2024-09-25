class GetStarResponse {
  int? status;
  Data? data;
  String? message;

  GetStarResponse({this.status, this.data, this.message});

  GetStarResponse.fromJson(Map<String, dynamic> json) {
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
  List<int>? partnerIds;
  int? starCount;

  Data({this.partnerIds, this.starCount});

  Data.fromJson(Map<String, dynamic> json) {
    partnerIds = json['partnerIds'].cast<int>();
    starCount = json['star_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['partnerIds'] = this.partnerIds;
    data['star_count'] = this.starCount;
    return data;
  }
}
