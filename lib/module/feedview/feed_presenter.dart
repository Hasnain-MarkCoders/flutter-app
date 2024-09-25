import 'dart:io';

import 'package:likeplay/module/model/all_post_response.dart';
import 'package:likeplay/module/model/alluser_tag_response.dart';
import 'package:likeplay/module/model/create-comment_response.dart';
import 'package:likeplay/module/model/post_comment_users_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import '../../../../utils/rest_ds.dart';
import '../model/like_users_response.dart';
import '../model/postTag_users_response.dart';
import '../model/user_profile_response.dart';

abstract class FeedInterface {
  onAllPostResponse(AllPostResponse response);
  onPostSlotResponse(SuccessResponse response);
  onAllUserResponse(AllUserForTagResponse response);
  onDeletePost(SuccessResponse response);
  onReportPost(SuccessResponse response);
  onPostTag(PostTagUsersResponse response);
  onPostLike(LikeUsersResponse response);
  onPostCommentList(PostCommentUsersResponse response);
  onDeleteComment(SuccessResponse response);
  onBlockPost(SuccessResponse response);
  onLikeByUserPost(SuccessResponse response);
  onHidePost(SuccessResponse response);
  onPostComment(SuccessResponse response);
  onPostLikeComment(CreateCommentResponse response);
  onPostHeartLike(SuccessResponse response);
  onProfileResponse(UserProfileResponse response);
  onError(String msg, int status);
  onReportError(String msg, int status);
}

class FeedPresenter {
  FeedInterface _view;
  RestDatasource api = RestDatasource();

  FeedPresenter(this._view);

  doAllPostResponseData(String page ,String limit) {
    api.allPostData(page,limit)
        .then((AllPostResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onAllPostResponse(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }

  //Upload Post
  doPostSlot(String filePath,List<int>? fileName,String caption, List tagIds) {
    api.uploadPostUpload(filePath, fileName, caption, tagIds)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onPostSlotResponse(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      }
      else if (successResponse.status == 404) {
        _view.onError(successResponse.message!, successResponse.status!);
      }
      else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }
  //Upload Post
  doPostSlotMobile(File filePath,String caption, List tagIds) {
    api.uploadPostUploadMobile(filePath,caption, tagIds)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onPostSlotResponse(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      }
      else if (successResponse.status == 404) {
        _view.onError(successResponse.message!, successResponse.status!);
      }
      else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }
  //Users All this API
  doAllUsers() {
    api.allUsers()
        .then((AllUserForTagResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onAllUserResponse(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }
  //End

  doDeleteSlot(String postId) {
    api.deletePost(postId)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onDeletePost(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }

  doReportforSlot(String postId,String message,String otherUserID) {
    api.postReportUser(postId,message,otherUserID)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onReportPost(successResponse);
      } else if (successResponse.status == 400) {
        _view.onReportError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onReportError(successResponse.message!, successResponse.status!);
      }else {
        _view.onReportError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onReportError(error.toString(), 500));
  }


  doBlockPost(String userId, bool status) {
    api.blockPost(userId,status)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onBlockPost(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }
  doHidePost(String userId, bool status) {
    api.hidePost(userId,status)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onHidePost(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }

  doPostTags(String postID) {
    api.postTagUsers(postID)
        .then((PostTagUsersResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onPostTag(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }
  doPostLike(String postID,String type) {
    api.postLikeUsers(postID,type)
        .then((LikeUsersResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onPostLike(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }
  doCommentData(String postID) {
    api.getAllPostComment(postID)
        .then((PostCommentUsersResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onPostCommentList(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }

  doPostComment(String postID,String comment) {
    api.postComment(postID,comment)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onPostComment(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }

  doLikePost(String postId, bool status,String type) {
    api.likePost(postId,status,type)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onLikeByUserPost(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }

  doEditPost(String caption, List tagIds,String postId) {
    api.editPost(caption, tagIds,postId)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onPostSlotResponse(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }
  doEditPostMobile(String caption, List tagIds,String postId) {
    api.editPost(caption, tagIds,postId)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onPostSlotResponse(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }
  doCreateCommentLike(String postId,String commentId,String text,String unicode,) {
    api.createLikeComment(postId, commentId,text,unicode)
        .then((CreateCommentResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onPostLikeComment(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }
  doCreateHeartLike(String postId,String commentId,String status) {
    api.forHeartLike(postId, commentId,status)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onPostHeartLike(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }
  doUserResponseData(String userID) {
    api.userProfileData(userID)
        .then((UserProfileResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onProfileResponse(successResponse);
      }
      else if (successResponse.status == 404) {
        _view.onError(successResponse.message!, successResponse.status!);
      }
      else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }
  doDeleteComment(String commentId) {
    api.deleteCommentApi(commentId)
        .then((SuccessResponse successResponse) {
      if (successResponse.status == 200) {
        _view.onDeleteComment(successResponse);
      } else if (successResponse.status == 400) {
        _view.onError(successResponse.message!, successResponse.status!);
      } else if (successResponse.status == 401) {
        _view.onError(successResponse.message!, successResponse.status!);
      }else {
        _view.onError(
            successResponse.message.toString(), successResponse.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 500));
  }
}
