import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/module/model/payment_paystack_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import 'package:likeplay/module/model/user_profile_response.dart';
import 'package:likeplay/module/subscription/subscription_presenter.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/color_utils.dart';
import '../../utils/constant_lists.dart';
import '../../utils/responsive.dart';
import '../../utils/sharedpref/preferences.dart';
import '../../utils/sharedpref/shared_prefrence.dart';
import '../../utils/string_utils.dart';
import '../../utils/utils.dart';
import '../model/subscription_model.dart';
import '../model/subscription_model_mobile.dart';
import '../sidemenu/web_side_menu.dart';

class SubscriptionWebScreen extends StatefulWidget {
  const SubscriptionWebScreen({Key? key}) : super(key: key);
  @override
  State<SubscriptionWebScreen> createState() => _SubscriptionWebScreenState();
}
class _SubscriptionWebScreenState extends State<SubscriptionWebScreen> implements SubscriptionInterface{
  List<SubscriptionCommonList>subscriptionCommonList=                                           [
    SubscriptionCommonList(title: UtilStrings.Complimentary_Free_Days_upon_Sign_Up, basic: 0 , standard: 0,  gold: 0,  platinum: 0),
    SubscriptionCommonList(title: UtilStrings.Unlimited_Post_on_Take_the_FLOOR, basic: 0, standard: 0,  gold: 0, platinum: 0,),
    SubscriptionCommonList(title: UtilStrings.Unlimited_Post_on_Take_the_MIC, basic: 0, standard: 0, gold: 0, platinum: 0, ),
    SubscriptionCommonList(title: UtilStrings.Super_User_Badge, basic: 0, standard: 0, gold: 0,  platinum: 0, ),
    SubscriptionCommonList(title: UtilStrings.Favorites, basic: 0, standard: 0,  gold: 0,  platinum: 0,),
    SubscriptionCommonList(title: UtilStrings.Chat_Option, basic: 0, standard: 0,  gold: 0,  platinum: 0,),
    SubscriptionCommonList(title: UtilStrings.Admire_Be_Admired, basic: 2, basicValue: "2/DAY", standard: 0, gold: 0,platinum: 0),
    SubscriptionCommonList(title: UtilStrings.Audio_Voice_Note_Messages, basic: 1, standard: 1, gold: 0, platinum: 0,),
    SubscriptionCommonList(title: UtilStrings.Video, basic: 1,standard: 1,gold: 1,platinum: 0),
    SubscriptionCommonList(title: UtilStrings.Picture_Upload, basic: 2, basicValue: "1 PHOTO", standard: 2, standardValue: "3 PHOTOS", gold: 2, goldValue: "4 PHOTOS", platinum: 2, platinumValue: "5 PHOTOS"),
    SubscriptionCommonList(title: UtilStrings.Opening_Matches, basic: 2, basicValue: "5 MATCHES", standard: 2, standardValue: "10 MATCHES", gold: 2, goldValue: "15 MATCHES", platinum: 2, platinumValue: "20 MATCHES"),
    SubscriptionCommonList(title: UtilStrings.New_Matches_Update, basic: 2, basicValue: "1/DAY", standard: 2, standardValue: "3/DAY", gold: 2, goldValue: "4/DAY", platinum: 2, platinumValue: "5/DAY"),
    SubscriptionCommonList(title: UtilStrings.Admired_Day, basic: 2, basicValue: "1/DAY", standard: 2, standardValue: "2/DAY", gold: 2, goldValue: "3/DAY", platinum: 2, platinumValue: "5/DAY"),
  ];
  //String? selectedRegion;
  // String? selectedRegion = '1 MONTH - 1500';
  SubscriptionModel? selectedbasic;
  String? basicPlanID="PLN_2xi5jljz9gfwlbr";
  String? basicPlanPrice="1500";
  String? basicPlanType="1";

  SubscriptionModel? standardValue /*= '1 MONTH - 2200'*/;
  String? standardPlanID="PLN_pbty44gwvj48g4t";
  String? standardPlanPrice="2200";
  String? standardPlanType="2";


