import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/module/model/choice_data.dart';
import 'package:likeplay/module/model/feed_view_model.dart';
import 'package:likeplay/module/model/info_model.dart';
import 'package:likeplay/utils/string_utils.dart';

import '../module/model/chat_model.dart';
import '../module/model/faq_model.dart';
import '../module/model/matches.dart';
import '../module/model/notification_common_list.dart';
import '../module/model/report_view_model.dart';
import '../module/model/subscription_inapp_model.dart';
import '../module/model/subscription_model_mobile.dart';
import '../module/model/text_bool.dart';
import '../module/model/verification_model.dart';

List<String> aboutUS =
     [
       "We are bringing a game-changing process, and culture to online dating in Nigeria, and Africa.",
      "We are Africa-focused. Bringing Africa’s unique dating style and infusing tech to differentiate ourselves. It is this LikePlay style dating that will excite.",
     "Our focus is Women. Women are too often relegated, silenced, or stigmatized. Our LikePlay wants women to be able to do it all and have it all without stigma. Ladies you can build a career and have a loving partner.",
   "Take the floor! We want you to Show-up and Show-off. That is what the Floor is about! Take the mic!",
   "Our game-changing African style tech infused dating will wrap our arms around you. None of the cookie-cutter platforms. We are interested in you building a healthy relationship. No catch-and-release silo approach.",
  "Africa is a continent with different countries and different cultures. We shall keep working to reflect each unique culture all over our beautiful continent, where Love and Play is a thing. We will bring LikePlay to your country, and your unique culture.",
  "We want you to have options.",
  "On LikePlay, playfulness is our thing. We want you to show yourself on the Floor, and take the mic often and say something, show-off your style so folks get to know you better. There is some one who is noticing you. So, be your true self, be real, speak your mind ladies and gentlemen, and most of all show your playful side. Finally, we want you to be safe, date safely.",
   "Our growth is helped by you. Keep telling us through your feedback how we can improve and serve you well.Hit the refer button and with 5 referrals you get one month of our standard package subscription FREE",

];
String IMAGE_URL="https://dsi4auy1jdf82.cloudfront.net/";
List<String> title =[
  "Upload more\npictures",
  "Favorite other Love\nSeekers",
  "4 ways to verify\nyour self",
  "Voice Note",
  "Video Calls",
  "Realtime fast\nmessaging",
  "Take the Floor, Pick\nthe Mic to replace\nPlayground",
  "Emoji's for Better\nexpression",
  "More Active\nmembers around\nthe Country",
  "Better Profile\nquestions to improve\nyour Match",
  "3 Level Subscription\nPackage",
  "Referal option to\nSustitue Paid\nSubscription",
];
List<String> titleIcon =[
  "assets/images/ic_file.png",
  "assets/images/ic_star.png",
  "assets/images/ic_check.png",
  "assets/images/ic_voice.png",
  "assets/images/ic_video.png",
  "assets/images/ic_chat.png",
  "assets/images/ic_feed.png",
  "assets/images/ic_love.png",
  "assets/images/ic_team.png",
  "assets/images/ic_woman.png",
  "assets/images/ic_subscription.png",
  "assets/images/ic_customer.png",
];

