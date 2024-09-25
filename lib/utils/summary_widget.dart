import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SummaryTxt extends StatelessWidget {


  bool padding_left;
  String txt;


   SummaryTxt({Key? key,
     required this.padding_left,

  required this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(


        child:padding_left==true? Padding(
          padding: const EdgeInsets.only(left: 12),
          child: RichText(
            text:  TextSpan(
              children: [

                TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600)
                ,text: "Summary: "),
                TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  text: txt
                ),
              ]

            ),

          ),
        ):
        RichText(
          text:  TextSpan(
              children: [

                TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600)
                    ,text: "Summary: "),
                TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    text: txt
                ),
              ]

          ),

        )

        ,


      ),
    );
  }
}
