class PostTagUsersResponse {
  int? status;
  List<Data>? data;
  String? message;

  PostTagUsersResponse({this.status, this.data, this.message});

  PostTagUsersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  int? postId;
  int? tagBy;
  String? createdAt;
  String? updatedAt;
  TagTo? tagTo;

  Data(
      {this.id,
        this.postId,
        this.tagBy,
        this.createdAt,
        this.updatedAt,
        this.tagTo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    tagBy = json['tag_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    tagTo = json['tagTo'] != null ? new TagTo.fromJson(json['tagTo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post_id'] = this.postId;
    data['tag_by'] = this.tagBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.tagTo != null) {
      data['tagTo'] = this.tagTo!.toJson();
    }
    return data;
  }
}

class TagTo {
  int? id;
  String? name;
  List<UserImagesWhileSignup>? userImagesWhileSignup;

  TagTo({this.name, this.userImagesWhileSignup});

  TagTo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.userImagesWhileSignup != null) {
      data['user_images_while_signup'] =
          this.userImagesWhileSignup!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserImagesWhileSignup {
  String? imageUrl;

  UserImagesWhileSignup({this.imageUrl});

  UserImagesWhileSignup.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_url'] = this.imageUrl;
    return data;
  }
}
