class AllPostResponse {
  int? status;
  List<AllPostData>? data;
  String? message;

  AllPostResponse({this.status, this.data, this.message});

  AllPostResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AllPostData>[];
      json['data'].forEach((v) {
        data!.add(new AllPostData.fromJson(v));
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

class AllPostData {
  int? id;
  int? userId;
  String? mediaType;
  String? caption;
  String? createdAt;
  String? updatedAt;
  String? totalLikeByThumb;
  String? totalLikeByHeart;
  String? totalLikeByStar;
  String? totalCommments;
  String? totalTags;
  String? currentUserLikeByThumb;
  String? currentUserLikeByHeart;
  String? currentUserLikeByStar;
  String? likeByCurrentUser;
  List<PostContents>? postContents;
  User? user;

  AllPostData(
      {this.id,
        this.userId,
        this.mediaType,
        this.caption,
        this.createdAt,
        this.updatedAt,
        this.totalLikeByThumb,
        this.totalLikeByHeart,
        this.totalLikeByStar,
        this.totalCommments,
        this.totalTags,
        this.currentUserLikeByThumb,
        this.currentUserLikeByHeart,
        this.currentUserLikeByStar,
        this.likeByCurrentUser,
        this.postContents,
        this.user});

  AllPostData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    mediaType = json['media_type'];
    caption = json['caption'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    totalLikeByThumb = json['totalLikeByThumb'];
    totalLikeByHeart = json['totalLikeByHeart'];
    totalLikeByStar = json['totalLikeByStar'];
    totalCommments = json['totalCommments'];
    totalTags = json['totalTags'];
    currentUserLikeByThumb = json['CurrentUserLikeByThumb'];
    currentUserLikeByHeart = json['CurrentUserLikeByHeart'];
    currentUserLikeByStar = json['CurrentUserLikeByStar'];
    likeByCurrentUser = json['likeByCurrentUser'];
    if (json['PostContents'] != null) {
      postContents = <PostContents>[];
      json['PostContents'].forEach((v) {
        postContents!.add(new PostContents.fromJson(v));
      });
    }
    user = json['User'] != null ? new User.fromJson(json['User']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['media_type'] = this.mediaType;
    data['caption'] = this.caption;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['totalLikeByThumb'] = this.totalLikeByThumb;
    data['totalLikeByHeart'] = this.totalLikeByHeart;
    data['totalLikeByStar'] = this.totalLikeByStar;
    data['totalCommments'] = this.totalCommments;
    data['totalTags'] = this.totalTags;
    data['CurrentUserLikeByThumb'] = this.currentUserLikeByThumb;
    data['CurrentUserLikeByHeart'] = this.currentUserLikeByHeart;
    data['CurrentUserLikeByStar'] = this.currentUserLikeByStar;
    data['likeByCurrentUser'] = this.likeByCurrentUser;
    if (this.postContents != null) {
      data['PostContents'] = this.postContents!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['User'] = this.user!.toJson();
    }
    return data;
  }
}

class PostContents {
  int? id;
  int? postId;
  String? mediaUrl;
  dynamic videoThumbnail;
  String? createdAt;
  String? updatedAt;

  PostContents(
      {this.id,
        this.postId,
        this.mediaUrl,
        this.videoThumbnail,
        this.createdAt,
        this.updatedAt});

  PostContents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    mediaUrl = json['media_url'];
    videoThumbnail = json['video_thumbnail'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post_id'] = this.postId;
    data['media_url'] = this.mediaUrl;
    data['video_thumbnail'] = this.videoThumbnail;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class User {
  String? userName;
  String? name;
  bool? isAdmin;
  String? createdAt;
  List<UserImagesWhileSignup>? userImagesWhileSignup;

  User(
      {this.userName,
        this.name,
        this.isAdmin,
        this.createdAt,
        this.userImagesWhileSignup});

  User.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    name = json['name'];
    isAdmin = json['is_admin'];
    createdAt = json['createdAt'];
    if (json['user_images_while_signup'] != null) {
      userImagesWhileSignup = <UserImagesWhileSignup>[];
      json['user_images_while_signup'].forEach((v) {
        userImagesWhileSignup!.add(new UserImagesWhileSignup.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['name'] = this.name;
    data['is_admin'] = this.isAdmin;
    data['createdAt'] = this.createdAt;
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
