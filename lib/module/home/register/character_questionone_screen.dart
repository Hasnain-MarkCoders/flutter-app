import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/module/home/register/presenter/profile_update_presenter.dart';
import 'package:likeplay/module/model/choice_data.dart';
import 'package:likeplay/module/model/photo_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import 'package:likeplay/module/model/update_profile_response.dart';
import 'package:likeplay/utils/color_utils.dart';
import 'package:likeplay/utils/constant_lists.dart';
import 'package:likeplay/utils/responsive.dart';
import 'package:likeplay/utils/string_utils.dart';
import 'package:likeplay/utils/utils.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../model/phone_verification_response.dart';
import '../../model/user_profile_response.dart';
import '../home.dart';
class CharacterQuestionsOneScreen extends StatefulWidget {
  int? viewType;
  CharacterQuestionsOneScreen({Key? key,this.viewType}) : super(key: key);
  @override
  State<CharacterQuestionsOneScreen> createState() => _CharacterQuestionsOneScreenState();
}

class _CharacterQuestionsOneScreenState extends State<CharacterQuestionsOneScreen> implements ProfileUpdateInterface{
  bool isLoading = false;
  int? _charactertagOne=0;
  int? _charactertagTwo=0;
  int? _charactertagThree=0;
  int? _charactertagFour=0;
  int? _charactertagFive=0;
  ProfileUpdatePresenter? profileUpdatePresenter;
  bool isCharactertagOne=false;
  bool isCharactertagTwo=false;
  bool isCharactertagThree =false;
  bool isCharactertagFour =false;
  bool isCharactertagFive =false;


