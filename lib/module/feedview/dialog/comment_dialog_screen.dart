import 'dart:async';
import 'package:flutter/foundation.dart' as foundation;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/module/model/all_post_response.dart';
import 'package:likeplay/module/model/alluser_tag_response.dart';
import 'package:likeplay/module/model/create-comment_response.dart';
import 'package:likeplay/module/model/like_users_response.dart';
import 'package:likeplay/module/model/postTag_users_response.dart';
import 'package:likeplay/module/model/post_comment_users_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import 'package:likeplay/module/model/user_profile_response.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/constant_lists.dart';
import '../../../utils/custom_scroll_behavior.dart';
import '../../../utils/responsive.dart';
import '../../../utils/sharedpref/preferences.dart';
import '../../../utils/sharedpref/shared_prefrence.dart';
import '../../../utils/string_utils.dart';
import '../../../utils/utils.dart';
import '../../model/comment_model.dart';
import '../../profile/profile_screen.dart';
import '../feed_presenter.dart';

class CommentDialogScreen extends StatefulWidget {
  String userName;
  String postID;
  String userProfile;
  String postDate;
  bool isLoading;

  CommentDialogScreen({
    required this.userName,
    required this.userProfile,
    required this.postID,
    required this.postDate,
    required this.isLoading,
  });
  @override
  State<CommentDialogScreen> createState() => _CommentDialogScreenState();
}

