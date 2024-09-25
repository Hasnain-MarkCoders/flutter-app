import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../utils/color_utils.dart';
class CommonTextfieldBorder extends StatefulWidget {
  String? hint;
  String? message;
  TextEditingController? controller;
  TextInputAction? textinputAction;
   TextInputType? keyBoardType;
   Color ?color;
   int ?length;
  bool readOnly ;
  CommonTextfieldBorder({Key? key,this.message,this.hint,this.textinputAction=TextInputAction.next, this.controller,
     this.color,this.keyBoardType,this.length,this.readOnly = false
   }):super(key:key);
  @override
  State<CommonTextfieldBorder> createState() => _CommonTextfieldState();
}
class _CommonTextfieldState extends State<CommonTextfieldBorder> {
  @override
  Widget build(BuildContext context){
    return  Container(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
          validator: (v) {
            if (v!.trim().isEmpty) return widget.message;
            return null;
          },
          // keyboardType:TextInputType.number,
          controller: widget.controller,
          decoration:InputDecoration(
              fillColor:Colors.white,
              contentPadding: const EdgeInsets.only(left: 10.0, bottom: 12.0, top: 12.0,right: 10.0),
              hintText: widget.hint,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color:HexColor(AppColor.BLACK)),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10.0),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10.0),
              ))),
    );
  }
}