  List<ChoiceData> charactertagOneForTwo = [
    ChoiceData("Yeah 100%",  HexColor("#F0F0F0"),  HexColor("#000000")),
    ChoiceData("Occasionally 50-50",  HexColor("#F0F0F0"),  HexColor("#000000")),
    ChoiceData("No Way", HexColor("##F0F0F0"), HexColor("#000000")),
  ];List<ChoiceData> charactertagTwoForTwo = [
    ChoiceData("Yeah 100%",  HexColor("#F0F0F0"),  HexColor("#000000")),
    ChoiceData("Occasionally 50-50",  HexColor("#F0F0F0"),  HexColor("#000000")),
    ChoiceData("No Way", HexColor("##F0F0F0"), HexColor("#000000")),
  ];List<ChoiceData> charactertagThreeForTwo = [
    ChoiceData("Yeah 100%",  HexColor("#F0F0F0"),  HexColor("#000000")),
    ChoiceData("Occasionally 50-50",  HexColor("#F0F0F0"),  HexColor("#000000")),
    ChoiceData("No Way", HexColor("##F0F0F0"), HexColor("#000000")),
  ];List<ChoiceData> charactertagFourForTwo = [
    ChoiceData("Yeah 100%",  HexColor("#F0F0F0"),  HexColor("#000000")),
    ChoiceData("Occasionally 50-50",  HexColor("#F0F0F0"),  HexColor("#000000")),
    ChoiceData("No Way", HexColor("##F0F0F0"), HexColor("#000000")),
  ];List<ChoiceData> charactertagFiveForTwo = [
    ChoiceData("Yeah 100%",  HexColor("#F0F0F0"),  HexColor("#000000")),
    ChoiceData("Occasionally 50-50",  HexColor("#F0F0F0"),  HexColor("#000000")),
    ChoiceData("No Way", HexColor("##F0F0F0"), HexColor("#000000")),
  ];
  @override
  void initState() {
    super.initState();
    profileUpdatePresenter=ProfileUpdatePresenter(this);
  }

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
                 /*   height: Responsive().getResponsiveValue(
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
                        context: context),*/
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
                        context: context),
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
                                text: UtilStrings.Character_Questions1,
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
                        Gap(4),
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
                          'assets/images/character_step.png',
                          width: Responsive().getResponsiveValue(
                              forLargeScreen: size.width / 4,
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
                                text: UtilStrings.Let_know_your_Personality,
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
                                      text: UtilStrings.Character_Questions,
                                      fontFamily: 'Poppins',
                                      color: AppColor.black,
                                      textSize: 14),
                                  Gap(10),
                                  Utils.mediumHeadingStarNormalText(
                                      text: UtilStrings.I_cannot_date_someone,
                                      fontFamily: 'Poppins',
                                      color: AppColor.black,
                                      textSize: 10,),
                                  Container(
                                    height: 30,
                                    child: _buildChipCharacterOne(charactertagOneForTwo,_charactertagOne!),
                                  ),
                                  Gap(10),
                                  Utils.mediumHeadingStarNormalText(
                                      text: UtilStrings.People_say_I_am_a_prude,
                                      fontFamily: 'Poppins',
                                      color: AppColor.black,
                                      textSize: 10,),
                                  Container(
                                    height: 30,
                                    child: buildChipCharacterTwo(charactertagTwoForTwo,_charactertagTwo!),
                                  ),
                                  Gap(10),
                                  Utils.mediumHeadingStarNormalText(
                                      text: UtilStrings.I_am_very_judgemental,
                                      fontFamily: 'Poppins',
                                      color: AppColor.black,
                                      textSize: 10,),
                                  Container(
                                    height: 30,
                                    child: buildChipCharacterThree(charactertagThreeForTwo,_charactertagThree!),
                                  ),
                                  Gap(10),
                                  Utils.mediumHeadingStarNormalText(
                                      text: UtilStrings.Folks_see_me_as_good_guy,
                                      fontFamily: 'Poppins',
                                      color: AppColor.black,
                                      textSize: 10,),
                                  Container(
                                    height: 30,
                                    child: buildChipCharacterFour(charactertagFourForTwo,_charactertagFour!),
                                  ),
                                  Gap(10),
                                  Utils.mediumHeadingStarNormalText(
                                      text: UtilStrings.I_am_a_rebel_never,
                                      fontFamily: 'Poppins',
                                      color: AppColor.black,
                                      textSize: 10),
                                  Container(
                                    height: 30,
                                    child: buildChipCharacterFive(charactertagFiveForTwo,_charactertagFive!),
                                  ),
                                  Gap(16),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if(isCharactertagOne==false){
                                            Utils.customDialog(context,message:UtilStrings.Please_select_character_Question );
                                          }else if(isCharactertagTwo==false){
                                            Utils.customDialog(context,message:UtilStrings.Please_select_character_Question );
                                          }else if(isCharactertagThree==false){
                                            Utils.customDialog(context,message:UtilStrings.Please_select_character_Question );
                                          }else if(isCharactertagFour==false){
                                            Utils.customDialog(context,message:UtilStrings.Please_select_character_Question );
                                          }else if(isCharactertagFive==false){
                                            Utils.customDialog(context,message:UtilStrings.Please_select_character_Question );
                                          }else{
                                            setState(() {
                                              isLoading=true;
                                            });
                                            profileUpdatePresenter?.doUpdateusersQuestions2(
                                              cannot_date_below_my_socio_economic:charactertagOneForTwo[_charactertagOne!].label,
                                              am_prude:charactertagTwoForTwo[_charactertagTwo!].label,
                                              am_judgemental:charactertagThreeForTwo[_charactertagThree!].label,
                                              folks_see_me_as_goodguy:charactertagFourForTwo[_charactertagFour!].label,
                                              am_rebel_never_do_things_normal_way:charactertagFiveForTwo[_charactertagFive!].label,
                                            );
                                          }

                                        /*  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                              HomeScreen(
                                                viewType: 18,
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

  Widget _buildChipCharacterOne(List<ChoiceData> list,int type) {
    List<Widget> chips = [];
    for (int i = 0; i < list.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        padding: EdgeInsets.zero,
        selected: _charactertagOne == i,
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
            _charactertagOne = i;
            list[i].color=HexColor("#A8580F");
            list[i].textColor=HexColor("#F0F0F0");
            isCharactertagOne=true;
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
  Widget buildChipCharacterTwo(List<ChoiceData> list,int type) {
    List<Widget> chips = [];
    for (int i = 0; i < list.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        padding: EdgeInsets.zero,
        selected: _charactertagTwo == i,
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
            _charactertagTwo = i;
            list[i].color=HexColor("#A8580F");
            list[i].textColor=HexColor("#F0F0F0");
            isCharactertagTwo=true;

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
  Widget buildChipCharacterThree(List<ChoiceData> list,int type) {
    List<Widget> chips = [];
    for (int i = 0; i < list.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        padding: EdgeInsets.zero,
        selected: _charactertagThree == i,
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
            _charactertagThree = i;
            list[i].color=HexColor("#A8580F");
            list[i].textColor=HexColor("#F0F0F0");
            isCharactertagThree=true;

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
  Widget buildChipCharacterFour(List<ChoiceData> list,int type) {
    List<Widget> chips = [];
    for (int i = 0; i < list.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        padding: EdgeInsets.zero,
        selected: _charactertagFour == i,
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
            _charactertagFour = i;
            list[i].color=HexColor("#A8580F");
            list[i].textColor=HexColor("#F0F0F0");
            isCharactertagFour=true;

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
  Widget buildChipCharacterFive(List<ChoiceData> list,int type) {
    List<Widget> chips = [];
    for (int i = 0; i < list.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        padding: EdgeInsets.zero,
        selected: _charactertagFive == i,
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
              _charactertagFive = i;
              list[i].color=HexColor("#A8580F");
              list[i].textColor=HexColor("#F0F0F0");
              isCharactertagFive=true;

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
   if(status==401){
     Utils.sessionExpire(context);
   }
  }

  @override
  onProfileUpdateResponse(UpdateProfileResponse response) {

  }

  @override
  onUpdateusersQuestions(SuccessResponse response) {
  setState(() {
    isLoading=false;
    if(response.status==200) {
      //Clear
      /*charactertagOneForTwo.clear();
      charactertagTwoForTwo.clear();
      charactertagThreeForTwo.clear();
      charactertagFourForTwo.clear();
      charactertagFiveForTwo.clear();*/
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          HomeScreen(
            viewType: 18,
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
  onVerificationFace(SuccessResponse response) {

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
  onVerificationPhone(PhoneVerificationResponse response) async {

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