  SubscriptionModel? goldValue/* = '1 MONTH - 3000'*/;
  String? goldPlanID="PLN_nw9ycrc4aug65au";
  String? goldPlanPrice="5000";
  String? goldPlanType="3";


  SubscriptionModel? platiniumValue/* = '1 MONTH - 5000'*/;
  String? platiniumPlanID="PLN_688h2sg8ykwuole";
  String? platiniumPrice="5000";
  String? platiniumPlanType="4";


  String? planPricebasic="1 Month - 1500";
  String? standardPricebasic="1 Month - 2200";
  String? goldPricebasic="1 Month - 3000";
  String? platiniumPricebasic="1 Month - 5000";

  bool isLoading=false;
  SubscriptionPresenter? subscriptionPresenter;


  @override
  void initState() {
    super.initState();
    subscriptionPresenter=SubscriptionPresenter(this);
    setState(() {
      selectedbasic=basicList[0];
      standardValue=standardList[0];
      goldValue=goldList[0];
      platiniumValue=platinumList[0];
    });
  }

  var Basic = [
    '1 MONTH - 1500',
    '3 MONTH - 4500',
    '12 MONTH - 16000',
  ];
  var Standard = [
    '1 MONTH - 2200',
    '3 MONTH - 6000',
    '12 MONTH - 25000',
  ];
  var Gold = [
    '1 MONTH - 3000',
    '3 MONTH - 8550',
    '12 MONTH - 34200',
  ];
  var Platinium = [
    '1 MONTH - 5000',
    '3 MONTH - 14250',
    '12 MONTH - 57000',
  ];


