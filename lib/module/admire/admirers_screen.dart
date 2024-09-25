import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:likeplay/module/admire/admirers_view_screen.dart';
import 'package:likeplay/utils/constant_lists.dart';
import 'package:likeplay/utils/route/route_name.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import '../../../utils/responsive.dart';
import '../../utils/color_utils.dart';
import '../../utils/sharedpref/preferences.dart';
import '../../utils/sharedpref/shared_prefrence.dart';
import '../../utils/string_utils.dart';
import '../../utils/utils.dart';
import '../profile/profile_screen.dart';
import '../sidemenu/web_side_menu.dart';

class AdmirersScreen extends StatefulWidget {
  const AdmirersScreen({Key? key}) : super(key: key);
  @override
  State<AdmirersScreen> createState() => _AdmirersScreenState();
}

class _AdmirersScreenState extends State<AdmirersScreen>{
  int selectIndex=0;

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
      body:Container(
        /*width: size.width,
        height: size.height,*/
        color: Colors.white,
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
                                    AdmirerViewScreen()),
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
                                  userId:  SessionManager
                                      .getString(Preferences
                                      .USER_ID)
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
                                Row(children: [
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
                                  Utils.mediumHeadingNormalText(text: SessionManager.getString(Preferences.USER_NAME),textSize: 12,fontWeight: FontWeight.w500,color: Colors.black),
                                  Spacer(),
                                  Image.asset("assets/images/icon_forword.png",width: 22,height: 22,),
                                ],)
                              ],
                            ),
                          ),),
                          Gap(12),

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
      ) , );
  }

}
