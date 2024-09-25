
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:likeplay/module/home/register/camera/web_camera_screen.dart';
class CammeraButton extends StatefulWidget {
  @override
  static String path = '';
  _CammeraButtonState createState() => _CammeraButtonState();
}

class _CammeraButtonState extends State<CammeraButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

          body: Column (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> CameraScreenNew()));
                  },
                  child: Container(
                    width: 80,
                    alignment: Alignment.center,
                    color: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child:  Text(
                      'Camera Button',
                      style: TextStyle(color: Colors.black, fontSize: 13.0,),
                    ),
                  ),
                ),
              ],
            ),
                SizedBox(height: 40,),
                CammeraButton.path.isNotEmpty?
                Container(
                    child:Image.network(CammeraButton.path.toString(),fit: BoxFit.cover,)):Container(),
                  //  child: Image.file(File(CammeraButton.path.toString()),fit: BoxFit.cover,)):Container(),
          ]
          )
      ),
    );
  }
}