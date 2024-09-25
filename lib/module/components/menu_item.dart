import 'package:flutter/material.dart';
import 'package:likeplay/utils/color_utils.dart';
import 'package:likeplay/utils/constants.dart';
import 'package:likeplay/utils/utils.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    Key? key,
    required this.title,
    required this.tapEvent
  }) : super(key: key);

  final String title;
  final GestureTapCallback tapEvent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapEvent,
      hoverColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36),
        child:  Utils.mediumHeadingNormalText(
            text: title,
            color: AppColor.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w300,
            textSize: 14),
      ),
    );
  }
}