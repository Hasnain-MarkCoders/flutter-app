import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/module/model/admiring_response.dart';
import 'package:likeplay/module/model/success_response.dart';
import 'package:likeplay/utils/constant_lists.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/responsive.dart';
import '../../utils/firebase/authentication_service.dart';
import '../../utils/sharedpref/preferences.dart';
import '../../utils/sharedpref/shared_prefrence.dart';
import '../../utils/string_utils.dart';
import '../../utils/utils.dart';
import '../model/admirers_response.dart';
import 'admire_presenter.dart';

class AdmirerViewScreen extends StatefulWidget {

  @override
  State<AdmirerViewScreen> createState() => _AdmirerViewScreenState();
}

class _AdmirerViewScreenState extends State<AdmirerViewScreen> implements AdmireInterface {
  DateTime ?dateTime;
  bool isLoading=false;
  bool isRemove=false;
  int selectIndex=0;
  TextEditingController matchController = TextEditingController();
  List<AdmirersData> admirersList=[];
  AdmirePresenter? admirePresenter;
  bool isShowText=true;
  String receiverId="";
  final _authService = AuthenticationService();
  @override
  void initState() {
    super.initState();
    admirePresenter=AdmirePresenter(this);
    setState(() {
      isLoading=true;
      admirePresenter?.doAdmirer("");
    });
  }
/*  searchData(String keyword){
    if(keyword.isNotEmpty){
      admirePresenter?.doAdmirer(keyword);
    }else{
      admirePresenter?.doAdmirer("");

    }
  }*/
  void searchData(String value) {
    List<AdmirersData> results = [];
    if (value.isEmpty) {
      admirePresenter?.doAdmirer("");
    } else {
      results = admirersList.where((user) {
        final title = user.admireBy!
            .name.toString().toLowerCase();
        final desc = user.admireBy!.country!.toLowerCase(); // added
        final searchLower = value.toLowerCase();
        return title.contains(searchLower) ||
            desc.contains(searchLower); //changed
      }).toList();
    }
    setState(() {
      admirersList = results;
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      /*width: size.width,
      height: size.height,*/
      color: Colors.white,
      child: Stack(
        children: [
          Column(children: [
            Container(
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.all(20),
                      child:Row(
                        children:  [
                          //Utils.
                          Expanded(
                              child: Container(
                                height: 46,
                                decoration: BoxDecoration(
                                  color:const Color.fromRGBO(250, 245, 241, 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child:Stack(
                                  children: [
                                    isShowText==true?  Container(
                                      margin: EdgeInsets.only(top: 12,left: 18),
                                      child: Row(
                                        children: [
                                          Utils.mediumHeadingNormalText(text:"Admirers",
                                              textSize: 12,fontWeight:
                                              FontWeight.w300,color: HexColor(AppColor.SIDE_TEXT_COLOR)),
                                          Container(
                                            padding: EdgeInsets.all(0.0),
                                            width:Responsive().getResponsiveValue(
                                                forLargeScreen:  MediaQuery.of(context).size.width,
                                                forShortScreen:  MediaQuery.of(context).size.width/1.8,
                                                forMobLandScapeMode: MediaQuery.of(context).size.width/1.8,
                                                forMediumScreen: MediaQuery.of(context).size.width/1.8,
                                                forTabletScreen: MediaQuery.of(context).size.width/1.8,
                                                context: context),
                                            child: Utils.mediumHeadingNormalText(text:UtilStrings.Admirers_whey_de_enter,
                                                textSize: 10,fontWeight:
                                                FontWeight.w300,color: AppColor.APP_TEXT_COLOR_SECOND,overflow: TextOverflow.ellipsis,textAlign: TextAlign.left),
                                          ),
                                        ],
                                      ),
                                    ):Container(),
                                    TextField(
                                      onTap: (){
                                        /*setState(() {
                                           isShowText=false;
                                         });*/
                                      },
                                      onChanged: (value){
                                        setState(() {
                                          isShowText=false;
                                        });
                                        searchData(value);
                                      },
                                      style: TextStyle(
                                        color:AppColor.black,
                                        fontSize: 12,
                                      ),
                                      cursorColor: HexColor(AppColor.SIDE_TEXT_COLOR),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          /*  hintText: UtilStrings.Admirers_whey_de_enter,
                                          hintStyle: TextStyle(
                                            color:AppColor.black,
                                            fontSize: 12,
                                          ),*/
                                          contentPadding:EdgeInsets.all(13),
                                          suffixIcon: Icon(Icons.search_outlined,color: Colors.black,)
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ),
                          Gap(12),
                        ],
                      )),
                  Container(
                    color: Colors.grey,
                    height: 1,
                  ),
                  const Gap(16),
                  Stack(children: [
                    Column(children: [
                      admirersList.isNotEmpty?Container(
                        padding: EdgeInsets.all(10),
                        height:
                        Responsive().getResponsiveValue(
                            forLargeScreen:
                            MediaQuery.of(context).size
                                .height,
                            forShortScreen:
                            MediaQuery
                                .of(context)
                                .size
                                .height/1.5,
                            forTabletScreen:
                            MediaQuery
                                .of(context)
                                .size
                                .height/1.5,
                            forMediumScreen:
                            MediaQuery
                                .of(context)
                                .size
                                .height/1.3,
                            context: context),
                        child: ResponsiveGridList(
                          maxItemsPerRow:  Responsive().getResponsiveValue(
                              forLargeScreen: 4,
                              forShortScreen: 2,
                              forMobLandScapeMode: 2,
                              forMediumScreen: 2,
                              forTabletScreen: 2,
                              context: context),
                          minItemWidth: Responsive().getResponsiveValue(
                              forLargeScreen: 160.0,
                              forShortScreen: 160.0,
                              forMobLandScapeMode: 160.0,
                              forMediumScreen: 160.0,
                              forTabletScreen: 160.0,
                              context: context),
                          children: List.generate(admirersList.length,
                                (index) =>Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child:  CachedNetworkImage(
                                          imageUrl:admirersList[index].admireBy!.userImagesWhileSignup!.isNotEmpty?IMAGE_URL+admirersList[index].admireBy!.userImagesWhileSignup![0].imageUrl.toString():"",
                                          imageBuilder: (context, imageProvider) => Container(
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                                image: DecorationImage(
                                                  image:imageProvider,
                                                  fit: BoxFit.fill,
                                                ),
                                              )),
                                          placeholder: (context, url) =>  const Image(image: AssetImage("assets/images/icon_loading.png")),
                                          errorWidget: (context, url, error) =>   const Image(image: AssetImage("assets/images/icon_loading.png")),
                                          width: 155,
                                          height: 110,
                                        ),),
                                      const Gap(12),
                                      Utils.mediumHeadingNormalText(text:admirersList[index].admireBy!.name.toString()=="null"?"NA":admirersList[index].admireBy!.name.toString(),textSize: 12,fontWeight:  FontWeight.bold,color: AppColor.APP_TEXT_COLOR),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Utils.mediumHeadingNormalText(text:admirersList[index].admireBy!.age.toString()=="null"?"NA":admirersList[index].admireBy!.age.toString(),textSize: 8,color: AppColor.APP_TEXT_COLOR_SECOND),
                                          Utils.customBlackDot(),
                                          Utils.mediumHeadingNormalText(text:admirersList[index].admireBy!.country.toString()=="null"?
                                          "NA":admirersList[index].admireBy!.country.toString(),textSize: 8,fontWeight:  FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND),
                                          Utils.customBlackDot(),
                                          Container(
                                              width:Responsive().getResponsiveValue(
                                                  forLargeScreen: 60.0,
                                                  forShortScreen: 64.0,
                                                  forMobLandScapeMode: 0.0,
                                                  forMediumScreen: 64.0,
                                                  forTabletScreen:64.0,
                                                  context: context) ,
                                              child: Utils.mediumHeadingNormalText(text:admirersList[index].admireBy!.employment.toString()=="null"?"NA":admirersList[index].admireBy!.employment.toString(),textSize: 8,fontWeight:  FontWeight.w400,color: AppColor.APP_TEXT_COLOR_SECOND,overflow: TextOverflow.ellipsis)),
                                        ],
                                      ),
                                      const Gap(10),
                                   /*  GestureDetector(onTap: (){
                                      setState(() {
                                        isLoading=true;
                                        receiverId=admirersList[index].admireBy!.id.toString();
                                        admirePresenter?.onSendRequest(admirersList[index].admireBy!.id.toString(), "2");
                                      });
                                     }, child:Container(
                                       height: 28,
                                       width: 150,
                                       decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(5),
                                           color: HexColor('#FF483C')
                                       ),
                                       child: Row(
                                         crossAxisAlignment: CrossAxisAlignment.center,
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                           Utils.mediumHeadingNormalText(text:UtilStrings.admire_back,textSize: 10,fontWeight:  FontWeight.w400,color: AppColor.white,overflow: TextOverflow.ellipsis),
                                         ],
                                       ),
                                     ),)*/
                                      Row(children: [
                                        GestureDetector(onTap: (){
                                          setState(() {
                                            isLoading=true;
                                            receiverId=admirersList[index].admireBy!.id.toString();
                                            admirePresenter?.onSendRequest(admirersList[index].admireBy!.id.toString(), "2");
                                          });
                                        }, child:Container(
                                          height: 28,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: HexColor('#FF483C')
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Utils.mediumHeadingNormalText(text:UtilStrings.admire_back,textSize: 10,fontWeight:  FontWeight.w400,color: AppColor.white,overflow: TextOverflow.ellipsis),
                                            ],
                                          ),
                                        ),),
                                        const Gap(4),
                                        //Add here
                                        GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              isLoading=true;
                                              isRemove=true;
                                              receiverId=admirersList[index].admireBy!.id.toString();
                                              admirePresenter?.onSendRequest(admirersList[index].admireBy!.id.toString(), "0");
                                            });
                                          },
                                          child:Container(
                                            height: 28,
                                            width: 54,
                                            padding: const EdgeInsets.only(left: 2.0,top: 2,bottom:2),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: HexColor(AppColor.FillColor)
                                            ),
                                            child: Utils.imageView(image: "assets/images/icon_waving.png",height: 14,width:14),
                                            // Icon(Icons.waving_hand,color: HexColor(AppColor.YellowColor),size: 17,),
                                          ),),
                                      ],)
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0,top: 12),
                                    child: Container(
                                      height: 16,
                                      width: 32,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: HexColor('#FF483C'),
                                      ),
                                      child:  Center(child:
                                      Utils.mediumHeadingNormalText(text:  UtilStrings.New,textSize: 10,fontWeight:  FontWeight.w400,color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ),
                        ),

                      ):Container(  height:Responsive().getResponsiveValue(
                          forLargeScreen: MediaQuery.of(context).size.height,
                          forShortScreen: MediaQuery.of(context).size.height/1.8,
                          forMobLandScapeMode: MediaQuery.of(context).size.height,
                          forMediumScreen: MediaQuery.of(context).size.height/1.8,
                          forTabletScreen:MediaQuery.of(context).size.height,
                          context: context),
                        alignment: Alignment.center,
                        child: Utils.mediumHeadingNormalText(
                            text: isLoading ==
                                false
                                ? UtilStrings
                                .NO_RECORD
                                : "",
                            textSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColor.black,
                            textAlign: TextAlign.end),
                      )
                    ],),
                  ],)
                ],
              ),
            ),

          ],),
          Utils.progressDialog(context, isLoading, type: 3)
        ],
      ),
    );
  }

  @override
  onAdmirers(AdmirersResponse response) {
    setState(() {
      isLoading=false;
      admirersList.clear();
      if(response.status==200){
        admirersList.addAll(response.data!);
      }else{

      }
    });
  }

  @override
  onAdmiring(AdmiringDataResponse response) {

  }

  @override
  onError(String msg, int status) {
    setState(() {
      isLoading=false;
    });
    if(status==401){
      Utils.sessionExpire(context);
    }
    else if(status==404){
      Utils.sessionExpire(context);
    }

  }

  @override
  onSendRequest(SuccessResponse response) {
    setState(() async {
      isLoading=false;
      if(response.status==200){
        Utils.customDialog(context,message:response.message.toString());
        admirePresenter?.doAdmirer("");
        if(isRemove==true){
          _authService.delelteUser(SessionManager.getString(Preferences.USER_ID), receiverId);
        }else{
          await _authService.updateAdmireStatus(SessionManager.getString(Preferences.USER_ID), receiverId, "1");
        }
      }else{
      }
    });
  }

}
