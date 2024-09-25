import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:likeplay/module/match/match_userprofile_screen.dart';
import 'package:likeplay/module/model/success_response.dart';
import 'package:likeplay/utils/constant_lists.dart';
import 'package:likeplay/utils/online_dating_tips.dart';
import 'package:need_resume/need_resume.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/responsive.dart';
import '../../utils/firebase/authentication_service.dart';
import '../../utils/sharedpref/preferences.dart';
import '../../utils/sharedpref/shared_prefrence.dart';
import '../../utils/string_utils.dart';
import '../../utils/utils.dart';
import '../model/match_response.dart';
import 'match_presenter.dart';

class MatchViewScreen extends StatefulWidget {

  @override
  State<MatchViewScreen> createState() => _MatchViewScreenState();
}

class _MatchViewScreenState extends ResumableState<MatchViewScreen> implements MatchInterface {
  DateTime ?dateTime;
  bool isLoading=false;
  int selectIndex=0;
  TextEditingController matchController = TextEditingController();
  List<UserDataMatch> matchList=[];
  MatchPresenter? matchPresenter;
  TextEditingController commentController = TextEditingController();
  final _authService = AuthenticationService();
 @override
  void initState() {
    super.initState();
    matchPresenter=MatchPresenter(this);
    setState(() {
      isLoading=true;
      matchPresenter?.onMatchData();
    });
  }
  void searchData(String value) {
    List<UserDataMatch> results = [];
    if (value.isEmpty) {
      matchPresenter?.onMatchData();
    } else {
      results = matchList.where((user) {
        final title = user.partnerData!
            .name.toString().toLowerCase();
        final desc = user.partnerData!.residenceCountry!.toLowerCase(); // added
        final searchLower = value.toLowerCase();
        return title.contains(searchLower) ||
            desc.contains(searchLower); //changed
      }).toList();
    }
    setState(() {
      matchList = results;
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      /*width: size.width,
      height: size.height,*/
      color: Colors.white,
      child: Stack(
        children: [
          Column(
            children: [
              /* Container(
                      margin: EdgeInsets.only(right: 12),
                      child:*/  /*Card(
                          color: HexColor("#FFFFFF"),
                          elevation: 8.0,
                          child:*/
              Container(
                decoration: Responsive().getResponsiveValue(
                    forLargeScreen: const BoxDecoration(
                        border: Border(
                            right: BorderSide(width: 1.0, color: Colors.black26),
                            left: BorderSide(width: 1.0, color:Colors.black26))),
                    context: context),
                width:  Responsive().getResponsiveValue(
                    forLargeScreen: MediaQuery.of(context).size.width,
                    context: context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResponsiveRowColumn(
                      rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                      rowCrossAxisAlignment: CrossAxisAlignment.start,
                      layout: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                          ? ResponsiveRowColumnType.COLUMN
                          : ResponsiveRowColumnType.ROW,
                      children: [
                        ResponsiveRowColumnItem(
                            rowFlex: 2, child:
                        Column(children: [
                         Container(
                            child: Column(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(20),
                                    child:Row(
                                      children:  [
                                        //Utils.
                                        Expanded(
                                            child: Container(
                                              height: 46,
                                              decoration: BoxDecoration(
                                                color:const Color.fromRGBO(250, 245, 241, 1),
                                                borderRadius: BorderRadius
                                                    .circular(10),
                                              ),
                                              child: TextField(
                                                onChanged: (value){
                                                  searchData(value);
                                                },
                                                style: TextStyle(
                                                  color:AppColor.black,
                                                  fontSize: 12,
                                                ),cursorColor: HexColor(AppColor.SIDE_TEXT_COLOR),
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: UtilStrings.Matches,
                                                    hintStyle: TextStyle(
                                                      color:HexColor(AppColor.SIDE_TEXT_COLOR),
                                                      fontSize: 12,
                                                    ),
                                                    contentPadding:EdgeInsets.all(13),
                                                    suffixIcon: Icon(Icons.search_outlined,color: Colors.black,)
                                                ),
                                              ),
                                            )
                                        ),
                                        Gap(12),
                                      ],
                                    )),
                                Container(
                                  color: Colors.grey,
                                  height: 1,
                                ),
                                const Gap(16),
                                Column(children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(onTap: (){
                                        showOnlineDetailDialog(context);
                                      },child:  Utils.mediumHeadingNormalText(text: UtilStrings.OnlineDatingTips,textSize: 14,fontWeight: FontWeight.w300,color: Colors.red,underline: true),
                                      ),

                                      Gap(32),
                                    ],
                                  ),
                                  Gap(20),
                                  matchList.isNotEmpty?Container(
                                    padding: EdgeInsets.all(10),
                                    height:
                                    Responsive().getResponsiveValue(
                                        forLargeScreen:
                                        MediaQuery.of(context).size
                                            .height,
                                        forShortScreen:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .height/1.5,
                                        forTabletScreen:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .height/1.5,
                                        forMediumScreen:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .height/1.3,
                                        context: context),
                                    child: ResponsiveGridList(
                                      maxItemsPerRow:  Responsive().getResponsiveValue(
                                          forLargeScreen: 4,
                                          forShortScreen: 2,
                                          forMobLandScapeMode: 2,
                                          forMediumScreen: 2,
                                          forTabletScreen: 2,
                                          context: context),
                                      minItemWidth: Responsive().getResponsiveValue(
                                          forLargeScreen: 160.0,
                                          forShortScreen: 160.0,
                                          forMobLandScapeMode: 160.0,
                                          forMediumScreen: 160.0,
                                          forTabletScreen: 160.0,
                                          context: context),
                                      children: List.generate(
                                        matchList.length,
                                            (index) =>GestureDetector(onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MatchUsersProfileScreen(
                                                  userId:   matchList[index].partnerData!.id.toString()
                                              )));
                                            },
                                                child:Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Stack(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(8),
                                                    child:  CachedNetworkImage(
                                                        imageUrl:matchList[index].partnerData!.userImagesWhileSignup!.isNotEmpty?IMAGE_URL+matchList[index].partnerData!.userImagesWhileSignup![0].imageUrl.toString():"",
                                                      imageBuilder: (context, imageProvider) => Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                                                            image: DecorationImage(
                                                              image:imageProvider,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          )),
                                                      placeholder: (context, url) =>  const Image(image: AssetImage("assets/images/icon_loading.png")),
                                                      errorWidget: (context, url, error) =>   const Image(image: AssetImage("assets/images/icon_loading.png")),
                                                      width: 155,
                                                      height: 110,
                                                    ),),
                                                  const Gap(12),
                                                  Utils.mediumHeadingNormalText(text:matchList[index].partnerData!.name.toString()=="null"?"NA":matchList[index].partnerData!.name,textSize: 12,fontWeight:  FontWeight.bold,color: AppColor.APP_TEXT_COLOR),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment:CrossAxisAlignment.start,
                                                    children: [
                                                      Utils.mediumHeadingNormalText(text:matchList[index].partnerData!.age.toString()=="null"?"NA":
                                                      matchList[index].partnerData!.age,textSize: 8,color: AppColor.APP_TEXT_COLOR_SECOND),
                                                      Utils.customBlackDot(),
                                                      Text(
                                                        matchList[index].partnerData!.residenceCountry.toString()=="null"?
                                                        "NA":matchList[index].partnerData!.residenceCountry.toString(),
                                                        textAlign:  TextAlign.start,
                                                        maxLines:1,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 8,

                                                          fontFamily: 'Poppins',
                                                        ),
                                                      ),
                                                      Gap(2),
                                                      Container(
                                                        height: 3,
                                                        width: 3,
                                                        margin: EdgeInsets.only(top: 5),
                                                        decoration: BoxDecoration(
                                                          color: AppColor.APP_TEXT_COLOR_SECOND,
                                                          borderRadius: BorderRadius.circular(100),
                                                        ),
                                                      ),
                                                      Gap(2),
                                                      Container(
                                                        alignment: Alignment.topLeft,
                                                        width:Responsive().getResponsiveValue(
                                                            forLargeScreen: 60.0,
                                                            forShortScreen: 64.0,
                                                            forMobLandScapeMode: 0.0,
                                                            forMediumScreen: 64.0,
                                                            forTabletScreen:64.0,
                                                            context: context) ,
                                                        child: Utils.mediumHeadingNormalText(text:matchList[index].partnerData!.employment.toString()=="null"?"NA":
                                                        matchList[index].partnerData!.employment,textSize: 8,fontWeight:  FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,overflow: TextOverflow.ellipsis),
                                                      ),
                                                    ],
                                                  ),
                                                  const Gap(10),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: (){
                                                          setState(() {
                                                            // isLoading=true;
                                                            // matchPresenter?.onSendRequest(matchList[index].partnerData!.id.toString(), "1");
                                                          });
                                                          //String subscriptionType,String subscriptionPlan,
                                                          showPopSendMatchRequest(context,matchList[index].partnerData!.id.toString(),
                                                              matchList[index].partnerData!.userImagesWhileSignup!.isNotEmpty?IMAGE_URL+matchList[index].partnerData!.userImagesWhileSignup![0].imageUrl.toString():"",
                                                              matchList[index].partnerData!.name.toString(),matchList[index].partnerData!.age.toString(),
                                                              matchList[index].partnerData!.residenceCountry.toString(),matchList[index].partnerData!.employment.toString(),
                                                            matchList[index].partnerData!.subscriptionStatus.toString(),
                                                            matchList[index].partnerData!.subscriptions!.isNotEmpty?
                                                            matchList[index].partnerData!.subscriptions![0].supscriptionType.toString():"",
                                                          );
                                                        },
                                                        child:Container(
                                                        height: 20,
                                                        width: 54,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(5),
                                                            color: HexColor(AppColor.RedColor)
                                                        ),
                                                        child: Icon(Icons.done,color: Colors.white,size: 17,),
                                                      )),
                                                      Gap(40),
                                                     GestureDetector(
                                                       onTap: (){
                                                         setState(() {
                                                           isLoading=true;
                                                           matchPresenter?.onSendRequest(matchList[index].partnerData!.id.toString(), "0");
                                                         });
                                                       },
                                                       child:Container(
                                                       height: 20,
                                                       width: 54,
                                                       padding: const EdgeInsets.only(left: 2.0,top: 2,bottom:2),
                                                       decoration: BoxDecoration(
                                                           borderRadius: BorderRadius.circular(5),
                                                           color: HexColor(AppColor.FillColor)
                                                       ),
                                                       child: Utils.imageView(image: "assets/images/icon_waving.png",height: 14,width:14),
                                                       // Icon(Icons.waving_hand,color: HexColor(AppColor.YellowColor),size: 17,),
                                                     ),),

                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 4.0,top: 12),
                                                child: Container(
                                                  height: 16,
                                                  width: 32,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: HexColor('#FF483C'),
                                                  ),
                                                  child:  Center(child:
                                                  Utils.mediumHeadingNormalText(text:  UtilStrings.New,textSize: 10,fontWeight:  FontWeight.w400,color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),

                                      ),
                                    ),

                                  ):
                                  Container(
                                      height:Responsive().getResponsiveValue(
                                          forLargeScreen: MediaQuery.of(context).size.height,
                                          forShortScreen: MediaQuery.of(context).size.height/1.8,
                                          forMobLandScapeMode: MediaQuery.of(context).size.height,
                                          forMediumScreen: MediaQuery.of(context).size.height/1.8,
                                          forTabletScreen:MediaQuery.of(context).size.height,
                                          context: context),
                                    alignment: Alignment.center,
                                    child: Utils.mediumHeadingNormalText(
                                        text: isLoading ==
                                            false
                                            ? UtilStrings
                                            .NO_RECORD
                                            : "",
                                        textSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.black,
                                        textAlign: TextAlign.end),
                                  ),
                                ],)
                              ],
                            ),),

                        ],)),

                        /* ResponsiveRowColumnItem(
                                      rowFlex: 1, child:
                                    Container(
                                      margin: EdgeInsets.only(left: 42,right: 42),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: HexColor(AppColor.BLACK)),
                                        borderRadius: BorderRadius.circular(8.0),
                                        color: HexColor(AppColor.BLACK),
                                      ),
                                      child:  Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Utils.mediumHeadingNormalText(text: "This month",
                                            color: AppColor.black,fontWeight: FontWeight.normal,textSize: 14),
                                      ),
                                    ),
                                    ),*/
                      ],
                    ),
                    Gap(20),
                  ],
                ),
              )

              //),
              //),
            ],
          ),
          Utils.progressDialog(context, isLoading, type: 3)
        ],
      ),
    );
  }


