import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/color_utils.dart';
import '../../utils/utils.dart';

// ignore: must_be_immutable
class CommonIconTextBtn extends StatelessWidget {
  String text;
  IconData icon;
  double height;
  double width;
  bool needIcon;
  CommonIconTextBtn({Key? key,
  required this.text,this.icon =  Icons.arrow_back,
  this.height = 48,this.width = 200,this.needIcon = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(
          color: AppColor.appDarkColor,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      alignment: Alignment.center,
      child: needIcon ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.arrow_back,
            color: AppColor.appDarkColor,),
          const Gap(8),
          Utils.mediumTWhite(
            text:text,
            color: AppColor.appDarkColor,
            fontWeight: FontWeight.w700,
          ),
        ],
      ) : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Utils.mediumTWhite(
            text:text,
            color: AppColor.appDarkColor,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
