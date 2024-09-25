import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:likeplay/module/components/footer.dart';
import 'package:likeplay/utils/color_utils.dart';
import 'package:likeplay/utils/responsive.dart';
import 'package:likeplay/utils/utils.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../../utils/constant_lists.dart';

class ComingScreen extends StatefulWidget {
  int? viewType;
  ComingScreen({Key? key,this.viewType}) : super(key: key);

  @override
  State<ComingScreen> createState() => _ComingScreenState();
}

class _ComingScreenState extends State<ComingScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment:  CrossAxisAlignment.center,
      children: [
        Container(
          height: Responsive().getResponsiveValue(
              forLargeScreen:   MediaQuery.of(context).size.height/1.4,
              forShortScreen:   MediaQuery.of(context).size.height/1.2,
              forMobLandScapeMode:  MediaQuery.of(context).size.height/1.2,
              forMediumScreen:   MediaQuery.of(context).size.height/1.2,
              forTabletScreen:   MediaQuery.of(context).size.height/1.4,
              context: context),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Utils.mediumHeadingNormalText(
                  text: "Coming Soon...",
                  fontFamily: 'Poppins',color: AppColor.white,
                  fontWeight: FontWeight.w800,
                  textAlign: TextAlign.center,
                  textSize: 26),
            Gap(8),
            Image.asset(
              'assets/images/app_icon.png',
              height: Responsive().getResponsiveValue(
                  forLargeScreen: size.height * 0.1,
                  forShortScreen: size.height * 0.1,
                  context: context),
            ),
              Gap(12),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.white,
                      width: 1.0,
                      style: BorderStyle.solid
                  ),
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.black54,
                ),
               padding: EdgeInsets.only(top: Responsive().getResponsiveValue(
                   forLargeScreen: 18.0,
                   forShortScreen: 22.0,
                   forMobLandScapeMode: 20.0,
                   forMediumScreen: 20.0,
                   forTabletScreen: 18.0,
                   context: context),
                   bottom: Responsive().getResponsiveValue(
                   forLargeScreen: 18.0,
                   forShortScreen: 22.0,
                   forMobLandScapeMode: 20.0,
                   forMediumScreen: 20.0,
                   forTabletScreen: 18.0,
                   context: context)),
               /* decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/bg_border.png'),
                        fit: BoxFit.contain)),*/
                width:  Responsive().getResponsiveValue(
                    forLargeScreen: MediaQuery.of(context).size.width/1.2,
                    forShortScreen: MediaQuery.of(context).size.width/1.2,
                    forMobLandScapeMode: MediaQuery.of(context).size.height/2,
                    forMediumScreen: MediaQuery.of(context).size.height/2,
                    forTabletScreen: MediaQuery.of(context).size.height/2,
                    context: context),
                height:  Responsive().getResponsiveValue(
                    forLargeScreen: MediaQuery.of(context).size.height/3.4,
                    forShortScreen: MediaQuery.of(context).size.height/1.6,
                    forMobLandScapeMode: MediaQuery.of(context).size.height/1.6,
                    forMediumScreen: MediaQuery.of(context).size.height/1.6,
                    forTabletScreen: MediaQuery.of(context).size.height/2.6,
                    context: context),
                child: ResponsiveGridList(
                  maxItemsPerRow:  Responsive().getResponsiveValue(
                      forLargeScreen: 6,
                      forShortScreen: 2,
                      forMobLandScapeMode: 6,
                      forMediumScreen: 2,
                      forTabletScreen: 4,
                      context: context),
                  minItemWidth: Responsive().getResponsiveValue(
                      forLargeScreen: 160,
                      forShortScreen: 58,
                      forMobLandScapeMode: 160,
                      forMediumScreen: 160,
                      forTabletScreen: 140,
                      context: context),
                  children: List.generate(title.length,
                        (index) => Utils.featureWidget(title: title[index],imageUrl: titleIcon[index],context: context)
                  ),
                ),
              ),
          ],)),
        Gap(Responsive().getResponsiveValue(
            forLargeScreen: 22,
            forShortScreen: 32,
            forMobLandScapeMode: 32,
            forMediumScreen: 32,
            forTabletScreen: 32,
            context: context)),
        Responsive().getResponsiveValue(
            forLargeScreen:  SizedBox(),
            forShortScreen:  Footer(viewType:widget.viewType),
            forMobLandScapeMode:  Footer(viewType:widget.viewType),
            forMediumScreen:  Footer(viewType:widget.viewType),
            forTabletScreen:  Footer(viewType:widget.viewType),
            context: context),
    ],);

  }

}
