class LikeUsersResponse {
  int? status;
  List<LikeData>? data;
  String? message;

  LikeUsersResponse({this.status, this.data, this.message});

  LikeUsersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <LikeData>[];
      json['data'].forEach((v) {
        data!.add(new LikeData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class LikeData {
  int? id;
  int? postId;
  String? type;
  bool? status;
  int? likeBy;
  String? createdAt;
  String? updatedAt;
  LikeDetails? likeDetails;

  LikeData(
      {this.id,
        this.postId,
        this.type,
        this.status,
        this.likeBy,
        this.createdAt,
        this.updatedAt,
        this.likeDetails});

  LikeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    type = json['type'];
    status = json['status'];
    likeBy = json['like_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    likeDetails = json['likeDetails'] != null
        ? new LikeDetails.fromJson(json['likeDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post_id'] = this.postId;
    data['type'] = this.type;
    data['status'] = this.status;
    data['like_by'] = this.likeBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.likeDetails != null) {
      data['likeDetails'] = this.likeDetails!.toJson();
    }
    return data;
  }
}

class LikeDetails {
  String? name;
  List<UserImagesWhileSignup>? userImagesWhileSignup;

  LikeDetails({this.name, this.userImagesWhileSignup});

  LikeDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['user_images_while_signup'] != null) {
      userImagesWhileSignup = <UserImagesWhileSignup>[];
      json['user_images_while_signup'].forEach((v) {
        userImagesWhileSignup!.add(new UserImagesWhileSignup.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.userImagesWhileSignup != null) {
      data['user_images_while_signup'] =
          this.userImagesWhileSignup!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserImagesWhileSignup {
  int? id;
  int? userId;
  String? imageUrl;
 dynamic position;
  String? createdAt;
  String? updatedAt;

  UserImagesWhileSignup(
      {this.id,
        this.userId,
        this.imageUrl,
        this.position,
        this.createdAt,
        this.updatedAt});

  UserImagesWhileSignup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    imageUrl = json['image_url'];
    position = json['position'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['image_url'] = this.imageUrl;
    data['position'] = this.position;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
