import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

TextSpan spanBold(BuildContext context,String txt)

{
  return TextSpan(
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600)
      ,text: txt);
}

TextSpan spanNoramal(BuildContext context,String txt)

{
  return TextSpan(
      style: Theme.of(context).textTheme.bodyMedium
      ,text: txt);
}
TextSpan spanRed(BuildContext context,VoidCallback callback)

{
  return TextSpan(
      recognizer: TapGestureRecognizer()..onTap=callback,

      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: color_primary,
        decoration: TextDecoration.underline
      )
      ,text: "LikePlaylikeplay.com");
}

TextSpan spanRedCustom(BuildContext context,VoidCallback callback,String txt)

{
  return TextSpan(
      recognizer: TapGestureRecognizer()..onTap=callback,

      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: color_primary,
          decoration: TextDecoration.underline
      )
      ,text: txt);
}



WidgetSpan bulletPointContainer(BuildContext context,String txt)

{
  return WidgetSpan(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
            top: margin_dot_top, left: margin_dot_left),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "⚈",
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
                child: RichText(
                    text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium,
                        children: [
                          TextSpan(
                              text:
                              txt

                          ),
                        ]))),
          ],
        ),
      ));

}


WidgetSpan bodyText(BuildContext context,String txt)

{
  return WidgetSpan(
      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 10),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                text:txt

            ),
          ]),
        ),
      ));
}

WidgetSpan  summarySpan(BuildContext context,bool padding_left,String txt)
{
  return WidgetSpan(child:

  Padding(
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
  )

  );
}

WidgetSpan  summarySpanBold(BuildContext context,bool padding_left,String txt)
{
  return WidgetSpan(child:

  Padding(
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
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(

                      fontWeight: FontWeight.w600
                    ),
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
  )

  );



}

SizedBox box_15()
{

  return SizedBox(height: 15,);
}
SizedBox box_20()
{

  return SizedBox(height: 15,);
}


Container bulletPointer1(BuildContext context,String txt)
{
  return Container(
    width: double.infinity,
    padding: EdgeInsets.only(
        top: margin_dot_top, left: margin_dot_left),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "⚈",
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
            child: RichText(
                text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium,
                    children: [
                      TextSpan(
                          text:
                          txt

                      ),
                    ]))),
      ],
    ),
  );
}

Container bulletPointer2(BuildContext context,String txt)
{
  return Container(
    width: double.infinity,
    padding: EdgeInsets.only(
        top: margin_dot_top, left: 75),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "⚈",
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
            child: RichText(
                text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium,
                    children: [
                      TextSpan(
                          text:
                          txt

                      ),
                    ]))),
      ],
    ),
  );
}

