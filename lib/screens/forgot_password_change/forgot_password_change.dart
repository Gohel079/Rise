import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/screens/forgot_password_change/ForgotPasswordChangeBloc.dart';
import 'package:rise_and_grow/screens/register/register_screen.dart';

import '../../base/constants/app_colors.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/widgets/button_view.dart';
import '../../base/widgets/custom_page_route.dart';
import '../../utils/common_utils.dart';
import '../login/login_screen.dart';

class ForgotPasswordChangeScreen extends BasePage{
  const ForgotPasswordChangeScreen({super.key});


  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _ForGotPasswordChangeScreenState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => const ForgotPasswordChangeScreen());
  }

}

class _ForGotPasswordChangeScreenState extends BasePageState<ForgotPasswordChangeScreen,ForgotPasswordChangeBloc> {

  ForgotPasswordChangeBloc bloc = ForgotPasswordChangeBloc();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final FocusNode _nodePassword = FocusNode();
  final FocusNode _nodeConfirmPassword = FocusNode();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                      height: 20,
                    ),),
                ),
              ],
            ),

            SizedBox(height: 30.h,),

            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(string("label_forgot_pwd"),
                    style: styleLarge4.copyWith(
                      color: secondaryColor,
                      fontWeight: FontWeight.w700,
                    )),
              ],
            ),

            SizedBox(height: 30.h,),

            newPasswordTextField(),

            SizedBox(height: 30.h,),

            confirmNewPasswordTextField(),

            SizedBox(height: 60.h,),

            submitButton()
          ],)),

          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(string('label_don_t_have_account'),
                style: styleMedium1.copyWith(
                    color: lightBlack,
                    fontWeight: FontWeight.w500),),

              SizedBox(width: 1.w),

              InkWell(onTap: () {

                Navigator.push(context, RegisterScreen.route());
              },
                child: Text(string("label_register_now"),
                    style:styleMedium1.copyWith(
                        color: secondaryColor,
                        fontWeight: FontWeight.w700)),
              ),],)

        ],));
  }

  @override
  ForgotPasswordChangeBloc getBloc() {
    return bloc;
  }

  Widget submitButton() {
    return ButtonView(string('label_submit'),true , () {
      // Navigator.push(context, RegisterScreen.route());
    });
  }

  Widget newPasswordTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      // validator: validateMobile,
      obscureText: !_passwordVisible,
      controller: _passwordController,
      focusNode: _nodePassword,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: "New Password",
          labelStyle: const TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: textGrayColor,
            fontSize: 13,
          ),
          contentPadding: const EdgeInsetsDirectional.symmetric(vertical: 22,horizontal: 20),
          fillColor:  darkTextFieldFillColor,
          filled: true,
          suffixIcon:  Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: (){
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
              child: SvgPicture.asset(
                _passwordVisible ? AppImages.icEyePassword : AppImages.icEyeClose,
                color: passwordIconColor,
              ),
            ),
          ),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          errorMaxLines: 2,
          isDense: true,
          hintText: "New Password",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: const TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget confirmNewPasswordTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      // validator: validateMobile,
      obscureText: !_confirmPasswordVisible,
      controller: _confirmPasswordController,
      focusNode: _nodeConfirmPassword,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: "Confirm New Password",
          labelStyle: const TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: textGrayColor,
            fontSize: 13,
          ),
          contentPadding: const EdgeInsetsDirectional.symmetric(vertical: 22,horizontal: 20),
          fillColor:  darkTextFieldFillColor,
          filled: true,
          suffixIcon:  Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: (){
                setState(() {
                  _confirmPasswordVisible = !_confirmPasswordVisible;
                });
              },
              child: SvgPicture.asset(
               _confirmPasswordVisible ? AppImages.icEyePassword : AppImages.icEyeClose,
                color: passwordIconColor,
              ),
            ),
          ),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          errorMaxLines: 2,
          isDense: true,
          hintText: "Confirm New Password",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: const TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }
}