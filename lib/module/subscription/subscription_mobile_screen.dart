import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:in_app_purchase_android/src/types/google_play_purchase_details.dart';
import 'package:likeplay/module/home/terms_and_condition_screen.dart';
import 'package:likeplay/module/model/payment_paystack_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import 'package:likeplay/module/model/user_profile_response.dart';
import 'package:likeplay/module/subscription/subscription_presenter.dart';
import 'package:likeplay/utils/sharedpref/preferences.dart';
import 'package:likeplay/utils/sharedpref/shared_prefrence.dart';
import '../../utils/color_utils.dart';
import '../../utils/constant_lists.dart';
import '../../utils/consumable store.dart';
import '../../utils/responsive.dart';
import '../../utils/route/route_name.dart';
import '../../utils/string_utils.dart';
import '../../utils/utils.dart';
import '../home/PrivacyPolicyScreen.dart';
import '../model/subscription_inapp_model.dart';
import '../model/subscription_model_mobile.dart';
import '../sidemenu/web_side_menu.dart';

class SubscriptionMobileScreen extends StatefulWidget {
  String? comesFrom;
  SubscriptionMobileScreen({this.comesFrom});
  @override
  State<SubscriptionMobileScreen> createState() => _SubscriptionMobileScreenState();
}
const String com_likeplaylikeplay_basicmonthly='com.likeplaylikeplay.basicmonthly';
const String com_likeplaylikeplay_basicthreemonth='com.likeplaylikeplay.basicthreemonth';
const String com_likeplaylikeplay_basicyearly='com.likeplaylikeplay.basicyearly';
const String com_likeplaylikeplay_standardmonthly='com.likeplaylikeplay.standardmonthly';
const String com_likeplaylikeplay_standardthreemonth='com.likeplaylikeplay.standardthreemonth';
const String com_likeplaylikeplay_standardyearly='com.likeplaylikeplay.standardyearly';
const String com_likeplaylikeplay_goldmonthly='com.likeplaylikeplay.goldmonthly';
const String com_likeplaylikeplay_goldthreemonth='com.likeplaylikeplay.goldthreemonth';
const String com_likeplaylikeplay_goldyearly='com.likeplaylikeplay.goldyearly';
const String com_likeplaylikeplay_platinummonthly='com.likeplaylikeplay.platinummonthly';
const String com_likeplaylikeplay_platinumthreemonth='com.likeplaylikeplay.platinumthreemonth';
const String com_likeplaylikeplay_platinumyearly='com.likeplaylikeplay.platinumyearly';
const bool _kAutoConsume = true;

