import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/utils/color_utils.dart';
import 'package:likeplay/utils/responsive.dart';
import 'package:likeplay/utils/route/route_name.dart';
import 'package:likeplay/utils/utils.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import '../../../utils/string_utils.dart';
import '../../utils/constants.dart';
import '../../utils/sharedpref/preferences.dart';
import '../../utils/sharedpref/shared_prefrence.dart';
import '../home/home.dart';
import '../model/success_response.dart';
import 'drawer_presenter.dart';

class WebNavigationScreen extends StatefulWidget {
  const WebNavigationScreen({required this.permanentlyDisplay, Key? key})
      : super(key: key);

  final bool permanentlyDisplay;

  @override
  _WebNavigationScreenState createState() => _WebNavigationScreenState();
}

class _WebNavigationScreenState extends State<WebNavigationScreen> with RouteAware {
  String? _selectedRoute;
  //AppRouteObserver? _routeObserver;
  bool isLoading=false;
  int selectIndex=0;
  @override
  void initState() {
    super.initState();
   // _routeObserver = AppRouteObserver();
    setState(() {
   if(SessionManager.getString(Preferences.INDEX).isNotEmpty){
        var temp=int.parse(SessionManager.getString(Preferences.INDEX));
        if(temp!=0){
          selectIndex=int.parse(SessionManager.getString(Preferences.INDEX));
        }else if(selectIndex==null){
          selectIndex=0;
        }
      }
      else{
        selectIndex=0;
      }
    });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //_routeObserver!.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
  //  _routeObserver!.unsubscribe(this);
    super.dispose();
  }

  void changeIndex(int index){
    setState(() {
      selectIndex=index;
    });
   SessionManager.setString(Preferences.INDEX,selectIndex.toString());
   if(selectIndex==4){
     SessionManager.setString(Preferences.IS_MESSAGE, "IS_MESSAGE");
   }
  }
  @override
  void didPush() {
    _updateSelectedRoute();
  }

