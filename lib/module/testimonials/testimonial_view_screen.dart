import 'dart:io';
import 'dart:math';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:likeplay/module/model/success_response.dart';
import 'package:likeplay/module/testimonials/testimonials_presenter.dart';
import '../../../utils/color_utils.dart';
import '../../utils/responsive.dart';
import '../../utils/string_utils.dart';
import '../../utils/utils.dart';
import '../../widget/common/commontextfield_registerscreen.dart';

class TestimonialViewScreen extends StatefulWidget {

  @override
  State<TestimonialViewScreen> createState() => _TestimonialViewScreenState();
}

class _TestimonialViewScreenState extends State<TestimonialViewScreen> implements TestimonialsInterface{
bool isLoading=false;
TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController testimonialController = TextEditingController();
TestimonialsPresenter? testimonialsPresenter;

@override
void initState() {
  testimonialsPresenter=TestimonialsPresenter(this);
  super.initState();
}
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Container(
          /*width: size.width,
          height: size.height,*/
          color: Colors.white,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                      padding: EdgeInsets.all(20),
                      color: HexColor("#F0F0F0"),
                      child:Row(
                        children:  [
                          //Utils.
                          Expanded(
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Gap(12),
                                Utils.mediumHeadingNormalText(text: UtilStrings.Testimonial,textSize: 14,color: AppColor.APP_TEXT_COLOR),
                              ],
                            ),
                          ),
                          Gap(12),
                        ],
                      )),
                  Container(
                    color: Colors.grey,
                    height: 1,
                  ),
                  const Gap(16),
                  Column(children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20,right: 22,left: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Utils.customTextFeildSetting(context,
                              UtilStrings.Name,
                              UtilStrings.EnterName,
                              nameController, false,
                              false),
                          Gap(18),
                          Utils.customTextFeildSetting(context,
                              UtilStrings.Email,
                              UtilStrings.Enter_Email,
                              emailController, false,
                              false),
                          Gap(18),
                          Utils.customTextFeildTestMonials(context,
                              UtilStrings.Testimonial,
                              UtilStrings.AddTestimonial,
                              testimonialController, false,
                              false),
                          Gap(38),
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(onTap: (){
                              validation();
                            },child: Container(
                              height: 48,
                              width: 160,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.APP_SUBMIT_COLOR
                              ),
                              child: Center(
                                child: Utils.mediumHeadingNormalText(text: UtilStrings.Submit,color:Colors.white),
                              ),
                            ),),
                          )


                        ],
                      ),
                    ),

                  ],)
                ],
              ),
              Utils.progressDialog(context, isLoading, type: 3)
            ],
          ),
        ),
    );
  }

  @override
  onError(String msg, int status) {
    setState(() {
      isLoading=false;
      if(status==400){
        Utils.customDialog(context,message:msg);
      }
      else if(status==401){
        Utils.sessionExpire(context);
      }
    });
  }

@override
onTestimonials(SuccessResponse response) {
  setState(() {
    isLoading=false;
    if(response.status==200){
      Utils.customDialog(context,message:response.message!);
      nameController.text="";
      emailController.text="";
      testimonialController.text="";
    }
  });
}

  void validation() {
    if(nameController.text.toString().trim().isEmpty){
      Utils.customDialog(context,message:UtilStrings.ENTER_NAME);
    }
    else if(emailController.text.toString().trim().isEmpty){
      Utils.customDialog(context,message:UtilStrings.ENTER_EMAIL);
    }
    else if (!EmailValidator.validate(emailController.text.toString().trim())){
      Utils.customDialog(context,message:UtilStrings.ENTER_YOUR_VALID_EMAIL);
    }
    else if(testimonialController.text.toString().trim().isEmpty){
      Utils.customDialog(context,message:UtilStrings.Add_Testimonial);
    }
    else{
      Utils.hideKeyBoard(context);
      setState(() {
        isLoading=true;
      });
      testimonialsPresenter?.doTestimonialsPost(nameController.text.toString(), emailController.text.toString(), testimonialController.text.toString());
    }
  }


}