  @override
  Widget build(BuildContext context) {
    return AppSideMenu(
      pageTitle:UtilStrings.Subscription,
      screenType: 1,
      body:SingleChildScrollView(
        child: Container(
          /*width: size.width,
          height: size.height,*/
          color: Colors.white,
          child: Container(
              child: Stack(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(Responsive().getResponsiveValue(
                        forLargeScreen: 0.0,
                        forShortScreen:   22.0,
                        forMobLandScapeMode:   22.0,
                        forMediumScreen:   22.0,
                        forTabletScreen:  22.0,
                        context: context) ,),
                    ResponsiveRowColumn(
                      rowMainAxisAlignment: MainAxisAlignment.start,
                      rowCrossAxisAlignment: CrossAxisAlignment.start,
                      layout: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                          ? ResponsiveRowColumnType.COLUMN
                          : ResponsiveRowColumnType.ROW,
                      children: [
                        ResponsiveRowColumnItem(
                            rowFlex: 2, child: Stack(
                          children: [
                            Container(
                              padding : EdgeInsets.only(top: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.topCenter,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Gap(20),
                                        Expanded(
                                            flex: 1,
                                            child: Container()),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.only(right: 5),
                                            child: Column(
                                              children: [
                                                Utils.imageView(image: "assets/images/ic_basicDiamond.png",height: 18,color: HexColor(AppColor
                                                    .settingBorderColor)),
                                                Gap(5),
                                                Utils
                                                    .mediumHeadingNormalText(
                                                    text: UtilStrings
                                                        .Basic,
                                                    textSize: 9,
                                                    fontWeight: FontWeight
                                                        .w500,
                                                    color: AppColor
                                                        .black),
                                                Gap(5),
                                                Divider(thickness: 1,color: AppColor.DIVIDER_COLOR,)
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.only(right: 5),
                                            child: Column(
                                              children: [
                                                Utils.imageView(image: "assets/images/ic_diamond.png",height: 18 ),
                                                Gap(5),
                                                Utils
                                                    .mediumHeadingNormalText(
                                                    text: UtilStrings
                                                        .Standard,
                                                    textSize: 9,
                                                    fontWeight: FontWeight
                                                        .w500,
                                                    color: AppColor
                                                        .black),
                                                Gap(5),
                                                Divider(thickness: 1,color: AppColor.DIVIDER_COLOR,)
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.only(right: 5),
                                            child: Column(
                                              children: [
                                                Utils.imageView(image: "assets/images/ic_goldDiamond.png",height: 18),
                                                Gap(5),
                                                Utils
                                                    .mediumHeadingNormalText(
                                                    text: UtilStrings
                                                        .Gold,
                                                    textSize: 9,
                                                    fontWeight: FontWeight
                                                        .w500,
                                                    color: AppColor
                                                        .black),
                                                Gap(5),
                                                Divider(thickness: 1,color: AppColor.DIVIDER_COLOR,)
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.only(right: 5),
                                            child: Column(
                                              children: [
                                                Utils.imageView(image: "assets/images/ic_platinumDiamond.png",height: 18),
                                                Gap(5),
                                                Utils
                                                    .mediumHeadingNormalText(
                                                    text: UtilStrings
                                                        .Platinum,
                                                    textSize: 9 ,
                                                    fontWeight: FontWeight
                                                        .w500,
                                                    color: AppColor
                                                        .black),
                                                Gap(5),
                                                Divider(thickness: 1,color: AppColor.DIVIDER_COLOR,)
                                              ],
                                            ),
                                          ),
                                        ),
                                        Gap(20),
                                      ],
                                    ),
                                  ),
                                  Gap(10),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: subscriptionCommonList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start  ,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              color: AppColor.light_white2,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 20,right: 20),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        padding: EdgeInsets.only(right: 10),
                                                        child:Utils.mediumHeadingNormalText(text: subscriptionCommonList[index].title,textSize: 10,fontWeight: FontWeight.w400,textAlign: TextAlign.start),),
                                                    ),
                                                    if(subscriptionCommonList[index].basic==0)...[
                                                      Expanded(
                                                          flex: 1,
                                                          child: Icon(Icons.check,color:  AppColor.SideTextColor,size: 10,))
                                                    ]
                                                    else if (subscriptionCommonList[index].basic==1)...[
                                                      Expanded(
                                                          flex: 1,
                                                          child: Icon(Icons.close,color:  AppColor.APP_SUBMIT_COLOR,size: 10,)),
                                                    ]else...[
                                                      Expanded(
                                                          flex: 1,
                                                          child: Utils.mediumHeadingNormalText(text: subscriptionCommonList[index].basicValue, textSize: 7, fontWeight: FontWeight.w400, color: AppColor.black,textAlign: TextAlign.center)),
                                                    ],
                                                    if(subscriptionCommonList[index].standard==0)...[
                                                      Expanded(
                                                          flex: 1,
                                                          child: Icon(Icons.check,color:  AppColor.SideTextColor,size: 10,))
                                                    ]
                                                    else if (subscriptionCommonList[index].standard==1)...[
                                                      Expanded(
                                                          flex: 1,
                                                          child: Icon(Icons.close,color:  AppColor.APP_SUBMIT_COLOR,size: 10,)),
                                                    ]else...[
                                                      Expanded(
                                                          flex: 1,
                                                          child: Utils.mediumHeadingNormalText(text: subscriptionCommonList[index].standardValue, textSize: 7, fontWeight: FontWeight.w400, color: AppColor.black,textAlign: TextAlign.center)),

                                                    ],
                                                    if(subscriptionCommonList[index].gold==0)...[
                                                      Expanded(
                                                          flex: 1,
                                                          child: Icon(Icons.check,color:  AppColor.SideTextColor,size: 10,))
                                                    ]
                                                    else if (subscriptionCommonList[index].gold==1)...[
                                                      Expanded(
                                                          flex: 1,
                                                          child: Icon(Icons.close,color:  AppColor.APP_SUBMIT_COLOR,size: 10,)),
                                                    ]else...[
                                                      Expanded(
                                                          flex: 1,
                                                          child: Utils.mediumHeadingNormalText(text: subscriptionCommonList[index].goldValue, textSize: 7, fontWeight: FontWeight.w400, color: AppColor.black,textAlign: TextAlign.center)),

                                                    ],
                                                    if(subscriptionCommonList[index].platinum==0)...[
                                                      Expanded(
                                                          flex: 1,
                                                          child: Icon(Icons.check,color:  AppColor.SideTextColor,size: 10,))
                                                    ]
                                                    else if (subscriptionCommonList[index].platinum==1)...[
                                                      Expanded(
                                                          flex: 1,
                                                          child: Icon(Icons.close,color:  AppColor.APP_SUBMIT_COLOR,size: 10,)),
                                                    ]else...[
                                                      Expanded(
                                                          flex: 1,
                                                          child: Utils.mediumHeadingNormalText(text: subscriptionCommonList[index].platinumValue, textSize: 7, fontWeight: FontWeight.w400, color: AppColor.black,textAlign: TextAlign.center)),

                                                    ],
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Gap(15),
                                          ],
                                        );
                                    },
                                  ),
                                  Gap(20),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Gap(20),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Utils.mediumHeadingNormalText(text: UtilStrings.SelectSubscription,textSize: 12,fontWeight: FontWeight.w500,textAlign: TextAlign.start),),
                                      ),
                                      Expanded(

                                        flex: 1,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 35,
                                              margin:  EdgeInsets.only(right: 20,left : 20),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(color: AppColor.DIVIDER_COLOR)
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      DropdownButton(
                                                        dropdownColor :AppColor.white,
                                                        underline: SizedBox(),
                                                        isDense: true,
                                                        icon: const Icon(Icons.keyboard_arrow_down,color: Colors.black,size: 26,),
                                                        value: selectedbasic,
                                                        items: basicList
                                                            .map((e) => DropdownMenuItem(
                                                          child:  Utils.mediumHeadingNormalText(text:e.planPrice,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND),
                                                          value: e,
                                                        ))
                                                            .toList(),
                                                        onChanged: (SubscriptionModel? value) {
                                                          if(value!=null){
                                                            setState(() {
                                                              basicPlanID=value.id;
                                                              basicPlanPrice=value.price;
                                                              basicPlanType=value.purchaseType;
                                                              planPricebasic=value.planPrice;
                                                              selectedbasic=value;
                                                            });
                                                          }
                                                        },)

                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Gap(14),
                                            GestureDetector(
                                                onTap: (){
                                                  paymentMethod(basicPlanPrice.toString(),basicPlanID.toString(),basicPlanType.toString(),"1");
                                                },
                                                child: Container(
                                                  height: 35,
                                                  margin:  EdgeInsets.only(right: 20,left : 20),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: AppColor.APP_SUBMIT_COLOR,
                                                  ),
                                                  child: Center(
                                                    child: Utils.mediumHeadingNormalText(
                                                        text: "Buy",
                                                        textSize: 12,
                                                        textAlign: TextAlign.center,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.white),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 35,
                                              margin:  EdgeInsets.only(right: 20,left : 20),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(color: AppColor.DIVIDER_COLOR)
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      DropdownButton(
                                                        dropdownColor :AppColor.white,
                                                        underline: SizedBox(),
                                                        isDense: true,
                                                        icon: const Icon(Icons.keyboard_arrow_down,color: Colors.black,size: 26,),
                                                        value: standardValue,
                                                        items: standardList
                                                            .map((e) => DropdownMenuItem(
                                                          child:  Utils.mediumHeadingNormalText(text:e.planPrice,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND),
                                                          value: e,
                                                        ))
                                                            .toList(),
                                                        onChanged: (SubscriptionModel? value) {
                                                          if(value!=null){
                                                            setState(() {
                                                              standardPlanID=value.id;
                                                              standardPlanPrice=value.price;
                                                              standardPlanType=value.purchaseType;
                                                              standardPricebasic=value.planPrice;
                                                              standardValue=value;
                                                            });
                                                          }
                                                        },)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Gap(14),
                                            GestureDetector(
                                                onTap: (){
                                                  paymentMethod(standardPlanPrice.toString(),standardPlanID.toString(),standardPlanType.toString(),"2");
                                                },
                                                child: Container(
                                                  height: 35,
                                                  margin:  EdgeInsets.only(right: 20,left : 20),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: AppColor.APP_SUBMIT_COLOR,
                                                  ),
                                                  child: Center(
                                                    child: Utils.mediumHeadingNormalText(
                                                        text: "Buy",
                                                        textSize: 12,
                                                        textAlign: TextAlign.center,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.white),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 35,
                                              margin:  EdgeInsets.only(right: 20,left : 20),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(color: AppColor.DIVIDER_COLOR)
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      DropdownButton(
                                                        dropdownColor :AppColor.white,
                                                        underline: SizedBox(),
                                                        isDense: true,
                                                        icon: const Icon(Icons.keyboard_arrow_down,color: Colors.black,size: 26,),
                                                        value: goldValue,
                                                        items: goldList
                                                            .map((e) => DropdownMenuItem(
                                                          child:  Utils.mediumHeadingNormalText(text:e.planPrice,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND),
                                                          value: e,
                                                        ))
                                                            .toList(),
                                                        onChanged: (SubscriptionModel? value) {
                                                          if(value!=null){
                                                            setState(() {
                                                              goldPlanID=value.id;
                                                              goldPlanPrice=value.price;
                                                              goldPlanType=value.purchaseType;
                                                              goldPricebasic=value.planPrice;
                                                              goldValue=value;

                                                            });
                                                          }
                                                        },)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Gap(14),
                                            GestureDetector(
                                                onTap: (){
                                                  paymentMethod(goldPlanPrice.toString(),goldPlanID.toString(),goldPlanType.toString(),"3");
                                                },
                                                child: Container(
                                                  height: 35,
                                                  margin:  EdgeInsets.only(right: 20,left : 20),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: AppColor.APP_SUBMIT_COLOR,
                                                  ),
                                                  child: Center(
                                                    child: Utils.mediumHeadingNormalText(
                                                        text: "Buy",
                                                        textSize: 12,
                                                        textAlign: TextAlign.center,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.white),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 35,
                                              margin:  EdgeInsets.only(right: 20,left : 20),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(color: AppColor.DIVIDER_COLOR)
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      DropdownButton(
                                                        dropdownColor :AppColor.white,
                                                        underline: SizedBox(),
                                                        isDense: true,
                                                        icon: const Icon(Icons.keyboard_arrow_down,color: Colors.black,size: 26,),
                                                        value: platiniumValue,
                                                        items: platinumList
                                                            .map((e) => DropdownMenuItem(
                                                          child:  Utils.mediumHeadingNormalText(text:e.planPrice,textSize: 12,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND),
                                                          value: e,
                                                        ))
                                                            .toList(),
                                                        onChanged: (SubscriptionModel? value) {
                                                          if(value!=null){
                                                            setState(() {
                                                              platiniumPlanID=value.id;
                                                              platiniumPrice=value.price;
                                                              platiniumPlanType=value.purchaseType;
                                                              platiniumValue=value;
                                                              //platiniumPricebasic=value.planPrice;
                                                            });
                                                          }
                                                        },),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Gap(14),
                                            GestureDetector(
                                                onTap: (){
                                                  paymentMethod(platiniumPrice.toString(),platiniumPlanID.toString(),platiniumPlanType.toString(),"4");
                                                },
                                                child: Container(
                                                  height: 35,
                                                  margin:  EdgeInsets.only(right: 20,left : 20),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: AppColor.APP_SUBMIT_COLOR,
                                                  ),

                                                  child: Center(
                                                    child: Utils.mediumHeadingNormalText(
                                                        text: "Buy",
                                                        textSize: 12,
                                                        textAlign: TextAlign.center,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.white),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Gap(10)

                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Container()),
                                Container(
                                  margin: EdgeInsets.only(left: 9),
                                  height: MediaQuery.of(context).size.height/1.3,
                                  width: 1,
                                  color: AppColor.DIVIDER_COLOR,
                                ),
                                Flexible(child: Container(),flex: 5,fit: FlexFit.loose,)
                              ],
                            )
                          ],
                        )),
                      ],
                    ),
                  ],
                ),
                Utils.progressDialog(context, isLoading,type:4)

              ],)
          ),
        ),
      ),
    );

  }

  @override
  onError(String msg, int status) {
    setState(() {
      isLoading=false;
    });
  }

  @override
  onPayStackPayment(PaymentPayStackResponse response) {
    setState(() {
      isLoading=false;
    });
    if(response.status==200){
      launch(response.data!.data!.authorizationUrl.toString());
      // html.WindowBase _popup = html.window.open(response.data!.data!.authorizationUrl.toString(), "likeplay",'left=100,top=100,width=800,height=600');
      // if (_popup.closed!) {
      //   throw("Popups blocked");
      // }
    }
  }

  void paymentMethod(String amount,String planCode,String purchaseType, String subscriptionType) {
    setState(() {
      isLoading=true;
    });
    subscriptionPresenter?.onPaymentPayStack(amount,planCode, purchaseType, subscriptionType);
  }

  @override
  onSubscriptionSuccess(SuccessResponse response) {

  }

  @override
  onProfileResponse(UserProfileResponse response) {
    if(response.status==200){
      //Utils.customDialog(response.message!);
      SessionManager.setString(Preferences.USER_NAME, response.data!.name.toString());
      SessionManager.setString(Preferences.EMAIL, response.data!.email.toString());
      SessionManager.setString(Preferences.REFERAL_CODE, response.data!.referCode.toString());
      SessionManager.setString(Preferences.USER_ID, response.data!.id.toString());
      SessionManager.setString(Preferences.CHOOSE_ANY_ONE, response.data!.chooseAnyOne.toString());
      SessionManager.setString(Preferences.PROFILE_IMAGE, response.data!.userImagesWhileSignup!.isNotEmpty?response.data!.userImagesWhileSignup![0].imageUrl.toString():"");
      SessionManager.setString(Preferences.INDEX,"0");
      SessionManager.setString(Preferences.profileStatus,response.data!.profileStatus.toString());
      SessionManager.setString(Preferences.verification_status,response.data!.userVerification.toString());
      SessionManager.setString(Preferences.government_status, "");
      SessionManager.setString(Preferences.phone_status, "");
      SessionManager.setString(Preferences.pose_status, "");
      SessionManager.setString(Preferences.facebook_status, "");
      SessionManager.setString(Preferences.subscription_status, response.data!.subscriptionStatus.toString());
      //1=> Basic ,2=> Standard ,3=> Gold ,4=>Platinum
      // subscription type(1,2,3,4) 1 : basic, 2:standard, 3:gold, 4:platinum
      if(response.data!.subscriptionStatus==false && response.data!.subscriptions!.isEmpty){
        SessionManager.setString(Preferences.subscription_plan, "");
        SessionManager.setString(Preferences.plan_ammount, "");
        SessionManager.setString(Preferences.plan_id, "");
      }else
      if(response.data!.subscriptionStatus==true && response.data!.subscriptions!.isNotEmpty){
        SessionManager.setString(Preferences.subscription_plan, response.data!.subscriptions![0].supscriptionType.toString());
        SessionManager.setString(Preferences.plan_ammount, response.data!.subscriptions![0].amount.toString());
        SessionManager.setString(Preferences.plan_id, response.data!.subscriptions![0].productId.toString());
      }else{
        SessionManager.setString(Preferences.subscription_plan, "");
        SessionManager.setString(Preferences.plan_ammount, "");
        SessionManager.setString(Preferences.plan_id, "");
      }
    }
  }
}
class SubscriptionCommonList{
  String ?title;
  int ?basic;
  String? basicValue;
  int ?standard;
  String ?standardValue;
  int ?gold;
  String ?goldValue;
  int ?platinum;
  String ?platinumValue;
  SubscriptionCommonList({
    this.title,
    this.basic,
    this.basicValue,
    this.standard,
    this.standardValue,
    this.gold,
    this.goldValue,
    this.platinum,
    this.platinumValue
  });
}