  @override
  void didPop() {
    _updateSelectedRoute();
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: AppColor.white,
      width: Responsive().getResponsiveValue(
          forShortScreen: size.width/1.8,
          forLargeScreen: size.width/6.6,
          forMobLandScapeMode: size.width/3.2,
          forMediumScreen:size.width/2.2,
          forTabletScreen: size.width/3.4,
          context: context),
      child: Row(
        children: [
          Expanded(
            child: Container(
             color: Colors.white,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Center(
                    child: Container(
                        margin: EdgeInsets.only(top: 42,right: 32,left: 32),
                        child: Image.asset(
                          "assets/images/app_icon.png",
                          height: 60,
                        )),
                  ),
                  Gap(22),
                  DrawerListTile(
                    title: "ShowRoom",
                    svgSrc: "assets/images/side_icon_home.png",
                    isSelected:selectIndex==0?true:false,selectIndex: 0,
                    press: () async {
                      changeIndex(0);
                      await _navigateTo(context, RouteName.feed_screen);
                    },
                  ),
                  DrawerListTile(
                    title: UtilStrings.Matches,
                    svgSrc: "assets/images/icon_match.png",
                    isSelected:selectIndex==1?true:false,
                    selectIndex: 1,
                    press: () async {
                      changeIndex(1);
                      SessionManager.getString(Preferences.subscription_status)=="false"?
                      Utils.showAlertSubscriptionDialog(context): await _navigateTo(context, RouteName.match_screen);
                    },
                  ),
                  DrawerListTile(
                    title: UtilStrings.Admiring,
                    svgSrc: "assets/images/icon_admiring.png",
                    isSelected:selectIndex==2?true:false,selectIndex: 2,
                    press: () async {
                      changeIndex(2);
                      SessionManager.getString(Preferences.subscription_status)=="false"?
                      Utils.showAlertSubscriptionDialog(context):
                      await _navigateTo(context, RouteName.admiring_screen);
                    },
                  ),
                  DrawerListTile(
                    title: UtilStrings.Admirers,
                    svgSrc: "assets/images/icon_like.png",
                    isSelected:selectIndex==3?true:false,selectIndex: 3,
                    press: () async {
                      changeIndex(3);
                      SessionManager.getString(Preferences.subscription_status)=="false"?
                      Utils.showAlertSubscriptionDialog(context):
                      await _navigateTo(context, RouteName.admirers_screen);
                    },
                  ),
                  DrawerListTile(
                    title: UtilStrings.Messages,
                    svgSrc: "assets/images/icon_messages.png",
                    isSelected:selectIndex==4?true:false,
                   selectIndex: 4,
                    press: () async {
                      changeIndex(4);
                      if(SessionManager.getString(Preferences.subscription_status)=="false"){
                        Utils.showAlertSubscriptionDialog(context);
                      }else{
                        Utils.onUserLogin(SessionManager.getString(Preferences.USER_ID),SessionManager.getString(Preferences.USER_NAME));
                        await _navigateTo(context, RouteName.message_screen);
                      }

                    },
                  ),
                  DrawerListTile(
                    title: UtilStrings.Notifications,
                    svgSrc: "assets/images/icon_notification.png",
                    isSelected:selectIndex==5?true:false,selectIndex: 5,
                    press: () async {
                      changeIndex(5);
                      await _navigateTo(context, RouteName.notification_screen);
                    },
                  ),
                  DrawerListTile(
                    title: UtilStrings.Subscription,
                    svgSrc: "assets/images/icon_subscription.png",
                    isSelected:selectIndex==6?true:false,selectIndex: 6,
                    press: () async {
                      changeIndex(6);
                      if(kIsWeb){
                        await _navigateTo(context, RouteName.subscription_screen_web);
                      }else{
                        await _navigateTo(context, RouteName.subscription_screen_mobile);
                      }
                    },
                  ),
                  DrawerListTile(
                    title: UtilStrings.Settings,
                    svgSrc: "assets/images/icon_setting.png",
                    isSelected:selectIndex==7?true:false ,selectIndex: 7,
                    press: () async {
                      changeIndex(7);
                      await _navigateTo(context, RouteName.setting_screen);
                    },
                  ),
                  DrawerListTile(
                    title: UtilStrings.FAQs,
                    svgSrc: "assets/images/icon_faq.png",
                    isSelected:selectIndex==8?true:false,selectIndex: 8,
                    press: () async {
                      changeIndex(8);
                      await _navigateTo(context, RouteName.faq_screen);
                    },
                  ),
                  DrawerListTile(
                    title:  UtilStrings.Testimonial,
                    svgSrc: "assets/images/icon_test.png",
                    isSelected:selectIndex==9?true:false,selectIndex: 9,
                    press: () async {
                      changeIndex(9);
                      await _navigateTo(context, RouteName.testimonials_screen);
                    },
                  ),
                  DrawerListTile(
                    title:  UtilStrings.More,
                    svgSrc: "assets/images/icon_more.png",
                    isSelected:selectIndex==10?true:false,selectIndex: 10,
                    press: () async {
                      changeIndex(10);
                    },
                  ),
                ],
              ),
            ),
          ),
          if (widget.permanentlyDisplay)
            const VerticalDivider(
              width: 1,
            )
        ],
      ),
    );
  }

  Future<void> _navigateTo(BuildContext context, String routeName) async {
    if (widget.permanentlyDisplay) {
      Navigator.pop(context);
    }
    await Navigator.pushNamed(context, routeName);
  }


  void _updateSelectedRoute() {
    setState(() {
      _selectedRoute = ModalRoute.of(context)!.settings.name;
    });
  }

}

class DrawerListTile extends StatefulWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.isSelected,
    required this.selectIndex,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final bool isSelected;
  final VoidCallback press;
  final int selectIndex;

  @override
  State<DrawerListTile> createState() => _DrawerListTileState();
}

class _DrawerListTileState extends State<DrawerListTile> implements DrawerResponseInterface
{

  DrawerResponsePresenter? drawerResponsePresenter;
  @override
  void initState() {
    drawerResponsePresenter=DrawerResponsePresenter(this);
    super.initState();
  }  bool isLoading=false;
  @override
  onCreateSource(SuccessResponse response) {
    print("response==>"+response.message.toString());
    if(response.status==200){
      Utils.customDialog(context,message:response.message.toString());

    }
  }

