import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/module/home/home.dart';
import 'package:likeplay/module/home/register/presenter/profile_update_presenter.dart';
import 'package:likeplay/module/model/choice_data.dart';
import 'package:likeplay/module/model/photo_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import 'package:likeplay/module/model/update_profile_response.dart';
import 'package:likeplay/module/model/user_profile_response.dart';
import 'package:likeplay/utils/color_utils.dart';
import 'package:likeplay/utils/constant_lists.dart';
import 'package:likeplay/utils/responsive.dart';
import 'package:likeplay/utils/string_utils.dart';
import 'package:likeplay/utils/utils.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../model/phone_verification_response.dart';
class PartnerAttributesScreen extends StatefulWidget {
  int? viewType;
  PartnerAttributesScreen({Key? key,this.viewType}) : super(key: key);
  @override
  State<PartnerAttributesScreen> createState() => _PartnerAttributesScreenState();
}

class _PartnerAttributesScreenState extends State<PartnerAttributesScreen> implements ProfileUpdateInterface {
  bool isLoading = false;
  int? _sizetag=0;
  int? _backend=0;
  int? _facial=0;
  int? _height=0;
  int? _front=0;
  int? _glasses=0;
  ProfileUpdatePresenter? profileUpdatePresenter;

  @override
  void initState() {
    super.initState();
    profileUpdatePresenter=ProfileUpdatePresenter(this);
  }
  List<ChoiceData> physicalsizePartner = [
    ChoiceData("Big",  HexColor("#F0F0F0"),  HexColor("#000000")),
    ChoiceData("Medium",  HexColor("#F0F0F0"),  HexColor("#000000")),
    ChoiceData("Small", HexColor("##F0F0F0"),  HexColor("#000000")),
  ];