String receiverId="";
String receiverName="";
String receiverImage="";
String subscriptionStatus="";
String subscriptionPlanTemp="";
  Future<bool> _onWillPop() async {
    commentController.clear();
    return true; //<-- SEE HERE
  }
  showPopSendMatchRequest(
      BuildContext context,String userId,String profileImage,String userName,String age,
      String country,String occupation,String subscriptionType,String subscriptionPlan,) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setInnerState) {
            return WillPopScope(
                onWillPop: _onWillPop,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                actions: [
                  Column(
                    children: [
                      Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 8,right: 8),
                          decoration:BoxDecoration(
                            borderRadius:BorderRadius.circular(12),
                          /*  image: DecorationImage(
                              image: NetworkImage(profileImage),
                              fit: BoxFit.fill,
                            )*/
                          ), child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:  CachedNetworkImage(
                          imageUrl:profileImage,
                          imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                image: DecorationImage(
                                  image:imageProvider,
                                  fit: BoxFit.fill,
                                ),
                              )),
                          placeholder: (context, url) =>  const Image(image: AssetImage("assets/images/icon_loading.png")),
                          errorWidget: (context, url, error) =>   const Image(image: AssetImage("assets/images/icon_loading.png")),
                          width: 155,
                          height: 110,
                        ),)
                         ),
                      SizedBox(height: 15,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /*  Expanded(
                            flex: 1,
                            child: Container(
                                height: 200,
                                decoration:BoxDecoration(
                                  borderRadius:BorderRadius.circular(12),
                                ),
                                child: Image.network(profileImage,height: 200,
                                width:MediaQuery.of(context).size.width/6,fit: BoxFit.fill,))),*/
                          Gap(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Utils.mediumHeadingNormalText(text: userName,
                                  textSize: 12,
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                              Gap(10),
                              Row(
                                children: [
                                  Utils.mediumHeadingNormalText(text: age,
                                    textSize: 12,
                                    textAlign: TextAlign.start,
                                    fontWeight: FontWeight.normal,
                                    color: AppColor.APP_TEXT_COLOR_SECOND,),
                                  Utils.customBlackDot(),
                                  Utils.mediumHeadingNormalText(text: country,
                                    textSize: 12,
                                    textAlign: TextAlign.start,
                                    fontWeight: FontWeight.normal,
                                    color: AppColor.APP_TEXT_COLOR_SECOND,),
                                  Utils.customBlackDot(),
                                  Utils.mediumHeadingNormalText(text: occupation+" ",
                                    textSize: 12,
                                    textAlign: TextAlign.start,
                                    fontWeight: FontWeight.normal,
                                    color: AppColor.APP_TEXT_COLOR_SECOND,),

                                ],
                              ),
                              Gap(10),
                              RichText(text: TextSpan(
                                  text: "Comments",
                                  style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.black),
                                  children: [
                                    TextSpan(text: '(optional)',
                                      style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal, color: AppColor.APP_TEXT_COLOR_SECOND,),
                                    )
                                  ]
                              )),
                              Gap(15),
                              Container(
                                padding: EdgeInsets.all(0),
                                width: MediaQuery.of(context).size.width/1.4,
                                decoration:  BoxDecoration(
                                    border: Border.all(color:AppColor.grey),
                                    borderRadius:BorderRadius.circular(8)),
                                child: TextField(
                                  controller: commentController,
                                  textAlign: TextAlign.start,
                                  maxLines:3,
                                  cursorColor: HexColor(AppColor.SIDE_TEXT_COLOR),
                                  obscureText: false,
                                  decoration:InputDecoration(
                                      contentPadding: EdgeInsets.only(left:12,bottom:4,right: 10,top: 6),
                                      border: InputBorder.none,
                                      hintText: 'Enter comments'         ,
                                      hintStyle:const TextStyle(color:Colors.grey,fontFamily: 'Poppins',fontSize: 12)
                                  ),
                                ),
                              ),

                            ],
                          ),

                        ],
                      ),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              commentController.clear();
                              Navigator.pop(context);
                            },
                            child: Container(
                                height: 40,
                                width:80,
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: HexColor("#F0F0F0"),
                                  borderRadius: BorderRadius.circular(8),
                                  //border: Border.all(color: HexColor("#FF483C"))
                                ),
                                child: Center(child:Text("Cancel",textAlign:TextAlign.center,style: TextStyle(color: Colors.black,fontSize:10,)),)
                            ),
                          ),
                          Gap(30),
                          GestureDetector(
                            onTap: () async{
                              if(commentController.text.isEmpty){
                                //send request
                                Navigator.pop(context);
                                matchPresenter?.onSendRequest(userId, "1");
                              }else{
                                //Chat view
                                setState(() {
                                  receiverId=userId;
                                  receiverName=userName;
                                  receiverImage=profileImage;
                                  subscriptionStatus=subscriptionType;
                                  subscriptionPlanTemp=subscriptionPlan;
                                });
                                matchPresenter?.onSendRequest(userId, "1");
                                SessionManager.setString(Preferences.IS_MESSAGE, "");
                                Navigator.pop(context);
                              }
                            },
                            child: Container(
                              height: 40,
                              width:80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: HexColor('#FF483C')
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Utils.mediumHeadingNormalText(text: "Admire", textSize:10, fontWeight: FontWeight.bold, color: AppColor.white, overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],

              ),
            );
          });
        });
  }

  @override
  onError(String msg, int status) {
    print("onError===>"+msg);
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
  onSendRequest(SuccessResponse response) {
    setState(() async {
      isLoading=false;
      if(response.status==200){
        Utils.customDialog(context,message:response.message.toString());
        matchPresenter?.onMatchData();
        if(commentController.text.isEmpty){

        }else{
          await _authService.createChatUser(
            senderId:SessionManager.getString(Preferences.USER_ID),
            receiverId: receiverId,
            senderName: SessionManager.getString(Preferences.USER_NAME),
            receiverName:  receiverName,
            receiverImage: receiverImage,
            senderImage:   IMAGE_URL+SessionManager.getString(Preferences.PROFILE_IMAGE),
            admrireStatus: "0",
            subscriptionStatus: subscriptionStatus,
            subscriptionPlan:subscriptionPlanTemp,
          );
          _authService.sendMessage(
              SessionManager.getString(Preferences.USER_ID),
              receiverId,
              SessionManager.getString(Preferences.USER_NAME),
              receiverName,
              IMAGE_URL+SessionManager.getString(Preferences.PROFILE_IMAGE),
              receiverImage,
              "",
              commentController.text.toString(),
              0,
              "");
          commentController.clear();
        }
      }else{
      }
    });
  }

  @override
  void onResume() {
    matchPresenter?.onMatchData();
    super.onResume();
  }

  @override
  onMatch(MatchResponse response) {
    setState(() {
      isLoading=false;
      matchList.clear();
      if(response.status==200){
        matchList.addAll(response.data!.userData!);
      }
    });
  }
  showOnlineDetailDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  OnlineDatingTips();
      },
    );

  }

  @override
  onRequestError(String msg, int status) {
    print("onError===>"+msg);
    setState(() {
      isLoading=false;
    });
    if(status==400){
      Utils.customDialog(context,message: msg.toString());
    }
    else if(status==401){
      Utils.sessionExpire(context);
    }
    else if(status==404){
      Utils.sessionExpire(context);
    }
  }


}
