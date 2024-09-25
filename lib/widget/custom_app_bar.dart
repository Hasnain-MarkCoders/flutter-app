
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class CustomAppBar extends StatelessWidget {
  final dynamic child;
  const CustomAppBar({Key? key,this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Utils.getHeight(context),
        child: child,
    );
  }
}
