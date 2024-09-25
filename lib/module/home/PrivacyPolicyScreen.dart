import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/SpanBold.dart';
import '../../utils/TextBold.dart';
import '../../utils/TextItalic.dart';
import '../../utils/TextNormal.dart';
import '../../utils/color_utils.dart';
import '../../utils/constants.dart';
import '../../utils/summary_widget.dart';
import '../../utils/utils.dart';
class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                            // html.window.history.replaceState(null, '', '/');
                            /*Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                SubscriptionWebScreen()), (Route<dynamic> route) => false);*/
                          },
                          child: Utils.imageView(image: "assets/images/ic_close.png",color: Colors.black,height: 20,width: 20))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(height: 20,),

                  Center(
                    child: Text("Privacy Policy",style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 25
                    ),),
                  ),
                  SizedBox(height: 25,),

                  TextNormal(text: "Effective Date: January 1, 2023"),

                  SizedBox(height: 20,),

                  TextBold(text: "OUR COMMITMENT"),

                  box_15(),

                  TextNormal(text: "LikePlay-LikePlay.com (“LikePlay”), which is operated by LIKE PLAY NETWORK, Inc. respects your privacy. LikePlay operates the Website in all applicable areas. We are committed to protecting the privacy of our users and we want to provide a safe and secure user experience. We will use our best efforts to ensure that the information you submit to us remains private and is used only for the purposes set forth herein. This policy details how data about you is collected, used, and shared when you access our websites and services or interact with us (collectively, the “Services”)."),

                  box_20(),
                  TextBold(text: "APPLICABILITY OF PRIVACY POLICY"),
                  box_15(),
                  TextNormal(text: "This privacy policy applies to all information we collect through our web and mobile applications from current and former LikePlay users and visitors. When you are no longer our customer, we continue to share your information as described in this policy. This policy only applies to the Services and does not apply to the practices of any other LikePlay service. This policy also covers our treatment of any personally identifiable information that our business partners share with us."),
                  box_20(),
                  TextBold(text: "LIKEPLAY NETWORK, INC. and AFRICA LIKE PLAY ONLINE PLATFORMS LTD"),
                  box_15(),
                  TextNormal(text: "Are  are affiliated with various entities.  "),
                  /*bulletPointer1(context, "Clover8 Investments Pte Ltd."),
                  bulletPointer1(context, "W8 Tech Limited (Hong Kong)"),
                  bulletPointer1(context, "W8 Tech Limited, Inc. (USA)"),*/
                  box_20(),
                  TextBold(text: "INFORMATION COLLECTED"),
                  box_15(),
                  TextNormal(text: "When you use the Services, you may be asked for certain personal information, including your name, email address, zip/postal code, phone numbers, credit card information, occupation, hobbies and interests. Our website also automatically receives and records information on our server logs from your browser, including your IP address, browser type and LikePlay Cookie (defined below) information. As previously stated, we are committed to providing you a safe and secure user environment. Therefore, before permitting you to use the Services, we may require additional information from you that we can use to verify your identity, address or other information or to manage risk and compliance throughout our relationship. We may also obtain information about you from third parties such as identity verification, fraud prevention, and similar services. LikePlay, collect data to operate effectively and provide better quality experiences. If you do not agree to our collection of the information, you may be limited or restricted in the Services available to you."),
                  box_20(),
                  TextBold(text: "HOW LIKEPLAY, USE PERSONAL DATA:"),
                  box_15(),
                  TextNormal(text: "LikePlay uses this information to:"),
                  bulletPointer1(context, "Provide, maintain, and improve the Services;"),
                  bulletPointer1(context, "Personalize the content you see;"),
                  bulletPointer1(context, "Provide Customer Service;"),
                  bulletPointer1(context, "Help protect the safety of LikePlay and its users, which includes blocking suspected spammers, investigating and addressing abuse, and enforcing the LikePlay Terms of Use and Privacy Policy;"),
                  bulletPointer1(context, "Inform you of updates to our services, security alerts, and other support and administrative messages;"),
                  bulletPointer1(context, "Communicate with you about products, services, offers, promotions, and events, and provide other news and information we think will be of interest to you (for information about how to opt out of these communications, see “Choices” below); and"),
                  bulletPointer1(context, "Monitor and analyze trends, usage, and activities in connection with the Services."),

                  box_20(),
                  TextBold(text: "WEBSITE VISITORS"),
                  box_15(),
                  RichText(
                    text:  TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [

                          TextSpan(
                              style: Theme.of(context).textTheme.bodyMedium
                              ,text: "We gather information about all users collectively, such as what areas users visit most frequently and what services users access the most. We only use such data anonymously. This information helps us determine what is the most beneficial for our users and how we can continually create a better overall user experience. We may share anonymized information with our partners so that they may also understand how users and visitors use our services. We may use data stitching, which is the process of combining your datasets from multiple sources, to better track website use. Our Website uses Google Analytics. To learn more about how Google Analytics collects and uses data, or to opt out, "),

                          spanRedCustom(context, () {
                            lauch_url(url_policy_google);
                          }, "click HERE")
                        ]

                    ),

                  ),

                  box_20(),
                  TextBold(text: "INFORMATION FROM MINORS"),
                  box_15(),
                  TextNormal(text: "We do not knowingly solicit, collect, or share information from any individuals under the age of 18."),


                  box_20(),
                  TextBold(text: "COOKIES"),
                  box_15(),
                  TextNormal(text: "When you utilize the Services, we—along with certain business partners and vendors—may use cookies and other tracking technologies (collectively, “Cookies”). We use Cookies as outlined in the “How Your Information Is Used Section.”Certain aspects and features of the Services are only available through the use of Cookies, so if you choose to disable or decline Cookies, your use of the Services may be limited or not possible."),


                  box_20(),
                  TextBold(text: "DO NOT TRACK"),
                  box_15(),
                  TextNormal(text: "Do Not Track (“DNT”) is an optional browser setting that allows you to express your preferences regarding tracking by advertisers and other third parties. We do not respond to DNT signals."),

                  box_20(),
                  TextBold(text: "SHARING INFORMATION"),
                  box_15(),
                  TextNormal(text: "When you use the Services, certain information may be shared with other users and the public. For example:"),


                  bulletPointer1(context, "When you submit a post or comment to the Services, visitors to and users of the Services will be able to see the content of your posts and comments, the username associated with your posts or comments, and the date and time you originally submitted the post or comment. Although some parts of the services may be private or quarantined, they may become public and you should take that into consideration before posting to the Services."),
                  bulletPointer1(context, "When you send private messages or messages, the recipients of those messages will be able to see the content of your message, your username, and the date and time the message was sent. Please use caution when sharing information about yourself to third parties, as we have no control over how they will use the information you share with them."),
                  bulletPointer1(context, "When other users view your profile, they will be able to see information about your activities on the Services, such as your username, prior posts and comments, etc."),
                  bulletPointer1(context, "We will not share, sell, or give away any of our users’ personal information to third parties, unless one of the following circumstances applies:"),
                  bulletPointer1(context, "We may share information with vendors, consultants, and other service providers who need access to such information to carry out work for us. A complete list of the types of these third parties is at Appendix I at the end of this Policy. These companies may have access to your personal information as necessary to perform their functions, and they are contractually obligated to maintain the confidentiality of any personal information in which they come in contact as part of their services to LikePlayLikePlay."),
                  bulletPointer1(context, "If you participate in promotions, special offers, or other events or activities in connection with the Services, we may share information with entities that partner with us to provide these offerings;"),
                  bulletPointer1(context, "We may share information in response to a request for information if we believe disclosure is in accordance with, or required by, any applicable law, regulation, legal process or governmental request, including, but not limited to meeting national security or law enforcement requirements;"),
                  bulletPointer1(context, "We may share information in response to an emergency if we believe it is necessary to prevent imminent and serious bodily harm to a person;"),
                  bulletPointer1(context, "We may share aggregated or anonymized  information, which cannot reasonably be used to identify you;"),
                  bulletPointer1(context, "We may share information between and among LikePlay, and its current and future parents, affiliates, subsidiaries, and other companies under common control and ownership; and"),
                  bulletPointer1(context, "We may share information with your consent or at your direction."),
                  box_20(),
                  TextBold(text: "SOCIAL SHARING"),
                  box_15(),
                  TextNormal(text: "The Services may offer social sharing features or other integrated tools that let you share content or action you take using the Services with other media. Your use of these features enables the sharing of certain information with your friends or the public, depending on the settings you establish with the third party that provides the social sharing feature. For more information about the purpose and scope of data collection and processing in connection with social sharing features, please visit the privacy policies of the third parties that provide these social sharing features."),

                  box_20(),
                  TextBold(text: "ONLINE TRANSACTIONS"),
                  box_15(),
                  RichText(

                    text:  TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [

                          TextSpan(
                              text: "When you place an order online, your personal details and credit card information are encrypted using SSL encryption technology before being sent over the Internet. Although we cannot guarantee encryption or the privacy of your personal details, SSL makes it very difficult for your information to be stolen or intercepted while being transferred. Our credit card transactions are processed by Pystack. All information sent to Paystack is in the secure SSL environment, which will protect it against disclosure to third parties. When we receive your order, it is on an SSL server. For Paystack privacy statement, please visit their website "
                          ),

                          spanRedCustom(context, () {
                            lauch_url(paystack);
                          }, "https://paystack.com"),


                          /*    TextSpan(


                            text: ". For RocketGate’s privacy statement, please click "

                          ),
                          spanRedCustom(context, () {
                            lauch_url(url_policy_rocket_gate);
                          }, "HERE"),

                          TextSpan(

                            text: ". At the point when an end-user wishes to make a payment, his registration details may be passed to PaymentWall, a company that provides payment processing services, in order for PaymentWall to better protect service- and end-users from unauthorized payments."

                          ),*/


                        ]

                    ),

                  ),
                  box_20(),
                  TextBold(text: "ACCOUNTS PAYABLE OR COLLECTIONS"),
                  box_15(),
                  TextNormal(text: "It is your duty to make sure that you keep your account(s) in good standing with us. If you have an outstanding balance, or if you dispute your payment to us with your credit card or financial institution for any reason, please note that all information collected from your activity on our website may be disclosed to the bank andIt is your duty to make sure that you keep your account(s) in good standing with us. If you have an outstanding balance, or if you dispute your payment to us with your credit card or financial institution for any reason, please note that all information collected from your activity on our website may be disclosed to the bank and/or collections agency we work with for the purposes of establishing proof of users’ identity, proof of use, proof that service was provided, and/or collecting any outstanding debt owed to us.."),


                  box_20(),
                  TextBold(text: "DOMESTIC DATA"),
                  box_15(),
                  TextNormal(text: "LikePlay is based in both the United States and Nigeria. The information we collect is governed by both. By accessing or using the Services or otherwise providing information to us, You consent to the processing, transfer, and storage of information in Nigeria and to the U.S."),
                  box_15(),
                  TextBold(text: "UPDATING ACCOUNT INFORMATION"),
                  box_15(),
                  TextNormal(text: "LikePlay allows you to change your personal information at any time. To do so, simply log on to Seeking with your username and password, and you will be able to update the information you have submitted."),
                  box_15(),
                  box_20(),
                  TextBold(text: "CHOICES"),
                  box_15(),
                  TextNormal(text: "We also provide you with the opportunity to opt-in to receive these types of communications at the time of registration, but later decide to opt out of several types of communications at the time of registration. If you no longer want to receive them, simply change your preferences on your account settings or communicate your preferences to us via email. You may opt out of receiving promotional communications from us by following the instructions in those communications. If you opt out, we may still send you non-promotional communications, such as information about your account or your use of the Services. With your consent, we may send promotional and non-promotional push notifications or alerts to your mobile device. You can deactivate these messages at any time by changing the notification settings on your mobile device."),

                  box_15(),
                  TextNormal(text: "If you deactivate your account or request that LikePlay delete your Personal Data, LikePlay may still retain certain information associated with your account for analytical purposes and record-keeping integrity, as well as to prevent fraud, collect any fees owed, enforce our terms and conditions, take actions we deem necessary to protect the integrity of our website or our users, or take other actions otherwise permitted by the General Data Protection Regulation. In addition, if certain information has already been provided to third parties as described in our Privacy Policy, retention of that information will be subject to those third parties’ policies"),

                  box_20(),
                  TextBold(text: "CHANGES TO OUR PRIVACY POLICY"),
                  box_15(),
                  TextNormal(text: "We may update this Privacy Policy from time to time. We will place any updates to this policy on our website. You may also request a paper copy of the Privacy Policy by contacting us at the email or address noted below. You are bound by any changes to the Privacy Policy by using the Services after such changes have been posted to the website."),

                  box_20(),
                  TextBold(text: "CONTACT US"),
                  box_15(),

                  RichText(
                    text:  TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                              text: "Depending on where you live, LikePlay is responsible for your information. If you have any questions, You can contact LikePlay via the following email "
                          ),
                          spanRedCustom(context, () {
                            sendMail(mail_like_play_like);
                          }, "hello@likeplaylikeplay.com"),


                        ]

                    ),



                  ),


                ],

              ),
            ),
          ),
        ),



      ),
    );
  }

  /*void lauch_url(String url_policy_google) {

  }*/


  Future<void> lauch_url(String url) async {
    try{
      if (!await launchUrl(Uri.parse(url))) {

        throw Exception('Could not lauch_url $url');
      }
    }catch(e)
    {


    }

  }

  void sendMail  (String mail) async{



    final mailtoLink = Mailto(
      to: [mail],
      cc: ['', ''],
      subject: '',
      body: '',
    );
    // Convert the Mailto instance into a string.
    // Use either Dart's string interpolation
    // or the toString() method.

    try
    {
      await launchUrl(Uri.parse('$mailtoLink'));

    }catch(e)
    {
      await Clipboard.setData(ClipboardData(text: '$mailtoLink'));

    }





  }
}
