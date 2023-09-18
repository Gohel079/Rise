import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/base/constants/app_colors.dart';
import 'package:rise_and_grow/base/constants/app_widgets.dart';
import 'package:rise_and_grow/base/src_components.dart';
import 'package:rise_and_grow/screens/forgot_password/forgor_password_screen.dart';
import 'package:rise_and_grow/screens/home/home_screen.dart';
import 'package:rise_and_grow/screens/register/register_screen.dart';

import '../../base/constants/app_constant.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/widgets/button_view.dart';
import '../../base/widgets/custom_page_route.dart';
import '../../utils/app_valid.dart';
import '../../utils/common_utils.dart';
import '../../widgets/custom_decoration.dart';
import 'login_screen_bloc.dart';

class LoginScreen  extends BasePage<LoginScreenBloc> {
  const LoginScreen({super.key});


  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _LoginScreenState();
  }


  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => LoginScreen());
  }

}

class _LoginScreenState   extends BasePageState<LoginScreen,LoginScreenBloc>{


  LoginScreenBloc bloc = LoginScreenBloc();

  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _nodeMobileNumber = FocusNode();
  final FocusNode _nodePassword = FocusNode();

  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;



  @override
  Widget buildWidget(BuildContext context) {
   return Padding(
     padding: const EdgeInsets.all(22.0),
     child: Column(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [

         Expanded(
           child: SingleChildScrollView(
             child: Column(children: [
               SizedBox(height:80.h),

               Row(mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Text(string("label_welcome_back"),
                       style: styleLarge4.copyWith(
                         color: secondaryColor,
                         fontWeight: FontWeight.w700,
                       )),
                 ],
               ),

               SizedBox(height:40.h),

               Form(
                  key: _formKey,
                   child: Column(
                 children: [
                   emailPhoneTextField(),

                   SizedBox(height:30.h),

                   passwordTextField()
                 ],
               ))



               ,SizedBox(height:20.h),

               Row(mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   InkWell(onTap: () {
                     Navigator.push(context, ForgotPasswordScreen.route());
                   },
                     child: Text(string("label_forget_password"),
                         style: styleMedium1.copyWith(
                           color: secondaryColor,
                           fontWeight: FontWeight.w600,
                         )),
                   ),
                 ],
               ),

               SizedBox(height:60.h),

               submitButton()

             ]),
           ),
         ),
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




     ],),
   );
  }

  @override
  LoginScreenBloc getBloc() {
    return bloc;
  }

  Widget emailPhoneTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      validator: validateMobileAndEmail,
      controller: _mobileNumberController,
      focusNode: _nodeMobileNumber,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: "Enter Your Email/ Phone Number",
          labelStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: textGrayColor,
            fontSize: 13,
          ),
          contentPadding: EdgeInsetsDirectional.symmetric(vertical: 22,horizontal: 20),
          fillColor:  darkTextFieldFillColor,
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          errorMaxLines: 2,
          isDense: true,
          hintText: "Enter Your Email/ Phone Number",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget passwordTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      validator: validatePassword,
      obscureText: !_passwordVisible,
      controller: _passwordController,
      focusNode: _nodePassword,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          labelText: "Enter Your Password",
          labelStyle: const TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: textGrayColor,
            fontSize: 13,
          ),
          contentPadding: const EdgeInsetsDirectional.symmetric(vertical: 22,horizontal: 20),
          fillColor:  darkTextFieldFillColor,
          filled: true,
          suffixIcon:  Padding(
            padding: const EdgeInsets.all(10.0),
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
          hintText: "Enter Your Password",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: const TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget submitButton() {
    return ButtonView(string('label_Login'),true , () {

      Navigator.pushReplacement(context,HomeScreen.route());

      var state = _formKey.currentState!;
      if(state.validate()){
        hideKeyboard(context);

       String email =  _mobileNumberController.text.toString();
       String password = _passwordController.text.toString();

       Map requestData = {
         "email": email,
         "password":password
       };


        getBloc().doVerifyUser(requestData, (response){

         String status = response.responseType ?? success;

         if(status.toLowerCase() == success){
         }
           else if(status.toLowerCase() == failed){
           showMessageBar('Failed :  ${response.data ?? ""}');
         }
         else {
           showMessageBar('ERROR :${response.message ?? ""}');
         }

       },);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }
}
