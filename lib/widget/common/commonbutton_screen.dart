import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CommonButton extends StatefulWidget {
  String ? text;
  Function ? onTap;
  Color bgColor ;
  Color borderColor ;
  Color textColor ;
  double borderWidth ;
  FontWeight? fontWeight;
  double textFontSize;
   CommonButton({Key? key,this.text="",this.onTap,
   this.bgColor = const Color(0xff33374E),
   this.borderColor = const Color(0xff33374E),
     this.borderWidth =  1,
   this.textColor = const Color(0xffFFFFFF),
    this.fontWeight = FontWeight.normal,
   this.textFontSize = 14}) : super(key: key);

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: (){
      widget.onTap!();
    },
      child: Container(
        height: 50,width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: widget.bgColor,
          border: Border.all(
            color: widget.borderColor,
            width: widget.borderWidth,
          )
        ),
        child: Center(child: Text(widget.text!,style: TextStyle(fontWeight: widget.fontWeight,fontSize:widget.textFontSize,color: widget.textColor,fontFamily: 'Poppins'),)),
      ),
    );
  }
}