const List<String> _kProductBasicIds = <String>[
  com_likeplaylikeplay_basicmonthly,
  com_likeplaylikeplay_basicthreemonth,
  com_likeplaylikeplay_basicyearly,
  com_likeplaylikeplay_standardmonthly,
  com_likeplaylikeplay_standardthreemonth,
  com_likeplaylikeplay_standardyearly,
  com_likeplaylikeplay_goldmonthly,
  com_likeplaylikeplay_goldthreemonth,
  com_likeplaylikeplay_goldyearly,
  com_likeplaylikeplay_platinummonthly,
  com_likeplaylikeplay_platinumthreemonth,
  com_likeplaylikeplay_platinumyearly,
];
class _SubscriptionMobileScreenState extends State<SubscriptionMobileScreen> implements SubscriptionInterface {
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
  SubscriptionInAppModel? basicValue;
  SubscriptionInAppModel? standardValue ;
  SubscriptionInAppModel? goldValue;
  SubscriptionInAppModel? platiniumValue ;
  String purchaseToken="";
  String transactionDate="";
  bool subscriptionStatus=false;
  String basicPlanID="com.likeplaylikeplay.basicmonthly";
  String standardPlanID="com.likeplaylikeplay.standardmonthly";
  String goldPlanID="com.likeplaylikeplay.goldmonthly";
  String platinumPlanID="com.likeplaylikeplay.platinummonthly";
  String productPlanID="com.likeplaylikeplay.basicmonthly";
  String productStanardPlanID="com.likeplaylikeplay.standardmonthly";
  String productGoldPlanID="com.likeplaylikeplay.goldmonthly";
  String productPlatinumPlanID="com.likeplaylikeplay.platinummonthly";
  String basicPlanPrice="1900";
  String basicPlanType="1";
  String planPricebasic="1900";
  String? standardPlanPrice="2500";
  String? standardPlanType="1";
  String? goldPlanPrice="3500";
  String? goldPlanType="1";
  String? platiniumPrice="4900";
  String? platiniumPlanType="1";
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  List<String> _notFoundIds = [];
  List<ProductDetails> _products = [];
  List<ProductDetails> _duplicateProducts = [];
  List<PurchaseDetails> _purchases = [];
  List<String> _consumables = [];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;
  SubscriptionPresenter? subscriptionPresenter;
  String subscriptionAmmount="";
  String subscriptionType="1";
  String purchaseTypeD="1";
  bool isBasic=false;
  bool isStandard=false;
  bool isGold=false;
  bool isPlatinium=false;
  bool isLoading=false;
  @override
  void initState() {
    subscriptionPresenter=SubscriptionPresenter(this);

  setState(() {
        basicValue=basicListInApp[0];
        standardValue=standardListInApp[0];
        goldValue=goldListInApp[0];
        platiniumValue=platinumListInApp[0];
      });
    final Stream<List<PurchaseDetails>> purchaseUpdated = _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription!.cancel();
    }, onError: (error) {
      _subscription!.resume();
    });
    initStoreInfo();
    super.initState();
  }
  ProductDetails? productDetails;
  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = [];
        _purchases = [];
        _notFoundIds = [];
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (Platform.isIOS) {
      var iosPlatformAddition = _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    ProductDetailsResponse productDetailResponse = await _inAppPurchase.queryProductDetails(_kProductBasicIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    List<String> consumables = await ConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = consumables;
      _purchasePending = false;
      _loading = false;
    });
    // getDuplicateList();
  }

 /* getDuplicateList(){
    for(int i=0;i<_products.length;i++){
      // for basic
      if(basicPlanID==_products[i].id){
        print("id ${basicPlanID} == ${_products[i].id}");
        _duplicateProducts=[
          ProductDetails(id:  _products[i].id,
              title:  _products[i].title, description:
              _products[i].description, price:  _products[i].price,
              rawPrice:  _products[i].rawPrice,
              currencyCode:  _products[i].currencyCode)
        ];
      }
      //for standard
      if(standardPlanID==_products[i].id){
        print("id ${standardPlanID} == ${_products[i].id}");
        _duplicateProducts=[
          ProductDetails(id:  _products[i].id,
              title:  _products[i].title, description:
              _products[i].description, price:  _products[i].price,
              rawPrice:  _products[i].rawPrice,
              currencyCode:  _products[i].currencyCode)
        ];
      }
      //for gold
      if(goldPlanID==_products[i].id){
        print("id $goldPlanID} == ${_products[i].id}");
        _duplicateProducts=[
          ProductDetails(id:  _products[i].id,
              title:  _products[i].title, description:
              _products[i].description, price:  _products[i].price,
              rawPrice:  _products[i].rawPrice,
              currencyCode:  _products[i].currencyCode)
        ];
      }
      //for platinum
      if(platinumPlanID==_products[i].id){
        print("id ${platinumPlanID} == ${_products[i].id}");
        _duplicateProducts=[
          ProductDetails(id:  _products[i].id,
              title:  _products[i].title, description:
              _products[i].description, price:  _products[i].price,
              rawPrice:  _products[i].rawPrice,
              currencyCode:  _products[i].currencyCode)
        ];
      }
    }
  }*/
  @override
  Widget build(BuildContext context) {
    return AppSideMenu(
      pageTitle:UtilStrings.Subscription,
      screenType: 1,
      body:SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              /*width: size.width,
              height: size.height,*/
              color: Colors.white,
              child: Container(
                  child: Column(
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
                      Stack(
                        children: [
                          Container(
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
                                          flex: 2,
                                          child: Container()),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding: EdgeInsets.only(right: 5),
                                          child: Column(
                                            children: [
                                              Utils.imageView(image: "assets/images/ic_basicDiamond.png",height: 18,color: Colors.grey),
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
                                              Utils.imageView(image: "assets/images/ic_basicDiamond.png",height: 18 ),
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
                                  physics: NeverScrollableScrollPhysics(),
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
                                                    flex: 2,
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
                                      flex: 2,
                                      child: Container(
                                        child: Utils.mediumHeadingNormalText(text: UtilStrings.SelectSubscription,textSize: 14,fontWeight: FontWeight.w500,textAlign: TextAlign.start),),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 2,right: 2),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(3),
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
                                                    IgnorePointer(
                                                      ignoring: true,
                                                      child: DropdownButton(
                                                        dropdownColor :AppColor.white,
                                                        value: basicValue,
                                                        underline: SizedBox(),
                                                        icon: const Icon(Icons.keyboard_arrow_down,color: Colors.black,size: 15,),
                                                        items: basicListInApp.map((Basic) {
                                                          return DropdownMenuItem(

                                                            value: Basic,
                                                            child: Utils.mediumHeadingNormalText(text: Basic.planPrice,textSize: 7,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND),
                                                          );
                                                        }).toList(),
                                                        onChanged: (SubscriptionInAppModel? value) {
                                                          setState(() {
                                                            basicPlanID=value!.id;
                                                            basicPlanPrice=value.price;
                                                            basicPlanType=value.purchaseType;
                                                            planPricebasic=value.planPrice;
                                                            basicValue=value;
                                                            isBasic=true;
                                                            print(_products.toString());
                                                            print(_duplicateProducts.toString());
                                                           productPlanID= _products[value.index-1].id;
                                                            _duplicateProducts=[
                                                              ProductDetails(id:  _products[value.index-1].id,
                                                                  title:  _products[value.index-1].title, description:
                                                                  _products[value.index-1].description, price:  _products[value.index-1].price,
                                                                  rawPrice:  _products[value.index-1].rawPrice,
                                                                  currencyCode:  _products[value.index-1].currencyCode)
                                                            ];
                                                          });
                                                        },
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Gap(14),
                                        /*  GestureDetector(
                                            onTap: (){
                                              if((SessionManager.getString(Preferences.subscription_status)=="false" || SessionManager.getString(Preferences.is_trial)=="true") || widget.comesFrom=="UpgradeView"){
                                                if(isBasic==false){
                                                  for(int i=0;i<_products.length;i++){
                                                    if(basicPlanID==_products[i].id){
                                                      print("id ${basicPlanID} == ${_products[i].id}");
                                                      productPlanID= _products[i].id;
                                                      _duplicateProducts=[
                                                        ProductDetails(id:  _products[i].id,
                                                            title:  _products[i].title, description:
                                                            _products[i].description, price:  _products[i].price,
                                                            rawPrice:  _products[i].rawPrice,
                                                            currencyCode:  _products[i].currencyCode)
                                                      ];
                                                    }}
                                                  paymethodMethod(basicPlanPrice.toString(),basicPlanID.toString(),basicPlanType.toString(),"1",productPlanID);
                                                }else{
                                                  paymethodMethod(basicPlanPrice.toString(),basicPlanID.toString(),basicPlanType.toString(),"1",productPlanID);
                                                }
                                              }else{
                                              }

                                            },
                                            child: Container(
                                              height: 26,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(3),
                                                color:SessionManager.getString(Preferences.subscription_status)=="false" || SessionManager.getString(Preferences.is_trial)=="true" || widget.comesFrom=="UpgradeView"?
                                                AppColor.APP_SUBMIT_COLOR:AppColor.grey.withOpacity(0.4),
                                              ),
                                              child: Center(
                                                child: Utils.mediumHeadingNormalText(
                                                    text: "Buy",
                                                    textSize: 12,
                                                    textAlign: TextAlign.center,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),*/
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 2,right: 2),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(3),
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
                                                    IgnorePointer(
                                                      ignoring: true,
                                                      child: DropdownButton(
                                                        value: standardValue,
                                                        dropdownColor :AppColor.white,
                                                        underline: SizedBox(),
                                                        icon: const Icon(Icons.keyboard_arrow_down,color: Colors.black,size: 15,),
                                                        items: standardListInApp.map(( Standard) {
                                                          return DropdownMenuItem(
                                                            value: Standard,
                                                            child: Utils.mediumHeadingNormalText(text: Standard.planPrice,textSize: 7,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND),
                                                          );
                                                        }).toList(),

                                                        onChanged: (SubscriptionInAppModel? value) {
                                                          setState(() {
                                                            standardValue = value!;
                                                            setState(() {
                                                              standardPlanID=value.id;
                                                              standardPlanPrice=value.price;
                                                              standardPlanType=value.purchaseType;
                                                              standardValue=value;
                                                              isStandard=true;
                                                              print(_products.toString());
                                                              for(int i=0;i<_products.length;i++){
                                                                if(value.id==_products[i].id){
                                                                  productStanardPlanID= _products[i].id;
                                                                  print("id ${value.id} == ${_products[i].id}");
                                                                  _duplicateProducts=[
                                                                    ProductDetails(id:  _products[i].id,
                                                                        title:  _products[i].title, description:
                                                                        _products[i].description, price:  _products[i].price,
                                                                        rawPrice:  _products[i].rawPrice,
                                                                        currencyCode:  _products[i].currencyCode)
                                                                  ];
                                                                }
                                                              }
                                                            });
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Gap(14),
                                         /* GestureDetector(
                                            onTap: (){
                                              if(SessionManager.getString(Preferences.subscription_status)=="false" ||  SessionManager.getString(Preferences.is_trial)=="true" || widget.comesFrom=="UpgradeView"){
                                                if(isStandard==false){
                                                  for(int i=0;i<_products.length;i++){
                                                    if(standardPlanID==_products[i].id){
                                                      print("id ${standardPlanID} == ${_products[i].id}");
                                                      productStanardPlanID= _products[i].id;
                                                      _duplicateProducts=[
                                                        ProductDetails(id:  _products[i].id,
                                                            title:  _products[i].title, description:
                                                            _products[i].description, price:  _products[i].price,
                                                            rawPrice:  _products[i].rawPrice,
                                                            currencyCode:  _products[i].currencyCode)
                                                      ];
                                                    }}
                                                  paymethodMethod(
                                                      standardPlanPrice.toString(),
                                                      standardPlanID.toString(),
                                                      standardPlanType.toString(),
                                                      "2",productStanardPlanID);
                                                }else {
                                                  paymethodMethod(
                                                      standardPlanPrice.toString(),
                                                      standardPlanID.toString(),
                                                      standardPlanType.toString(),
                                                      "2",productStanardPlanID);
                                                }
                                              }else{

                                              }
                                              *//*final List<String> productList = [];
                                              Map<String, PurchaseDetails> purchases = Map.fromEntries(_purchases.map((PurchaseDetails purchase) {
                                                if (purchase.pendingCompletePurchase) {
                                                  _inAppPurchase.completePurchase(purchase);
                                                }
                                                return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
                                              }));
                                              productList.addAll(_duplicateProducts.map(
                                                      (ProductDetails productDetails) {
                                                    late PurchaseParam purchaseParam;
                                                    if (Platform.isAndroid) {
                                                      final oldSubscription = _getOldSubscription(productDetails, purchases);
                                                      purchaseParam = GooglePlayPurchaseParam(
                                                          productDetails: productDetails,
                                                          applicationUserName: null,
                                                          changeSubscriptionParam: (oldSubscription != null)
                                                              ? ChangeSubscriptionParam(
                                                            oldPurchaseDetails: oldSubscription,
                                                            prorationMode: ProrationMode
                                                                .immediateWithTimeProration,
                                                          )
                                                              : null);
                                                    } else {
                                                      purchaseParam = PurchaseParam(
                                                        productDetails: productDetails,
                                                        applicationUserName: null,
                                                      );
                                                    }
                                                    if ((productStanardPlanID == standardPlanID) ){
                                                      _inAppPurchase.buyConsumable(
                                                          purchaseParam: purchaseParam,
                                                          autoConsume: _kAutoConsume || Platform.isIOS);
                                                    }
                                                    return "";

                                                  }
                                              ));*//*
                                            },
                                            child: Container(
                                              height: 26,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(3),
                                                color: SessionManager.getString(Preferences.subscription_status)=="false" ||  SessionManager.getString(Preferences.is_trial)=="true" || widget.comesFrom=="UpgradeView"?
                                                AppColor.APP_SUBMIT_COLOR:AppColor.grey.withOpacity(0.4),
                                              ),
                                              child: Center(
                                                child: Utils.mediumHeadingNormalText(
                                                    text: "Buy",
                                                    textSize: 12,
                                                    textAlign: TextAlign.center,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),*/
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 2,right: 2),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(3),
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
                                                    IgnorePointer(
                                                      ignoring: true,
                                                      child: DropdownButton(
                                                        value: goldValue,
                                                        dropdownColor :AppColor.white,
                                                        underline: SizedBox(),
                                                        icon: const Icon(Icons.keyboard_arrow_down,color: Colors.black,size: 15,),
                                                        items:  goldListInApp.map((  Gold) {
                                                          return DropdownMenuItem(
                                                            value:  Gold,
                                                            child: Utils.mediumHeadingNormalText(text:  Gold.planPrice,textSize: 7,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND),
                                                          );
                                                        }).toList(),

                                                        onChanged: (SubscriptionInAppModel? value) {
                                                          setState(() {
                                                            goldValue = value!;
                                                            goldPlanID=value.id;
                                                            goldPlanPrice=value.price;
                                                            goldPlanType=value.purchaseType;
                                                            isGold=true;
                                                            for(int i=0;i<_products.length;i++){
                                                              if(value.id==_products[i].id){
                                                                productGoldPlanID= _products[i].id;
                                                                print("id ${value.id} == ${_products[i].id}");
                                                                _duplicateProducts=[
                                                                  ProductDetails(id:  _products[i].id,
                                                                      title:  _products[i].title, description:
                                                                      _products[i].description, price:  _products[i].price,
                                                                      rawPrice:  _products[i].rawPrice,
                                                                      currencyCode:  _products[i].currencyCode)
                                                                ];
                                                              }
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Gap(14),
                                          /*GestureDetector(
                                            onTap: (){
                                              if(SessionManager.getString(Preferences.subscription_status)=="false" ||  SessionManager.getString(Preferences.is_trial)=="true" || widget.comesFrom=="UpgradeView"){
                                                if(isGold==false){
                                                  for(int i=0;i<_products.length;i++){
                                                    if(goldPlanID==_products[i].id){
                                                      print("id ${goldPlanID} == ${_products[i].id}");
                                                      productGoldPlanID= _products[i].id;
                                                      _duplicateProducts=[
                                                        ProductDetails(id:  _products[i].id,
                                                            title:  _products[i].title, description:
                                                            _products[i].description, price:  _products[i].price,
                                                            rawPrice:  _products[i].rawPrice,
                                                            currencyCode:  _products[i].currencyCode)
                                                      ];
                                                    }}
                                                  paymethodMethod(
                                                      goldPlanPrice.toString(),
                                                      goldPlanID.toString(),
                                                      goldPlanType.toString(), "3",productGoldPlanID);
                                                }else {
                                                  paymethodMethod(
                                                      goldPlanPrice.toString(),
                                                      goldPlanID.toString(),
                                                      goldPlanType.toString(), "3",productGoldPlanID);
                                                }
                                              }else{

                                              }

                                              *//*final List<String> productList = [];
                                              Map<String, PurchaseDetails> purchases = Map.fromEntries(_purchases.map((PurchaseDetails purchase) {
                                                if (purchase.pendingCompletePurchase) {
                                                  _inAppPurchase.completePurchase(purchase);
                                                }
                                                return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
                                              }));
                                              productList.addAll(_duplicateProducts.map(
                                                      (ProductDetails productDetails) {
                                                    print("productDetails id::"+productDetails.id.toString());
                                                    print("productDetails::"+productDetails.rawPrice.toString());
                                                    print("productDetails price::"+productDetails.price.toString());
                                                    print("productDetails title::"+productDetails.title);
                                                    late PurchaseParam purchaseParam;
                                                    if (Platform.isAndroid) {
                                                      final oldSubscription = _getOldSubscription(productDetails, purchases);
                                                      purchaseParam = GooglePlayPurchaseParam(
                                                          productDetails: productDetails,
                                                          applicationUserName: null,
                                                          changeSubscriptionParam: (oldSubscription != null)
                                                              ? ChangeSubscriptionParam(
                                                            oldPurchaseDetails: oldSubscription,
                                                            prorationMode: ProrationMode
                                                                .immediateWithTimeProration,
                                                          )
                                                              : null);
                                                    } else {
                                                      purchaseParam = PurchaseParam(
                                                        productDetails: productDetails,
                                                        applicationUserName: null,
                                                      );
                                                    }
                                                    if ((productGoldPlanID == goldPlanID) ){
                                                      _inAppPurchase.buyConsumable(
                                                          purchaseParam: purchaseParam,
                                                          autoConsume: _kAutoConsume || Platform.isIOS);
                                                    }
                                                    return "";

                                                  }
                                              ));*//*
                                            },
                                            child: Container(
                                              height: 26,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(3),
                                                color: SessionManager.getString(Preferences.subscription_status)=="false"||  SessionManager.getString(Preferences.is_trial)=="true" || widget.comesFrom=="UpgradeView"?
                                                AppColor.APP_SUBMIT_COLOR:AppColor.grey.withOpacity(0.4),
                                              ),
                                              child: Center(
                                                child: Utils.mediumHeadingNormalText(
                                                    text: "Buy",
                                                    textSize: 12,
                                                    textAlign: TextAlign.center,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),*/
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 2,right: 2),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(3),
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
                                                    IgnorePointer(
                                                      ignoring: true,
                                                      child: DropdownButton(
                                                        value: platiniumValue,
                                                        dropdownColor :AppColor.white,
                                                        underline: SizedBox(),
                                                        icon: const Icon(Icons.keyboard_arrow_down,color: Colors.black,size: 15,),
                                                        items:  platinumListInApp.map((  Platinium) {
                                                          return DropdownMenuItem(
                                                            value:  Platinium,
                                                            child: Utils.mediumHeadingNormalText(text:  Platinium.planPrice,textSize: 7,fontWeight: FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND),
                                                          );
                                                        }).toList(),

                                                        onChanged: (SubscriptionInAppModel? value) {
                                                          setState(() {
                                                            platiniumValue = value!;
                                                            platinumPlanID=value.id;
                                                            platiniumPrice=value.price;
                                                            platiniumPlanType=value.purchaseType;
                                                            isPlatinium=true;
                                                            print(_products.toString());
                                                            print(_duplicateProducts.toString());
                                                            for(int i=0;i<_products.length;i++){
                                                              if(value.id==_products[i].id){
                                                                productPlatinumPlanID= _products[i].id;
                                                                print("id ${value.id} == ${_products[i].id}");
                                                                _duplicateProducts=[
                                                                  ProductDetails(id:  _products[i].id,
                                                                      title:  _products[i].title, description:
                                                                      _products[i].description, price:  _products[i].price,
                                                                      rawPrice:  _products[i].rawPrice,
                                                                      currencyCode:  _products[i].currencyCode)
                                                                ];
                                                              }
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Gap(14),
                                         /* GestureDetector(
                                            onTap: (){
                                             *//* final List<String> productList = [];
                                              Map<String, PurchaseDetails> purchases = Map.fromEntries(_purchases.map((PurchaseDetails purchase) {
                                                if (purchase.pendingCompletePurchase) {
                                                  _inAppPurchase.completePurchase(purchase);
                                                }
                                                return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
                                              }));
                                              productList.addAll(_duplicateProducts.map(
                                                      (ProductDetails productDetails) {
                                                    print("productDetails id::"+productDetails.id.toString());
                                                    PurchaseParam purchaseParam;
                                                    if (Platform.isAndroid) {
                                                      final oldSubscription = _getOldSubscription(productDetails, purchases);
                                                      purchaseParam = GooglePlayPurchaseParam(
                                                          productDetails: productDetails,
                                                          applicationUserName: null,
                                                          changeSubscriptionParam: (oldSubscription != null)
                                                              ? ChangeSubscriptionParam(
                                                            oldPurchaseDetails: oldSubscription,
                                                            prorationMode: ProrationMode
                                                                .immediateWithTimeProration,
                                                          )
                                                              : null);
                                                    } else {
                                                      purchaseParam = PurchaseParam(
                                                        productDetails: productDetails,
                                                        applicationUserName: null,
                                                      );
                                                    }
                                                    if ((productPlatinumPlanID == platinumPlanID) ){
                                                      _inAppPurchase.buyConsumable(
                                                          purchaseParam: purchaseParam,
                                                          autoConsume: _kAutoConsume || Platform.isIOS);
                                                    }
                                                    return "";
                                                  }
                                              ));*//*
                                              if(SessionManager.getString(Preferences.subscription_status)=="false"||  SessionManager.getString(Preferences.is_trial)=="true" || widget.comesFrom=="UpgradeView"){
                                                if(isPlatinium==false){
                                                  for(int i=0;i<_products.length;i++){
                                                    if(platinumPlanID==_products[i].id){
                                                      print("id ${goldPlanID} == ${_products[i].id}");
                                                      productPlatinumPlanID= _products[i].id;
                                                      _duplicateProducts=[
                                                        ProductDetails(id:  _products[i].id,
                                                            title:  _products[i].title, description:
                                                            _products[i].description, price:  _products[i].price,
                                                            rawPrice:  _products[i].rawPrice,
                                                            currencyCode:  _products[i].currencyCode)
                                                      ];
                                                    }}
                                                  paymethodMethod(
                                                      platiniumPrice.toString(),
                                                      platinumPlanID.toString(),
                                                      platiniumPlanType.toString(),
                                                      "4",productPlatinumPlanID);
                                                }else {
                                                  paymethodMethod(
                                                      platiniumPrice.toString(),
                                                      platinumPlanID.toString(),
                                                      platiniumPlanType.toString(),
                                                      "4",productPlatinumPlanID);
                                                }
                                              }else{

                                              }
                                            },
                                            child: Container(
                                              height: 26,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(3),
                                                color:SessionManager.getString(Preferences.subscription_status)=="false"||  SessionManager.getString(Preferences.is_trial)=="true" || widget.comesFrom=="UpgradeView"?
                                                AppColor.APP_SUBMIT_COLOR:AppColor.grey.withOpacity(0.4),
                                              ),
                                              child: Center(
                                                child: Utils.mediumHeadingNormalText(
                                                    text: "Buy",
                                                    textSize: 12,
                                                    textAlign: TextAlign.center,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),*/
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
                                  flex: 2,
                                  child: Container()),
                              Container(
                                margin: EdgeInsets.only(left: 9),
                                height: MediaQuery.of(context).size.height/1.3,
                                width: 1,
                                color: AppColor.DIVIDER_COLOR,
                              ),
                              Expanded(
                                  flex: 4,
                                  child: Container())
                            ],
                          )
                        ],
                      ),
                      Gap(8),
                      Center(
                        child: Utils
                            .mediumHeadingNormalText(
                            text: UtilStrings
                                .Recurring_Billing_Cancel_at_anytime_By,
                            textSize: 13,
                            fontWeight: FontWeight
                                .w500,  fontFamily: "Poppins",
                            color: HexColor(AppColor.textColor)
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20,right: 20,bottom: 20),
                        child: RichText(
                            text: TextSpan(
                                style: TextStyle(fontSize: 13,
                                    fontWeight: FontWeight
                                        .w400,
                                    color: AppColor
                                        .grey),
                                children: [
                                 /* TextSpan(
                                      text:
                                      UtilStrings.Recurring_Billing_Cancel_at_anytime_By,),*/
                                  TextSpan(
                                      text:
                                    Platform.isIOS ? UtilStrings.PRIVACY_TEXT_IOS:UtilStrings.PRIVACY_TEXT_Android,
                                    style: TextStyle(fontSize: 13,
                                fontWeight: FontWeight
                                    .w400,  fontFamily: "Poppins",
                                color: HexColor(AppColor.textColor).withOpacity(0.8)),),
                                          TextSpan( recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              // lauch_url(url_terms_of_use);
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>PrivacyPolicyScreen()));
                                            },
                                      text: UtilStrings.privacy,style: TextStyle(fontSize: 13,
                                              fontWeight: FontWeight
                                                  .w400,decoration: TextDecoration.underline,
                                              color: AppColor
                                                  .SideTextColor , fontFamily: "Poppins",),
                                      ), TextSpan(
                                      text: UtilStrings.AND,style: TextStyle(fontSize: 13,
                                      fontWeight: FontWeight
                                          .w400,  fontFamily: "Poppins",
                                      color: HexColor(AppColor.textColor).withOpacity(0.8)),
                                      ),
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // lauch_url(url_terms_of_use);
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsAndConditionScreen()));
                                      },
                                      text:UtilStrings.Terms,style: TextStyle(fontSize: 13,
                                      fontWeight: FontWeight
                                          .w400,decoration: TextDecoration.underline,
                                      color: AppColor
                                          .SideTextColor),
                                      ),
                                         ])),
                      )
                    ],
                  )
              ),
            ),
            Utils.progressDialogFullScreen(context, isLoading),
          ],
        ),
      ),
    );

  }



  Future<void> consume(String id) async {
    await ConsumableStore.consume(id);
    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _consumables = consumables;
    });
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }
  @override
  void dispose() {
    if (Platform.isIOS) {
      var iosPlatformAddition = _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription!.cancel();
    super.dispose();
  }
  void deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify purchase details before delivering the product.
    if ((purchaseDetails.productID == com_likeplaylikeplay_basicthreemonth)) {
      await ConsumableStore.save(purchaseDetails.purchaseID!);
      List<String> consumables = await ConsumableStore.load();
      setState(() {
        _purchasePending = false;
        _consumables = consumables;
      });
    } else {
      setState(() {
        _purchases.add(purchaseDetails);
        _purchasePending = false;
      });
    }

  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }
///////////call your api here....

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    /* purchaseDetails.verificationData.serverVerificationData
    is the purchase token on Android.*/
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    setState(() {
      purchaseToken= purchaseDetails.verificationData.serverVerificationData;
      subscriptionStatus=true;
    });

    transactionDate=purchaseDetails.transactionDate.toString();
      setState(() {
        isLoading=true;
      });
      // Here android Subscription Api
    print("purchaseToken ::"+purchaseToken.toString());
    print("productID ::"+purchaseDetails.productID.toString());
    print("subscriptionType ::"+subscriptionType);
    print("transactionDate ::"+transactionDate);
    print("purchaseTypeD ::"+purchaseTypeD);
    print("subscriptionAmmount ::"+subscriptionAmmount);

    if(Platform.isAndroid){
      subscriptionPresenter?.onSubscriptionAndroid(purchaseToken,purchaseDetails.productID,
          subscriptionType,transactionDate,purchaseTypeD,subscriptionAmmount);
    }else{
      subscriptionPresenter?.onSubscriptionIos(purchaseToken,
          subscriptionAmmount,subscriptionType,purchaseTypeD);
    }


    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    setState(() {
      // isLoading=false;
    });
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    });
  }

  Future<void> confirmPriceChange(BuildContext context) async {
    if (Platform.isAndroid) {
      final InAppPurchaseAndroidPlatformAddition androidAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
    /*  var priceChangeConfirmationResult =
      await androidAddition.launchPriceChangeConfirmationFlow(
        sku: 'purchaseId',
      );*/
     /* if (priceChangeConfirmationResult.responseCode == BillingResponse.ok) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Price change accepted'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            priceChangeConfirmationResult.debugMessage ??
                "Price change failed with code ${priceChangeConfirmationResult.responseCode}",
          ),
        ));
      }*/
    }
    if (Platform.isIOS) {
      var iapStoreKitPlatformAddition = _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iapStoreKitPlatformAddition.showPriceConsentIfNeeded();
    }
  }

