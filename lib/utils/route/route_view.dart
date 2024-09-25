import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:likeplay/module/admire/admirers_screen.dart';
import 'package:likeplay/module/feedview/feed_screen_live.dart';
import 'package:likeplay/module/forgot/forgot_view.dart';
import 'package:likeplay/module/home/home.dart';
import 'package:likeplay/module/home/register/register_screen.dart';
import 'package:likeplay/module/match/match_screen.dart';
import 'package:likeplay/module/profile/edit_profile_screen.dart';
import 'package:likeplay/module/referral/referal_screen.dart';
import 'package:likeplay/module/setting/faq/faq_screen.dart';
import 'package:likeplay/module/testimonials/testimonials_screen.dart';
import 'package:likeplay/utils/route/route_name.dart';
import '../../module/admire/admiring_screen.dart';
import '../../module/home/terms_and_condition_screen.dart';
import '../../module/match/match_userprofile_screen.dart';
import '../../module/message/mobile_message/message_mobile_screen.dart';
import '../../module/notification/notification_screen.dart';
import '../../module/profile/profile_screen.dart';
import '../../module/setting/setting_screen.dart';
import '../../module/subscription/subscription_mobile_screen.dart';
import '../../module/subscription/subscription_screen_web.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case RouteName.referral_screen:
        return MaterialPageRoute(
          builder: (_) => ReferralScreen(),
        );
      case RouteName.homeScreen:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(viewType: 0,),
        );
        case RouteName.registerScreen:
        return MaterialPageRoute(
          builder: (_) => RegisterScreen(),
        );
        case RouteName.forgot_screen:
        return MaterialPageRoute(
          builder: (_) => ForgotScreen(viewType:4),
        );
        case RouteName.feed_screen:
        return MaterialPageRoute(
          builder: (_) => FeedLiveScreen(),
        );
        case RouteName.match_screen:
        return MaterialPageRoute(
          builder: (_) => MatchScreen(),
        );
        case RouteName.admiring_screen:
        return MaterialPageRoute(
          builder: (_) => AdmiringScreen(),
        );
        case RouteName.admirers_screen:
        return MaterialPageRoute(
          builder: (_) => AdmirersScreen(),
        );
        case RouteName.profile_screen:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(userId: '',),
        );
        case RouteName.notification_screen:
        return MaterialPageRoute(
          builder: (_) => NotificationScreen(),
        );
        case RouteName.setting_screen:
        return MaterialPageRoute(
          builder: (_) => SettingScreen(),
        );
        case RouteName.message_screen:
        return MaterialPageRoute(
          builder: (_) => MessageMobileView(),
        );
        case RouteName.edit_profile_screen:
        return MaterialPageRoute(
          builder: (_) => EditProfileScreen(),
        );
        case RouteName.match_profile_screen:
        return MaterialPageRoute(
          builder: (_) => MatchUsersProfileScreen(userId: '',),
        );
        case RouteName.faq_screen:
        return MaterialPageRoute(
          builder: (_) => FAQScreen(),
        );
        case RouteName.testimonials_screen:
        return MaterialPageRoute(
          builder: (_) => TestimonialsScreen(),
        );
        case RouteName.subscription_screen_mobile:
        return MaterialPageRoute(
          builder: (_) => SubscriptionMobileScreen(),
        );
        case RouteName.subscription_screen_web:
        return MaterialPageRoute(
          builder: (_) => SubscriptionWebScreen(),
        );
        case RouteName.TermsAndConditionScreen:
        return MaterialPageRoute(
          builder: (_) => TermsAndConditionScreen(),
        );
        ///directory materialPageRoutes end here
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}