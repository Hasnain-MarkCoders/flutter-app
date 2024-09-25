import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:likeplay/module/admire/admiring_view_screen.dart';
import 'package:likeplay/utils/constant_lists.dart';
import 'package:likeplay/utils/route/route_name.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import '../../../utils/responsive.dart';
import '../../utils/sharedpref/preferences.dart';
import '../../utils/sharedpref/shared_prefrence.dart';
import '../../utils/string_utils.dart';
import '../../utils/utils.dart';
import '../profile/profile_screen.dart';
import '../sidemenu/web_side_menu.dart';

class AdmiringScreen extends StatefulWidget {
  const AdmiringScreen({Key? key}) : super(key: key);
  @override
  State<AdmiringScreen> createState() => _AdmiringScreenState();
}

class _AdmiringScreenState extends State<AdmiringScreen>  {
  DateTime ?dateTime;
  int selectIndex = 0;
  TextEditingController matchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return /*kIsWeb?*/AppSideMenu(
      pageTitle: UtilStrings.Home,
      screenType: 1,
      body: Container(
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
                rowFlex: 2, child: Column(
                children: [
                  AdmiringViewScreen()
                ],
              ),),
            ],
          ),
          ],

        ),
      ),
      ) , );
  }

}