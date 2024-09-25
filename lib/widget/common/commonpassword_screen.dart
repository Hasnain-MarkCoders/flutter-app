import 'package:flutter/material.dart';
import 'package:likeplay/utils/responsive.dart';

import '../../utils/color_utils.dart';

class CommonPassword extends StatefulWidget {
  String ? hint;
  Color? bordercolor;
  TextEditingController ? controller;
   CommonPassword({Key? key,this.hint,this.controller,this.bordercolor}) : super(key: key);

  @override
  State<CommonPassword> createState() => _CommonPasswordState();
}

class _CommonPasswordState extends State<CommonPassword> {
  bool obscureText=true;
  @override
  Widget build(BuildContext context) {
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
          border: Border.all(color:widget.bordercolor!),
          borderRadius:BorderRadius.circular(10)
      ),
      child: TextField(
        controller: widget.controller,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        obscureText: obscureText,
        cursorColor: Colors.black,
        style: const TextStyle(color:Colors.black,fontFamily: 'Poppins',fontSize: 12),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 16,top:12),
            border: InputBorder.none,
            hintText:widget.hint,
            hintStyle: TextStyle(color: Colors.black45,fontFamily: 'Poppins',fontSize: 12),
          suffixIcon: GestureDetector(
              onTap: (){
                if(obscureText==true){
                  setState(() {
                    obscureText=false;
                  });
                }
                else{
                  setState(() {
                    obscureText=true;
                  });
                }
              },
              child: obscureText==true?Icon(Icons.visibility_off,color: Colors.grey,):
          Icon(Icons.visibility,color: Colors.grey,)
          )
        ),
      ),
    );
  }
}
