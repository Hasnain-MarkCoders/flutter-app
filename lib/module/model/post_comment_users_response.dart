class PostCommentUsersResponse {
  int? status;
  Data? data;
  String? message;

  PostCommentUsersResponse({this.status, this.data, this.message});

  PostCommentUsersResponse.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  List<Comments>? comments;

  Data({this.id, this.userId, this.comments});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    if (json['Comments'] != null) {
      comments = <Comments>[];
      json['Comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    if (this.comments != null) {
      data['Comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  int? id;
  int? postId;
  String? comment;
  int? commentBy;
  int? commentLikesCount;
  String? createdAt;
  String? updatedAt;
  String? heartCount;
  String? userLikeStatus;
  CommentDeatils? commentDeatils;
  List<CommentDetails>? commentDetails;
  List<CommentHeartLikes>? commentHeartLikes;

  Comments(
      {this.id,
        this.postId,
        this.comment,
        this.commentBy,
        this.commentLikesCount,
        this.createdAt,
        this.updatedAt,
        this.heartCount,
        this.userLikeStatus,
        this.commentDeatils,
        this.commentDetails,
        this.commentHeartLikes});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    comment = json['comment'];
    commentBy = json['comment_by'];
    commentLikesCount = json['comment_likes_count'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    heartCount = json['heartCount'];
    userLikeStatus = json['userLikeStatus'];
    commentDeatils = json['commentDeatils'] != null
        ? new CommentDeatils.fromJson(json['commentDeatils'])
        : null;
    if (json['commentDetails'] != null) {
      commentDetails = <CommentDetails>[];
      json['commentDetails'].forEach((v) {
        commentDetails!.add(new CommentDetails.fromJson(v));
      });
    }
    if (json['CommentHeartLikes'] != null) {
      commentHeartLikes = <CommentHeartLikes>[];
      json['CommentHeartLikes'].forEach((v) {
        commentHeartLikes!.add(new CommentHeartLikes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post_id'] = this.postId;
    data['comment'] = this.comment;
    data['comment_by'] = this.commentBy;
    data['comment_likes_count'] = this.commentLikesCount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['heartCount'] = this.heartCount;
    data['userLikeStatus'] = this.userLikeStatus;
    if (this.commentDeatils != null) {
      data['commentDeatils'] = this.commentDeatils!.toJson();
    }
    if (this.commentDetails != null) {
      data['commentDetails'] =
          this.commentDetails!.map((v) => v.toJson()).toList();
    }
    if (this.commentHeartLikes != null) {
      data['CommentHeartLikes'] =
          this.commentHeartLikes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommentDeatils {
  String? name;
  String? userName;
  List<UserImagesWhileSignup>? userImagesWhileSignup;

  CommentDeatils({this.name, this.userName, this.userImagesWhileSignup});

  CommentDeatils.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userName = json['user_name'];
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
    data['user_name'] = this.userName;
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

class CommentDetails {
  int? id;
  int? userId;
  int? postId;
  int? commentId;
  String? test;
  String? emojiUnicode;
  String? createdAt;
  String? updatedAt;
  String? emojiCount;

  CommentDetails(
      {this.id,
        this.userId,
        this.postId,
        this.commentId,
        this.test,
        this.emojiUnicode,
        this.createdAt,
        this.updatedAt,
        this.emojiCount});

  CommentDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    postId = json['post_id'];
    commentId = json['comment_id'];
    test = json['test'];
    emojiUnicode = json['emoji_unicode'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    emojiCount = json['emojiCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['post_id'] = this.postId;
    data['comment_id'] = this.commentId;
    data['test'] = this.test;
    data['emoji_unicode'] = this.emojiUnicode;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['emojiCount'] = this.emojiCount;
    return data;
  }
}

class CommentHeartLikes {
  int? id;
  int? userId;
  int? postId;
  int? commentId;
  bool? status;
  String? createdAt;
  String? updatedAt;
  User? user;

  CommentHeartLikes(
      {this.id,
        this.userId,
        this.postId,
        this.commentId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.user});

  CommentHeartLikes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    postId = json['post_id'];
    commentId = json['comment_id'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['User'] != null ? new User.fromJson(json['User']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['post_id'] = this.postId;
    data['comment_id'] = this.commentId;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['User'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? name;
  String? userName;

  User({this.name, this.userName});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['user_name'] = this.userName;
    return data;
  }
}