  List<ChoiceData> backEndPartner = [
    ChoiceData("Well endowed",  HexColor("#F0F0F0"),  HexColor("#000000")),
    ChoiceData("Normal",  HexColor("#F0F0F0"),  HexColor("#000000")),
    ChoiceData("Comfortable", HexColor("##F0F0F0"),  HexColor("#000000")),
    ChoiceData("Flat", HexColor("##F0F0F0"),  HexColor("#000000")),
  ];
  List<ChoiceData> facialPartner = [
    ChoiceData("Beautiful",  HexColor("#F0F0F0"),  HexColor("#000000")),
    ChoiceData("Good-looking",  HexColor("#F0F0F0"),  HexColor("#000000")),
    ChoiceData("Okay", HexColor("##F0F0F0"),  HexColor("#000000")),
    ChoiceData("Just okay", HexColor("##F0F0F0"),  HexColor("#000000")),
    ChoiceData("Not my strong suit", HexColor("##F0F0F0"),  HexColor("#000000")),
  ];
  List<ChoiceData> heightsPartner  = [
    ChoiceData("Tall",  HexColor("#F0F0F0"),  HexColor("#000000")),
    ChoiceData("Medium",  HexColor("#F0F0F0"),  HexColor("#000000")),
    ChoiceData("Short", HexColor("##F0F0F0"),  HexColor("#000000")),
  ];
  List<ChoiceData> frontPartner  = [
    ChoiceData("Well endowed",  HexColor("#F0F0F0"),  HexColor("#000000")),
    ChoiceData("Normal",  HexColor("#F0F0F0"),  HexColor("#000000")),
    ChoiceData("Small", HexColor("##F0F0F0"),  HexColor("#000000")),
  ];
  List<ChoiceData> glassesPartner  = [
    ChoiceData("Yes",  HexColor("#F0F0F0"),  HexColor("#000000")),
    ChoiceData("No",  HexColor("#F0F0F0"),  HexColor("#000000")),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return SingleChildScrollView(
        child:
        Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ResponsiveRowColumn(
                rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                rowCrossAxisAlignment: CrossAxisAlignment.center,
                layout: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                    ? ResponsiveRowColumnType.COLUMN
                    : ResponsiveRowColumnType.ROW,
                children: [
                  ResponsiveRowColumnItem(
                      rowFlex: 2, child: Row(
                    mainAxisAlignment: Responsive().getResponsiveValue(
                        forLargeScreen: MainAxisAlignment.start,
                        forShortScreen: MainAxisAlignment.center,
                        context: context),
                    children: [
                      Gap(Responsive().getResponsiveValue(
                          forLargeScreen: 42.0,
                          forShortScreen: 0.0,
                          context: context)),
                      Column(
                        crossAxisAlignment: Responsive().getResponsiveValue(
                            forLargeScreen: CrossAxisAlignment.start,
                            forShortScreen: CrossAxisAlignment.center,
                            context: context),
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Gap(Responsive().getResponsiveValue(
                              forLargeScreen: 0.0,
                              forShortScreen: 40.0,
                              context: context)),
                          Gap(Responsive().getResponsiveValue(
                              forLargeScreen: 0.0,
                              forShortScreen: 8.0,
                              context: context),),
                        ],
                      )
                    ],)),
                  ResponsiveRowColumnItem(
                    rowFlex: 1, child: SizedBox(
                   /* height: Responsive().getResponsiveValue(
                        forLargeScreen: MediaQuery
                            .of(context)
                            .size
                            .height / 1.1,
                        forShortScreen: MediaQuery
                            .of(context)
                            .size
                            .height,
                        forMobLandScapeMode: MediaQuery
                            .of(context)
                            .size
                            .height / 1.2,
                        forMediumScreen: MediaQuery
                            .of(context)
                            .size
                            .height / 1.2,
                        forTabletScreen: MediaQuery
                            .of(context)
                            .size
                            .height,
                        context: context),
                    width: Responsive().getResponsiveValue(
                        forLargeScreen: MediaQuery
                            .of(context)
                            .size
                            .width / 1.2,
                        forShortScreen: MediaQuery
                            .of(context)
                            .size
                            .width,
                        forMobLandScapeMode: MediaQuery
                            .of(context)
                            .size
                            .width / 2,
                        forMediumScreen: MediaQuery
                            .of(context)
                            .size
                            .width / 2,
                        forTabletScreen: MediaQuery
                            .of(context)
                            .size
                            .width / 2,
                        context: context),*/
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Gap(Responsive().getResponsiveValue(
                            forLargeScreen: 32.0,
                            forShortScreen: 22.0,
                            context: context)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Utils.mediumHeadingNormalText(
                                text: UtilStrings.hundred_Complete,
                                fontFamily: 'Poppins',
                                color: AppColor.white,
                                left: Responsive().getResponsiveValue(
                                    forLargeScreen: 0.0,
                                    forShortScreen: 22.0,
                                    forMobLandScapeMode: 22.0,
                                    forMediumScreen: 22.0,
                                    forTabletScreen: 22.0,
                                    context: context),
                                textSize: 12),
                          ],),
                        const Gap(4),
                        Container(
                            alignment: Alignment.centerLeft,
                            width: Responsive().getResponsiveValue(
                                forLargeScreen: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2,
                                forShortScreen: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                forMobLandScapeMode: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 4.2,
                                forMediumScreen: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2,
                                forTabletScreen: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2,
                                context: context),
                            margin: EdgeInsets.only(left: Responsive().getResponsiveValue(
                                forLargeScreen: 0.0,
                                forShortScreen: 22.0,
                                forMobLandScapeMode: 22.0,
                                forMediumScreen: 22.0,
                                forTabletScreen: 22.0,
                                context: context), right: Responsive().getResponsiveValue(
                                forLargeScreen: 36.0,
                                forShortScreen: 22.0,
                                forMobLandScapeMode: 22.0,
                                forMediumScreen: 22.0,
                                forTabletScreen: 22.0,
                                context: context),),
                            child:Image.asset(
                              'assets/images/bg_hundred.png',
                              width: Responsive().getResponsiveValue(
                                  forLargeScreen: size.width / 2,
                                  forShortScreen: size.width / 1.1,
                                  forMobLandScapeMode: size.width / 2,
                                  forMediumScreen: size.width / 2,
                                  forTabletScreen: size.width / 2.1,
                                  context: context),
                            )),
                        Gap(10),
                        Container(
                            alignment: Alignment.centerLeft,
                            width: Responsive().getResponsiveValue(
                                forLargeScreen: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2,
                                forShortScreen: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                forMobLandScapeMode: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 4.2,
                                forMediumScreen: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2,
                                forTabletScreen: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2,
                                context: context),
                            child:Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Utils.mediumHeadingNormalText(
                                    text: UtilStrings.Physical_Attributes_in_your_Partner,
                                    fontFamily: 'Poppins',
                                    color: AppColor.white,
                                    left: Responsive().getResponsiveValue(
                                        forLargeScreen: 0.0,
                                        forShortScreen: 22.0,
                                        forMobLandScapeMode: 22.0,
                                        forMediumScreen: 22.0,
                                        forTabletScreen: 22.0,
                                        context: context),
                                    textSize: 14),
                              ],)),
                        Gap(6),
                        Container(
                            alignment: Alignment.centerLeft,
                            width: Responsive().getResponsiveValue(
                                forLargeScreen: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2,
                                forShortScreen: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                forMobLandScapeMode: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 4.2,
                                forMediumScreen: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2,
                                forTabletScreen: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2,
                                context: context),
                            child: Utils.mediumHeadingNormalText(
                                text: UtilStrings
                                    .simple_and_fun_questions_help_us_carefully,
                                fontFamily: 'Poppins',
                                color: AppColor.white,
                                left: Responsive().getResponsiveValue(
                                    forLargeScreen: 0.0,
                                    forShortScreen: 22.0,
                                    forMobLandScapeMode: 22.0,
                                    forMediumScreen: 22.0,
                                    forTabletScreen: 22.0,
                                    context: context),
                                right: Responsive().getResponsiveValue(
                                    forLargeScreen: 36.0,
                                    forShortScreen: 22.0,
                                    forMobLandScapeMode: 22.0,
                                    forMediumScreen: 22.0,
                                    forTabletScreen: 22.0,
                                    context: context),
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.normal,
                                textSize: 10)),
                        Gap(6),
                        Container(
                            alignment: Alignment.centerLeft,
                            width: Responsive().getResponsiveValue(
                                forLargeScreen: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2,
                                forShortScreen: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                forMobLandScapeMode: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 4.2,
                                forMediumScreen: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2,
                                forTabletScreen: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2,
                                context: context),
                            child: Utils.mediumHeadingNormalText(
                                text: UtilStrings
                                    .only_take_a_minute_and_we_means,
                                left: Responsive().getResponsiveValue(
                                    forLargeScreen: 0.0,
                                    forShortScreen: 22.0,
                                    forMobLandScapeMode: 22.0,
                                    forMediumScreen: 22.0,
                                    forTabletScreen: 22.0,
                                    context: context),
                                right: Responsive().getResponsiveValue(
                                    forLargeScreen: 36.0,
                                    forShortScreen: 22.0,
                                    forMobLandScapeMode: 22.0,
                                    forMediumScreen: 22.0,
                                    forTabletScreen: 22.0,
                                    context: context),
                                fontFamily: 'Poppins',
                                color: AppColor.white,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.normal,
                                textSize: 10)),
                        Gap(10),
                        Container(
                          width: Responsive().getResponsiveValue(
                              forLargeScreen: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 2,
                              forShortScreen: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              forMobLandScapeMode: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 4.2,
                              forMediumScreen: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 2,
                              forTabletScreen: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 2,
                              context: context),
                          margin: EdgeInsets.only(
                            left: Responsive().getResponsiveValue(
                                forLargeScreen: 0.0,
                                forShortScreen: 16.0,
                                forMobLandScapeMode: 0.0,
                                forMediumScreen: 0.0,
                                forTabletScreen: 0.0,
                                context: context),
                            right: Responsive().getResponsiveValue(
                                forLargeScreen: 36.0,
                                forShortScreen: 16.0,
                                forMobLandScapeMode: 0.0,
                                forMediumScreen: 0.0,
                                forTabletScreen: 0.0,
                                context: context),
                          ),
                          padding: EdgeInsets.only(left: Responsive()
                              .getResponsiveValue(
                              forLargeScreen: 12.0,
                              forShortScreen: 12.0,
                              forMobLandScapeMode: 12.0,
                              forMediumScreen: 12.0,
                              forTabletScreen: 12.0,
                              context: context),
                            top: Responsive().getResponsiveValue(
                                forLargeScreen: 16.0,
                                forShortScreen: 16.0,
                                context: context),
                            bottom: Responsive().getResponsiveValue(
                                forLargeScreen: 12.0,
                                forShortScreen: 32.0,
                                forMobLandScapeMode: 12.0,
                                forMediumScreen: 12.0,
                                forTabletScreen: 12.0,
                                context: context),),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white,
                                width: 1.0,
                                style: BorderStyle.solid
                            ),
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: Responsive().getResponsiveValue(
                                  forLargeScreen: 8.0,
                                  forShortScreen: 8.0,
                                  context: context),
                              top: Responsive().getResponsiveValue(
                                  forLargeScreen: 0.0,
                                  forShortScreen: 0.0,
                                  context: context),
                              right: Responsive().getResponsiveValue(
                                  forLargeScreen: 0.0,
                                  forShortScreen: 20.0,
                                  context: context),),
                            child: Stack(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Utils.mediumHeadingNormalText(
                                      text: UtilStrings.Partner_Physical_Attributes,
                                      fontFamily: 'Poppins',
                                      color: AppColor.black,
                                      textSize: 14),
                                  Gap(10),
                                  Utils.mediumHeadingStarNormalText(
                                      text: UtilStrings.Size,
                                      fontFamily: 'Poppins',
                                      color: AppColor.black,
                                      textSize: 10),
                                  Container(
                                    height: 30,
                                    child: _buildChipSize(physicalsizePartner,_sizetag!),
                                  ),
                                  Gap(10),
                                  Utils.mediumHeadingStarNormalText(
                                      text: UtilStrings.Back_End,
                                      fontFamily: 'Poppins',
                                      color: AppColor.black,
                                      textSize: 10,),
                                  Container(
                                    height: 30,
                                    child: _buildChipsBackEnd(backEndPartner,_backend!),
                                  ),
                                  Gap(10),
                                  Utils.mediumHeadingStarNormalText(
                                      text: UtilStrings.Facial,
                                      fontFamily: 'Poppins',
                                      color: AppColor.black,
                                      textSize: 10,),
                                  Container(
                                    height: 30,
                                    child: _buildChipsFacial(facialPartner,_facial!),
                                  ),
                                  Gap(10),
                                  Utils.mediumHeadingStarNormalText(
                                      text: UtilStrings.Height,
                                      fontFamily: 'Poppins',
                                      color: AppColor.black,
                                      textSize: 10,),
                                  Container(
                                    height: 30,
                                    child: _buildChipsHeight(heightsPartner,_height!),
                                  ),
                                  Gap(10),
                                  Utils.mediumHeadingStarNormalText(
                                      text: UtilStrings.Front,
                                      fontFamily: 'Poppins',
                                      color: AppColor.black,
                                      textSize: 10),
                                  Container(
                                    height: 30,
                                    child: _buildChipsFront(frontPartner,_front!),
                                  ),
                                  Gap(10),
                                  Utils.mediumHeadingStarNormalText(
                                      text: UtilStrings.Glasses,
                                      fontFamily: 'Poppins',
                                      color: AppColor.black,
                                      textSize: 10),
                                  Container(
                                    height: 30,
                                    child: _buildChipsGlasses(glassesPartner,_glasses!),
                                  ),
                                  Gap(16),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if(isSize==false){
                                            Utils.customDialog(context,message:UtilStrings.Please_select_size );
                                          }else if(isBackend==false){
                                            Utils.customDialog(context,message:UtilStrings.Please_select_backend );
                                          }else if(isFacial==false){
                                            Utils.customDialog(context,message:UtilStrings.Please_select_facial );
                                          }else if(isHeight==false){
                                            Utils.customDialog(context,message:UtilStrings.Please_select_height );
                                          }else if(isFront==false){
                                            Utils.customDialog(context,message:UtilStrings.Please_select_front );
                                          }else if(isGlasses==false){
                                            Utils.customDialog(context,message:UtilStrings.Please_select_glasses );
                                          }else{
                                            setState(() {
                                              isLoading=true;
                                            });
                                            profileUpdatePresenter?.doUpdatePartnersPhysicalQuestions(
                                              size:physicalsizePartner[_sizetag!].label,
                                              back_end:backEndPartner[_backend!].label,
                                              facial:facialPartner[_facial!].label,
                                              height:heightsPartner[_height!].label,
                                              front:frontPartner[_front!].label,
                                              glasses:glassesPartner[_glasses!].label,
                                            );
                                          }

                                         /* Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                                            viewType:19,
                                          )));*/
                                        },
                                        child: Container(
                                          height: 46,
                                          width: Responsive()
                                              .getResponsiveValue(
                                              forLargeScreen: size.width / 9.4,
                                              forShortScreen: size.width / 2.6,
                                              forMobLandScapeMode: size.width /
                                                  2.6,
                                              forMediumScreen: size.width / 2.6,
                                              forTabletScreen: size.width / 5.0,
                                              context: context),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: HexColor("#FF483C"),
                                              border: Border.all(
                                                  color: HexColor("#FF483C")),
                                              borderRadius: BorderRadius
                                                  .circular(10)
                                          ),
                                          child: Utils.mediumHeadingNormalText(
                                              text: "Next",
                                              color: AppColor.white,
                                              fontFamily: 'Poppins',
                                              textSize: 13),
                                        ),),
                                    ],),
                                  Gap(Responsive().getResponsiveValue(
                                      forLargeScreen: 12.0,
                                      forShortScreen: 32.0,
                                      context: context)),
                                ],
                              ),
                              Utils.progressDialog(context, isLoading, type: 0)
                            ],),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ),

                ],
              ),
              Gap(54)
            ],),
        ],)


    );
  }

  validation(BuildContext context) {


  }
  bool isSize=false;
  bool isBackend=false;
  bool isFacial =false;
  bool isHeight =false;
  bool isFront =false;
  bool isGlasses =false;
  Widget _buildChipSize(List<ChoiceData> list,int type) {
    List<Widget> chips = [];
    for (int i = 0; i < list.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        padding: EdgeInsets.zero,
        selected: _sizetag == i,
        label:  Text(
          list[i].label!,
        ),
        labelStyle:TextStyle(
            color:  Colors.black,
            fontFamily: 'Poppins',
            fontSize: 10
        ) ,
        elevation: 0,
        pressElevation: 0,
        shadowColor: HexColor("#F0F0F0"),
        selectedShadowColor: HexColor("#F0F0F0"),
        backgroundColor: HexColor("#F0F0F0"),
        selectedColor:  list[i].color!,
        onSelected: (bool selected) {
          setState(() {
              _sizetag = i;
              list[i].color=HexColor("#A8580F");
              list[i].textColor=HexColor("#F0F0F0");
              isSize=true;
          });
        },
      );

      chips.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: choiceChip
      ));
    }

    return ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }
  Widget _buildChipsBackEnd(List<ChoiceData> list,int type) {
    List<Widget> chips = [];
    for (int i = 0; i < list.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        padding: EdgeInsets.zero,
        selected: _backend == i,
        label:  Text(
          list[i].label!,
        ),
        labelStyle:TextStyle(
            color:  Colors.black,
            fontFamily: 'Poppins',
            fontSize: 10
        ) ,
        elevation: 0,
        pressElevation: 0,
        shadowColor: HexColor("#F0F0F0"),
        selectedShadowColor: HexColor("#F0F0F0"),
        backgroundColor: HexColor("#F0F0F0"),
        selectedColor:  list[i].color!,
        onSelected: (bool selected) {
          setState(() {
              _backend = i;
              list[i].color=HexColor("#A8580F");
              list[i].textColor=HexColor("#F0F0F0");
               isBackend=true;
          });
        },
      );

      chips.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: choiceChip
      ));
    }

    return ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }
  Widget _buildChipsFacial(List<ChoiceData> list,int type) {
    List<Widget> chips = [];
    for (int i = 0; i < list.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        padding: EdgeInsets.zero,
        selected: _facial == i,
        label:  Text(
          list[i].label!,
        ),
        labelStyle:TextStyle(
            color:  Colors.black,
            fontFamily: 'Poppins',
            fontSize: 10
        ) ,
        elevation: 0,
        pressElevation: 0,
        shadowColor: HexColor("#F0F0F0"),
        selectedShadowColor: HexColor("#F0F0F0"),
        backgroundColor: HexColor("#F0F0F0"),
        selectedColor:  list[i].color!,
        onSelected: (bool selected) {
          setState(() {
              _facial = i;
              list[i].color=HexColor("#A8580F");
              list[i].textColor=HexColor("#F0F0F0");
               isFacial =true;
          });
        },
      );

      chips.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: choiceChip
      ));
    }

    return ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }
  Widget _buildChipsHeight(List<ChoiceData> list,int type) {
    List<Widget> chips = [];
    for (int i = 0; i < list.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        padding: EdgeInsets.zero,
        selected: _height == i,
        label:  Text(
          list[i].label!,
        ),
        labelStyle:TextStyle(
            color:  Colors.black,
            fontFamily: 'Poppins',
            fontSize: 10
        ) ,
        elevation: 0,
        pressElevation: 0,
        shadowColor: HexColor("#F0F0F0"),
        selectedShadowColor: HexColor("#F0F0F0"),
        backgroundColor: HexColor("#F0F0F0"),
        selectedColor:  list[i].color!,
        onSelected: (bool selected) {
          setState(() {
              _height = i;
              list[i].color=HexColor("#A8580F");
              list[i].textColor=HexColor("#F0F0F0");
               isHeight =true;
          });
        },
      );

      chips.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: choiceChip
      ));
    }

    return ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }
  Widget _buildChipsFront(List<ChoiceData> list,int type) {
    List<Widget> chips = [];
    for (int i = 0; i < list.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        padding: EdgeInsets.zero,
        selected: _front == i,
        label:  Text(
          list[i].label!,
        ),
        labelStyle:TextStyle(
            color:  Colors.black,
            fontFamily: 'Poppins',
            fontSize: 10
        ) ,
        elevation: 0,
        pressElevation: 0,
        shadowColor: HexColor("#F0F0F0"),
        selectedShadowColor: HexColor("#F0F0F0"),
        backgroundColor: HexColor("#F0F0F0"),
        selectedColor:  list[i].color!,
        onSelected: (bool selected) {
          setState(() {
              _front = i;
              list[i].color=HexColor("#A8580F");
              list[i].textColor=HexColor("#F0F0F0");
               isFront =true;
          });
        },
      );

      chips.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: choiceChip
      ));
    }

    return ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }
  Widget _buildChipsGlasses(List<ChoiceData> list,int type) {
    List<Widget> chips = [];
    for (int i = 0; i < list.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        padding: EdgeInsets.zero,
        selected: _glasses == i,
        label:  Text(
          list[i].label!,
        ),
        labelStyle:TextStyle(
            color:  Colors.black,
            fontFamily: 'Poppins',
            fontSize: 10
        ) ,
        elevation: 0,
        pressElevation: 0,
        shadowColor: HexColor("#F0F0F0"),
        selectedShadowColor: HexColor("#F0F0F0"),
        backgroundColor: HexColor("#F0F0F0"),
        selectedColor:  list[i].color!,
        onSelected: (bool selected) {
          setState(() {
              _glasses = i;
              list[i].color=HexColor("#A8580F");
              list[i].textColor=HexColor("#F0F0F0");
               isGlasses =true;

          });
        },
      );

      chips.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: choiceChip
      ));
    }

    return ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }

  @override
  onDeletePhoto(SuccessResponse response) {

  }

  @override
  onError(String msg, int status) {
   setState(() {
     isLoading=false;
   });
  }

  @override
  onProfileUpdateResponse(UpdateProfileResponse response) {

  }

  @override
  onUpdateusersQuestions(SuccessResponse response) {
    setState(() {
      isLoading=false;
    if(response.status==200){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
        viewType:19,
      )));
    }
    });
  }

  @override
  onUploadMediaFile(PhotoResponse response) {

  }
  @override
  onUpdateVerificationQuestions(SuccessResponse response) {

  }
  @override
  onUpdateFloorStatusData(SuccessResponse response) {

  }

  @override
  onUserProfileData(UserProfileResponse response) {

  }
  @override
  onChooseAnyOne(SuccessResponse response) {
  }
  @override
  onVerificationPhoto(SuccessResponse response) {

  }
  @override
  onVerificationFace(SuccessResponse response) {

  }
  @override
  onVerificationPhone(PhoneVerificationResponse response) {

  }
  @override
  onVerificationOtp(SuccessResponse response) {

  }
  @override
  onVerificationFacebook(SuccessResponse response) {

  }

  @override
  onVerifyUserToken(SuccessResponse response) {

  }
}