class _CommentDialogScreenState extends State<CommentDialogScreen> implements FeedInterface{
  TextEditingController messageController = TextEditingController();
  TextEditingController emojiController = TextEditingController();
  bool isLoading = false;
  FeedPresenter? feedPresenter;
  final List <CommentModel> postCommentUsers=[];
  ScrollController controller = ScrollController();
  bool? isShowSticker;
  String commentId="";
  @override
  void initState() {
    super.initState();

    feedPresenter=FeedPresenter(this);
    setState(() {
      isLoading=true;
      isShowSticker = false;
      feedPresenter?.doCommentData(widget.postID);
    });
  }
  Future<bool> _onWillPop() async {
    setState(() {
      isShowSticker=false;
    });
    return true; //<-- SEE HERE
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child:   AlertDialog(
        contentPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        actions: [
          Container(
            width: Responsive().getResponsiveValue(
                forLargeScreen: MediaQuery
                    .of(context)
                    .size
                    .width / 3.8,
                forShortScreen: MediaQuery
                    .of(context)
                    .size
                    .width,
                forMobLandScapeMode: MediaQuery
                    .of(context)
                    .size
                    .width,
                forMediumScreen: MediaQuery
                    .of(context)
                    .size
                    .width,
                forTabletScreen: MediaQuery
                    .of(context)
                    .size
                    .width,
                context: context),
            height: Responsive().getResponsiveValue(
                forLargeScreen: MediaQuery
                    .of(context)
                    .size
                    .height / 1.6,
                forShortScreen: MediaQuery
                    .of(context)
                    .size
                    .height / 2,
                forMobLandScapeMode: MediaQuery
                    .of(context)
                    .size
                    .height / 1.8,
                forMediumScreen: MediaQuery
                    .of(context)
                    .size
                    .height / 1.8,
                forTabletScreen: MediaQuery
                    .of(context)
                    .size
                    .height / 1.8,
                context: context),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isShowSticker=false;
                        });
                      },
                      child: Container(
                        alignment: Alignment.topLeft,
                        width: Responsive().getResponsiveValue(
                            forLargeScreen: MediaQuery
                                .of(context)
                                .size
                                .width / 3.8,
                            forShortScreen: MediaQuery
                                .of(context)
                                .size
                                .width,
                            forMobLandScapeMode: MediaQuery
                                .of(context)
                                .size
                                .width,
                            forMediumScreen: MediaQuery
                                .of(context)
                                .size
                                .width,
                            forTabletScreen: MediaQuery
                                .of(context)
                                .size
                                .width,
                            context: context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Gap(10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Gap(12),
                                SizedBox(
                                  height: 32,
                                  width: 32,
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: widget.userProfile != "" ? IMAGE_URL +
                                          widget.userProfile : "",
                                      imageBuilder:
                                          (context, imageProvider) =>
                                          Container(
                                              decoration:
                                              BoxDecoration(
                                                borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8)),
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.fill,

                                                ),
                                              )),
                                      placeholder: (context, url) =>
                                      const Image(
                                          image: AssetImage(
                                              "assets/images/icon_loading.png")),
                                      errorWidget: (context, url,
                                          error) =>
                                      const Image(
                                          image: AssetImage(
                                              "assets/images/icon_loading.png")),
                                      width: 32,
                                      height: 32,
                                    ),
                                  ),
                                ),
                                Gap(12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Utils.mediumHeadingNormalText(text: widget.userName,
                                        textSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.APP_TEXT_COLOR),
                                    Utils.mediumHeadingNormalText(
                                        text: Utils.convertDate(widget.postDate),
                                        textSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.APP_TEXT_COLOR_SECOND),

                                  ],)
                              ],),
                            Divider(
                              color: HexColor("#E2E2E2"),
                              thickness: 1,
                            ),
                            Gap(12),
                            SizedBox(
                                height: Responsive().getResponsiveValue(
                                    forLargeScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 2.4,
                                    forShortScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 3.1,
                                    forMobLandScapeMode: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 2.8,
                                    forMediumScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 2.8,
                                    forTabletScreen: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 2.8,
                                    context: context),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    controller: controller,
                                    scrollDirection: Axis.vertical,
                                    //itemCount: commentUsers.length,
                                    itemCount: postCommentUsers.length,
                                    itemBuilder: (_, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          left: 12, right: 12, bottom: 12,),
                                        child: Column(mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileScreen(
                                                          userId:   postCommentUsers[index].id.toString()
                                                      )));
                                                    },
                                                    child: SizedBox(
                                                      height: 30,
                                                      width: 30,
                                                      child: ClipOval(
                                                        child: CachedNetworkImage(
                                                          imageUrl: postCommentUsers[index].profileurl,
                                                          imageBuilder:
                                                              (context, imageProvider) =>
                                                              Container(
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    borderRadius:
                                                                    const BorderRadius.all(
                                                                        Radius.circular(8)),
                                                                    image: DecorationImage(
                                                                      image: imageProvider,
                                                                      fit: BoxFit.fill,

                                                                    ),
                                                                  )),
                                                          placeholder: (context, url) =>
                                                          const Image(
                                                              image: AssetImage(
                                                                  "assets/images/icon_loading.png")),
                                                          errorWidget: (context, url,
                                                              error) =>
                                                          const Image(
                                                              image: AssetImage(
                                                                  "assets/images/icon_loading.png")),
                                                          width: 32,
                                                          height: 32,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Gap(12),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .spaceAround,
                                                        children: [
                                                          Utils.mediumHeadingNormalText(
                                                              text: postCommentUsers[index]
                                                                  .name,
                                                              textSize: 12,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              color: AppColor
                                                                  .APP_TEXT_COLOR),
                                                          // Utils.mediumHeadingNormalText(text:"11",textSize: 10,fontWeight: FontWeight.w500,color: AppColor.APP_TEXT_COLOR_SECOND),
                                                        ],),
                                                      Container(
                                                        width: Responsive().getResponsiveValue(
                                                            forLargeScreen: MediaQuery.of(context).size.width /5.8,
                                                            forShortScreen: MediaQuery.of(context).size.width/3,
                                                            forMobLandScapeMode: MediaQuery.of(context).size.width/2,
                                                            forMediumScreen: MediaQuery.of(context).size.width/3,
                                                            forTabletScreen: MediaQuery.of(context).size.width/2,
                                                            context: context),
                                                        child: Utils.mediumHeadingNormalText(
                                                            text:postCommentUsers[index].comment,
                                                            textSize: 10,
                                                            textAlign: TextAlign.start,
                                                            fontWeight: FontWeight.w500,
                                                            color: AppColor
                                                                .APP_TEXT_COLOR_SECOND),),
                                                      Container(
                                                        width: Responsive().getResponsiveValue(
                                                            forLargeScreen: MediaQuery.of(context).size.width /5.8,
                                                            forShortScreen: MediaQuery.of(context).size.width/2,
                                                            forMobLandScapeMode: MediaQuery.of(context).size.width/2,
                                                            forMediumScreen: MediaQuery.of(context).size.width/2,
                                                            forTabletScreen: MediaQuery.of(context).size.width/2,
                                                            context: context),
                                                        child: Row(
                                                          children: [
                                                            postCommentUsers[index].likeCount=="0"?SizedBox():
                                                            Utils.mediumHeadingNormalText(
                                                                text:postCommentUsers[index].likeCount+" Like",
                                                                textSize: 12,
                                                                textAlign: TextAlign.start,
                                                                fontWeight: FontWeight.normal,
                                                                color: AppColor
                                                                    .APP_TEXT_COLOR_SECOND),
                                                            postCommentUsers[index].likeCount=="0"?SizedBox(): Gap(6),
                                                            /* Container(
                                                          padding: EdgeInsets.only(left: 4,right: 4,top: 2,bottom: 2),
                                                          decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(12),
                                                            color: Colors.grey,
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Utils.mediumHeadingNormalText(
                                                                  text:"1",
                                                                  textSize: 10,
                                                                  textAlign: TextAlign.start,
                                                                  fontWeight: FontWeight.normal,
                                                                  color: Colors.black),
                                                              Gap(1.5),
                                                              Utils.imageView(image: "assets/images/ic_smileComment.png",height: 12,width: 12),
                                                            ],
                                                          ),
                                                        ),*/
                                                            GestureDetector(
                                                                onTap: (){
                                                                  // showEmojiDialog(context,postCommentUsers[index].id.toString());
                                                                  setState(() {
                                                                    isShowSticker=true;
                                                                    commentId=postCommentUsers[index].commentId.toString();
                                                                    });
                                                                },
                                                                child: Utils.imageView(image: "assets/images/ic_smileComment.png",height: 14,width: 14)),
                                                            Gap(6),
                                                            postCommentUsers[index].commentList.isNotEmpty?
                                                            Container(
                                                              height: 20,
                                                              width: MediaQuery.of(context).size.width/3,
                                                              child: ScrollConfiguration(
                                                                  behavior: MyCustomScrollBehavior(),
                                                                  child: ListView.builder(
                                                                      shrinkWrap: true,
                                                                      scrollDirection: Axis.horizontal,
                                                                      itemCount: postCommentUsers[index].commentList.length,
                                                                      itemBuilder: (_, indexTem) {
                                                                        return Container(
                                                                          padding: EdgeInsets.only(left: 6,right: 6,top: 2,bottom: 2),
                                                                          margin: EdgeInsets.only(left: 4),
                                                                          decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(8),
                                                                            color: Colors.grey.withOpacity(0.4),
                                                                          ),
                                                                          child: Row(
                                                                            children: [
                                                                              /*  Utils.mediumHeadingNormalText(
                                                                              text:postCommentUsers[index].commentList[indexTem].test,
                                                                              textSize: 10,
                                                                              textAlign: TextAlign.start,
                                                                              fontWeight: FontWeight.normal,
                                                                              color: Colors.black),*/
                                                                              Gap(1.5),
                                                                              Utils.mediumHeadingNormalText(
                                                                                  text:postCommentUsers[index].commentList[indexTem].emojiCount.toString()+
                                                                                      postCommentUsers[index].commentList[indexTem].test.toString(),
                                                                                  textSize: 10,
                                                                                  textAlign: TextAlign.start,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  color: Colors.black),
                                                                              Gap(1.5),
                                                                              // Utils.imageView(image: "assets/images/ic_smileComment.png",height: 12,width: 12),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      })),
                                                            ):Container(),
                                                          ],
                                                        ),)
                                                    ],),
                                                  Spacer(),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Utils.mediumHeadingNormalText(
                                                          text: postCommentUsers[index].commentTime,
                                                          textSize: 10,
                                                          fontWeight: FontWeight.normal,
                                                          color: AppColor.grey),
                                                      Gap(4),
                                                     Row(
                                                       mainAxisAlignment: MainAxisAlignment.start,
                                                       crossAxisAlignment: CrossAxisAlignment.start,
                                                       children: [
                                                         postCommentUsers[index].likeStatus==false?
                                                         GestureDetector(
                                                             onTap: (){
                                                               setState(() {
                                                                 postCommentUsers[index].likeStatus=true;
                                                               });
                                                               feedPresenter!.doCreateHeartLike(widget.postID,postCommentUsers[index].commentId.toString(),"1");
                                                             },
                                                             child: Padding(
                                                               padding: const EdgeInsets.all(3.0),
                                                               child: Utils.imageView(image: "assets/images/ic_likeComment.png",height: 12,width: 12),
                                                             )):
                                                         GestureDetector(
                                                             onTap: (){
                                                               setState(() {
                                                                 postCommentUsers[index].likeStatus=false;
                                                               });
                                                               feedPresenter!.doCreateHeartLike(widget.postID,postCommentUsers[index].commentId.toString(),"0");
                                                             },
                                                             child: Padding(
                                                               padding: const EdgeInsets.all(3.0),
                                                               child: Utils.imageView(image: "assets/images/redCommentLike.png",height: 12,width: 12),
                                                             )),
                                                         SessionManager.getString(Preferences.USER_ID)==
                                                             postCommentUsers[index].id.toString()?
                                                         GestureDetector(
                                                           onTap: (){
                                                             showAlertDeleteCommentDialog(context, postCommentUsers[index].commentId.toString());
                                                           },
                                                           child: Padding(
                                                             padding: const EdgeInsets.all(2.0),
                                                             child: Icon(Icons.delete,color: Colors.red,size: 14,),
                                                           ),
                                                         ):SizedBox()
                                                       ],
                                                     )
                                                    ],
                                                  )
                                                ]),
                                          ],
                                        ),
                                      );
                                    })),
                          ],),),
                    ),
                  ],),
                Positioned(
                    bottom: 0,
                    left: 10,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                              vertical: 16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8),

                          height:Responsive().getResponsiveValue(
                              forLargeScreen: 50.0,
                              forShortScreen: 50.0,
                              forTabletScreen: 50.0,
                              forMediumScreen: 50.0,
                              context: context),
                          width: Responsive().getResponsiveValue(
                              forLargeScreen: MediaQuery.of(context).size.width / 4.5,
                              forShortScreen: MediaQuery.of(context).size.width / 1.7,
                              forTabletScreen: MediaQuery.of(context).size.width / 1.4,
                              forMediumScreen: MediaQuery.of(context).size.width / 1.7,
                              context: context),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: AppColor.APP_TEXT_COLOR,
                                width: 1.0,
                                style: BorderStyle.solid
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            children: [
                              const Gap(10),
                              Expanded(
                                child: TextField(
                                  onTap: () {
                                    if (isShowSticker != false) {
                                      setState(() {
                                        isShowSticker = !isShowSticker!!;
                                      });
                                    }
                                  },
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  cursorColor: AppColor.appDarkColor,
                                  controller: messageController,
                                  textInputAction:TextInputAction.done,
                                  style: const TextStyle(
                                      color: AppColor.black),
                                  decoration:  InputDecoration(
                                    hintText: "Type your message here",
                                    hintStyle: TextStyle(
                                      color: AppColor.black,
                                      fontSize: Responsive().getResponsiveValue(
                                          forLargeScreen: 13.0,
                                          forShortScreen:12.0,
                                          forTabletScreen: 12.0,
                                          forMediumScreen: 12.0,
                                          context: context),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(10),
                        GestureDetector(
                          onTap: () {
                            if (messageController.text
                                .toString()
                                .isEmpty) {
                              Utils.customDialog(context,message:UtilStrings.Enter_Your_Comment);
                            }
                            else {
                              setState(() {
                                isLoading = true;
                                isShowSticker=false;
                                Utils.scroll(controller);
                                Utils.hideKeyBoard(context);
                                feedPresenter?.doPostComment(widget.postID, messageController.text.toString());
                              });
                            }
                          },
                          child: Utils.mediumHeadingNormalText(text: "Post",
                              textSize: 12,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                        Gap(8),
                      ],)),
                Offstage(
                  offstage: !isShowSticker!,
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                    height: 200,
                    width: Responsive().getResponsiveValue(
                        forLargeScreen: MediaQuery.of(context).size.width / 3.8,
                        forShortScreen: MediaQuery.of(context).size.width,
                        forMobLandScapeMode: MediaQuery.of(context).size.width,
                        forMediumScreen: MediaQuery.of(context).size.width,
                        forTabletScreen: MediaQuery.of(context).size.width,
                        context: context),
                    child: EmojiPicker(
                      onEmojiSelected: (Category? category, Emoji emoji) {
                        // Do something when emoji is tapped (optional)
                        int codePoint = emoji.emoji.codeUnitAt(0);
                        String unicode = 'U+' + codePoint.toRadixString(16).toUpperCase();
                        feedPresenter!.doCreateCommentLike(widget.postID,commentId,emoji.emoji.toString(),unicode);
                        // Navigator.pop(context);
                        setState(() {
                          isShowSticker=false;
                        });
                      },
                      onBackspacePressed: () {
                        // Do something when the user taps the backspace button (optional)
                        // Set it to null to hide the Backspace-Button
                      },
                      textEditingController: emojiController,
                      config: Config(
                        columns: 8,
                        verticalSpacing: 0,
                        horizontalSpacing: 0,
                        gridPadding: EdgeInsets.zero,
                        bgColor: Colors.white,
                        indicatorColor: Theme.of(context).primaryColor,
                        iconColor: Colors.grey,
                        iconColorSelected: Theme.of(context).primaryColor,
                        backspaceColor: Theme.of(context).primaryColor,
                        skinToneDialogBgColor: Colors.white,
                        skinToneIndicatorColor: Colors.grey,
                        enableSkinTones: true,
                        //showRecentsTab: true,
                        recentsLimit: 32,
                        noRecents: const Text(
                          'Pas d\'émojis récents',
                          style: TextStyle(fontSize: 20, color: Colors.black26),
                          textAlign: TextAlign.center,
                        ),
                        tabIndicatorAnimDuration: kTabScrollDuration,
                        categoryIcons: const CategoryIcons(),
                        buttonMode: ButtonMode.MATERIAL,
                      ),
                    ),
                  ),
                ),
                Utils.progressDialog(context, isLoading, type: 3)
              ],),
          ),
        ],
      ),
    );
  }
  @override
  onReportError(String msg, int status) {
    setState(() {
      isLoading=false;
    });
    if(status==400){
      Utils.customDialog(context,message:msg.toString());
      Navigator.pop(context);
    }
  }

  @override
  onAllPostResponse(AllPostResponse response) {

  }

  @override
  onAllUserResponse(AllUserForTagResponse response) {

  }

  @override
  onBlockPost(SuccessResponse response) {
  }

  @override
  onDeletePost(SuccessResponse response) {
  }

  @override
  onError(String msg, int status) {
    print("onError===>"+msg.toString());
    setState(() {
      isLoading=false;
    });
    if(status==401){
      Utils.sessionExpire(context);
    }
    else if(status==404){
      Utils.sessionExpire(context);
    }
  }

  @override
  onPostCommentList(PostCommentUsersResponse response) {
    setState(() {
      isLoading=false;
      widget.isLoading=false;
      if(response.status==200){
        messageController.text="";
        postCommentUsers.clear();
        // for(int i=0;i< response.data!.comments!.length;i++){
        for(var item in response.data!.comments!){
          // print("user id=="+item.id!.toString());
          CommentModel commentList=CommentModel(id: item.commentBy!.toInt(),
              name:item.commentDeatils!.name.toString(),
              profileurl: item.commentDeatils!.userImagesWhileSignup!.isNotEmpty?
              item.commentDeatils!.userImagesWhileSignup![0].imageUrl.toString()==""?"": IMAGE_URL+ item.commentDeatils!.userImagesWhileSignup![0].imageUrl.toString():"",
              comment: item.comment.toString(),
              commentList:  item.commentDetails!.isNotEmpty?item.commentDetails!:[],
              likeStatus: item.userLikeStatus.toString()=="0"?false :true,
              likeCount:item.heartCount.toString(), commentTime:Utils.formatDateToTimeAgo(item.createdAt.toString()),  commentId: item.id!);
          postCommentUsers.add(commentList);
          Utils.scroll(controller);
        }
      }
    });
  }
  showEmojiDialog(BuildContext context,String commentId) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setInnerState) {
            return  AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              actions: [
                Container(
                  height: MediaQuery.of(context).size.height/2,
                  width: MediaQuery.of(context).size.width/4,
                  child: EmojiPicker(
                    onEmojiSelected: (Category? category, Emoji emoji) {
                      // Do something when emoji is tapped (optional)
                      int codePoint = emoji.emoji.codeUnitAt(0);
                      String unicode = 'U+' + codePoint.toRadixString(16).toUpperCase();
                      feedPresenter!.doCreateCommentLike(widget.postID,commentId,emoji.emoji.toString(),unicode);
                      Navigator.pop(context);

                    },
                    onBackspacePressed: () {
                      // Do something when the user taps the backspace button (optional)
                      // Set it to null to hide the Backspace-Button
                    },
                    textEditingController: emojiController,
                    config: Config(
                      emojiSizeMax: 32 *
                          (foundation.defaultTargetPlatform ==
                              TargetPlatform.iOS
                              ? 1.30
                              : 1.0),
                      columns: 8,
                      verticalSpacing: 0,
                      horizontalSpacing: 0,
                      gridPadding: EdgeInsets.zero,
                      bgColor: Colors.white,
                      indicatorColor: Theme.of(context).primaryColor,
                      iconColor: Colors.grey,
                      iconColorSelected: Theme.of(context).primaryColor,
                      backspaceColor: Theme.of(context).primaryColor,
                      skinToneDialogBgColor: Colors.white,
                      skinToneIndicatorColor: Colors.grey,
                      enableSkinTones: true,
                      //showRecentsTab: false,
                      tabIndicatorAnimDuration: kTabScrollDuration,
                      categoryIcons: const CategoryIcons(),
                      buttonMode: ButtonMode.MATERIAL,
                    ),
                  ),
                )
              ],
            );
          });
        });
  }
  @override
  onPostComment(SuccessResponse response) {
    setState(() {
      isLoading=false;
      if(response.status==200){
        messageController.text="";
        /* Utils.customDialog(response.message.toString());*/
        feedPresenter?.doCommentData(widget.postID);
      }
    });
  }

  @override
  onPostLike(LikeUsersResponse response) {
  }

  @override
  onPostSlotResponse(SuccessResponse response) {
  }

  @override
  onPostTag(PostTagUsersResponse response) {
  }

  @override
  onReportPost(SuccessResponse response) {
  }

  @override
  onHidePost(SuccessResponse response) {

  }

  @override
  onLikeByUserPost(SuccessResponse response) {

  }

  @override
  onPostLikeComment(CreateCommentResponse response) {
    print("response===>"+response.message.toString());
    if(response.status==200){
      feedPresenter?.doCommentData(widget.postID);
    }
  }

  @override
  onPostHeartLike(SuccessResponse response) {
    if(response.status==200){
      feedPresenter?.doCommentData(widget.postID);
    }
  }

  @override
  onProfileResponse(UserProfileResponse response) {

  }
  showAlertDeleteCommentDialog(BuildContext context,String commentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
          backgroundColor: Colors.transparent,
          actions: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(width: 1.0, color: Colors.black26)),
              // margin: const EdgeInsets.only(left: 20,right: 20),
              width:  Responsive().getResponsiveValue(
                  forLargeScreen:  MediaQuery.of(context).size.width/3.8,
                  forShortScreen:  MediaQuery.of(context).size.width,
                  forMobLandScapeMode: MediaQuery.of(context).size.width,
                  forMediumScreen: MediaQuery.of(context).size.width,
                  forTabletScreen: MediaQuery.of(context).size.width/1.1,
                  context: context),
              height:  Responsive().getResponsiveValue(
                  forLargeScreen:  MediaQuery.of(context).size.height/4,
                  forShortScreen:  MediaQuery.of(context).size.height/4.2,
                  forMobLandScapeMode: MediaQuery.of(context).size.height/4,
                  forMediumScreen: MediaQuery.of(context).size.height/4.2,
                  forTabletScreen: MediaQuery.of(context).size.height/4,
                  context: context),
              child: Wrap(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20,bottom: 10.0),
                    child: Center(
                      child: Utils.mediumHeadingNormalText(text:"Delete Comment",textSize: 16,fontWeight: FontWeight.bold,color: HexColor("#242424")),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child:Utils.mediumHeadingNormalText(text:"Are you sure want to delete your comment?",textSize: 12,fontWeight: FontWeight.normal,color: HexColor("#7B7F91")),

                  ),
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.only(top: 30.0,bottom: 20),
                            decoration: BoxDecoration(
                              color: HexColor("#F0F0F0"),
                              borderRadius: BorderRadius.circular(8),
                              //border: Border.all(color: HexColor("#FF483C"))
                            ),
                            child: Text("Cancel",textAlign:TextAlign.center,style: TextStyle(color: Colors.black),),
                          ),
                          SizedBox(width: 12,),
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                              setState(() {
                                isLoading=true;
                              });
                              feedPresenter!.doDeleteComment(commentId);
                            },
                            child: Container(
                              width: 120,
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(top: 30.0,bottom: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: HexColor("#FF483C"),
                              ),
                              child: Text("Delete",textAlign:TextAlign.center,style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  onDeleteComment(SuccessResponse response) {
    print("response===>"+response.message.toString());

    setState(() {
      isLoading=false;
    });
    if(response.status==200){
      feedPresenter?.doCommentData(widget.postID);
    }
  }
}
