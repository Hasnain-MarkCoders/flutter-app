import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/utils/route/route_name.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import '../../../../utils/responsive.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/constant_lists.dart';
import '../../../utils/sharedpref/preferences.dart';
import '../../../utils/sharedpref/shared_prefrence.dart';
import '../../../utils/string_utils.dart';
import '../../../utils/utils.dart';
import '../../profile/profile_screen.dart';
import '../../sidemenu/web_side_menu.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);
  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen>{
  DateTime ?dateTime;
  bool isLoading=false;
  int selectIndex=0;
  TextEditingController matchController = TextEditingController();

  ScrollController _mycontroller1 = new ScrollController();
  ScrollController _mycontroller2 = new ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return /*kIsWeb?*/AppSideMenu(
      pageTitle:UtilStrings.Home,
      screenType: 1,
      body:SingleChildScrollView(
        controller: _mycontroller1,
        child: Container(
          /*width: size.width,
          height: size.height,*/
          color: Colors.white,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ResponsiveRowColumn(
                  rowMainAxisAlignment: MainAxisAlignment.start,
                  rowCrossAxisAlignment: CrossAxisAlignment.start,
                  layout: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                      ? ResponsiveRowColumnType.COLUMN
                      : ResponsiveRowColumnType.ROW,
                  children: [
                    ResponsiveRowColumnItem(
                      rowFlex: 2, child:Column(
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
                                  Column(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(20),
                                          color: AppColor.grey.withOpacity(0.4),
                                          child:Row(
                                            children:  [
                                              //Utils.
                                              Expanded(
                                                child:  Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    const Gap(12),
                                                    Utils.mediumHeadingNormalText(text: UtilStrings.FAQs,textSize: 14,color: AppColor.APP_TEXT_COLOR),
                                                  ],
                                                ),
                                              ),
                                              Gap(12),
                                            ],
                                          )),
                                      Container(
                                        color: Colors.grey,
                                        height: 1,
                                      ),
                                      const Gap(16),
                                      Container(
                                        padding: EdgeInsets.only(left:14,right: 14,top: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                       SizedBox(
                                         width: Responsive().getResponsiveValue(
                                             forLargeScreen: MediaQuery.of(context).size.width/1.6,
                                             forShortScreen: MediaQuery.of(context).size.width,
                                             forMobLandScapeMode: MediaQuery.of(context).size.width,
                                             forMediumScreen: MediaQuery.of(context).size.width,
                                             forTabletScreen: MediaQuery.of(context).size.width/1.6,
                                             context: context),
                                         child: Utils.mediumHeadingNormalText(text: UtilStrings.Live_Chat_is_available_only,textSize: 12,fontWeight: FontWeight.w300,color: Colors.red,textAlign: TextAlign.start),
                                         ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:faqList.length ,
                                            controller: _mycontroller2,
                                            itemBuilder: (BuildContext context,int index){
                                              return  Container(
                                                margin: EdgeInsets.only(bottom: 8),
                                                padding: EdgeInsets.only(bottom: 8),
                                                decoration: BoxDecoration(
                                                    color: AppColor.grey.withOpacity(0.4),
                                                    borderRadius: BorderRadius.circular(8)
                                                ),
                                                child: Theme(
                                                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                                  child: ExpansionTile(
                                                    expandedAlignment: Alignment.topLeft,
                                                    title: Utils.mediumHeadingNormalText(text: faqList[index].text.toString(),
                                                        textAlign: TextAlign.start,
                                                        textSize: 13,
                                                        fontWeight: FontWeight.w500,
                                                        color: AppColor.black),
                                                    trailing: Icon(faqList[index].value==true?
                                                    Icons.keyboard_arrow_down
                                                        :Icons.keyboard_arrow_right_outlined,color: Colors.black,size: 16,),
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left:16,right: 14),
                                                        child: Utils.mediumHeadingNormalText(text: faqList[index].subText.toString(),
                                                            textAlign: TextAlign.start,
                                                            fontWeight: FontWeight.normal,
                                                            color: AppColor.black,textSize: 12),
                                                      ),
                                                    ],
                                                    onExpansionChanged: (value){
                                                      setState(() {
                                                        faqList[index].value=value;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              );
                                            })
                                      ],),)
                                    ],
                                  ),),
                                ],
                              ),
                              Gap(20),
                            ],
                          ),
                        )

                        //),
                        //),
                      ],
                    ),),
                    Responsive().getResponsiveValue(
                        forLargeScreen: ResponsiveRowColumnItem(
                          rowFlex: 1, child:  Container(
                          margin: EdgeInsets.only(right: 12,left: 12,top: 12),
                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileScreen(
                                      userId:   SessionManager.getString(Preferences.USER_ID)
                                  )));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(left: 10,right: 20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(width: 1.0, color: Colors.black26)),
                                  width:  Responsive().getResponsiveValue(
                                      forLargeScreen: MediaQuery.of(context).size.width/6,
                                      context: context),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Utils.mediumHeadingNormalText(text:UtilStrings.My_Profile,textSize: 12,fontWeight: FontWeight.w500,color: Colors.black),
                                      Gap(12),
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 32,
                                            width: 32,
                                            child: ClipOval(
                                              child: CachedNetworkImage(
                                                imageUrl: SessionManager
                                                    .getString(Preferences
                                                    .PROFILE_IMAGE) !=
                                                    ""
                                                    ? IMAGE_URL +
                                                    SessionManager.getString(
                                                        Preferences
                                                            .PROFILE_IMAGE)
                                                    : "",
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
                                          Utils.mediumHeadingNormalText(
                                              text:
                                              SessionManager.getString(
                                                  Preferences
                                                      .USER_NAME),
                                              textSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                          Spacer(),
                                          Image.asset(
                                            "assets/images/icon_forword.png",
                                            width: 22,
                                            height: 22,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),),
                              Gap(12),
                              Container(
                                  width:  Responsive().getResponsiveValue(
                                      forLargeScreen: MediaQuery.of(context).size.width/6,
                                      context: context),
                                  padding: EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(left: 10,right: 20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(width: 1.0, color: Colors.black26)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Gap(12),
                                      Utils.mediumHeadingNormalText(text:UtilStrings.Messages,textSize: 14,fontWeight: FontWeight.w500,color: Colors.black,left: 20),
                                      Gap(12),
                                      Container(
                                        height: MediaQuery.of(context).size.height/2,
                                        child:StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                          stream:FirebaseFirestore.instance.collection('users').doc(SessionManager.getString(Preferences.USER_ID)).collection("match").where("user_id",isNotEqualTo: SessionManager.getString(Preferences.USER_ID)).snapshots(),
                                          builder: (_, snapshot) {
                                            if (snapshot.hasError) {
                                            }
                                            if (snapshot.hasData) {
                                              var docs = snapshot.data!.docs;
                                              docs =  docs.toList();
                                              return  docs.isNotEmpty?ListView.builder(
                                                  itemCount: docs.length,
                                                  itemBuilder: (BuildContext context, int index) {
                                                    return
                                                      GestureDetector(
                                                          behavior: HitTestBehavior.translucent,
                                                          onTap: (){
                                                            SessionManager.setString(Preferences.IS_MESSAGE, "");

                                                            /*  Utils.chatDialog(context,
                                                                    SessionManager.getString(Preferences.USER_ID),
                                                                    docs[index]["user_id"].toString(),
                                                                    SessionManager.getString(Preferences.USER_NAME),
                                                                    docs[index]["user_name"].toString(),
                                                                    docs[index]["user_image"].toString(),
                                                                    IMAGE_URL+SessionManager.getString(Preferences.PROFILE_IMAGE));*/
                                                           /* Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => MessageScreen(
                                                                        senderId:SessionManager.getString(Preferences.USER_ID),
                                                                        receiverId: docs[index]["user_id"].toString(),
                                                                        senderName: SessionManager.getString(Preferences.USER_NAME),
                                                                        receiverName: docs[index]["user_name"].toString(),
                                                                        receiverImage: docs[index]["user_image"].toString(),
                                                                        senderImage: IMAGE_URL+SessionManager.getString(Preferences.PROFILE_IMAGE)
                                                                    )));*/

                                                          },
                                                          child:Container(
                                                            //color: Colors.black,
                                                            margin: const EdgeInsets.only(bottom:8,left: 8,right: 8),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 32,
                                                                      width: 32,
                                                                      child:ClipRRect(
                                                                        borderRadius: BorderRadius.circular(25),
                                                                        child: Image.network(
                                                                          docs[index]["user_image"],
                                                                          fit: BoxFit.cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Gap(8),
                                                                    Utils.mediumHeadingNormalText(
                                                                        text:  docs[index]["user_name"],
                                                                        textSize: 14,
                                                                        fontWeight: FontWeight
                                                                            .w500,
                                                                        color: Colors.black)
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ));
                                                  }):Center(
                                                  child: Utils.mediumHeadingNormalText(text: "No Record!",textSize: 12,fontWeight: FontWeight.bold,color: Colors.black));
                                            }
                                            return Center(
                                                child: Utils.mediumHeadingNormalText(text: "No Record!",textSize: 12,fontWeight: FontWeight.bold,color: Colors.black));
                                          },
                                        ),)
                                    ],)
                              ),
                            ],
                          ),
                        ),),
                        forShortScreen: ResponsiveRowColumnItem(
                          rowFlex: 1, child:  Container(
                        ),),
                        context: context) ,
                  ],
                ),
              ],

            ),
          ),
        ),
      ) , );
  }

}