List <String> nationalityList = ["Afghanistan", "Albania", "Algeria", "American Samoa", "Andorra", "Angola", "Anguilla",

"Antarctica", "Antigua and Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria",

"Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium",

"Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia and Herzegovina", "Botswana",

"Brazil", "British Indian Ocean Territory", "British Virgin Islands", "Brunei", "Bulgaria",

"Burkina Faso", "Burma (Myanmar)", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde",

"Cayman Islands", "Central African Republic", "Chad", "Chile", "China", "Christmas Island",

"Cocos (Keeling) Islands", "Colombia", "Comoros", "Cook Islands", "Costa Rica",

"Croatia", "Cuba", "Cyprus", "Czech Republic", "Democratic Republic of the Congo",

"Denmark", "Djibouti", "Dominica", "Dominican Republic",

"Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia",

"Ethiopia", "Falkland Islands", "Faroe Islands", "Fiji", "Finland", "France", "French Polynesia",

"Gabon", "Gambia", "Gaza Strip", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece",

"Greenland", "Grenada", "Guam", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana",

"Haiti", "Holy See (Vatican City)", "Honduras", "Hong Kong", "Hungary", "Iceland", "India",

"Indonesia", "Iran", "Iraq", "Ireland", "Isle of Man", "Israel", "Italy", "Ivory Coast", "Jamaica",

"Japan", "Jersey", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Kosovo", "Kuwait",

"Kyrgyzstan", "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein",

"Lithuania", "Luxembourg", "Macau", "Macedonia", "Madagascar", "Malawi", "Malaysia",

"Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania", "Mauritius", "Mayotte", "Mexico",

"Micronesia", "Moldova", "Monaco", "Mongolia", "Montenegro", "Montserrat", "Morocco",

"Mozambique", "Namibia", "Nauru", "Nepal", "Netherlands", "Netherlands Antilles", "New Caledonia",

"New Zealand", "Nicaragua", "Niger", "Nigeria", "Niue", "Norfolk Island", "North Korea",

"Northern Mariana Islands", "Norway", "Oman", "Pakistan", "Palau", "Panama",

"Papua New Guinea", "Paraguay", "Peru", "Philippines", "Pitcairn Islands", "Poland",

"Portugal", "Puerto Rico", "Qatar", "Republic of the Congo", "Romania", "Russia", "Rwanda",

"Saint Barthelemy", "Saint Helena", "Saint Kitts and Nevis", "Saint Lucia", "Saint Martin",

"Saint Pierre and Miquelon", "Saint Vincent and the Grenadines", "Samoa", "San Marino",

"Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone",

"Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Korea",

"Spain", "Sri Lanka", "Sudan", "Suriname", "Swaziland", "Sweden", "Switzerland",

"Syria", "Taiwan", "Tajikistan", "Tanzania", "Thailand", "Timor-Leste", "Togo", "Tokelau",

"Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Turks and Caicos Islands",

"Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "Uruguay", "US Virgin Islands", "Uzbekistan", "Vanuatu", "Venezuela", "Vietnam",

"Wallis and Futuna", "West Bank", "Yemen", "Zambia", "Zimbabwe"];



 List <String> statusList=["Divorced","Never Married","Separated","Single Parent","Widowed"];


List <String> ghanaTribe=[
  'Aboriginals',
  'African American',
  'Afrikaners',
  'Akan',
  'Amhara',
  'Arabs',
  'Berbers',
  'British',
  'Chewa',
  'Chinese',
  'Dinka',
  'French',
  'Fula',
  'Fulani',
  'Hausa',
  'Hutu',
  'Igbo',
  'Indian',
  'Kanuri',
  'Kongo',
  'Luba',
  'Luo',
  'Malagasy',
  'Mande',
  'Massai',
  'Mixed',
  'Mongo',
  'Moore',
  'Mossi',
  'Nama',
  'Nilotes',
  'Nuer',
  'Oromo',
  'Other',
  'San',
  'Sandawe',
  'Shona',
  'Somali',
  'Tigrayan',
  'White',
  'Yoruba',
  'Zulu']
;

