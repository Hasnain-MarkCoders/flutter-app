import 'package:flutter/material.dart';
import 'package:likeplay/module/home/home.dart';
import 'package:likeplay/module/login/login_view.dart';
import 'package:likeplay/utils/responsive.dart';
import 'package:likeplay/utils/responsive_value.dart';
import 'package:likeplay/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/constants.dart';
import 'menu_item.dart';

class Header extends StatelessWidget {
  int? viewType;
  Header({Key? key,this.viewType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color:  viewType==3?Colors.black54:Colors.black26,
      padding: EdgeInsets.only(left:  Responsive().getResponsiveValue(
          forLargeScreen: 90.0,
          forShortScreen: 16.0,
          context: context),
          right: Responsive().getResponsiveValue(
          forLargeScreen: 32.0,
          forShortScreen: 12.0,
          context: context),top: 38,bottom: 14),
      child: Row(
        children: <Widget>[
          Image.asset(
            'assets/images/app_icon.png',
            width: 32,
          ),
          Spacer(),

          if (!isMobile(context))
            Row(
              children: [
                NavItem(
                  title: 'Home',
                  tapEvent: () {
                    launch(home_url_website);
                   /* viewType!=0?Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                        viewType: 0
                    ))):const SizedBox();*/
                  },
                ),
                NavItem(
                  title: 'About us',
                  tapEvent: () {
                    viewType!=2?Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                        viewType: 2
                    ))):SizedBox();
                  },
                ),
                NavItem(
                  title: 'Help',
                  tapEvent: () async {
                    Utils.openMail("service@likeplaylikeplay.com");
                  },
                ),
                NavItem(
                  title: 'Contact us',
                  tapEvent: () async {
                    Utils.openMail("hello@likeplaylikeplay.com");
                  },
                ),
              ],
            ),

          if (isMobile(context))
            IconButton(
              icon: Icon(Icons.menu,color: Colors.white,),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              }
            )
        ],
      ),
    );
  }
}