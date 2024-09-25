import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../utils/constant_lists.dart';
import '../../../utils/responsive.dart';
import '../../../utils/sharedpref/preferences.dart';
import '../../../utils/sharedpref/shared_prefrence.dart';
import '../../../utils/string_utils.dart';
import '../../../utils/utils.dart';
import '../../sidemenu/web_side_menu.dart';
import 'message_view_mobile.dart';

class MessageMobileView extends StatefulWidget {
  const MessageMobileView({Key? key}) : super(key: key);

  @override
  State<MessageMobileView> createState() => _MessageMobileViewState();
}

class _MessageMobileViewState extends State<MessageMobileView> {

  @override
  void initState() {
   // print("subscription_status===>>"+SessionManager.getString(Preferences.subscription_status));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: AppSideMenu(
        pageTitle:UtilStrings.Home,
        screenType: 1,
        body:SingleChildScrollView(
          child:    Container(
              margin: const EdgeInsets.only(left: 10,right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(32),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width:  MediaQuery.of(context).size.width,
                    child:StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream:FirebaseFirestore.instance.collection('users').
                      doc(SessionManager.getString(Preferences.USER_ID)).collection("match").
                      where("user_id",isNotEqualTo: SessionManager.getString(Preferences.USER_ID)).snapshots(),
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
                                  docs[index]["is_chat"]==true?   docs[index]["is_block"]==false?
                                  GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: (){
                                        SessionManager.setString(Preferences.IS_MESSAGE, "");
                                        /*Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MessageMobileViewScreen(
                                                  senderId:SessionManager.getString(Preferences.USER_ID),
                                                  receiverId: docs[index]["user_id"].toString(),
                                                  senderName: SessionManager.getString(Preferences.USER_NAME),
                                                  receiverName: docs[index]["user_name"].toString(),
                                                  receiverImage: docs[index]["user_image"].toString(),
                                                  senderImage: IMAGE_URL+SessionManager.getString(Preferences.PROFILE_IMAGE),
                                                  otherSubscriprtion: docs[index]["subscription_status"].toString(),
                                                  OtherSubscriptopnPlan: docs[index]["subscription_plan"].toString(),
                                                )));*/
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MessageMobileViewScreen(
                                                    senderId:SessionManager.getString(Preferences.USER_ID),
                                                    receiverId: docs[index]["user_id"].toString(),
                                                    senderName: SessionManager.getString(Preferences.USER_NAME),
                                                    receiverName: docs[index]["user_name"].toString(),
                                                    receiverImage: docs[index]["user_image"].toString(),
                                                    senderImage: IMAGE_URL+SessionManager.getString(Preferences.PROFILE_IMAGE)
                                                )));
                                      },
                                      child:Container(
                                        //color: Colors.black,

                                        child: Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(bottom:8,left: 8,right: 8,top: 12),
                                              child: Row(
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
                                                      color: Colors.black),
                                                ],
                                              ),
                                            ),
                                            Gap(8),
                                            Container(
                                              width: MediaQuery.of(context).size.width,
                                              height: 1,
                                              color: Colors.grey,
                                            ),
                                            Gap(8),
                                          ],
                                        ),
                                      )):Container():Container();
                              }):Center(
                              child: Utils.mediumHeadingNormalText(text: "No Record!",textSize: 12,fontWeight: FontWeight.bold,color: Colors.black));
                        }
                        return Center(
                            child: Utils.mediumHeadingNormalText(text: "No Record!",textSize: 12,fontWeight: FontWeight.bold,color: Colors.black));
                      },
                    ),)
                ],)
          ),
        ) , )

    );
  }
}
