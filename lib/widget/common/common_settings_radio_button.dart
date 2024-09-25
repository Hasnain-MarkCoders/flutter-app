import 'package:flutter/material.dart';
import '../../utils/color_utils.dart';

class CommonSettingsRadioButtons extends StatefulWidget {
  bool? value;
   CommonSettingsRadioButtons({Key? key,this.value=false}) : super(key: key);

  @override
  State<CommonSettingsRadioButtons> createState() => _CommonSettingsRadioButtonsState();
}

class _CommonSettingsRadioButtonsState extends State<CommonSettingsRadioButtons> {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){
        if(widget.value==false){
          setState(() {
            widget.value=true;
          });
        }
        else if( widget.value==true){
          setState(() {
            widget.value=false;
          });
        }
      },
        child: Container(
          height:
          30,
          width: 66,
          decoration: BoxDecoration(
              border: Border.all(color:AppColor.black),
              color:widget.value==true?Color(0xffD9F2E8):Colors.grey.shade300,
              borderRadius: BorderRadius.circular(25)
          ),
          child:
          Row(
            children: [
              widget.value == true
                  ? const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text("On",style: TextStyle(fontSize:14),),
              )
                  : Container(),
              widget.value == true
                  ?const Spacer()
                  :Container(),
              Row(
                children: [
                  Container(
                    height: 28,
                    width: 28,
                    decoration:BoxDecoration(color:widget.value == true ? const Color(0xff08DED4):Colors.white, border: Border.all(color: widget.value == true ? const Color(0xff277255) : AppColor.oneOff), borderRadius: BorderRadius.circular(30)),
                    child:Column(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                              border: widget.value==true?Border.all(color: AppColor.black):null,
                              color: widget.value == true ? const Color(0xffD9F2E8) : AppColor.grey, borderRadius: BorderRadius.circular(35)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              widget.value== false ? const Spacer()
                  : Container(),
              widget.value == false
                  ? const  Padding(
                padding: EdgeInsets.only(right:12),
                child: Text("Off"),
              )
                  : Container()
            ],
          ),
    ),
      );
  }
}
