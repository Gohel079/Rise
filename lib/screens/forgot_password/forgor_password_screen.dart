import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/screens/forgot_password_change/forgot_password_change.dart';
import 'package:rise_and_grow/screens/login/login_screen.dart';

import '../../base/constants/app_colors.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/widgets/button_view.dart';
import '../../base/widgets/custom_page_route.dart';
import '../../utils/common_utils.dart';
import 'forgot_password_bloc.dart';


class ForgotPasswordScreen extends BasePage<ForgotPasswordBloc> {
  const ForgotPasswordScreen({super.key});


  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return ForgotPasswordScreenState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => const ForgotPasswordScreen());
  }

}

class ForgotPasswordScreenState  extends BasePageState<ForgotPasswordScreen,ForgotPasswordBloc>{
  ForgotPasswordBloc bloc = ForgotPasswordBloc();

  @override
  Widget buildWidget(BuildContext context) {
   return  Padding(padding:
   const EdgeInsets.all(20),
     child: Column(children: [

       Expanded(child: Column(children: [
         SizedBox(height: 30.h,),

         Row(mainAxisAlignment: MainAxisAlignment.start,
           children: [
             InkWell(onTap: () {
               Navigator.pop(context);
             },
               child: Container(padding: const EdgeInsets.all(12),decoration:
               BoxDecoration(
                   borderRadius: BorderRadius.circular(16),
                   border: Border.all(color: lightGrayBorder,width: 1),
                   color: white),
                 child: SvgPicture.asset(
                   AppImages.icBackArrow,
                   height: 22,
                 ),),
             ),
           ],
         ),

         SizedBox(height: 30.h,),

         Row(mainAxisAlignment: MainAxisAlignment.start,
           children: [
             Text(string("label_forgot_password_header"),
                 style: styleLarge4.copyWith(
                   color: secondaryColor,
                   fontWeight: FontWeight.w700,
                 )),
           ],
         ),

         SizedBox(height: 20.h,),

         Align(
           alignment: Alignment.topLeft,
           child: Text(string("label_forgot_password_body"),
               style: styleMedium2  .copyWith(
                 color: textGrayColor,
                 fontWeight: FontWeight.w500,
               )),
         ),

         SizedBox(height: 30.h,),

         otpFieldBox(),

         SizedBox(height: 40.h,),

         submitButton()
       ],)),

       Row(mainAxisAlignment: MainAxisAlignment.center,
         children: [

           Text(string('label_remember_password'),
             style: styleMedium1.copyWith(
                 color: lightBlack,
                 fontWeight: FontWeight.w500),),

           SizedBox(width: 1.w),

           InkWell(onTap: () {

             Navigator.push(context, LoginScreen.route());
           },
             child: Text(string("label_Login"),
                 style:styleMedium1.copyWith(
                     color: secondaryColor,
                     fontWeight: FontWeight.w700)),
           ),],)

     ],));
  }

  @override
  ForgotPasswordBloc getBloc() {
   return bloc;
  }

  Widget otpFieldBox(){

    final defaultPinTheme = PinTheme(
      margin: const EdgeInsets.all(3),
      width: 66,
      height: 58,
      textStyle:  styleMedium4.copyWith(
        color: secondaryColor,
        fontWeight: FontWeight.w700,
      ),
      decoration: BoxDecoration(color: darkTextFieldFillColor,
        border: Border.all(color: borderColor,width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(color: white,
      border: Border.all(color: secondaryColor,width: 1.5),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: white,
        border: Border.all(color: secondaryColor,width: 1.5),
        borderRadius: BorderRadius.circular(8),),
    );

    return Pinput(
      length: 4,
     keyboardType: TextInputType.number,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
    );
  }

  Widget submitButton() {
    return ButtonView(string('label_verify'),true , () {
      Navigator.push(context, ForgotPasswordChangeScreen.route());
    });
  }
}