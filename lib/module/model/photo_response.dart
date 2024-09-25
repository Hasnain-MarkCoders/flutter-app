class PhotoResponse {
  int? status;
  Data? data;
  String? message;

  PhotoResponse({this.status, this.data, this.message});

  PhotoResponse.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? imageUrl;
  int? userId;
  String? updatedAt;
  String? createdAt;
  dynamic position;

  Data(
      {this.id,
        this.imageUrl,
        this.userId,
        this.updatedAt,
        this.createdAt,
        this.position});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
    userId = json['user_id'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_url'] = this.imageUrl;
    data['user_id'] = this.userId;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['position'] = this.position;
    return data;
  }
}