/*  GooglePlayPurchaseDetails? _getOldSubscription(
      ProductDetails productDetails, Map<String, PurchaseDetails> purchases) {
    GooglePlayPurchaseDetails? oldSubscription;
    // if (productDetails.id == basePlan180 &&
    //     purchases[_kGoldSubscriptionId] != null) {
    //   oldSubscription =
    //       purchases[_kGoldSubscriptionId] as GooglePlayPurchaseDetails;
    // } else if (productDetails.id == _kGoldSubscriptionId &&
    //     purchases[basePlan180] != null) {
    //   oldSubscription = purchases[basePlan180] as GooglePlayPurchaseDetails;
    // }

    return oldSubscription;
  }*/
  GooglePlayPurchaseDetails? _getOldSubscription(
      ProductDetails productDetails, Map<String, PurchaseDetails> purchases,String productId) {
    // This is just to demonstrate a subscription upgrade or downgrade.
    // This method assumes that you have only 2 subscriptions under a group, 'subscription_silver' & 'subscription_gold'.
    // The 'subscription_silver' subscription can be upgraded to 'subscription_gold' and
    // the 'subscription_gold' subscription can be downgraded to 'subscription_silver'.
    // Please remember to replace the logic of finding the old subscription Id as per your app.
    // The old subscription is only required on Android since Apple handles this internally
    // by using the subscription group feature in iTunesConnect.
   GooglePlayPurchaseDetails? oldSubscription;
   // _kSilverSubscriptionId==clickId
   //_kGoldSubscriptionId==old ID
  if (productDetails.id == productId && purchases[SessionManager.getString(Preferences.plan_id)] != null) {
      oldSubscription = purchases[SessionManager.getString(Preferences.plan_id)]! as GooglePlayPurchaseDetails;
    } else if (productDetails.id == SessionManager.getString(Preferences.plan_id) &&
        purchases[productId] != null) {
      oldSubscription =
      purchases[productId]! as GooglePlayPurchaseDetails;
    }
    return oldSubscription;
}

  @override
  onPayStackPayment(PaymentPayStackResponse response) {

  }

  @override
  onSubscriptionSuccess(SuccessResponse response) {
    print("onSubscriptionSuccess ::"+response.message.toString());
    setState(() {
      isLoading=false;
    });
    if(response.status==200){
      Navigator.pushReplacementNamed(context, RouteName.feed_screen);
      subscriptionPresenter!.doUserResponseData(SessionManager.getString(Preferences.USER_ID));
        Utils.customDialog(context,message:response.message.toString());
    }

  }

  void paymethodMethod(String amount,String planCode,String purchaseType, String subscriptionTypeD, String productId) {
  print("amount==>"+amount.toString());
     print("planCode==>"+planCode.toString());
     print("purchaseType==>"+purchaseType.toString());
     print("subscriptionType==>"+subscriptionType.toString());
    setState(() {
      subscriptionAmmount=amount;
      purchaseTypeD=purchaseType;
      subscriptionType=subscriptionTypeD;
    });
    final List<String> productList = [];
    Map<String, PurchaseDetails> purchases = Map.fromEntries(_purchases.map((PurchaseDetails purchase) {
      if (purchase.pendingCompletePurchase) {
        _inAppPurchase.completePurchase(purchase);
      }
      return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    }));

    productList.addAll(_duplicateProducts.map(
            (ProductDetails productDetails) {
          print("productDetails id::"+productDetails.id.toString());
          PurchaseParam purchaseParam;
          if (Platform.isAndroid) {
            final oldSubscription = _getOldSubscription(productDetails, purchases,productId);
            purchaseParam = GooglePlayPurchaseParam(
                productDetails: productDetails,
                applicationUserName: null,
                changeSubscriptionParam: (oldSubscription != null)
                    ? ChangeSubscriptionParam(
                  oldPurchaseDetails: oldSubscription,
                  prorationMode: ProrationMode
                      .immediateWithTimeProration,
                )
                    : null);
          } else {
            purchaseParam = PurchaseParam(
              productDetails: productDetails,
              applicationUserName: null,
            );
          }
          if(productId==planCode){
         /*   _inAppPurchase.buyConsumable(
                purchaseParam: purchaseParam,
                autoConsume: _kAutoConsume || Platform.isIOS);*/
            _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam,);
          }
          return "";

        }
    ));
  }

  @override
  onError(String msg, int status) {
    print("onError ::"+msg.toString());
    setState(() {
      isLoading=false;
    });
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
      DateTime loginDate = DateTime.parse(response.data!.createdAt.toString());
      DateTime currentDate = DateTime.now();
      final result = currentDate.difference(loginDate).inDays;
      if(response.data!.subscriptionStatus==false){
        if(result<3){
          SessionManager.setString(Preferences.subscription_status, "true");
          SessionManager.setString(Preferences.subscription_plan, "4");
          SessionManager.setString(Preferences.plan_ammount,"");
          SessionManager.setString(Preferences.plan_id, "");
          SessionManager.setString(Preferences.is_trial, "true");
        }else{
          SessionManager.setString(Preferences.subscription_status, response.data!.subscriptionStatus.toString());
          SessionManager.setString(Preferences.subscription_plan, "");
          SessionManager.setString(Preferences.plan_ammount, "");
          SessionManager.setString(Preferences.plan_id, "");
          SessionManager.setString(Preferences.is_trial, "false");
        }
      }
      else if(response.data!.subscriptionStatus==false && response.data!.subscriptions!.isEmpty){
        SessionManager.setString(Preferences.subscription_status, response.data!.subscriptionStatus.toString());
        SessionManager.setString(Preferences.subscription_plan, "");
        SessionManager.setString(Preferences.plan_ammount, "");
        SessionManager.setString(Preferences.plan_id, "");
        SessionManager.setString(Preferences.is_trial, "false");
      }
      else if(response.data!.subscriptionStatus==true && response.data!.subscriptions!.isNotEmpty){
        SessionManager.setString(Preferences.subscription_status, response.data!.subscriptionStatus.toString());
        SessionManager.setString(Preferences.subscription_plan, response.data!.subscriptions![0].supscriptionType.toString());
        SessionManager.setString(Preferences.plan_ammount, response.data!.subscriptions![0].amount.toString());
        SessionManager.setString(Preferences.plan_id, response.data!.subscriptions![0].productId.toString());
        SessionManager.setString(Preferences.is_trial, "false");
      }else{
        SessionManager.setString(Preferences.subscription_status, response.data!.subscriptionStatus.toString());
        SessionManager.setString(Preferences.subscription_plan, "");
        SessionManager.setString(Preferences.plan_ammount, "");
        SessionManager.setString(Preferences.is_trial, "false");
        SessionManager.setString(Preferences.plan_id, "");
      }

    }
  }

}
class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
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


