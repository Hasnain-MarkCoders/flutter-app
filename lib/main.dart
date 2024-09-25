import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:likeplay/module/home/home.dart';
import 'package:likeplay/splash/splash_screen.dart';
import 'package:likeplay/utils/route/route_name.dart';
import 'package:likeplay/utils/sharedpref/shared_prefrence.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'module/admire/admirers_screen.dart';
import 'module/admire/admiring_screen.dart';
import 'module/feedview/feed_screen_live.dart';
import 'module/forgot/forgot_view.dart';
import 'module/home/register/register_screen.dart';
import 'module/match/match_screen.dart';
import 'module/match/match_userprofile_screen.dart';
import 'module/message/mobile_message/message_mobile_screen.dart';
import 'module/notification/notification_screen.dart';
import 'module/profile/edit_profile_screen.dart';
import 'module/profile/profile_screen.dart';
import 'module/referral/referal_screen.dart';
import 'module/setting/faq/faq_screen.dart';
import 'module/setting/setting_screen.dart';
import 'module/subscription/subscription_mobile_screen.dart';
import 'module/subscription/subscription_screen_web.dart';
import 'module/testimonials/testimonials_screen.dart';
import 'utils/route/route_view.dart';
import 'package:zego_uikit/zego_uikit.dart';


const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title// description
    importance: Importance.high,
    playSound: true);


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled;
  await Firebase.initializeApp();
  if (kIsWeb || defaultTargetPlatform == TargetPlatform.macOS ) {{
    await FacebookAuth.instance.webAndDesktopInitialize(
      appId: "931380754771082",
      cookie: true,
      xfbml: true,
      version: "v16.0",
    );}}

  /// 1/5: define a navigator key
  final navigatorKey = GlobalKey<NavigatorState>();

  /// 2/5: set navigator key to ZegoUIKitPrebuiltCallInvitationService
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  ZegoUIKit().initLog().then((value) async {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );
 /* Firebase.initializeApp(options: const FirebaseOptions(
      apiKey: "AIzaSyB-EhKPYVdyGAasV9SiLIDTJMUByOUvTe0",
      authDomain: "likeplay-b2fd1.firebaseapp.com",
      projectId: "likeplay-b2fd1",
      storageBucket: "likeplay-b2fd1.appspot.com",
      messagingSenderId: "778160595737",
      appId: "1:778160595737:web:02a93267533ac357631b88",
      measurementId: "G-574MBVLM6S"));*/

 FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MyApp(navigatorKeyN: navigatorKey,));
});}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKeyN;

  const MyApp({
    required this.navigatorKeyN,
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Notification");
  bool _isForegroundServiceRunning = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _startForegroundService();
    } else if (state == AppLifecycleState.paused) {
      _startForegroundService();
    }else if (state == AppLifecycleState.detached) {
      _stopForegroundService();
    }
  }

  void _startForegroundService() {
    // Start the ZegoUIKitPrebuiltCallInvitationService
    //ZegoUIKitPrebuiltCallInvitationService().didChangeAppLifecycleState(true);
    _isForegroundServiceRunning = true;
  }

  void _stopForegroundService() {
    // Stop the ZegoUIKitPrebuiltCallInvitationService
    //ZegoUIKitPrebuiltCallInvitationService().didChangeAppLifecycleState(false);
  }

  @override
  initState() {
    SessionManager.init();
   /* Firebase.initializeApp(options: const FirebaseOptions(
        apiKey: "AIzaSyB-EhKPYVdyGAasV9SiLIDTJMUByOUvTe0",
        authDomain: "likeplay-b2fd1.firebaseapp.com",
        projectId: "likeplay-b2fd1",
        storageBucket: "likeplay-b2fd1.appspot.com",
        messagingSenderId: "778160595737",
        appId: "1:778160595737:web:02a93267533ac357631b88",
        measurementId: "G-574MBVLM6S"));*/
    var initializationSettingsAndroid =  AndroidInitializationSettings('ic_launcher');
    var initializationSettingsIOS = const IOSInitializationSettings(onDidReceiveLocalNotification: null);
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }

    });

    FirebaseMessaging.onBackgroundMessage((message) async{
      //var mType=message.data["msg_type"];
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null) {

      }
      return;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {

        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body.toString())],
                  ),
                ),
              );
            });
      }
    });
    super.initState();
  }
  Future<dynamic> onSelectNotification(payload) async {
    navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) =>  HomeScreen()),
          (Route<dynamic> route) => false,
    );
  }
 void scheduleNotification(String title, String subtitle,String msg_type) {
    print("scheduling one with $title and $subtitle and $msg_type and $msg_type");
    var rng = Random();
    Future.delayed(Duration(seconds: 5)).then((result) async {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channel.id,
        channel.name,
        color: Colors.blue,
        playSound: true,
        icon: '@mipmap/ic_launcher',
      );
      var iOSPlatformChannelSpecifics = IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
          rng.nextInt(100000), title, subtitle, platformChannelSpecifics,
          payload: msg_type);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: widget.navigatorKeyN,
      builder: (context,  Widget? child) {
        // do your initialization here
        child =  ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, child!),
          breakpoints: const [
            ResponsiveBreakpoint.resize(350, name: MOBILE),
            ResponsiveBreakpoint.autoScale(600, name: TABLET),
            ResponsiveBreakpoint.resize(800, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
          ],
        );  // assuming this is returning a widget
        child =Stack(
          children: [
            child,
            /// support minimizing
            ZegoUIKitPrebuiltCallMiniOverlayPage(
              contextQuery: () {
                return widget.navigatorKeyN.currentState!.context;
              },
            ),
          ],
        );
        return child;
      },
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColorDark: Colors.black,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black), // Customize the text color here
        ),
      ),
      // home:SplashScreen(),
      home:SplashScreen(),
      routes: routes,

      // home: SubscriptionScreen(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

Map<String, WidgetBuilder> routes = {
  // PageRouteNames.login: (context) => const LoginPage(),
  RouteName.homeScreen: (context) =>  HomeScreen(viewType: 0,),
  RouteName.referral_screen: (context) =>  ReferralScreen(),
  RouteName.registerScreen: (context) =>  RegisterScreen(),
  RouteName.feed_screen: (context) =>  FeedLiveScreen(),
  RouteName.forgot_screen: (context) =>  ForgotScreen(viewType:4),
  RouteName.match_screen: (context) => MatchScreen(),
  RouteName.admiring_screen: (context) => AdmiringScreen(),
  RouteName.admirers_screen: (context) => AdmirersScreen(),
  RouteName.profile_screen: (context) => ProfileScreen(userId: '',),
  RouteName.notification_screen: (context) => NotificationScreen(),
  RouteName.setting_screen: (context) =>  SettingScreen(),
  RouteName.message_screen: (context) => MessageMobileView(),
  RouteName.edit_profile_screen: (context) =>  EditProfileScreen(),
  RouteName.match_profile_screen: (context) =>   MatchUsersProfileScreen(userId: '',),
  RouteName.faq_screen: (context) =>   FAQScreen(),
  RouteName.testimonials_screen: (context) =>  TestimonialsScreen(),
  RouteName.subscription_screen_mobile: (context) =>  SubscriptionMobileScreen(),
  RouteName.subscription_screen_web: (context) =>  SubscriptionWebScreen(),

};
