import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
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
import '../../../utils/responsive.dart';
import '../../../utils/string_utils.dart';
import '../../../utils/utils.dart';
import '../../model/comment_model.dart';
import '../../model/user_model.dart';
import '../../profile/profile_screen.dart';
import '../feed_presenter.dart';

class TagsDialogScreen extends StatefulWidget {
  String userName;
  String postID;
  String userProfile;
  String postDate;
  bool isLoading;

  TagsDialogScreen({
    required this.userName,
    required this.userProfile,
    required this.postID,
    required this.postDate,
    required this.isLoading,
  });
  @override
  State<TagsDialogScreen> createState() => _TagsDialogScreenState();
}

class _TagsDialogScreenState extends State<TagsDialogScreen> implements FeedInterface{
  TextEditingController messageController = TextEditingController();
  bool isLoading = false;
  FeedPresenter? feedPresenter;
  final List <UserModel> postTagUsers=[];
  ScrollController controller = ScrollController();
  @override
  void initState() {
    super.initState();

    feedPresenter=FeedPresenter(this);
    setState(() {
      isLoading=true;
      feedPresenter?.doPostTags(widget.postID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      actions: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(width: 1.0, color: Colors.black26)),
          /*  margin:  EdgeInsets.only(left: Responsive().getResponsiveValue(
                  forLargeScreen:  0.0,
                  forShortScreen:  16,
                  forMobLandScapeMode: 16,
                  forMediumScreen: 16,
                  forTabletScreen:16,
                  context: context),right: Responsive().getResponsiveValue(
                  forLargeScreen:  0.0,
                  forShortScreen:  16,
                  forMobLandScapeMode: 16,
                  forMediumScreen: 16,
                  forTabletScreen:16,
                  context: context)),*/
          width:  Responsive().getResponsiveValue(
              forLargeScreen:  MediaQuery.of(context).size.width/3.8,
              forShortScreen:  MediaQuery.of(context).size.width,
              forMobLandScapeMode: MediaQuery.of(context).size.width,
              forMediumScreen: MediaQuery.of(context).size.width,
              forTabletScreen: MediaQuery.of(context).size.width,
              context: context),
          height:  Responsive().getResponsiveValue(
              forLargeScreen:  MediaQuery.of(context).size.height/1.4,
              forShortScreen:  MediaQuery.of(context).size.height/1.7,
              forMobLandScapeMode: MediaQuery.of(context).size.height/1.7,
              forMediumScreen: MediaQuery.of(context).size.height/1.7,
              forTabletScreen: MediaQuery.of(context).size.height/1.7,
              context: context),
          child: Wrap(
            children: [
              Center(
                  child:Stack(children: [
                    Column(children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        child: Utils.mediumHeadingNormalText(text:"Tag Users",textSize: 12,textAlign:TextAlign.center,fontWeight: FontWeight.normal,color: AppColor.APP_TEXT_COLOR),
                      ),
                      Divider(
                        color: HexColor("#E2E2E2"),
                        thickness: 1,
                      ),
                      Gap(12),
                      SizedBox(
                          height:Responsive().getResponsiveValue(
                              forLargeScreen:  MediaQuery.of(context).size.height/2.5,
                              forShortScreen:  MediaQuery.of(context).size.height/2.8,
                              forMobLandScapeMode: MediaQuery.of(context).size.height/3.2,
                              forMediumScreen: MediaQuery.of(context).size.height/2.8,
                              forTabletScreen: MediaQuery.of(context).size.height/3.2,
                              context: context),
                          child:ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: postTagUsers.length,
                              itemBuilder: (_, index) {
                                return   Padding(
                                  padding: const EdgeInsets.only(left:16,right: 16,bottom: 12,),
                                  child: Column(
                                    children: [
                                      Row(children: [
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileScreen(
                                                userId:   postTagUsers[index].id.toString()
                                            )));
                                          },
                                          child: CachedNetworkImage(
                                            imageUrl:postTagUsers[index].profileurl!=""? postTagUsers[index].profileurl:"",
                                            imageBuilder: (context, imageProvider) => Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                                                  image: DecorationImage(
                                                    image:imageProvider,
                                                    fit: BoxFit.fill,
                                                  ),
                                                )),
                                            placeholder: (context, url) =>  const Image(image: AssetImage("assets/images/icon_loading.png")),
                                            errorWidget: (context, url, error) =>   const Image(image: AssetImage("assets/images/icon_loading.png")),
                                            width: 22,
                                            height: 22,
                                          ),
                                        ),
                                        Gap(12),
                                        Utils.mediumHeadingNormalText(text:postTagUsers[index].name,textSize: 12,fontWeight: FontWeight.w500,color: Colors.black),
                                      ]),
                                    ],
                                  ),
                                );
                              }))
                    ],),
                    Utils.progressDialog(context, isLoading,type: 4)
                  ],)

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child:Container(
                        width: 120,
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.only(top: 10.0,bottom: 10),
                        decoration: BoxDecoration(
                          color: HexColor("#F0F0F0"),
                          borderRadius: BorderRadius.circular(8),/*
                              border: Border.all(color: HexColor("#FF483C"))*/
                        ),
                        child:  Utils.mediumHeadingNormalText(text:"Cancel",textSize: 12,textAlign:TextAlign.center,fontWeight: FontWeight.normal,color: Colors.black),

                      )),
                ],
              ),
            ],
          ),
        ),
      ],
    );
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
    print("onError==>"+onError.toString());
    setState(() {
      isLoading=false;
    });
  }

  @override
  onPostCommentList(PostCommentUsersResponse response) {
  }

  @override
  onPostComment(SuccessResponse response) {

  }

  @override
  onPostLike(LikeUsersResponse response) {

  }

  @override
  onPostSlotResponse(SuccessResponse response) {
  }

  @override
  onPostTag(PostTagUsersResponse response) {
    setState(() {
      isLoading=false;
      if(response.status==200){
        postTagUsers.clear();
        for(var item in response.data!){
          UserModel postTag=UserModel(id: item.tagTo!.id!, name: item.tagTo!.name.toString(),
            profileurl:  item.tagTo!.userImagesWhileSignup!.isNotEmpty?
            item.tagTo!.userImagesWhileSignup![0].imageUrl.toString()==""?"":
            IMAGE_URL+ item.tagTo!.userImagesWhileSignup![0].imageUrl.toString():"",);
          postTagUsers.add(postTag);
        }
      }
    });
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
  onPostHeartLike(SuccessResponse response) {

  }

  @override
  onPostLikeComment(CreateCommentResponse response) {

  }
  @override
  onReportError(String msg, int status) {
    if(status==400){
      Utils.customDialog(context,message:msg.toString());
      Navigator.pop(context);
    }
  }

  @override
  onProfileResponse(UserProfileResponse response) {

  }

  @override
  onDeleteComment(SuccessResponse response) {
  }
}
