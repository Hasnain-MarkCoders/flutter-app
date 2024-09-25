import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomGraphWidget extends StatelessWidget {
  List<ChartColumnWidget> list;
  double gHeight;
  double gWidth;
  BuildContext context;
  Color chartBgColor = Colors.white;

  CustomGraphWidget({
    Key? key,
    this.gHeight = 200,
    this.gWidth = 300,
    required this.context,
    required this.list,
    Color chartBgColor = Colors.white,
  }) : super(key: key);

  ChartModel exampleChartModel = ChartModel(
    name: "Jan",
    a: 25,
    b: 35,
  );

  @override
  Widget build(BuildContext context) {
    return customColumnGraphWidget(
      context: this.context,
      list: list,
      gHeight: gHeight,
      gWidth: gWidth,
      chartBgColor: chartBgColor,
    );
  }

  static Container customColumnGraphWidget({
    double gHeight = 200,
    double gWidth = 300,
    required BuildContext context,
    required List<ChartColumnWidget> list,
    Color chartBgColor = Colors.white,
  }) {
    return Container(
      height: gHeight,
      width: gWidth,
      decoration: BoxDecoration(
        color: chartBgColor,
      ),
      alignment: Alignment.center,
      child: Row(
        children: list,
      ),
    );
  }
}

class ChartModel {
  ChartModel({this.name = "name", this.a = 10, this.b = 30, this.c = 100});

  String name;
  int a;
  int b;
  int c;
}

// ignore: must_be_immutable
class ChartColumnWidget extends StatelessWidget {
  ChartModel model;
  double bHeight;
  Color textColor;
  Color bColor;
  Color secondBarColor;
  Color firstBarColor;
  Color thirdBarColor;
  double height;
  double width;
  Color color;
  EdgeInsetsGeometry? margin;
  double radius;
  Widget bottomWidget;
  bool needTitle;
  ChartColumnWidget(
      {Key? key,
      required this.model,
      this.bHeight = 130,
      this.textColor = Colors.grey,
      this.bColor = Colors.white,
      this.height = 100,
      this.width = 15,
      this.color = Colors.grey,
      this.margin = const EdgeInsets.only(right: 10),
      this.radius = 10,
      this.firstBarColor = const Color(0xffE05252),
      this.secondBarColor = const Color(0xff45B765),
      this.thirdBarColor =  const Color(0xffd8d7d7),
        this.bottomWidget = const Text(
          "",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        this.needTitle = true,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double a = double.parse(model.a.toString());
    double b = double.parse(model.b.toString());
    // ignore: non_constant_identifier_names
    double AHeight = height*(a/100);
    // ignore: non_constant_identifier_names
    double BHeight = height*(b/100);
    return Container(
      height: bHeight,
      alignment: Alignment.center,
      color: bColor,
      margin : margin,
      child: Column(
        children: [
          Stack(
            children: [
              barWidget(
                height: height,
                  color: thirdBarColor),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: barWidget(
                      height: BHeight,
                      color: secondBarColor)),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: barWidget(
                    height: AHeight,
                    color: firstBarColor,
                  )),
            ],
          ),
          needTitle ?  Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              model.name,
              style:  TextStyle(fontSize: 16, color: textColor),
            ),
          ) :  bottomWidget,
        ],
      ),
    );
  }

  static Container barWidget(
      {double height = 100,
      double width = 15,
      Color color = Colors.grey,
      EdgeInsetsGeometry? margin = const EdgeInsets.only(right: 14),
      double radius = 10}) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
