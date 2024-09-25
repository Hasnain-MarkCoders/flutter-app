class CreateCommentResponse {
  int? status;
  Data? data;
  String? message;

  CreateCommentResponse({this.status, this.data, this.message});

  CreateCommentResponse.fromJson(Map<String, dynamic> json) {
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
  int? postId;
  String? comment;
  int? commentBy;
  int? commentLikesCount;
  String? createdAt;
  String? updatedAt;
  List<CommentLikes>? commentLikes;

  Data(
      {this.id,
        this.postId,
        this.comment,
        this.commentBy,
        this.commentLikesCount,
        this.createdAt,
        this.updatedAt,
        this.commentLikes});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    comment = json['comment'];
    commentBy = json['comment_by'];
    commentLikesCount = json['comment_likes_count'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['CommentLikes'] != null) {
      commentLikes = <CommentLikes>[];
      json['CommentLikes'].forEach((v) {
        commentLikes!.add(new CommentLikes.fromJson(v));
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
    if (this.commentLikes != null) {
      data['CommentLikes'] = this.commentLikes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommentLikes {
  int? id;
  int? userId;
  int? postId;
  int? commentId;
  String? test;
  String? emojiUnicode;
  String? createdAt;
  String? updatedAt;

  CommentLikes(
      {this.id,
        this.userId,
        this.postId,
        this.commentId,
        this.test,
        this.emojiUnicode,
        this.createdAt,
        this.updatedAt});

  CommentLikes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    postId = json['post_id'];
    commentId = json['comment_id'];
    test = json['test'];
    emojiUnicode = json['emoji_unicode'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    return data;
  }
}
