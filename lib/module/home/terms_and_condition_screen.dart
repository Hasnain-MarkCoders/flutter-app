import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/utils/utils.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/SpanBold.dart';
import '../../utils/color_utils.dart';
import '../../utils/constants.dart';
import '../../utils/summary_widget.dart';
import 'PrivacyPolicyScreen.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionScreen> createState() => _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
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
                          },
                          child: Utils.imageView(image: "assets/images/ic_close.png",color: Colors.black,height: 20,width: 20))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: Text(
                        "TERMS AND CONDITIONS",
                        style: TextStyle(fontFamily: "Poppins",fontSize: 14,color:  Colors.black),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: Text("AFRICA LIKEPLAY ONLINE PLATFORMS LTD",
                          style: Theme.of(context).textTheme?.bodyMedium)),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Please review this Agreement carefully.",
                      style: Theme.of(context).textTheme?.bodyMedium),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Terms of Use",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text("Effective Date: May 1st, 2023",
                      style: Theme.of(context).textTheme?.bodyMedium),
                  SizedBox(
                    height: 15,
                  ),
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                            TextSpan(
                                text: "By accessing the LikePlayLikePlay.com "),
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    lauch_url(home_url_website);
                                  },
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: color_primary,
                                ),
                                text: "website"),
                            TextSpan(
                                text:
                                " (the “Website” or “LikePlay-LikePlay”), including through a mobile application, you (the “User”, “Member”, or “You”) agree to be bound by this Terms of Use agreement (the “Agreement”) and the Privacy Policy, which is available "),


                            WidgetSpan(child: Container(
                              color: Color.fromRGBO(0, 255, 255,1),

                              child: RichText(

                                text:  TextSpan(
                                    style: Theme.of(context).textTheme.bodyMedium,
                                    children: [


                                      TextSpan(
                                          style: TextStyle(
                                              decoration: TextDecoration.underline,
                                              color: color_primary),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              // lauch_url(url_terms_of_use);
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>PrivacyPolicyScreen()));
                                            },
                                          text: "here"
                                      ),
                                      TextSpan(
                                          text: "."
                                      )
                                    ]

                                ),

                              ),

                            )),

                            TextSpan(
                                text:
                                " You agree that this Agreement and the Privacy Policy bind you, whether or not You register as a Member of the Website. The Website is operated by AFRICA LIKEPLAY ONLINE PLATFORMS LTD. (“LikePlay,” “LikePlay-LikePlay” or the “Company”) and its affiliated companies (as defined immediately below). If You wish to visit the Website or to become a Member and make use of the "),
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    lauch_url(home_url_website);
                                  },
                                style: style_red_underdine,
                                text: "LikePlay-LikePlay"),
                            TextSpan(
                                text:
                                " service (the “Service”), please read this Agreement. You are required to accept this Agreement to access and use the Website. This Agreement is in English. You should not rely on any non-English translation of this Agreement. Refer to this Agreement in English in the event of any discrepancies or inconsistencies. The summaries of the Agreement’s provisions contained herein are solely for informational purposes. These summaries are not formally part of the Agreement and do not have binding legal effect. \n"),
                            TextSpan(
                                style: TextStyle(fontWeight: FontWeight.w600),
                                text: "\nSummary:"),
                            TextSpan(
                                text:
                                " This Agreement is between You and LikePlay-LikePlay and is required before You can use the site and the Service. English is the official language of this Agreement. This summary, and the other summaries, are to help you understand the Agreement and are not part of the Agreement itself."),
                            TextSpan(
                                style: TextStyle(fontWeight: FontWeight.w600),
                                text:
                                "\n\nAffiliated Companies of Africa LikePlay Online Platforms Inc."),
                            TextSpan(text: "$margin_dot LIKE PLAY NETWORK, INC."),
                            TextSpan(
                                style: TextStyle(fontWeight: FontWeight.w600),
                                text:
                                "\n\nIF YOU DO NOT ACCEPT AND AGREE TO BE BOUND BY ALL OF THE TERMS AND CONDITIONS OF THIS AGREEMENT OR YOU DO NOT MEET OR COMPLY WITH ITS PROVISIONS, DO NOT USE THE WEBSITE OR THE SERVICE."),
                            TextSpan(
                                style: TextStyle(fontWeight: FontWeight.w600),
                                text: "\n\nSummary:"),
                            TextSpan(
                                text:
                                " These are our terms and if You use the Website or our Service, you are bound by this Agreement. Please read this Agreement."),
                            TextSpan(
                                style: TextStyle(fontWeight: FontWeight.w600),
                                text:
                                "\n\nPlease review this Agreement carefully, including the Acceptable Website Use provision, which "),
                            TextSpan(
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w600),
                                text:
                                "PROHIBITS ANY UNLAWFUL USE OF THE SITE, INCLUDING ESCORTING, PROSTITUTION AND HUMAN TRAFFICKING. "),
                            TextSpan(
                                style: TextStyle(fontWeight: FontWeight.w600),
                                text:
                                " In order to proceed with this Agreement and to access the Service of the Website, You must acknowledge and agree to be bound by the terms of this Agreement, including the Acceptable Website Use provision described herein."),
                            TextSpan(
                                style: TextStyle(fontWeight: FontWeight.w600),
                                text: "\n\nSummary:"),
                            TextSpan(
                                text:
                                " If You access our Website and/or use our Service, You must do so lawfully. You cannot access our Service without agreeing to these terms."),
                            TextSpan(
                                style: TextStyle(fontWeight: FontWeight.w600),
                                text: "\n\n1. Binding Agreement"),
                            WidgetSpan(
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
                                                        "This Agreement is an electronic contract that sets out the legally binding terms. You must accept this Agreement to use the Website and to become a “Member.” For purposes of this Agreement, the term “Member” or “Membership” means a person who provides information to the Company on the Website to participate in the Service in any manner, whether such person uses the Service as a free Member or as a paid subscriber."),
                                                    TextSpan(
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w600),
                                                        text:
                                                        " This Agreement may be modified by LikePlay-LikePlay in its sole discretion at any time, and any such modifications will be posted on the Website. Your continued use of the Website or the Service after the posting of modifications to this Agreement will constitute your acceptance of such revisions.")
                                                  ]))),
                                    ],
                                  ),
                                )),
                            WidgetSpan(
                                child: SizedBox(
                                    child: SummaryTxt(
                                      padding_left: true,
                                      txt:
                                      'This is a contract between You and Africa LikePlay Online Platforms Ltd. We can modify this Agreement at any time. If You continue to use the Website or the Service after we post modifications to this Agreement, You have accepted the new modified Agreement.',
                                    ))),
                            WidgetSpan(
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
                                                        "This Agreement includes LikePlay-LikePlay’s Acceptable Website Use Policy (as set forth herein), LikePlay-LikePlay’s Privacy Policy, notices regarding the Website, and terms disclosed and agreed to by You if You become a Member or if You purchase or accept additional features, products, or services we offer on the Website, such as state-specific terms and terms governing features, billing, free trials, discounts, and promotions."),
                                                  ]))),
                                    ],
                                  ),
                                )),
                            WidgetSpan(
                                child: SummaryTxt(
                                  padding_left: true,
                                  txt:
                                  "Our Acceptable Use Policy and Privacy Policy are incorporated into this Agreement. Any other notices and terms presented to You and accepted by You (either directly or by use of the Service) are also incorporated into these terms.",
                                )),
                            TextSpan(
                                style: TextStyle(fontWeight: FontWeight.w600),
                                text: "\n\n2. Eligibility"),
                            WidgetSpan(
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 12, top: 10),
                                    child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                fontWeight: FontWeight.w600),
                                            text:
                                            "You must be at least eighteen years old to register as a Member or use the Website"),
                                        TextSpan(
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                            text:
                                            ". By using the Website, You represent and warrant that You have the right, authority, and capacity to enter into this Agreement and to abide by all of the terms and conditions of this Agreement. If You become a Member, You represent and warrant that You have never been convicted of a felony and that You are not required to register as a sex offender (or similar designation) with any government entity or legal authority. You will only use the Service and the Website in a manner consistent with this Agreement and any and all applicable local, state, national and international laws, and regulations, including, but not limited to, Nigeria, Ghana, South Africa, Congo, Cote ‘Ivoire, and United States export control laws. By using the Service, You represent that You have not been designated by Nigeria, Ghana, South Africa, Congo, Cote ‘Ivoire, and the United States government as a “Specially Designated National” or other person to whom the provisions of the Service are prohibited. Registration for, and use of, the Service are void where prohibited. You are responsible for determining whether the use of the Service is legal in the area in which you access the Website."),
                                      ]),
                                    ),
                                  ),
                                  SummaryTxt(
                                      padding_left: true,
                                      txt:
                                      "You must be 18 years old or older to use the Website. As a Member, You are telling us that You have never been convicted of a felony and that You are not required to register as a sex offender or any similar designation with any governmental agency. You will only use the Service as per these terms and all applicable local, state, national and international laws, and regulations. You cannot use the Service if it is not legal where You are located. You are responsible for determining whether You can legally use the Service."),
                                ],
                              ),
                            ),
                            TextSpan(
                                style: TextStyle(fontWeight: FontWeight.w600),
                                text: "\n\n3. Term and Termination"),
                            WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12, top: 10),
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          style: Theme.of(context).textTheme.bodyMedium,
                                          text:
                                          "All terms of this Agreement will remain in full force and effect while You use the Website and/or are a Member. Moreover, all terms of this Agreement will survive the Agreement’s termination by either You or LikePlay-LikePlay, except for any terms that by their nature expire or are fully satisfied. You may terminate your Membership at any time, and for any reason, by following the instructions on the Deactivate Account section in Account Settings, or by sending a written notice of termination to LikePlay-LikePlay. If you deactivate your account, Africa LikePlay Online Platforms Ltd may still retain certain information associated with your account for analytical purposes and record-keeping integrity, as well as to prevent fraud, collect any fees owed, enforce this Agreement and its conditions, take actions it deems necessary to protect the integrity of the Website or to protect the Website’s users, or take other actions otherwise permitted by law. In addition, if certain information has already been provided to third parties as described in the Privacy Policy, retention of that information will be subject to those third parties’ policies."),
                                      TextSpan(
                                          style: Theme.of(context).textTheme.bodyMedium,
                                          text:
                                          "\n\nAfrica LikePlay Network Ltd may terminate your Membership for any reason, with or without notice. If your Membership is terminated—whether by You or Africa LikePlay Platforms Ltd—You will not be entitled to any refund of unused subscription fees or unused credits."),
                                      WidgetSpan(
                                          child: SummaryTxt(
                                            padding_left: false,
                                            txt:
                                            "If You continue to use the Service, these terms are still applicable. You can terminate your Membership whenever You want. We can terminate your Membership at any time and for any reason. We will not issue a refund if we think You failed to abide by these terms. These terms are still applicable after termination of your Membership.",
                                          )),
                                    ]),
                                  ),
                                )),
                            TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                                text: "\n\n4. Exclusively for Non-Commercial Use"),
                            WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12, top: 10),
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          style: Theme.of(context).textTheme.bodyMedium,
                                          text:
                                          "The Website and the Service are for personal use only. Any other use, including use by the media, competitors, or any entity or individual wishing to use the Website or Service for profit, is considered "),
                                      TextSpan(
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(fontWeight: FontWeight.w600),
                                          text: "“Commercial Use” "),
                                      TextSpan(
                                          style: Theme.of(context).textTheme.bodyMedium,
                                          text: " by "),
                                      TextSpan(
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(fontWeight: FontWeight.w600),
                                          text: "“Commercial Users.” "),
                                      TextSpan(
                                          style: Theme.of(context).textTheme.bodyMedium,
                                          text:
                                          "Prohibited Commercial Use includes, but is not limited to, using the Service in connection with any commercial endeavors such as: (i) advertising or soliciting any user to buy or sell any products or services not offered by the Company; (ii) soliciting others to attend parties or other social functions, or networking, for commercial purposes; (iii) press or media purposes of any kind not authorized by the Company (all media inquiries should be directed to "),
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              sendMail(mail_like_play_like);
                                            },
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                              decoration: TextDecoration.underline,
                                              color: color_blue),
                                          text: "press@likeplaylikeplay.com"),
                                      TextSpan(
                                          style: Theme.of(context).textTheme.bodyMedium,
                                          text:
                                          "); (iv) LikePlay-LikePlay leads or customer information for any kind of business activities (whether or not those activities are conducted on or off of the Website); or (v) scraping or otherwise collecting data or information of any kind. Organizations, companies, agencies, and/or businesses—and any other associations or entities that are not individual persons—may not become Members and should not use the Service or the Website for any purpose. Illegal and/or unauthorized uses of the Website, including collecting usernames and/or email addresses of Members by electronic or other means for the purpose of sending unsolicited email, or unauthorized framing of or linking to the Website (or otherwise making LikePlay-LikePlay’s content viewable on another website through any other means), may be investigated and appropriate legal action may be taken. Such action may include (without limitation) civil, criminal, and injunctive relief. Users of the Website may not use any information obtained from the Service to contact any other user, without the other user’s prior explicit consent. The Company may investigate and take any available legal action in response to illegal and/or unauthorized uses of the Website, including referring activities the Company deems suspicious to governmental authorities."),
                                      WidgetSpan(
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(left: 0, top: 10),
                                            child: RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                        fontWeight: FontWeight.w600),
                                                    text: "Summary: "),
                                                TextSpan(
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                    text: "You "),
                                                TextSpan(
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                        fontWeight: FontWeight.w600),
                                                    text: "CANNOT"),
                                                spanNoramal(context,
                                                    " use the Website or the Service for business or media purposes. Illegal and/or unauthorized use of the Website or Service will be investigated, and we will take legal action. We may refer activities we deem suspicious to governmental authorities.")
                                              ]),
                                            ),
                                          )),
                                    ]),
                                  ),
                                ))

                            //here,
                            ,
                            TextSpan(
                                style: TextStyle(fontWeight: FontWeight.w600),
                                text: "\n\n5. Account Security"),
                            WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12, top: 10),
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          style: Theme.of(context).textTheme.bodyMedium,
                                          text:
                                          "Your Membership account is for your personal use only. You are responsible for maintaining the confidentiality of your username and password and You are solely responsible for all activities that occur under your username and password, including distribution of your personal information to other users. You acknowledge that Africa LikePlay Online Platforms Ltd is not responsible for third-party access to your account information or personal information when that access results from any action or inaction on your part, including but not limited to your voluntary distribution of your username, password, or other personal information. You also acknowledge that LikePlay-LikePlay is not responsible for third-party access to your account information when that access results from theft or misappropriation of your username, password or other personal information from your possession, custody, or control."),
                                    ]),
                                  ),
                                )),
                            WidgetSpan(
                                child: SummaryTxt(
                                  padding_left: true,
                                  txt:
                                  "Keep your username and password and personal information confidential. You are responsible for anything that occurs on the Website under your username and password, including providing personal information to others and keeping your information secure on your end.",
                                )),
                            TextSpan(
                                style: TextStyle(fontWeight: FontWeight.w600),
                                text: "\n\n6. Risk Assumption and Precautions"),
                            bulletPointContainer(context,
                                "LikePlay-LikePlay IS NOT RESPONSIBLE FOR THE CONDUCT, WHETHER ONLINE OR OFFLINE, OF ANY USER OF THE WEBSITE OR MEMBER OF THE SERVICE. YOU ASSUME ALL RISK WHEN USING THE SERVICE AND THE WEBSITE INCLUDING, BUT NOT LIMITED TO, ALL OF THE RISKS ASSOCIATED WITH ANY ONLINE OR OFFLINE INTERACTIONS WITH OTHER MEMBERS OR WEBSITE USERS, INCLUDING DATING OR SENDING MONEY TO ANOTHER MEMBER. YOU AGREE TO TAKE ALL NECESSARY PRECAUTIONS WHEN MEETING INDIVIDUALS THROUGH THE WEBSITE OR SERVICE. You should not provide your financial information (for example, your credit card or bank account information) to other Members."),
                            bulletPointContainer(context,
                                "LikePlay-LikePlay DOES NOT CURRENTLY CONDUCT CRIMINAL BACKGROUND SCREENINGS ON ITS MEMBERS. However, Africa LikePlay Online Platform Ltd reserves the right to conduct any criminal background check, at any time and using any records legally available. BY AGREEING TO THESE TERMS AND CONDITIONS, YOU HEREBY AUTHORIZE ANY SUCH CHECK."),
                            bulletPointContainer(context,
                                "Members may have a “Verified” mark displayed on their profile once they pass the Verification process. You understand that LikePlay-LikePlay makes no guarantees, express or implied, regarding the accuracy or reliability of Members background based on Identification, Facebook Login, Selfie, or Phone confirmation before issuing the  “ Verified” mark and in no event will LikePlay-LikePlay be liable for any damages whatsoever, whether direct, indirect, general, special, compensatory, consequential, and/or incidental, arising out of or relating to the Verification or “Verified” mark."),
                            bulletPointContainer(context,
                                "You understand that LikePlay-LikePlay makes no guarantees, either express or implied, regarding your ultimate compatibility with individuals You meet through the Service or as to the conduct of such individuals."),
                            WidgetSpan(
                                child: SummaryTxt(
                                  txt:
                                  "We are not responsible for our users’ conduct online or offline. We do not do criminal background checks on all of our Members, but we may conduct such a check at our discretion, and by agreeing to these terms You agree that we can do such a check. We make no guarantees about the reliability of the “Verified” mark as it relates to You, or to other users/Members. You assume these responsibilities when using the Service. Please take appropriate precautions.",
                                  padding_left: true,
                                )),
                            spanBold(context, "\n\n7. Proprietary Rights"),
                            bodyText(context,
                                "Like Play Network Inc., and/or Africa LikePlay Online Platforms Ltd, own and retain all proprietary rights on the Website and the Service, and in all content, trademarks, trade names, service marks, and other intellectual property rights related thereto. The Website contains the copyrighted material, trademarks, and other proprietary information of Like Play Network Inc, and/or Africa LikePlay Online Platforms. Except for information that is in the public domain or which You have been given written permission to use, You may not copy, modify, publish, transmit, distribute, perform, display, or sell any such proprietary information. You agree to not remove, obscure, or otherwise alter any proprietary notices appearing on any content, including copyright, trademark, and other intellectual property notices."),
                            WidgetSpan(
                                child: SummaryTxt(
                                  padding_left: true,
                                  txt:
                                  "We own the Website and the Service, which includes all the content, trademarks, trade names, service marks and other intellectual property. Do not copy or alter our stuff without our written permission.",
                                )),
                            spanBold(context, "\n\n8.Acceptable Website Use"),
                            bulletPointContainer(context,
                                "You are solely responsible for the content and information that You post, upload, publish, link to, transmit, record, display or otherwise make available (hereinafter, “Post” or “Posting”) on the Website or as part of the Service or transmit to other Members, including emails, videos (including streaming videos), photographs, voice notes, recordings or profile text, whether publicly posted or privately transmitted (collectively, “Content”). You may not Post on the Website or as part of the Service, or transmit to the Website or any other Member (either on or off the Website), any material or engage in conduct on or through the Website: (i) in violation of any applicable law or regulation; (ii) in a manner that will infringe the copyright, trademark, trade secret or other intellectual property rights of others or violate the privacy, publicity or other personal rights of others; (iii) in a manner that is offensive, inaccurate, profane, intimidating, defamatory, obscene, threatening, abusive or hateful; (iv) that uses multiple accounts for one user; or (v) that expresses or implies that any statements You make are endorsed by LikePlay-LikePlay, the Website, or any related websites, affiliates or subsidiaries. You represent and warrant that all information that You submit upon registration is accurate and truthful and that You will promptly update any information provided by You that subsequently becomes inaccurate, misleading, or false."),
                            summarySpan(context, true,
                                "You are responsible for what You do on our Website and how You use our Service. Do not post or transmit any material that violates laws or regulations. Do not post or transmit any material in a manner that will infringe on ours or others’ copyright, trademark, and other intellectual property rights. Do not be rude and do not threaten or offend others."),
                            bulletPointContainer(context,
                                "LikePlay-LikePlay reserves the right, but has no obligation, to monitor any Content You post on the Website or as part of the Service. LikePlay-LikePlay may remove any Content for any reason whatsoever. Without limitation, LikePlay-LikePlay may remove Content that, in its sole opinion, violates, or may violate any applicable law, or the letter or spirit of this Agreement. LikePlay-LikePlay may also remove any Content upon the request of any third party, or for any other reason whatsoever. LikePlay-LikePlay, in its sole discretion, may suspend or ban any Member that posts Content that is objectionable for any of the reasons given in this paragraph or for any other reason."),
                            summarySpan(context, true,
                                "We do not have to, but we may, monitor Content posted on the Website. We also may remove any Content that we think may violate the law or this Agreement or upon request by others and we may remove the Member posting such Content as well."),
                            bulletPointContainer(context,
                                "By Posting Content on the Website or as part of the Service, You automatically grant to LikePlay-LikePlay an irrevocable, perpetual, non-exclusive, fully paid-up, worldwide right and license to: (i) use, copy, store, perform, display, reproduce, record, play, adapt, modify and distribute the Content; (ii) prepare derivative works of the Content or incorporate the Content into other works; and (iii) grant and authorize sublicenses of the foregoing in any media now known or hereafter created. In addition, so that LikePlay-LikePlay can prevent the use of your Content outside of the Service, You authorize LikePlay-LikePlay to act on your behalf with respect to infringing uses of your Content taken from the Service by other users or third parties. Our license to your Content is subject to your rights under applicable law (including without limitation laws regarding personal data protection to the extent any Content contains personal information as defined by those laws) and is for the limited purpose of operating, developing, providing, and improving the Service and researching and developing new ones."),
                            summarySpan(context, true,
                                "Once You post something, we may use it in accordance with the terms of this Agreement"),
                            bulletPointContainer(context,
                                "You are prohibited from violating or attempting to violate the security of the Website, including, without limitation: (i) accessing data not intended for You or logging into a server or account that You are not authorized to access; (ii) attempting to probe, scan, or test the vulnerability of a system or network or breaching (or attempting to breach) security or authentication measures without proper authorization; (iii) attempting to interfere with or disrupt the Service or the Website including, without limitation, by way of submitting a virus to the Website, overloading, flooding, spamming, mail bombing or crashing; (iv) sending unsolicited email, including promotions and/or advertising of products or services; (v) forging headers or otherwise manipulating identifiers in order to disguise the origin of any information transmitted to or through the Website or Service (either directly or indirectly through use of third-party software); (vi) using (or attempting to use) any engine, software tool, agent, or other device or mechanism, any robot, spider, site search/retrieval application, or any manual or automatic device or process to retrieve, index, “data mine” or in any way reproduce or circumvent the navigational structure or presentation of the Website, Service or its Contents; or (vii) modifying, adapting, sublicensing, translating, selling, reverse engineering, deciphering, decompiling or otherwise disassembling any portion of the Service or the Website, or any software used on or for the Service or the Website, or causing others to do so."),
                            summarySpan(context, true,
                                "Do not do things to or on the Website that You are not authorized to do."),
                            WidgetSpan(
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
                                                    TextSpan(text: "The Website may be used "),
                                                    spanBold(
                                                        context, "only for lawful purposes "),
                                                    spanNoramal(context,
                                                        "by individuals seeking relationships. As one of the conditions of your use of the Website and the Service, You represent, warrant, and agree that You will not use (or plan, encourage or help others to use) the Website or the Service for any purpose or in any manner that is prohibited by this Agreement or by applicable law. It is your responsibility to ensure that your use of the Website and the Service complies with this Agreement, and to seek prior written consent from Like Play Network Inc. for any uses not permitted or not expressly specified herein. LikePlay-LikePlay specifically prohibits any use of the Website or the Service, and You hereby agree not to use the Website or the Service, for any of the following:"),
                                                  ]))),
                                    ],
                                  ),
                                )),
                            WidgetSpan(
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(left: margin_a, top: 10),
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          style: Theme.of(context).textTheme.bodyMedium,
                                          text: "a. "),
                                      spanBold(context,
                                          "Using the Website as an escort or prostitute or using the Service to promote, solicit, or engage clients for an escort or prostitution service, or to engage or facilitate human trafficking of any kind, including past escort activities or affiliation with an escort site or service.")
                                    ]),
                                  ),
                                )),
                            WidgetSpan(
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(left: margin_a, top: 10),
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          style: Theme.of(context).textTheme.bodyMedium,
                                          text: "b. "),
                                      spanBold(context,
                                          "Posting or sending material that exploits people under the age of 18, soliciting personal information from anyone under 18, failing to report knowledge of a person under the age of 18 to "),
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              sendMail(mail_hello_like_play);
                                            },
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                              color: color_blue,
                                              decoration: TextDecoration.underline,
                                              fontWeight: FontWeight.bold),
                                          text: "hello@likeplaylikeplay.com"),
                                      spanBold(context,
                                          ", or continuing to use the site to interact in any way with anyone You know or believe is under the age of 18. Any violation of these prohibitions will result in termination of your Membership and possible referral to law enforcement or other agencies."),
                                      spanNoramal(context,
                                          "\n\nc. Posting any incomplete, false, misleading, or inaccurate Content about yourself and/or your profile."),
                                      spanNoramal(context,
                                          "\n\nd. Posting any Content that is not entirely your own or which You do not have full rights to use."),
                                      spanNoramal(context,
                                          "\n\ne. Impersonating or otherwise misrepresenting an affiliation, connection or association with any person or entity."),
                                      spanNoramal(context,
                                          "\n\nf. If You have a password, allowing any other person to access a non-public area of the Website, disclosing or sharing your password to or with any third parties or using your password for any unauthorized purpose; using meta tags or code or other devices containing any reference (express or implied) to the Website or the Service (or any trademark, trade name, service mark, logo or slogan of the Website) to direct any person to any other website for any purpose;"),
                                      spanNoramal(context,
                                          "\n\ng. Soliciting, from other users, passwords, or personal identifying information for commercial or unlawful purposes, or for any other reason that would constitute a violation of this Agreement."),
                                      spanNoramal(context,
                                          "\n\nh. Engaging in advertising to, or solicitation of, other Members to send money, or buy or sell any products or services. You may not transmit any chain letters or junk/spam email to other Members. If You breach the terms of this subsection and send or post unsolicited bulk email, spam, or other unsolicited communications of any kind through the Service, You acknowledge that You will have caused substantial harm to LikePlay-LikePlay."),
                                      spanNoramal(context,
                                          "\n\ni. Initiating contact with Members off site by any other means without first obtaining explicit permission from them to do so via the Website."),
                                      spanNoramal(context,
                                          "\n\nj. Posting advertisements or solicitations of employment, business, or pyramid schemes."),
                                      spanNoramal(context,
                                          "\n\nk. Using the Website or Service for activities that violate any law, statute, ordinance, or regulations."),
                                      spanNoramal(context,
                                          "\n\nl. Using the Website or Service to encourage, promote, facilitate, or instruct others to engage in illegal activity."),
                                      spanNoramal(context,
                                          "\n\nm. Engage in any activity that violates criminal laws of the area in which the Member resides, visits or contacts Members."),
                                      spanNoramal(context,
                                          "\n\nn. Bullying, stalking, intimidating or otherwise harassing any other Members or Company employees or representatives."),
                                      spanNoramal(context,
                                          "\n\no. Framing or mirroring any part of the Service or the Website, without the Company’s prior written authorization."),
                                      spanNoramal(context,
                                          "\n\np. Using the Service to damage LikePlay-LikePlay or any of LikePlay-LikePlay’s related websites, affiliates, or subsidiaries"),
                                      spanNoramal(context,
                                          "\n\nq. Using the Website for any competitive purpose, including copying, soliciting, competitive or market analysis or any other use by a competitor."),
                                      spanNoramal(context,
                                          "\n\nr. Recruiting, including for pornography, modeling, or escort sites or brothels."),
                                      spanNoramal(context,
                                          "\n\ns. Commercial Use as defined above"),
                                      spanNoramal(context,
                                          "\n\nt. Any other use that violate any applicable law, including without limitation laws related to export controls."),
                                      summarySpan(context, false,
                                          "You may only use the Website as it is intended. No escorts or prostitutes. No human trafficking of any kind. Report any minors using the Website. Do not seek out minors and do not use the site if You are a minor. Do not use the Website for unlawful purposes. If You use the Website in a way that is not authorized or is illegal, we will take legal action against You and/or refer You to the proper law enforcement authorities."),
                                      bulletPointContainer(context,
                                          "Commercial Use and Competitive Violations and Liquidated Damages. Commercial Users act in violation of the terms of this Agreement and acknowledge that they are not using the Website for its intended purpose. Each and every instance of Commercial Use or competitive use of the Website is in violation of this Agreement and is subject to the equivalent of award for damages as liquidated damages for each breach. You acknowledge that any Commercial Use of the Website or Service will cause harm in an amount that would be extremely difficult to ascertain and that the equivalent of US\$10,000 for each and every commercial or competitor violation is a reasonable estimate of such harm."),
                                      summarySpan(context, false,
                                          "The Website is for personal use only. Each use of the Website for commercial or competitive reasons will result in the equivalent of US\$10,000 award for damages."),
                                    ]),
                                  ),
                                )),
                            spanBold(context,
                                "\n\n9. No Harassment of Reflex Media or Seeking Employees"),
                            bodyText(context,
                                "You will not harass, annoy, intimidate, or threaten any LikePlay-LikePlay employees or agents engaged in providing any portion of the Service to You. If we feel that your behavior towards any of our employees is at any time threatening or offensive, we reserve the right to immediately terminate your Membership and You will not be entitled to any refund of unused subscription fees."),
                            summarySpan(context, true,
                                "Do not harass our employees. We will terminate your Membership if You are threatening or offensive to our employees and You will not get a refund."),
                            spanBold(context,
                                "\n\n10.Copyright Policy; Notice and Procedure for Making Claims of Copyright Infringement."),
                            WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12, top: 10),
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          style: Theme.of(context).textTheme.bodyMedium,
                                          text:
                                          "You may not post, distribute, or reproduce in any way any copyrighted material, trademarks, or other proprietary information without obtaining the prior written consent of the owner of such proprietary rights. Without limiting the foregoing, if You believe that your work has been copied and posted on the Service in a way that constitutes copyright infringement, please contact us "),
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              sendMail(mail_hello_like_play);
                                            },
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                              decoration: TextDecoration.underline,
                                              color: color_blue),
                                          text: "hello@likeplaylikeplay.com"),
                                      spanNoramal(context,
                                          " and provide the following information: an electronic or physical signature of a person authorized to act on behalf of the copyright owner; identification of the copyrighted work that You claim is being infringed; identification of the material that is claimed to be infringing and where it is located on the Website; information reasonably sufficient to permit Africa LikePlay Online Platforms Ltd to contact You, such as your address, telephone number and email address; a statement that You have a good faith belief that use of the material in the manner complained of is not authorized by the copyright owner, its agent or the law; and a statement, made under penalty of perjury, that You are the copyright owner or authorized to act on the copyright owner’s behalf. Only copyright notices will be accepted at the above email address. All other inquiries or requests will be discarded."),
                                      summarySpan(context, false,
                                          "Do not use or post copyrighted, trademarked, or proprietary material unless You have written permission from the owner of such material. If You think someone on the Website has violated your copyright, trademark, or proprietary rights, let us know.")
                                    ]),
                                  ),
                                )),
                            spanBold(
                                context, "\n\n11. Subscription and Membership."),
                            WidgetSpan(
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
                                                        "You must provide current, complete, and accurate information for your Billing Account. You must promptly update all information to keep your Billing Account current, complete and accurate (such as a change in billing address, card number or expiration date) and You must promptly notify "),
                                                    spanRed(context, () {
                                                      lauch_url(home_url_website);
                                                    }),
                                                    spanNoramal(context,
                                                        " if your payment method is canceled (including if You lose your card or it is stolen), or if You become aware of a potential breach of security (such as an unauthorized disclosure or use of your username or password). Changes to such information can be made at “Settings” on the Website. If You fail to provide us any of the foregoing information, You agree that You are responsible for fees accrued under your Billing Account. In addition, You authorize us to obtain updated or replacement expiration dates and card numbers for your credit or debit card as provided by your credit or debit card issuer.")
                                                  ]))),
                                    ],
                                  ),
                                )),
                            WidgetSpan(
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
                                                        "You agree that all payments made on the Website are final and that You will not challenge or dispute the charge with your bank. You further agree that should You have any issues relating to your payment (such as duplicate billing), You will open a support ticket through the Website to resolve the issue. Should a dispute be initiated with your bank, You agree that You will be held responsible for any outstanding balance owed to us plus any dispute case fees charged by our bank, which may be as much as the equivalent of US\$20 per instance. You agree that You will pay any outstanding balance You have with"),
                                                    spanRed(context, () {

                                                      lauch_url(home_url_website);
                                                    }),

                                                    spanNoramal(context,
                                                        " within 30 days from the date of notification. Any outstanding balance left unpaid after 30 days may be submitted to a collections agency and You agree that a collections fee of up to 50% of the outstanding balance or the equivalent of \$US20 (whichever is higher) will be added to the amount that You owe.")
                                                  ]))),
                                    ],
                                  ),
                                )),
                            WidgetSpan(
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
                                                        "To provide continuous service, "),
                                                    spanRed(context, () {
                                                      lauch_url(home_url_website);
                                                    }),
                                                    TextSpan(
                                                        text:
                                                        " provides for automatic renewal. Whether it exercises the right or not, "),
                                                    spanRed(context, () {
                                                      lauch_url(home_url_website);
                                                    }),
                                                    TextSpan(
                                                        text:
                                                        " has the right to automatically renew your Membership from month to month. UNTIL TERMINATED, "),
                                                    spanRed(context, () {
                                                      lauch_url(home_url_website);
                                                    }),
                                                    TextSpan(
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w600),
                                                        text:
                                                        " MAY AUTOMATICALLY RENEW ALL PAID SUBSCRIPTIONS FOR THE SERVICES ON THE DATE SUCH SUBSCRIPTIONS EXPIRE. "),
                                                    spanNoramal(context,
                                                        " After your initial subscription commitment period, and again after any subsequent subscription period, your subscription will automatically continue for an additional equivalent period. By entering into this Agreement, You acknowledge that your account will be subject to the above-described automatic renewals. If You do not wish your account to renew automatically or if You want to change or terminate your subscription, please log in and go to “Settings” on the Website and follow the directions contained therein.")
                                                  ]))),
                                    ],
                                  ),
                                )),
                            WidgetSpan(
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
                                                    spanRed(context, () {
                                                      lauch_url(home_url_website);
                                                    }),
                                                    TextSpan(
                                                        text:
                                                        " MAINTAINS A STRICT NO-REFUND POLICY. ALL PURCHASES MADE ON THE WEBSITE ARE FINAL. IF YOU CHOOSE TO PURCHASE A SUBSCRIPTION PACKAGE ON THE WEBSITE, YOU AGREE THAT ABSOLUTELY NO REFUNDS, EITHER FULL OR PARTIAL, WILL BE ISSUED FOR ANY REASON OR FOR ANY UNUSED OR REMAINING SUBSCRIPTION OR CREDITS.")
                                                  ]))),
                                    ],
                                  ),
                                )),
                            WidgetSpan(
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
                                                    TextSpan(text: "When You deactivate your "),
                                                    spanRed(context, () {
                                                      lauch_url(home_url_website);
                                                    }),
                                                    spanNoramal(context,
                                                        " account or if your account is suspended for violating this Agreement or other policies, You agree that any remaining or unused subscription and credits will be forfeited and no refunds will be issued for any remaining or unused Membership subscription and credits. Further, if your deactivated "),
                                                    spanRed(context, () {
                                                      lauch_url(home_url_website);
                                                    }),
                                                    spanNoramal(context,
                                                        " account is reinstated at a later date, You agree that neither any unused subscription or credits forfeited at the time of your account deactivation will be reinstated with your account. "),
                                                  ]))),
                                    ],
                                  ),
                                )),
                            WidgetSpan(
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
                                                        "Credits or a subscription purchased for a specific "),
                                                    spanRed(context, () {
                                                      lauch_url(home_url_website);
                                                    }),
                                                    TextSpan(
                                                        text:
                                                        " account are strictly non-transferable. You agree that any remaining or unused Membership subscription associated with an active or deactivated "),
                                                    spanRed(context, () {
                                                      lauch_url(home_url_website);
                                                    }),
                                                    TextSpan(
                                                        text:
                                                        " account will not be transferred to any other account belonging to You or to someone else."),
                                                  ]))),
                                    ],
                                  ),
                                )),
                            WidgetSpan(
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
                                                        "LikePlay-LikePlay reserves the right to offer free Membership to any person(s) of its choice at any given time, for any duration, while charging other Members, at the same time. LikePlay-LikePlay also reserves the right to cancel the free trial period at any time, for all or any of its Members. A Member profile (whether that profile relates to a paying subscription or a free Membership) may remain posted on the Website even if that Member is not actively using the Service. You acknowledge that although a Member’s profile may be viewed, You may not (even as a subscriber) be able to use the Service to communicate with that Member if he or she is not then actively using the Service.")
                                                  ]))),
                                    ],
                                  ),
                                )),
                            summarySpan(context, true,
                                "You need to give us accurate information for your billing account and You need to keep the information updated. All payments made are final—no refunds—even if You or we terminate your account early (exceptions for Members located in certain specified geographic locations). Credits or subscriptions cannot be transferred to any other account. If You think there has been an error in billing, You must contact us immediately. Your account may be automatically renewed. We can grant free Memberships to whomever and whenever we want, and we can cancel any free trial periods when we want."),
                            spanBold(context,
                                "\n\n12. Service and Modification to the Website."),
                            bodyText(context,
                                "LikePlay-LikePlay does not guarantee that the Website will be fully operational all the time. Members may face significant service disturbances. Only if the Website is offline for a period of more than five consecutive days will a pro-rated refund be given. LikePlay-LikePlay DOES NOT OFFER TECHNICAL SUPPORT. We will offer support only for the Service related to the Website. The Company reserves the right at any time to modify or discontinue, temporarily or permanently, the Website or the Service (or any part thereof) with or without notice to any Member, group of Members or all Members. You agree that the Company shall not be liable to You or to any third party for any modification, suspension, or discontinuance of the Service. To protect the integrity of the Website or the Service, the Company reserves the right at any time, in its sole discretion, to block users related to certain IP addresses from accessing the Website or Service. You agree not to circumvent, or attempt to circumvent, any such user block imposed by the Company."),
                            summarySpan(context, true,
                                "We cannot guarantee that the Website will be operational all the time. We will provide Members with a pro-rated refund only if the website is offline more than 5 days consecutively. We do not offer technical support. We can modify or discontinue any part of the Website or the Website at any time without giving You notice, and we are not liable as a result. We can block users at any time from accessing the Website or Service."),
                            spanBold(context, "\n\n13. User Information."),
                            WidgetSpan(
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
                                                        "When You register for our Service on the Website, You will be asked to provide us with certain information, including but not limited to, a valid email address (your “User Information”). LikePlay-LikePlay right to use your User Information is described in our Privacy Policy. Please see our Privacy Policy for further details regarding use of your User Information. LikePlay-LikePlay reserves the right to offer third-party services and products to You based on the preferences that You identify in your User Information and at any time thereafter; such offers may be made by us or by third parties and are governed by our Privacy Policy."),
                                                  ]))),
                                    ],
                                  ),
                                )),
                            WidgetSpan(
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
                                                        "You acknowledge and agree that LikePlay-LikePlay may disclose in whole or in part your User Information and Content if required to do so by law, at the request of a third party (subject to our Privacy Policy), or if we, in our sole discretion, believe that disclosure is reasonable to: (i) comply with the law, requests or orders from law enforcement, or any compulsory legal process; (ii) protect or defend LikePlay-LikePlay, or a third party’s rights or property; or (iii) protect someone’s health or safety, such as when harm or violence against any person (including the user) is threatened."),
                                                  ]))),
                                    ],
                                  ),
                                )),
                            WidgetSpan(
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
                                                        "Notwithstanding any other provision of this Agreement or the Privacy Policy, LikePlay-LikePlay reserves the right, but has no obligation, to disclose any User Information and Content that You submit to the Service, if, in its sole opinion, LikePlay-LikePlay suspects or has reason to suspect that the information involves a party who may seek to commit a crime, be committing a crime, or be the victim of a crime or of any form of abuse. Abuse may include, without limitation, elder abuse, child abuse, spousal abuse, neglect, domestic violence, or human trafficking. Information may be disclosed to authorities that LikePlay-LikePlay, in its sole discretion, deems appropriate to handle such disclosure. Appropriate authorities may include, without limitation, law enforcement agencies, child protection agencies, or court officials. You hereby acknowledge and agree that LikePlay-LikePlay is permitted to make such disclosure."),
                                                  ]))),
                                    ],
                                  ),
                                )),
                            WidgetSpan(
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
                                                        "User profiles that have been inactive (i.e., user has not logged into their account) for more than 365 days will be removed from the Service and profile content will be deleted. User account settings and contact emails will continue to be maintained by LikePlay-LikePlay, subject to LikePlay-LikePlay’s Privacy Policy."),
                                                  ]))),
                                    ],
                                  ),
                                )),
                            summarySpan(context, true,
                                "We collect personal information from You and may share it, so You need to read our Privacy Policy."),
                            spanBold(context, "\n\n14. Links"),
                            WidgetSpan(
                                child: Padding(
                                  padding: padding_body_txt,
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          style: Theme.of(context).textTheme.bodyMedium,
                                          text:
                                          "The Website may contain, and the Service may provide, links to sites that are not maintained by LikePlay-LikePlay. While we try to include links only to those sites which are in good taste and safe for our users, we are not responsible for the content or accuracy of those sites and cannot guarantee that sites will not change without our knowledge. The inclusion of a link on the Website does not imply our endorsement of the linked site. If You decide to access linked third-party websites, you do so at your own risk. Your correspondence or business dealings with, or participation in promotions of, third parties found on or through the Website or Service, including payment and delivery of related goods or services, and any other terms, conditions, warranties, or representations associated with such dealings, are solely between You and such third party. You further acknowledge and agree that LikePlay-LikePlay/"),
                                      spanRed(context, () {
                                        lauch_url(home_url_website);
                                      }),
                                      spanNoramal(context,
                                          " and its affiliated companies shall not be responsible or liable, directly or indirectly, for any damage or loss caused or alleged to be caused by or in connection with the use of, or reliance upon, any such content, information, statements, advertising, goods or services or other materials available on or through any such linked website or resource.")
                                    ]),
                                  ),
                                )),

                            summarySpanBold(context, true, "There may be links on the Website that we do not maintain. We are not responsible for the content on those sites. Just because a link is on our Website, does not mean we are endorsing the linked site. Your interaction with the linked site is at your own risk. We are not liable for any damage or loss You may incur by engaging with the linked site."),

                            spanBold(context, "\n\n15. Disclaimers"),


                            WidgetSpan(
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
                                                        "LikePlay-LikePlay is not responsible for any incorrect or inaccurate Content posted on the Website or in connection with the Service, whether caused by users of the Website, Members, or by any of the equipment or programming associated with or utilized in the Service."),
                                                  ]))),
                                    ],
                                  ),
                                )),
                            WidgetSpan(
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
                                                        "LikePlay-LikePlay is not responsible for user or Member conduct of any kind, whether online or offline."),
                                                  ]))),
                                    ],
                                  ),
                                )),
                            WidgetSpan(
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
                                                        "LikePlay-LikePlay is not responsible for any error, omission, interruption, deletion, defect, delay in operation or transmission, communications line failure, theft or destruction or unauthorized access to, or alteration of, user or Member communications."),
                                                  ]))),
                                    ],
                                  ),
                                )),
                            WidgetSpan(
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
                                                        "LikePlay-LikePlay is not responsible for any problems or technical malfunction of any telephone network or lines, computer online systems, servers or providers, computer equipment, software, failure of email or players on account of technical problems or traffic congestion on the Internet or at any website or combination thereof, including injury or damage to users and/or Members or to any other person’s computer related to or resulting from participating or downloading materials in connection with the Website and/or in connection with the Service"),
                                                  ]))),
                                    ],
                                  ),
                                )),
                            WidgetSpan(
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
                                                        "Under no circumstances will LikePlay-LikePlay be responsible for any loss or damage, including personal injury or death, resulting from anyone’s use of the Website or the Service, any Content posted on the Website or transmitted to Members, or any interaction or contact between users of the Website, whether online or offline."),
                                                  ]))),
                                    ],
                                  ),
                                )),
                            WidgetSpan(
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
                                                        "THIS SITE IS FOR ENTERTAINMENT AND INFORMATIONAL PURPOSES ONLY. TO THE MAXIMUM EXTENT ALLOWED BY APPLICABLE LAW, LikePlay-LikePlay PROVIDES THE WEBSITE AND SERVICE ON AN “AS IS” AND “AS AVAILABLE” BASIS AND GRANTS NO WARRANTIES OF ANY KIND, EITHER EXPRESS, IMPLIED, STATUTORY OR OTHERWISE WITH RESPECT TO THE SERVICE OR THE WEBSITE (INCLUDING ALL CONTENT CONTAINED THEREIN) INCLUDING (WITHOUT LIMITATION) ANY IMPLIED WARRANTIES OF SATISFACTORY QUALITY, MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, EXPECTATIONS OF PRIVACY OR NON-INFRINGEMENT. LikePlay-LikePlay DOES NOT WARRANT THAT THE WEBSITE OR SERVICE WILL BE UNINTERRUPTED OR ERROR-FREE, SECURE OR THAT ANY DEFECTS OR ERRORS WILL BE CORRECTED."),
                                                  ]))),
                                    ],
                                  ),
                                )),
                            WidgetSpan(
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
                                                        "ANY MATERIAL DOWNLOADED OR OTHERWISE OBTAINED THROUGH THE USE OF THE SERVICE OR WEBSITE IS ACCESSED AT YOUR OWN DISCRETION AND RISK, AND YOU WILL BE SOLELY RESPONSIBLE FOR AND HEREBY WAIVE ANY AND ALL CLAIMS AND CAUSES OF ACTION WITH RESPECT TO ANY DAMAGE TO YOUR COMPUTER SYSTEM, INTERNET ACCESS, DOWNLOAD OR DISPLAY DEVICE OR LOSS OR CORRUPTION OF DATA THAT RESULTS OR MAY RESULT FROM THE DOWNLOAD OF ANY SUCH MATERIAL. IF YOU DO NOT ACCEPT THIS LIMITATION OF LIABILITY, YOU ARE NOT AUTHORIZED TO DOWNLOAD OR OBTAIN ANY MATERIAL THROUGH THE SERVICE OR WEBSITE."),
                                                  ]))),
                                    ],
                                  ),
                                )),
                            WidgetSpan(
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
                                                        "From time to time, LikePlay-LikePlay may make third-party opinions, advice, statements, offers, or other third-party information or content available on the Website and/or through the Service. All third-party content is the responsibility of the respective authors thereof and should not necessarily be relied upon. Such third-party authors are solely responsible for such content. LikePlay-LikePlay DOES NOT: (I) GUARANTEE THE ACCURACY, COMPLETENESS OR USEFULNESS OF ANY THIRD-PARTY CONTENT ON THE WEBSITE OR PROVIDED THROUGH THE SERVICE; OR (II) ADOPT, ENDORSE OR ACCEPT RESPONSIBILITY FOR THE ACCURACY OR RELIABILITY OF ANY OPINION, ADVICE OR STATEMENT MADE BY ANY PARTY THAT APPEARS ON THE WEBSITE OR SERVICE. UNDER NO CIRCUMSTANCES WILL LikePlay-LikePlay OR ITS AFFILIATES OR SUBSIDIARIES BE RESPONSIBLE OR LIABLE FOR ANY LOSS OR DAMAGE RESULTING FROM YOUR RELIANCE ON INFORMATION OR OTHER CONTENT POSTED ON THE WEBSITE OR SERVICE OR TRANSMITTED TO OR BY ANY MEMBERS."),
                                                  ]))),
                                    ],
                                  ),
                                )),
                            WidgetSpan(
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
                                                        "LikePlay-LikePlay cannot guarantee and does not promise any specific results from use of the Website and/or the Service."),
                                                  ]))),
                                    ],
                                  ),
                                )),
                            WidgetSpan(
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
                                                        "This Website is only a venue—it acts as a venue for individuals to post personal information for purposes of dating. LikePlay-LikePlay is not required to screen or censor information posted on the Website, including but not limited to, the identity of any user and any user content. We are not involved in any actual communication between Members. As a result, we have no control over the quality, safety, or legality of the information or profiles posted or the truth or accuracy of such information. You agree that You are solely responsible for your interactions with other Members and that LikePlay-LikePlay is not liable in any way for Member communications. LikePlay-LikePlay reserves the right, but has no obligation, to monitor communications on the Website between You and other Members, or any other correspondence or interaction that occurs outside the scope of the Website. The Website and Service is a tool for providing the initial contact between Members, and anything beyond that is not in our control and is carried out at the Members’ own risk. Members must use common sense about what information they reveal to others via email or any other means of communication. It is your responsibility to ensure your safety and to investigate Members and verify they are legitimate relationship seekers."),


                                                    spanBold(context, " There are many different frauds, schemes, and deceptions on the Internet, and we strongly caution You to be skeptical of any Member until You learn more about them and verify their background.")
                                                  ]))),
                                    ],
                                  ),
                                )),
                            WidgetSpan(
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
                                                        "In addition to the preceding information under this Agreement, any advice or thoughts that may be posted on the Website or through the Service provided for under this Agreement are for informational and entertainment purposes only and are not intended to replace, or substitute for, any professional, financial, medical, legal, or other advice. The Company makes no representations or warranties and expressly refuses any and all liability concerning any treatment, action by, or effect on any person following the information offered or provided within or through the Website. If You have specific concerns or a situation arises in which You require professional or medical advice, You should consult with an appropriately trained and qualified specialist and seek immediate attention of the proper professional."),
                                                  ]))),
                                    ],
                                  ),
                                )),
                            WidgetSpan(
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
                                                        "You specifically acknowledge and agree that LikePlay-LikePlay is not liable for your defamatory, offensive, infringing, or illegal materials or conduct or that of third parties, and we reserve the right to remove such materials from the Website without liability or notice to You."),
                                                  ]))),
                                    ],
                                  ),
                                )),

                            summarySpanBold(context, true, "We are not responsible or liable for a number of things related to the Website and your use of the Website. You are using the Website and Service at your own risk and any communications between You and other users/Members are at your own risk. If You read something on our site, do not take it on its face—use common sense, do your research, and take precautions."),


                            spanBold(context, "\n\n16. Limitation on Liability"),

                            bulletPointContainer(context, "TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, IN NO EVENT WILL LikePlay-LikePlay BE LIABLE FOR ANY INCIDENTAL, SPECIAL, CONSEQUENTIAL OR INDIRECT DAMAGES ARISING OUT OF OR RELATING TO YOUR USE, OR INABILITY TO USE, THE SERVICES, INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OR CORRUPTION OF DATA OR PROGRAMS, OR FOR SERVICE INTERRUPTIONS OR PROCUREMENT OF SUBSTITUTE SERVICES, EVEN IF LikePlay-LikePlay KNOWS OR HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, UNDER NO CIRCUMSTANCES WILL LikePlay-LikePlay AGGREGATE LIABILITY, IN ANY FORM OF ACTION WHATSOEVER IN CONNECTION WITH THIS AGREEMENT OR THE USE OF THE SERVICE OR THE WEBSITE, EXCEED THE PRICE PAID BY YOU FOR YOUR MEMBERSHIP, OR, IF YOU HAVE NOT PAID REFLEX MEDIA FOR THE USE OF ANY SERVICE, THE AMOUNT OF US\$25.00 OR ITS EQUIVALENT."),

                            bulletPointContainer(context, "TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, IN NO EVENT WILL LikePlay-LikePlay BE LIABLE FOR ANY DAMAGES WHATSOEVER, WHETHER DIRECT, INDIRECT, GENERAL, SPECIAL, COMPENSATORY, CONSEQUENTIAL AND/OR INCIDENTAL ARISING OUT OF, OR RELATING TO, THE CONDUCT OF YOU OR ANYONE ELSE IN CONNECTION WITH THE USE OF THE SERVICE, INCLUDING WITHOUT LIMITATION, BODILY INJURY, EMOTIONAL DISTRESS, AND/OR ANY OTHER DAMAGES RESULTING FROM COMMUNICATIONS OR MEETINGS WITH OTHER MEMBERS OF THE SERVICE. THIS INCLUDES ANY CLAIMS, LOSSES OR DAMAGES ARISING FROM THE CONDUCT OF MEMBERS WHO HAVE REGISTERED UNDER FALSE PRETENSES OR WHO ATTEMPT TO DEFRAUD OR HARM YOU."),

                            WidgetSpan(
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
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w600),
                                                        text:
                                                        "To the fullest extent permitted by applicable law, You release the Company from responsibility, liability, claims, demands or damages of every kind and nature, known and unknown (including, but not limited to, claims of negligence), arising out of, or related to, disputes between users and the acts or omissions of third parties. You expressly waive any rights You may have that would otherwise limit the coverage of this release to include only those claims which You may know or suspect to exist in your favor at the time of agreeing to this release."
                                                    )]))),
                                    ],
                                  ),
                                )),

                            WidgetSpan(
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
                                                        "THE LIMITATION OF LIABILITY PROVISIONS SET FORTH IN THIS SECTION SHALL APPLY EVEN IF YOUR REMEDIES UNDER THIS AGREEMENT FAIL WITH RESPECT TO THEIR ESSENTIAL PURPOSE."),
                                                    TextSpan(
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w600),
                                                        text:
                                                        ""
                                                    )]))),
                                    ],
                                  ),
                                )),

                            summarySpanBold(context, true, "We have built our Service for You, but we cannot promise it is perfect. We are not liable for various things and You release us from responsibility and liability for those things."),

                            spanBold(context, "\n\n17. Litigation of Disputes"),

                            WidgetSpan(
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
                                                        "LikePlay-LikePlay is always interested in attempting to resolve any dispute by amicable and informal means, and we encourage You to contact us at "),
                                                    TextSpan(

                                                        recognizer: TapGestureRecognizer()..onTap=()
                                                        {
                                                          sendMail(mail_hello_like_play);
                                                        },

                                                        style: TextStyle(
                                                            color:color_blue,
                                                            decoration: TextDecoration.underline),
                                                        text:
                                                        "Hello@likeplaylikeplay.com"
                                                    )]))),
                                    ],
                                  ),
                                )),

                            bulletPointContainer(context, "However, neither You nor LikePlay-LikePlay are required to resolve any dispute before bringing that dispute in litigation."),

                            bulletPointContainer(context, "Both You and LikePlay-LikePlay agree that all disputes will be litigated, exclusively, Nigeria and not in any other forum."),

                            bulletPointContainer(context, "By accessing and using the Website and/or Service, You hereby irrevocably consent to the area of Lagos in Nigeria."),

                            bulletPointContainer(context, "YOU AND LikePlay-LikePlay ACKNOWLEDGE THAT NEITHER WILL BRING OR PARTICIPATE IN ANY CLASS ACTION OR OTHER CLASS PROCEEDING IN CONNECTION WITH ANY DISPUTE WITH THE OTHER PARTY."),

                            bulletPointContainer(context, "If You access the Website or use the Service from outside Nigeria, You waive all rights under the laws and regulations of the territory from which You access or use the Website or Service."),

                            summarySpanBold(context,true, "This Agreement, and any dispute between You and LikePlay-LikePlay, shall be governed by the laws of Nigeria without regard to principles of conflicts of law."),

                            spanBold(context, "\n\n18. Consent to Service of Process by Email"),

                            bodyText(context, "By using the Website or Service, You consent to service of process of any summons and/or complaint at the email address that you provided to LikePlay-LikePlay to create your LikePlay-LikePlay account. You further agree that email is a reasonable means of notice and service for any litigation."),

                            summarySpan(context, true, "By providing your email address when using the Website or Service, You are agreeing to receive any type of litigation notice via that email address."),


                            spanBold(context, "\n\n19. Consent to Allow LikePlay-LikePlay to Bring Lawsuits on Your Behalf."),

                            bodyText(context, "You agree that LikePlay-LikePlay may bring actions on behalf of You or any other Member or Members, in any judicial, arbitral, or other forum, where LikePlay-LikePlay rights may be implicated."),

                            summarySpanBold(context, true, "You are agreeing to let LikePlay-LikePlay bring legal and equitable actions on your behalf if LikePlay-LikePlay determines its own rights are implicated in those actions."),


                            spanBold(context, "\n\n20. Indemnity"),

                            bodyText(context, "You agree to defend, indemnify, and hold harmless, LikePlay-LikePlay officers, directors, employees, agents, affiliates and subsidiaries from and against any claims, actions, or demands, arising from your use of the Website, the Service or your breach of the terms of this Agreement (including any breach of your representations and warranties contained herein), any postings or Content You post on the Website or as a result of the Service, and the violation of any law or regulation by You. You, and your estate in the case of your death, further agree that this indemnification provision covers all third-party claims, actions, or demands, including those filed by your spouse, children, family, or others who rely on You for support. You also agree that this indemnification provision covers all damages, costs, or expenses related to claims described in this Section, including without limitation all reasonable legal and accounting fees. LikePlay-LikePlay reserves the right to assume the exclusive defense and control of any matter otherwise subject to indemnification by You, in which event You will fully cooperate with LikePlay-LikePlay in connection therewith."),

                            summarySpanBold(context, true,"You agree to defend us and hold us harmless for your use of the Website and any breach by You of the Agreement terms or any violations of any law or regulation by You. This indemnification covers all claims, actions, or demands made by anyone."),

                            spanBold(context, "\n\n21. General Provisions"),
                            bulletPointContainer(context, "Violation of this Agreement may cause LikePlay-LikePlay irreparable harm, and You therefore agree that LikePlay-LikePlay will be entitled to seek extraordinary relief in court, including but not limited to, temporary restraining orders, preliminary injunctions and permanent injunctions without the necessity of posting a bond or other security, in addition to and without prejudice to any other rights or remedies that LikePlay-LikePlay may have for a breach of this Agreement."),

                            bulletPointContainer(context, "This Agreement (which You accept by using the Website and further affirm by becoming a Member of the Service), along with the LikePlay-LikePlay Privacy Policy located on the Website and any applicable payment, renewal and additional Service terms, comprise the entire agreement between You and LikePlay-LikePlay regarding the use of the Website and/or the Service, superseding any prior agreements between You and LikePlay-LikePlay related to your use of the Website or Service (including, but not limited to, any prior versions of this Agreement)."),

                            bulletPointContainer(context, "Unless otherwise explicitly stated, this Agreement will survive termination of your registration to the Service."),

                            bulletPointContainer(context, "If any provision of this Agreement is held invalid, the remainder of this Agreement shall continue in full force and effect."),

                            bulletPointContainer(context, "The failure of LikePlay-LikePlay to exercise or enforce any right or provision of this Agreement shall not constitute a waiver of such right or provision."),

                            bulletPointContainer(context, "You agree that your online account is non-transferable and all of your rights to your profile or contents within your account terminate upon your death."),

                            bulletPointContainer(context, "No agency, partnership, joint venture, or employment is created as a result of this Agreement and You may not make any representations or bind LikePlay-LikePlay in any manner."),


                            summarySpan(context, true, "These are general terms to which You agree, just like You are agreeing to all the other terms in this agreement."),


                            spanBold(context, "\n\n22. Notice"),
                            bodyText(context, "The Company may provide You with notices, including those regarding changes to this Agreement, using any reasonable means now known or hereafter developed, including by email, regular mail, SMS, MMS, text message or postings on the Website. Such notices may not be received if You violate this Agreement by accessing the Service in an unauthorized manner. You agree that You are deemed to have received any and all notices that would have been delivered had You accessed the Service in an authorized manner."),
                            summarySpan(context, true, "If we make changes or want to notify You, we will let You know"),

                            spanBold(context,"\n\n23. Revision Date and Amendment."),
                            WidgetSpan(
                                child: Padding(
                                  padding: padding_body_txt,
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(

                                              fontWeight: FontWeight.w600
                                          ),
                                          text:"This Agreement is subject to change by the Company at any time. If You are a non-subscribing Member at the time of any change, the revised terms will be effective when posted on the Website and your use of the Service after such posting will constitute acceptance by You of the revised Agreement. If You are a subscribing Member at the time of any change, to the extent permitted by applicable law the then-existing Agreement will continue to govern your Membership until such time that your Membership is renewed (whether by You or automatically by the Service) as contemplated herein. If You continue your Membership, your renewal will constitute acceptance by You of the revised Agreement. Alternatively, if You terminate your subscription at such time, your use of the Service after your termination will constitute acceptance by You of the then-existing Agreement."

                                      ),
                                    ]),
                                  ),
                                )),

                            summarySpan(context, true, "When we revise this Agreement, depending on your status (non-subscribing or subscribing), You may be subject to different terms (old or new) for a period of time")








                          ])),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> lauch_url(String url) async {
    if (!await launchUrl(Uri.parse(url))) {

      throw Exception('Could not lauch_url $url');
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