List<String> southTribe=["Afrikkans", "Chinese", "Filipinos", "Indians", "Khoekloe", "Malay", "Mixed Race", "Nigerian",
  "Other", "South-African Black", "Whites", "Zulu"];

 List <String> educationList=
 ["Bachelors of Arts", "Bachelors of Science", "HND", "JSCE", "MBA", "Masters", "OND", "Ph.D", "SSCE"];
 List <String> size=["Average","Chubby","Small"];
 List <String> bodyTypes=["Big","Chubby","Plump","Slim","Thin"];
 List <String> lookingforList=
 [
   "A relationship that I can build on",
   "A Serious Relationship","Marriage only seriously",
   "Anywhere it goes",
   "Just flirting",
   ];
 List <String>height=["Medium","Short","Tall"];
 List <String>ranges=["24-30","31-37","38-44","45-50","51-59","60-65"];
 List <String> tribeToDateList=["Fulani","Hausa","Igbo","Northern Minority","Minority","Southern Minority","Yoruba","Other"];
 List <String> religionlist=["Agnostic","Christian","Muslim","Traditional worshipper","Other"];
 List <String>ageList=["24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40"
   ,"41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59",
   "60","61","62","63","64","65"];
List<String> employmentList = [
  "Accountant",
  "Activist",
  "Agriculturist (including Agronomist)",
  "Airport Traffic Controller",
  "Animal Breeder",
  "Animal Scientist",
  "Architect",
  "Auxiliary Nurse",
  "Baker",
  "Banker",
  "Branch Manager",
  "Business Owner",
  "Caterer",
  "Chemist",
  "Civil Servant",
  "Claims Adjuster",
  "College Teacher",
  "Computer Systems Analyst",
  "Conservationalist",
  "Customer Services Representative",
  "Dairy Scientist",
  "Dentist",
  "Dietitian",
  "Disaster Relief Insurance",
  "Economist",
  "Entomologist",
  "Engineer",
  "Epidemiologist",
  "Evangelist",
  "Finance Controller",
  "Founder",
  "Forester",
  "Geneticist",
  "Geologist",
  "Geochemist",
  "Geophysicist",
  "Graphic Designer",
  "Horticulturist",
  "Hotel Manager",
  "Interior Designer",
  "Land Surveyor",
  "Landscape Architect",
  "Law Enforcement",
  "Lawyer",
  "Lecturer",
  "Librarian",
  "Management Consultant",
  "Marketer (other besides Banker)",
  "Mathematician (including Statistician and an Actuary)",
  "Medical Laboratory Technologist",
  "Meteorologist",
  "Military",
  "Nutritionist",
  "Occupational Therapist",
  "Pastor",
  "Pharmacist",
  "Pharmacologist",
  "Physician",
  "Physiotherapist/Physical Therapist",
  "Pilot",
  "Poultry Scientist",
  "Police Officer",
  "Radio Broadcaster",
  "Range Manager/Range",
  "Recreational Therapist",
  "Registered Nurse",
  "Research Assistant",
  "Scientific Technician/Technologist",
  "Skilled Trade",
  "Social Media Manager",
  "Social Worker",
  "Software developer",
  "Sylviculturist (including Forestry Specialist)",
  "Technical Publications Writer",
  "Urban Planner",
  "Veterinarian",
  "Vocational Counsellor",
  "Zoologist"
];

    final List <FeedViewModel>listt=[
      FeedViewModel(imageUrl: 'assets/images/bg_six.jpg', date: '13 January at 5:23PM', name: 'Vivek', description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry', profileurl: 'assets/images/icon_profile.png', like: true, heart: true,superLike: true),
      FeedViewModel(imageUrl: 'assets/images/bg_six.jpg', date: '14 January at 1:03PM', name: 'Ankush', description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry', profileurl: 'assets/images/icon_profile.png',like: true,heart: true,superLike: true),
      FeedViewModel(imageUrl: 'assets/images/bg_six.jpg', date: '15 January at 6:22PM', name: 'Aman', description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry', profileurl: 'assets/images/icon_profile.png',like: true,heart: true,superLike: true),
      FeedViewModel(imageUrl: 'assets/images/bg_six.jpg', date: '14 January at 8: 24PM', name: 'Ankush', description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry', profileurl: 'assets/images/icon_profile.png',like: true,heart: true,superLike: true),
      FeedViewModel(imageUrl: 'assets/images/bg_six.jpg', date: '15 January at 10:35PM', name: 'Aman', description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry', profileurl: 'assets/images/icon_profile.png',like: true,heart: true,superLike: true),
      FeedViewModel(imageUrl: 'assets/images/bg_six.jpg', date: '13 January at 3:40PM', name: 'Vivek', description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry', profileurl: 'assets/images/icon_profile.png',like: true,heart: true,superLike: true),
  ];

final List <ReportViewModel>reportList=[
  ReportViewModel(name: 'Bullying or harassment',type: 1,select: true),
  ReportViewModel(name: 'Scam or fraud',type: 2,select: false),
  ReportViewModel(name: 'Nudity or sexual activity',type: 3,select: false),
  ReportViewModel(name: 'False information',type: 4,select: false),

];


List <String>docTitle=["Verify using your facebook account. We will never post to Facebook or message your friends. Any accounts with less than 150 friends is not accepted.",
  "Government Issued ID with your photograph that matches your Full Names (Driver's License, NIN, International Passport Bio page, or PVC) please feel free to scratch out your number, but not your face. We will not reveal your full names on the website just your user name",
  "Take a picture with a hand signal. Please ensure that your picture is clear, facing front without a mask, nor sideways. There should be no sunglasses or face-cap. We request this information to ensure that bots are not on the platform.",
  "Verify via sms.\nVerify your account by providing is the code sent via sms.",
];

List <String>docSubTitle=["Verify With Facebook","Take a photo of my Id","Verify With Camera","Send me the Code"];
List <String>docIcon=["assets/images/icon_facebooks.png","assets/images/icon_govtdoc.png","assets/images/icon_photo.png","assets/images/icon_phoneverify.png"];


List<Widget> myprofileTabs = [
  Container(
    width: 60,
    child: const Tab(text: 'Shots'),
  ),
  const SizedBox(
    width: 70,
    child: const Tab(text: 'About me'),
  ),
  const SizedBox(
    width: 76,
    child: const Tab(text: 'Liked Shots'),
  ),
];
List<Widget> myOtherprofileTabs = [
  Container(
    width: 60,
    child: const Tab(text: 'Shots'),
  ),
  const SizedBox(
    width: 70,
    child: const Tab(text: 'About me'),
  ),
];

  List<NotificationCommonList> notificationDataList=[
  NotificationCommonList(profileIcon: 'assets/images/icon_profile.png', text: 'Vivek Sharma', subText: UtilStrings.SendYouAMessage,date: '30-03-2022'),
  NotificationCommonList(profileIcon: 'assets/images/icon_profile.png', text: 'Amit Kumar', subText: UtilStrings.JustViewedYourProfile,date: '30-03-2022'),
  NotificationCommonList(profileIcon: 'assets/images/icon_profile.png', text: 'Sahil Singh', subText: UtilStrings.LikedYourPost,date: '30-03-2022'),
  NotificationCommonList(profileIcon: 'assets/images/icon_profile.png', text: 'Aman preet', subText: UtilStrings.TagYou,date: '30-03-2022'),
  NotificationCommonList(profileIcon: 'assets/images/icon_profile.png', text: 'Rahul Chahun', subText: UtilStrings.ReactToYourPost,date: '30-03-2022'),
  NotificationCommonList(profileIcon: 'assets/images/icon_profile.png', text: 'Banish Kamar ', subText: UtilStrings.Tag,date: '29-03-2022'),
  NotificationCommonList(profileIcon: 'assets/images/icon_profile.png', text: 'Danish Khan', subText: UtilStrings.Admiring,date: '29-03-2022'),
  NotificationCommonList(profileIcon: 'assets/images/icon_profile.png', text: 'Vivek Sharma', subText: UtilStrings.SendYouAMessage,date: '29-03-2022'),
  NotificationCommonList(profileIcon: 'assets/images/icon_profile.png', text: 'Aman Singh', subText: UtilStrings.ReactToYourPost,date: '28-03-2022'),
  NotificationCommonList(profileIcon: 'assets/images/icon_profile.png', text: 'Manpreet', subText: '',date: '28-03-2022'),
];

List<ChatModel>chatMessage=[
  ChatModel(text: 'Hi ', type: 0),
  ChatModel(text: 'Hello️ ', type: 1),
  ChatModel(text: 'Sure, let’s do it! 😊', type: 0),
  ChatModel(text: 'Bye ', type: 1),
  ChatModel(text: 'Bye ', type:0 ),
  ChatModel(text: 'Take Care ', type:1),
  ChatModel(text: 'Take Care ', type:0),
];

List<InfoModel>information=[
  InfoModel(title: 'Yeah 100% :', subtitle: "100% No questions asked"),
  InfoModel(title: 'Occasionally 50-50 :', subtitle: "It can be either for me no\nhard & fast rule"),
  InfoModel(title: 'No Way : ', subtitle: "Never, Not me or at least not something\ni go for."),
];


final List<Matches>matches=[
  Matches(image: "assets/images/bg_six.jpg", name: "Vivek Sharma", age: "21", Country: "Indian", Role: "Software Developer"),
  Matches(image: "assets/images/bg_six.jpg", name: "Damanpreet Singh", age: "20", Country: "Canada", Role: "Android Developer"),
  Matches(image: "assets/images/bg_six.jpg", name: "Banish Kumar", age: "21", Country: "Dubai", Role: "Senior Developer"),
  Matches(image: "assets/images/bg_six.jpg", name: "Damanpreet Singh", age: "20", Country: "Canada", Role: "Android Developer"),
  Matches(image: "assets/images/bg_six.jpg", name: "Aditya Kumar", age: "21", Country: "Dubai", Role: "Senior Developer"),
  Matches(image: "assets/images/bg_six.jpg", name: "Aman Kumar", age: "21", Country: "Dubai", Role: "Senior Developer"),
  Matches(image: "assets/images/bg_six.jpg", name: "Sachin Verma", age: "23", Country: "Indian", Role: "Flutter Developer"),
  Matches(image: "assets/images/bg_six.jpg", name: "Damanpreet Singh", age: "20", Country: "Canada", Role: "Android Developer"),
  Matches(image: "assets/images/bg_six.jpg", name: "Damanpreet Singh", age: "20", Country: "Canada", Role: "Android Developer"),
  Matches(image: "assets/images/bg_six.jpg", name: "Damanpreet Singh", age: "20", Country: "Canada", Role: "Android Developer"),
  Matches(image: "assets/images/bg_six.jpg", name: "Aman Kumar", age: "21", Country: "Dubai", Role: "Senior Developer"),
];

List <FaqModel>faqList=[
  FaqModel(text: "How do I upload my pictures?",
      subText: "Depending on your subscription level, you will be limited to the number of pictures you can upload. To upload your picture, click on the + sign, and you can browse in the picture you wish to upload.  Once uploaded, the picture will go in for Review. At this time, you may not have access to your profile, as it will be “In Review” status until approved. For ease of approval, please ensure that your upload checks all the boxes of a profile picture.",
      value: false),
  FaqModel(text: "Why can’t I see my profile picture?", subText: "You might notice that after you upload your photo it does not show up on your dating profile. This is because we have to review each photo uploaded on LikePlay-LikePlay.com to ensure authenticity and quality.  Rest assured that once we’ve thoroughly reviewed your photo, it will immediately show up on your profile.", value: false),
  FaqModel(text: "How does the Refer 5 friends work?", subText: "You can refer five friends at a minimum who sign up using your referral code. The status of sign-up does not matter, so long as they are signed up, using your code which is immediately provided once you use the Refer 5 friends, you will be allowed a Standard subscription the following month. There are no cash refunds for this feature.", value: false),
  FaqModel(text: "What is the purpose of the Newsletter?", subText: "Our newsletter allows you an opportunity to enjoy the stories we feature on our Take the Floor, Pick the Mic”", value: false),
  FaqModel(text: "Who is a Super-User?", subText: "To reward those who participate, and draw in conversations, we created a Super-User class. These are folks who on a weekly basis are making a minimum of twenty-one comments or posting per week.", value: false),
  FaqModel(text: "How can I upgrade my subscription?", subText: "Click on Subscription located in the profile section of your screen. Select your desired membership type. Please note that the 5-Day trial will only be offered once. Then select Upgrade and your NEW subscription level, and then enter all the necessary payment details to start enjoying our upgraded features.", value: false),
  FaqModel(text: "How can I cancel my subscription?", subText: "Our subscription policy offers no refund. You can still contact us to cancel your current subscription, through Customer Support through Email or Live Support.", value: false),
  FaqModel(text: "How can I get a refund?", subText: "If you wish to get a refund, please review our Refund Policy. If qualified: Go to Contact Us.", value: false),
  FaqModel(text: "How can I report a user if there is an incident?", subText: "Go to the member’s profile that you wish to report. Click on Report User. Select the reason for your report, then click Submit Report.\nA member of our client services team will have to review your report and do the appropriate action.", value: false),
  FaqModel(text: "How can I chat with someone that I Admire who dey “Enter my eye?”", subText: "If someone is entering your eye on your match list, then go ahead and click the check mark pink box. If they respond back by Admiring you, then it’s a match. You need that mutual Admiration before you can chat with the member.", value: false),
  FaqModel(text: "I have a Standard subscription, but my Match wants to video call, What happens?", subText: "Unfortunately, because you do not have an upgraded subscription, they cannot video call you. You are encouraged to get an upgraded subscription to be able to video call one another, however; you both can Chat since you have a Standard subscription.", value: false),
  FaqModel(text: "I chose physical attributes ONLY for my match list, but I want to re-do it. What should I do?", subText: "You can go to your Settings page and select Edit Profile. It will allow you start afresh and your Edit will return again for Approval before it is Live again.", value: false),
  FaqModel(text: "I live in Ghana and I am Ghanaian but want to check out guys in Congo. What is the way to do it?", subText: "This is the reason we are here. If you wish to date other Africans, then select the country you wish to date from, and you have to create a new profile, and be re-approved for that Country as well as pay a new subscription. Once approved, you can start browsing from that country.", value: false),
  FaqModel(text: "I am attracted to 2 guys on this platform, I can say I am seeing both of them. One has asked me to sign -off from the platform. If I delete my profile, can I come back if it does not work out? What happens??", subText: "Well Congratulations! We ask you to maintain your profile, even if you have to reduce your subscription level. However, you need to know that by going to your settings, you can delete the app, and re-sign up if things do not pan as expected. Good luck! Remember to post a Testimonial.", value: false),

];

final List <SubscriptionInAppModel> basicListInApp=[
  SubscriptionInAppModel(id: "com.likeplaylikeplay.basicmonthly",planPrice:"1M\n1900",planName: "Monthly",price: "1900",purchaseType: "1",index:1 ),
  SubscriptionInAppModel(id: "com.likeplaylikeplay.basicthreemonth",planPrice:"3M\n4900 ",planName: "Quarterly",price: "4900",purchaseType: "2",index: 2),
  SubscriptionInAppModel(id: "com.likeplaylikeplay.basicyearly",planPrice:"12M\n17900",planName: "Annually",price: "17900",purchaseType: "3",index: 3),
];

final List <SubscriptionInAppModel> standardListInApp=[
  SubscriptionInAppModel(id: "com.likeplaylikeplay.standardmonthly",planPrice:"1M\n2500",planName: "Monthly",price: "2500",purchaseType: "1",index:1),
  SubscriptionInAppModel(id: "com.likeplaylikeplay.standardthreemonth",planPrice:"3M\n6900",planName: "Quarterly",price: "6900",purchaseType: "2",index:2),
  SubscriptionInAppModel(id: "com.likeplaylikeplay.standardyearly",planPrice:"12M\n29900",planName: "Annually",price: "29900",purchaseType: "3",index:3),
];



final List <SubscriptionInAppModel> goldListInApp=[
  SubscriptionInAppModel(id: "com.likeplaylikeplay.goldmonthly",planPrice:"1M\n3500",planName: "Monthly",price: "3500",purchaseType: "1",index:1),
  SubscriptionInAppModel(id: "com.likeplaylikeplay.goldthreemonth",planPrice:"3M\n9900",planName: "Quarterly",price: "9900",purchaseType: "2",index:2),
  SubscriptionInAppModel(id: "com.likeplaylikeplay.goldyearly",planPrice:"12M\n34900",planName: "Annually",price: "34900",purchaseType: "3",index:3),
];

final List <SubscriptionInAppModel> platinumListInApp=[
  SubscriptionInAppModel(id: "com.likeplaylikeplay.platinummonthly",planPrice:"1M\n4900",planName: "Monthly",price: "4900",purchaseType: "1",index:1),
  SubscriptionInAppModel(id: "com.likeplaylikeplay.platinumthreemonth",planPrice:"3M\n14900",planName: "Quarterly",price: "14900",purchaseType: "2",index:2),
  SubscriptionInAppModel(id: "com.likeplaylikeplay.platinumyearly",planPrice:"12M\n59900",planName: "Annually",price: "59900",purchaseType: "3",index:3),
];





final List <SubscriptionModel> basicList=[
  SubscriptionModel(id: "PLN_2xi5jljz9gfwlbr",planPrice:"1 Month - 1,900.00",planName: "Monthly",price: "1900",purchaseType: "1"),
  SubscriptionModel(id: "PLN_5c1ex3p3e05d02q",planPrice:"3 Months - 4,900.00",planName: "Quarterly",price: "4900",purchaseType: "2"),
  SubscriptionModel(id: "PLN_hv99kztf9tpx8tw",planPrice:"12 Months - 17,900.00",planName: "Annually",price: "17900",purchaseType: "3"),
];

final List <SubscriptionModel> standardList=[
  SubscriptionModel(id: "PLN_pbty44gwvj48g4t",planPrice:"1 Month - 2,500.00",planName: "Monthly",price: "2500",purchaseType: "1"),
  SubscriptionModel(id: "PLN_ist280r8ha8n6l3",planPrice:"3 Months - 6,900.00",planName: "Quarterly",price: "6900",purchaseType: "2"),
  SubscriptionModel(id: "PLN_8at4byof5r85ewm",planPrice:"12 Months - 29,900.00",planName: "Annually",price: "29000",purchaseType: "3"),
];



final List <SubscriptionModel> goldList=[
  SubscriptionModel(id: "PLN_nw9ycrc4aug65au",planPrice:"1 Month - 3,500.00",planName: "Monthly",price: "3500",purchaseType: "1"),
  SubscriptionModel(id: "PLN_hkbcky4azyjcmih",planPrice:"3 Months - 9,900.00",planName: "Quarterly",price: "9900",purchaseType: "2"),
  SubscriptionModel(id: "PLN_wsmeqtyj1jg92g2",planPrice:"12 Months - 34,900.00",planName: "Annually",price: "34900",purchaseType: "3"),
];

final List <SubscriptionModel> platinumList=[
  SubscriptionModel(id: "PLN_688h2sg8ykwuole",planPrice:"1 Month - 4,900.00",planName: "Monthly",price: "4900",purchaseType: "1"),
  SubscriptionModel(id: "PLN_1d777vfem8zmt47",planPrice:"3 Months - 14,900.00",planName: "Quarterly",price: "14900",purchaseType: "2"),
  SubscriptionModel(id: "PLN_je5i0sqxh8mivc8",planPrice:"12 Months- 59,900.00",planName: "Annually",price: "59000",purchaseType: "3"),
];


