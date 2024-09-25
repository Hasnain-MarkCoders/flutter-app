import 'package:flutter/material.dart';
import 'package:likeplay/utils/responsive.dart';
import '../../utils/color_utils.dart';
class CommonTextfield extends StatefulWidget {
  String? hint;
  TextEditingController? controller;
  TextInputAction? textinputAction;
   TextInputType? keyBoardType;
   Color ?color;
   int ?length;
  bool readOnly ;
   CommonTextfield({Key? key,this.hint,this.textinputAction=TextInputAction.next, this.controller,
     this.color,this.keyBoardType,this.length,this.readOnly = false
   }):super(key:key);
  @override
  State<CommonTextfield> createState() => _CommonTextfieldState();
}
class _CommonTextfieldState extends State<CommonTextfield> {
  @override
  Widget build(BuildContext context){
    return Container(
      height: 45,
      width:  Responsive().getResponsiveValue(
          forLargeScreen: MediaQuery.of(context).size.width/4.5,
          forShortScreen: MediaQuery.of(context).size.width/1.2,
          forTabletScreen: MediaQuery.of(context).size.width/1.2,
          forMediumScreen:  MediaQuery.of(context).size.width/1.2,
          context: context),
      decoration: BoxDecoration(
        color:AppColor.white,
        border: Border.all(color:AppColor.white),
        borderRadius:BorderRadius.circular(10)
      ),
      child: TextField(
        maxLength: widget.length==null?45:widget.length,
        keyboardType:widget.keyBoardType,
        readOnly:widget.readOnly,
        controller: widget.controller,
        textInputAction:widget.textinputAction==null?TextInputAction.next:widget.textinputAction,
        cursorColor:Colors.black,
        style: const TextStyle(color:Colors.black,fontFamily: 'Poppins',fontSize: 14),
        decoration:InputDecoration(
          counterText:'',
          contentPadding:const EdgeInsets.only(left:16,bottom:4,right: 10),
          border: InputBorder.none,
          hintText:widget.hint,
          hintStyle:const TextStyle(color:Colors.black45,fontFamily: 'Poppins',fontSize: 14)
        ),
      ),
    );
  }
}
