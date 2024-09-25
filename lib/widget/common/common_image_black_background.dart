
import 'package:flutter/material.dart';

class CommonImageBlackBackground extends StatefulWidget {
  Widget? child;
  String? image;
  CommonImageBlackBackground({Key? key,this.child,this.image}) : super(key: key);

  @override
  State<CommonImageBlackBackground> createState() => _CommonImageBlackBackground();
}
class _CommonImageBlackBackground extends State<CommonImageBlackBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(image:AssetImage("assets/images/bg_add_goal.jpg"),
                fit: BoxFit.fitHeight)
        ),
        child: widget.child
    );
  }
}
