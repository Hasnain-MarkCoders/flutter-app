

import 'package:likeplay/module/model/post_comment_users_response.dart';

class CommentModel{
  int id;
  int commentId;
  String name;
  String profileurl;
  String comment;
  bool likeStatus;
  String likeCount;
  String commentTime;
  List<CommentDetails> commentList;
  CommentModel({
    required this.id,
    required this.commentId,
    required this.name,
    required this.profileurl,
    required this.comment,
    required this.likeStatus,
    required this.commentList,
    required this.likeCount,
    required this.commentTime,
  });

}
