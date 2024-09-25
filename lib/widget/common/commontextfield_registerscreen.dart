import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:likeplay/utils/responsive.dart';
import '../../utils/color_utils.dart';
class CommonTextfieldRegister extends StatefulWidget {
  String? hint;
  TextEditingController? controller;
  TextInputAction? textinputAction;
   TextInputType? keyBoardType;
   Color ?color;
   int? length;
   int? maxLines;
   double? height;
  double? toppadding;
  bool readOnly ;
  String? comeFrom ;
  CommonTextfieldRegister({Key? key,this.hint,this.textinputAction=TextInputAction.next, this.controller,
     this.color,this.keyBoardType,this.length,this.readOnly = false,this.maxLines,this.height,this.toppadding
    ,this.comeFrom
   }):super(key:key);
  @override
  State<CommonTextfieldRegister> createState() => _CommonTextfieldState();
}
class _CommonTextfieldState extends State<CommonTextfieldRegister> {
  @override
  Widget build(BuildContext context){
    return Container(
      height: widget.height??45,
      width:  Responsive().getResponsiveValue(
          forLargeScreen: MediaQuery.of(context).size.width/4.5,
          forShortScreen: MediaQuery.of(context).size.width/1.2,
          forTabletScreen: MediaQuery.of(context).size.width/1.2,
          forMediumScreen:  MediaQuery.of(context).size.width/1.2,
          context: context),
      decoration: BoxDecoration(
        color:AppColor.white,
        border: Border.all(color:AppColor.grey),
        borderRadius:BorderRadius.circular(10)
      ),
      child: TextField(
        maxLength: widget.length==null?45:widget.length,
        keyboardType:widget.keyBoardType,
        readOnly:widget.readOnly,
        controller: widget.controller,
        textInputAction:widget.textinputAction==null?TextInputAction.next:widget.textinputAction,
        cursorColor:Colors.black,
        style: const TextStyle(color:Colors.black,fontFamily: 'Poppins',fontSize: 12,fontWeight: FontWeight.normal),
        maxLines: widget.maxLines ?? 1,
        inputFormatters:widget.comeFrom=="userName"? <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
        ]:widget.comeFrom=="email"?
        <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9.@]+')), // Allow letters, numbers, dot, and @
        ]:null,
        decoration:InputDecoration(
          counterText:'',
          contentPadding: EdgeInsets.only(left:16,bottom:4,right: 10,top: widget.toppadding??0.0),
          border: InputBorder.none,
          hintText:widget.hint,
          hintStyle:const TextStyle(color:Colors.grey,fontFamily: 'Poppins',fontSize: 12)
        ),
      ),
    );
  }
}
