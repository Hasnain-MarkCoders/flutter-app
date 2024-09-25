import 'package:flutter/material.dart';


class CustomSlider extends StatelessWidget {
  double?  totalWidth;
  double?  percentage;
  Color ? positiveColor;
  Color ? negetiveColor;

  CustomSlider({this.percentage, this.positiveColor, this.negetiveColor,this.totalWidth});

  @override
  Widget build(BuildContext context) {
    print((percentage! / 100) * totalWidth!);
    print((1 - percentage! / 100) * totalWidth!);
    return Container(
      width: totalWidth! + 2.0,
      height: 16.0,
      decoration: BoxDecoration(
        color: negetiveColor,
        borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white, width: 1.0)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: positiveColor,
              borderRadius: BorderRadius.circular(12),),
            width: (percentage! / 100) * totalWidth!,
          ),
        ],
      ),
    );
  }
}