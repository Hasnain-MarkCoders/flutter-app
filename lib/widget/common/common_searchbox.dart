
import 'package:flutter/material.dart';

import '../../utils/color_utils.dart';

class CommonSearchBox extends StatefulWidget {
  String ? hint;
  Function ? onTap;
  Function ?value;
   CommonSearchBox({Key? key,this.hint,this.onTap,this.value}) : super(key: key);

  @override
  State<CommonSearchBox> createState() => _CommonSearchBoxState();
}
class _CommonSearchBoxState extends State<CommonSearchBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius:BorderRadius.circular(10),
        color: AppColor.white,
      ),
      child:TextField(
      onSubmitted: (value){
        widget.value!();
      },
        onTap: (){
          widget.onTap!();
        },
        enabled:true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left:10,top: 10,right: 10),
        hintText: widget.hint,
        hintStyle: const TextStyle(
          color: AppColor.grey,fontFamily: 'Montserrat'
        ),
        suffixIcon: const Icon(Icons.search,color: AppColor.black,),
        border: InputBorder.none,
      ),),
    );
  }
}
