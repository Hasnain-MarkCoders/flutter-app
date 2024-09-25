import 'dart:async';
import 'package:flutter/material.dart';
import 'package:likeplay/utils/utils.dart';
import '../../utils/route/route_name.dart';
import '../../utils/sharedpref/preferences.dart';
import '../../utils/sharedpref/shared_prefrence.dart';
import '../module/home/home.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: SplashCode(),
      ),
    );
  }
}

class SplashCode extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State {
  @override
  void initState() {
    super.initState();
 Timer(const Duration(seconds: 3), () async {
     if(SessionManager.getBoolean(Preferences.IS_USER_LOGIN)==true){
       SessionManager.setString(Preferences.INDEX, "0");
        Navigator.pushReplacementNamed(context, RouteName.feed_screen);
      }
      else{
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen(
         viewType: 0,
       )));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(height: MediaQuery.of(context).size.height,
      width:  MediaQuery.of(context).size.width,
       color: Colors.white,
       child: Center(
         child: Utils.imageView(image: "assets/images/splash_icon.png",
             height: MediaQuery.of(context).size.height * 0.2,
       ),),
    );
  }
}