import 'package:flutter/material.dart';

class CommonContainerScreen extends StatefulWidget {
  String? text;
  Icon? icon;
  String? fontFamily;
  Function? onTap;
  bool? isFull;
  double? textSize;
   CommonContainerScreen({Key? key,this.text,this.icon,this.fontFamily,this.onTap,this.isFull,this.textSize}) : super(key: key);

  @override
  State<CommonContainerScreen> createState() => _CommonContainerScreenState();
}

class _CommonContainerScreenState extends State<CommonContainerScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){
      widget.onTap!();
    },
      child: Container(height: 45,
       width: widget.isFull==true?MediaQuery.of(context).size.width:MediaQuery.of(context).size.width/1.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white)
        ),
        child: Padding(
          padding: const EdgeInsets.only(right:20),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right:12,bottom:6),
                child: Container(
                  height: 18,width: 18,
                  child:widget.icon==null?null:widget.icon,),
              ),
              Text(widget.text!,style: TextStyle(
                  fontSize: widget.textSize??13,
                  color: Colors.white,fontWeight: FontWeight.w600,fontFamily: widget.fontFamily),),
            ],
          ),
        ),
      ),
    );
  }
}
