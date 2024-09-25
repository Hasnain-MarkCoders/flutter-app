import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:likeplay/module/home/home.dart';
import 'package:likeplay/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/constants.dart';
import 'menu_item.dart';

class SideMenu extends StatelessWidget {

  int? viewType;
  SideMenu({Key? key,this.viewType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: Colors.black26,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavItem(
                title: 'Home',
                tapEvent: () {
                  launch(home_url_website);
                  /*viewType!=0?Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                      viewType: 0
                  ))):const SizedBox();*/
                },
              ),
              Gap(12),
              NavItem(
                title: 'About us',
                tapEvent: () {
                  viewType!=2?Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                      viewType: 2
                  ))):SizedBox();
                },
              ),
              Gap(12),
              NavItem(
                title: 'Help',
                tapEvent: () async {
                  Utils.openMail("service@likeplaylikeplay.com");
                },
              ),
              Gap(12),
              NavItem(
                title: 'Contact us',
                tapEvent: () async {
                  Utils.openMail("hello@likeplaylikeplay.com");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}