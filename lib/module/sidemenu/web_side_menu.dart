import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:likeplay/module/sidemenu/web_navigation_screen.dart';
import 'package:likeplay/utils/sharedpref/shared_prefrence.dart';
import 'package:need_resume/need_resume.dart';
import '../../../utils/route/route_name.dart';
import '../../utils/constant_lists.dart';
import '../../utils/sharedpref/preferences.dart';
import '../profile/profile_screen.dart';

class AppSideMenu extends StatefulWidget {
  const AppSideMenu({required this.body, required this.pageTitle,required this.screenType, Key? key,this.bottomSheet})
      : super(key: key);
  final Widget body;
  final Widget? bottomSheet;
  final String pageTitle;
  final int screenType;

  @override
  State<AppSideMenu> createState() => _AppSideMenuState();
}

class _AppSideMenuState extends ResumableState<AppSideMenu> {
  Future<bool> _onWillPop() async {
    return kIsWeb? false:true; //<-- SEE HERE
  }
  void onResume() {

  }
  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 600;
    return Row(
      children: [
        if (!displayMobileLayout)
          const WebNavigationScreen(
            permanentlyDisplay: true,
          ),
        Expanded(
          child: WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor:  Colors.white,
              appBar: displayMobileLayout? AppBar(
                automaticallyImplyLeading: displayMobileLayout,
                iconTheme: IconThemeData(color: Colors.black),
                actions: <Widget>[
                 /* Image.asset(
                    "assets/images/ic_message_favorite.png",
                    width: 18,height: 18,
                  ),
                  Gap(10),*/
                  widget.screenType==1?  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:  GestureDetector(onTap: (){
                      // print("SessionManager==>"+   SessionManager.getString(Preferences.USER_ID));
                     push(context, MaterialPageRoute(builder: (context)=>ProfileScreen(
                          userId:  SessionManager.getString(Preferences.USER_ID)
                      )));
                    },
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(SessionManager.getString(Preferences.PROFILE_IMAGE).isNotEmpty ?
                          IMAGE_URL + SessionManager.getString(Preferences.PROFILE_IMAGE) : "")
                      ),
                    ),
                  ):CircleAvatar(backgroundColor: Colors.white,),
                 /* screenType==1?GestureDetector(onTap: (){
                    Navigator.pushNamed(
                        context, RouteName.profile_screen, arguments: 1);
                  },child:     GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen(
                  userId:   SessionManager.getString(Preferences.USER_ID)
              )));
            },
            child:   SizedBox(
              height: 32,
              width: 32,
              child: ClipOval(

                child: CachedNetworkImage(
                  imageUrl: SessionManager.getString(Preferences.PROFILE_IMAGE).isNotEmpty ? IMAGE_URL + SessionManager.getString(Preferences.PROFILE_IMAGE) : "",
                  imageBuilder:
                      (context, imageProvider) =>
                      Container(
                        // margin: EdgeInsets.only(top: 10,bottom: 10),
                          decoration:
                          BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(
                                Radius.circular(8)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,

                            ),
                          )),
                  placeholder: (context, url) =>
                  const Image(
                      image: AssetImage(
                          "assets/images/icon_loading.png")),
                  errorWidget: (context, url,
                      error) =>
                  const Image(
                      image: AssetImage(
                          "assets/images/icon_loading.png")),
                  width:32,
                  height: 32,
                ),
              ),
            ),
          )
            *//*Image.asset("assets/images/icon_profile.png",width: 18,height: 18,),*//*):Container(),*/
                  widget.screenType==1?   Gap(12):SizedBox(),
                ],
                title:Center(child: Image.asset(
                  "assets/images/app_icon.png",
                  height: 32,
                ),),
                backgroundColor: Colors.white,
              ):null,
              drawer: displayMobileLayout ? const WebNavigationScreen(
                permanentlyDisplay: false,
              )
                  : null,
              body: widget.body,
              bottomSheet: widget.bottomSheet,
            ),
          ),
        )
      ],
    );
  }
}