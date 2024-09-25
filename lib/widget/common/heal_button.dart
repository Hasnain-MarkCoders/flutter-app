import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HealButton extends StatefulWidget {
  String ? text;
  double? width;
  double? height;
  Function ? onTap;
  Border? border;
  Color bgColor;
  Icon ?icon;
  Color? textColor;


  HealButton({Key? key,this.text="",required this.onTap,this.width = 100,this.border,
  this.bgColor = const Color(0xff28A3A9),this.height=50,this.icon,this.textColor}) : super(key: key);


  @override
  State<HealButton> createState() => _HealButton();
}

class _HealButton extends State<HealButton> {
  @override
  Widget build(BuildContext context) {
    double? width = MediaQuery.of(context).size.width;
    if(widget.width!=100){
      width = widget.width;
    }
    double? height=50;
    if(widget.height!=50){
      height=widget.height;
    }
    return GestureDetector(onTap: (){
      widget.onTap!();
    },
      child: Container(
        height:height,width: width,
        decoration: BoxDecoration(
          border: widget.border,
          borderRadius: BorderRadius.circular(25),
          color: widget.bgColor,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text(widget.text!,style:  TextStyle(fontSize:15,
                color: widget.textColor?? Colors.white,fontFamily: 'Poppins',fontWeight: FontWeight.bold),)),
          ],
        ),
      ),
    );
  }
}