  @override
  onError(String msg, int status) {
    print("response==>"+msg.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20,right: 20),
          decoration: BoxDecoration(
              color:widget.isSelected?AppColor.white:null,
              borderRadius: BorderRadius.circular(12)
          ),
          child: ListTile(
            onTap: widget.press,
            hoverColor: widget.isSelected?AppColor.white:null,
            horizontalTitleGap: 0.0,
            selectedColor:widget.isSelected?AppColor.white:null,
            tileColor:widget.isSelected?AppColor.white:null,
            leading: Container(
              margin: EdgeInsets.only(top: 6),
              child: Image.asset(
                widget.svgSrc,
                color:widget.isSelected?HexColor("#A8580F"):HexColor("#7B7F91"),
                height: 16,
              ),
            ),
            title:widget.selectIndex!=10?Utils.mediumHeadingNormalText(text:widget.title,textSize: 12,fontWeight: FontWeight.normal,color:widget.isSelected?HexColor("#A8580F"):HexColor("#7B7F91"),textAlign: TextAlign.start):
            GestureDetector(
              onTap: (){

              },
              child: Theme(data: Theme.of(context).copyWith(
                  cardColor: Colors.white
              ),
                child: PopupMenuButton(
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),child: Utils.mediumHeadingNormalText(text:widget.title,textSize: 12,fontWeight: FontWeight.normal,color: Colors.black,textAlign: TextAlign.start),
                    itemBuilder: (ctx) => [
                      _buildPopupMenuItem(
                        // UtilStrings.Refer_to_friends,
                          UtilStrings.How_did_you_hear_about_us,
                              (){
                            showMemberMenu(context);
                            // Navigator.pop(context);
                          }),
                      _buildPopupMenuItem(UtilStrings.Contact_us,(){
                        Utils.launchMailto();
                        // Utils.openMail("hello@likeplaylikeplay.com");
                      }),
                      /*_buildPopupMenuItem(
                          // UtilStrings.Refer_to_friends,
                          UtilStrings.Feedback,
                              (){
                        Navigator.pop(context);
                      }),*/

                      _buildPopupMenuItem(UtilStrings.Logout,(){
                        showAlertLogoutDialog(context);
                      }
                      ),
                    ]),
              ),

            ))),
        Utils.progressDialogFullScreen(context, isLoading)
      ],
    );

  }

  void showMemberMenu(BuildContext context) async {
    final screenSize = MediaQuery.of(context).size;

    await showMenu(
      context: context,
      color: Colors.white,
      // position: RelativeRect.fromLTRB(12, 400, 22, 1),
      position: RelativeRect.fromLTRB(
        180,
        screenSize.height/1.4,
        screenSize.width - 400,
        screenSize.height - 400,
      ),
      // position: RelativeRect.fromDirectional(textDirection: TextDirection.rtl, start: 10.0, top: 400, end: 22, bottom: 10),
      items: [
        PopupMenuItem(
          value: 1,
          onTap: (){
            drawerResponsePresenter!.doCreateSource("1");

          },
          child: Text("Facebook",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black),),
        ),
        PopupMenuItem(
          onTap: (){
            drawerResponsePresenter!.doCreateSource("2");

          },
          value: 2,
          child: Text("You Tube", style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black),),
        ),
        PopupMenuItem(
          value: 3,
          onTap: (){
            drawerResponsePresenter!.doCreateSource("3");

          },
          child: Text("linkedIn", style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black),),  ),
        PopupMenuItem(
          value: 4,
          onTap: (){
            drawerResponsePresenter!.doCreateSource("4");

          },
          child: Text("Instagram", style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black),),),
        PopupMenuItem(
          value: 5,
          onTap: (){
            drawerResponsePresenter!.doCreateSource("5");

          },
          child: Text("Twitter", style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black),),
        ),
        PopupMenuItem(
          value: 6,
          onTap: (){
            drawerResponsePresenter!.doCreateSource("6");

          },
          child: Text("Newspaper", style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black),),),
        PopupMenuItem(
          value:7,
          onTap: (){
            drawerResponsePresenter!.doCreateSource("7");

          },
          child: Text("Friends", style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black),),
        ),
        PopupMenuItem(
          value: 8,
          onTap: (){
            drawerResponsePresenter!.doCreateSource("8");

          },
          child: Text("Media Ads", style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black),),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value != null) print(value);
    });
  }
  var _isLoading = false;


  showAlertLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  StatefulBuilder(
          builder: (context, StateSetter setInnerState) {
            return AlertDialog(
              actions: [
                Container(
                  margin: const EdgeInsets.only(left: 20,right: 20),
                  width:  Responsive().getResponsiveValue(
                      forLargeScreen: MediaQuery.of(context).size.width/4,
                      context: context),
                  height:  Responsive().getResponsiveValue(
                      forLargeScreen: MediaQuery.of(context).size.height/3,
                      context: context),
                  child: Wrap(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 40,bottom: 10.0),
                        child: Center(
                          child: Utils.mediumHeadingNormalText(text:"Logout",textSize: 12,fontWeight: FontWeight.bold,color: AppColor.APP_TEXT_COLOR,textAlign: TextAlign.start),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Center(
                        child:
                        Text("Are you sure want to log out?",style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600),),
                      ),
                      Center(
                        child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: (){
                                    setInnerState(() {
                                      _isLoading=false;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child:Container(
                                width: 100,
                                padding: EdgeInsets.all(9.0),
                                margin: EdgeInsets.only(top: 30.0,bottom: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: HexColor("#FF483C"))
                                ),
                                child: Text("Cancel",textAlign:TextAlign.center,style: TextStyle(color: HexColor("#112153")),),
                              )),
                              SizedBox(width: 12,),
                            GestureDetector(
                                onTap: () async {
                                  setInnerState(() {
                                    _isLoading=true;
                                  });
                                  await FirebaseMessaging.instance.unsubscribeFromTopic("user_${SessionManager.getString(Preferences.USER_ID)}");
                                  await FirebaseMessaging.instance.unsubscribeFromTopic("chatId_${SessionManager.getString(Preferences.USER_ID)}");
                                  await FirebaseMessaging.instance.unsubscribeFromTopic("is_admin");
                                  SessionManager.setString(Preferences.profileStatus,"");
                                  SessionManager.setBools(Preferences.IS_USER_LOGIN, false);
                                  ZegoUIKitPrebuiltCallInvitationService().uninit();
                                  launch(home_url_website);
                                  Navigator.pushAndRemoveUntil<void>(
                                    context,
                                    MaterialPageRoute<void>(builder: (BuildContext context) =>  HomeScreen(viewType: 0,)),
                                    ModalRoute.withName('/'),
                                  );
                                },
                                child: Container(
                                  width: 100,
                                  padding: EdgeInsets.all(9.0),
                                  margin: EdgeInsets.only(top: 30.0,bottom: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: HexColor("#FF483C"),
                                  ),
                                  child: _isLoading==false?
                                  Text("LogOut",textAlign:TextAlign.center,style: TextStyle(color: Colors.white),):
                                  Container(
                                    height: 26,
                                    width: 26,
                                    padding: EdgeInsets.only(left:30.0,right: 30.0,top: 10,bottom: 10),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1.2,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                        /*   ElevatedButton.icon(
                                onPressed: _isLoading ? null : _onSubmit,
                                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(4.0),backgroundColor: Colors.white),
                                icon: _isLoading
                                    ? Container(
                                  width: 24,
                                  height: 24,
                                  padding: const EdgeInsets.all(2.0),
                                  child: const CircularProgressIndicator(
                                    color: Colors.blueAccent,
                                    strokeWidth: 3,
                                  ),
                                )
                                    :  Container(
                                   width: 120,
                                   padding: EdgeInsets.all(10.0),
                                   margin: EdgeInsets.only(top: 30.0,bottom: 20),
                                   decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(8),
                                   color: HexColor("#FF483C"),
                                   ),
                                   child: Text("LogOut",textAlign:TextAlign.center,style: TextStyle(color: Colors.white),),
                                   ),
                                label: const Text(''),
                              )*/
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          }
        );
      },
    );
  }
}
PopupMenuItem _buildPopupMenuItem(String title, Function onTap) {
  return PopupMenuItem(
    onTap: (){
      onTap()!;
    },
    child:Utils.mediumHeadingNormalText(text:title,textSize: 12,fontWeight: FontWeight.normal,color: title==UtilStrings.Logout?Colors.red:Colors.black),
  );
}