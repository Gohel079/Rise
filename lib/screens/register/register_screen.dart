
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/base/constants/app_constant.dart';
import 'package:rise_and_grow/base/src_components.dart';
import 'package:rise_and_grow/base/src_constants.dart';
import 'package:rise_and_grow/remote/model/get_officelist_response_model.dart';
import 'package:rise_and_grow/screens/login/login_screen.dart';
import 'package:rise_and_grow/screens/register/register_screen_bloc.dart';
import 'package:rise_and_grow/remote/model/get_role_list_response_model.dart' as roleData;
import 'package:rxdart/rxdart.dart';

import '../../base/constants/app_colors.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/widgets/button_view.dart';
import '../../base/widgets/custom_page_route.dart';
import '../../base/widgets/image_view.dart';
import '../../utils/app_valid.dart';
import '../../utils/common_utils.dart';
import '../../utils/date_util.dart';

class RegisterScreen extends BasePage<RegisterScreenBloc> {


  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _RegisterScreenState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => RegisterScreen());
  }

}

class _RegisterScreenState
    extends BasePageState<RegisterScreen, RegisterScreenBloc> {
  RegisterScreenBloc bloc = RegisterScreenBloc();

  String companyNameDropdown = 'Select Company Name';
  String departMentDropdown = 'Select Department';
  String designationDropdown = 'Select Designation';
  String officeAddressDropdown = 'Select Office Address';
  String roleDropdown = 'Select Role';

  // List of items in our dropdown menu
  BehaviorSubject<List<dynamic>>? companyNameList;
  BehaviorSubject<List<dynamic>>? departmentList;
  BehaviorSubject<List<dynamic>>? designationList;
  BehaviorSubject<List<dynamic>>? officeList;
  BehaviorSubject<List<dynamic>>? roleList;


  /*var officeAddressList = [
    'Office Address',
    'SURAT',
    'AHD',
    'MUMBAI',
    'PUNE',
  ];*/

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  bool agree = true;

   BehaviorSubject<String>? companyPDFFileText;
   BehaviorSubject<String>? aadhaarCardPDFText;
   BehaviorSubject<String>? photoOrCameraFile;
   ImagePicker? imagePicker  = ImagePicker();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _employeeCodeController = TextEditingController();
  final TextEditingController _aadharNumberController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _anniversaryDateController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();


  final FocusNode _nodeFirstName = FocusNode();
  final FocusNode _nodeSecondName = FocusNode();
  final FocusNode _nodeEmployeeCode = FocusNode();
  final FocusNode _nodeAadhaarNumber = FocusNode();
  final FocusNode _nodeDesignation = FocusNode();
  final FocusNode _nodeEmailAddress = FocusNode();
  final FocusNode _nodeDateOfBirth = FocusNode();
  final FocusNode _nodeAnniversary = FocusNode();
  final FocusNode _nodeContactNumber = FocusNode();
  final FocusNode _nodePassword = FocusNode();
  final FocusNode _nodeConfirmPassword = FocusNode();

  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  @override
  Widget buildWidget(BuildContext context) {
    return SingleChildScrollView(child: Padding(
      padding: const EdgeInsets.all(22.0),
      child: Column(children: [

        SizedBox(height: 50.h,),

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
            Text(string("label_register_header"),
                style: styleLarge4.copyWith(
                  color: secondaryColor,
                  fontWeight: FontWeight.w700,
                )),
          ],
        ),

        Form(key: _formKey,
          child: Column(children: [


          SizedBox(height: 30.h,),

          firstNameTextField(),

          SizedBox(height: 20.h,),

          secondNameTextField(),

          SizedBox(height: 20.h,),

          employeeCodeTextField(),

          SizedBox(height: 20.h,),

          contactNumberTextField(),

          SizedBox(height: 20.h,),

          emailAddressTextField(),

          SizedBox(height: 20.h,),

          dateOfBirthField(),
          // designationTextField(),

          SizedBox(height: 20.h,),

          anniversaryDateField(),

          SizedBox(height: 20.h,),

          Container(width: double.infinity,decoration :
          BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
              border: Border.all(color: borderColor, ),
              color: darkTextFieldFillColor ),
              child: companyNameDropDown()),

          SizedBox(height: 20.h,),

          Container(width: double.infinity,decoration :
          BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
              border: Border.all(color: borderColor, ),color: darkTextFieldFillColor ),
              child: departMentDropDown()),

          SizedBox(height: 20.h,),

          Container(width: double.infinity,decoration :
          BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
              border: Border.all(color: borderColor, ),color: darkTextFieldFillColor ),
              child: designationDropDown()),

          SizedBox(height: 20.h,),


          Container(width: double.infinity,decoration :
          BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
              border: Border.all(color: borderColor, ),color: darkTextFieldFillColor ),
              child: officeAddressDropDown()),


          SizedBox(height:20.h),

            Container(width: double.infinity,decoration :
            BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
                border: Border.all(color: borderColor, ),color: darkTextFieldFillColor ),
                child: roleDropDown()),


            SizedBox(height:20.h),

            aadhaarNumberTextField(),

          SizedBox(height:20.h),

          passwordTextField(),

          SizedBox(height:30.h),

          confirmPasswordTextField(),

          SizedBox(height:40.h),

          uploadDocument(),

          SizedBox(height:20.h),

          termAndcondition(),

          ],),
        ),

        SizedBox(height:30.h),

        submitButton(),



        SizedBox(height:20.h),

        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text( string('label_already_have_account'),
              style: styleMedium1.copyWith(
                  color: lightBlack,
                  fontWeight: FontWeight.w500),),
            InkWell(onTap: () {
              Navigator.push(context, LoginScreen.route());
            },
              child: Text(string("label_login_now"),style: styleMedium1.copyWith(
                  color: secondaryColor,
                  fontWeight: FontWeight.w700)),
            ),
          ],),

        SizedBox(height:20.h),


      ],),
    ));
  }

  @override
  RegisterScreenBloc getBloc() {
    return bloc;
  }

  @override
  void initState() {
    super.initState();
    companyPDFFileText = BehaviorSubject<String>.seeded("");
    aadhaarCardPDFText = BehaviorSubject<String>.seeded("");
    photoOrCameraFile = BehaviorSubject<String>.seeded("");

    companyNameList = BehaviorSubject<List<dynamic>>.seeded([]);
    departmentList = BehaviorSubject<List<dynamic>>.seeded([]);
    designationList = BehaviorSubject<List<dynamic>>.seeded([]);
    officeList = BehaviorSubject<List<dynamic>>.seeded([]);
    roleList = BehaviorSubject<List<dynamic>>.seeded([]);






  }

  @override
  void onReady() {
    super.onReady();
    callCompanyListAPI();
    callDepartmentAPI();
    callDesignationAPI();
    callRoleAPI();

  }



  Widget firstNameTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,
          fontWeight: FontWeight.w600),
      controller: _firstNameController,
      focusNode: _nodeFirstName,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,
      validator:  validateFirstName,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          labelText: "First Name *",
          labelStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: textGrayColor,
            fontSize: 13,
          ),
          contentPadding: EdgeInsetsDirectional.
          symmetric(vertical: 22,horizontal: 20),
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
          // isDense: true,
          hintText: "First Name *",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget secondNameTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _secondNameController,
      focusNode: _nodeSecondName,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      validator: validateLastName,
      decoration: const InputDecoration(
        labelText: "Last Name",
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
          hintText: "Last Name",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget employeeCodeTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _employeeCodeController,
      focusNode: _nodeEmployeeCode,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      validator: validateEmployeeCode,
      decoration: const InputDecoration(
          labelText: "Employee Code",
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
          hintText: "Employee Code",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget aadhaarNumberTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _aadharNumberController,
      focusNode: _nodeAadhaarNumber,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.number,
      validator: validateAadhaarNumber,
      maxLength: 12,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          counterText: "",
          labelText: "Aadhaar Number",
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
          hintText: "Aadhaar Number",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget designationTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _designationController,
      focusNode: _nodeDesignation,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          labelText: "Designation",
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
          hintText: "Designation",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget emailAddressTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _emailAddressController,
      focusNode: _nodeEmailAddress,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: validateEmail,
      decoration: const InputDecoration(
          labelText: "Email Address",
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
          hintText: "Email Address",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget contactNumberTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _contactNumberController,
      focusNode: _nodeContactNumber,

      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.number,
      maxLength: 10,
      textInputAction: TextInputAction.next,
      validator: validateMobile,
      decoration: const InputDecoration(
        counterText: "",
          labelText: "Contact Number",
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
          hintText: "Contact Number",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget companyNameDropDown(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
      child: StreamBuilder<List<dynamic>>(
        stream: companyNameList?.stream,
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data!.length > 1){
            return DropdownButtonHideUnderline(
              child: DropdownButtonFormField(
                decoration: const InputDecoration(border: InputBorder.none),
                value: snapshot.data?[0],
                autovalidateMode: autoValidateMode,
                isExpanded: true,
                validator: validateCompanyName,
                icon: const Icon(Icons.keyboard_arrow_down,color: black,),
                items: snapshot.data?.map((dynamic items) {
                  return DropdownMenuItem(
                    value: items.toString(),
                    child: Text(items,
                      style: styleMedium1.copyWith(color: black,
                          fontWeight: FontWeight.w600),),
                  );
                }).toList(),
                onChanged: (dynamic newValue) {
                  setState(() {
                    companyNameDropdown = newValue!;
                    officeAddressDropdown = "Select Office Address";
                    callOfficeListAPI(int.parse(findCompanyIdByName()));
                    print(companyNameDropdown);
                  });
                },
              ),
            );
          }
          return  SizedBox(height: 40.h,
            child: DropdownMenuItem(
              value: "Select Company Name",
              child: Text("Select Company Name",
                style: styleMedium1.copyWith(color: black,
                    fontWeight: FontWeight.w600),),
            ),);

        }
      ),
    );
  }

  Widget officeAddressDropDown(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
      child: StreamBuilder<List<dynamic>>(
        stream: officeList?.stream,
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data!.length > 1){
            print("SNAP ${snapshot.data?.length}");
            snapshot.data?.forEach((element) { print(element); });
            return DropdownButtonHideUnderline(
              child: DropdownButtonFormField(
                value: officeAddressDropdown,
                isExpanded: true,
                autovalidateMode: autoValidateMode,
                decoration: const InputDecoration(border: InputBorder.none),
                validator: validateOfficeAddress,
                icon: const Icon(Icons.keyboard_arrow_down,color: black,),
                items: snapshot.data?.map((dynamic items) {
                  return DropdownMenuItem(
                    value: items ?? "",
                    child: Text(items ?? "",
                      style: styleMedium1.copyWith(color: black,
                          fontWeight: FontWeight.w600),),
                  );
                }).toList(),
                onChanged: (dynamic newValue) {
                  setState(() {
                    officeAddressDropdown = newValue!;

                  });
                },
              ),
            );
          }
          else {
            return InkWell(onTap: (){
              showMessageBar("Please Select First Company Name");
            },
              child: Container(height: 40.h,
                child: DropdownMenuItem(
                    value: "Select Office Address",
                    child: Text("Select Office Address",
                      style: styleMedium1.copyWith(color: black,
                          fontWeight: FontWeight.w600),),
                  ),),
            );
          }

        }
      ),
    );
  }

  Widget roleDropDown(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
      child: StreamBuilder<List<dynamic>>(
          stream: roleList?.stream,
          builder: (context, snapshot) {
            if(snapshot.hasData && snapshot.data!.length > 1){
              print("SNAP ${snapshot.data?.length}");
              snapshot.data?.forEach((element) { print(element); });
              return DropdownButtonHideUnderline(
                child: DropdownButtonFormField(
                  value: roleDropdown,
                  isExpanded: true,
                  autovalidateMode: autoValidateMode,
                  decoration: const InputDecoration(border: InputBorder.none),
                  validator: validateRoleDropDown,
                  icon: const Icon(Icons.keyboard_arrow_down,color: black,),
                  items: snapshot.data?.map((dynamic items) {
                    return DropdownMenuItem(
                      value: items ?? "",
                      child: Text(items ?? "",
                        style: styleMedium1.copyWith(color: black,
                            fontWeight: FontWeight.w600),),
                    );
                  }).toList(),
                  onChanged: (dynamic newValue) {
                    setState(() {
                      roleDropdown = newValue!;

                    });
                  },
                ),
              );
            }
            else {
              return Container(height: 40.h,
                child: DropdownMenuItem(
                  value: "Select Role",
                  child: Text("Select Role",
                    style: styleMedium1.copyWith(color: black,
                        fontWeight: FontWeight.w600),),
                ),);
            }

          }
      ),
    );
  }

  Widget departMentDropDown(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
      child: StreamBuilder<List<dynamic>>(
        stream: departmentList?.stream,
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data!.length > 1) {
            return DropdownButtonHideUnderline(
              child: DropdownButtonFormField(
                value: snapshot.data?[0],
                decoration: const InputDecoration(border: InputBorder.none),
                isExpanded: true,
                autovalidateMode: autoValidateMode,
                validator: validateDepartment,
                icon: const Icon(Icons.keyboard_arrow_down,color: black,),
                items: snapshot.data?.map((dynamic items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items,
                      style: styleMedium1.copyWith(color: black,
                          fontWeight: FontWeight.w600),),
                  );
                }).toList(),
                onChanged: (dynamic? newValue) {
                  setState(() {
                    departMentDropdown = newValue!;
                  });
                },
              ),
            );
          }else {
            return Container(height: 40.h,
              child: DropdownMenuItem(
                value: "Select Department",
                child: Text("Select Department",
                  style: styleMedium1.copyWith(color: black,
                      fontWeight: FontWeight.w600),),
              ),);
          }

        }
      ),
    );
  }

  Widget designationDropDown(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
      child: StreamBuilder<List<dynamic>>(
        stream: designationList?.stream,
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data!.length > 1){
            return DropdownButtonHideUnderline(
              child: DropdownButtonFormField(
                value: snapshot.data?[0],
                isExpanded: true,
                decoration: const InputDecoration(border: InputBorder.none),
                validator: validateDesignationDropDown,
                autovalidateMode: autoValidateMode,
                icon: const Icon(Icons.keyboard_arrow_down,color: black,),
                items: snapshot.data?.map((dynamic items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items,
                      style: styleMedium1.copyWith(color: black,
                          fontWeight: FontWeight.w600),),
                  );
                }).toList(),
                onChanged: (dynamic newValue) {
                  setState(() {
                    designationDropdown = newValue!;
                  });
                },
              ),
            );
          }else {
            return SizedBox(height: 40.h,
              child: DropdownMenuItem(
                value: "Select Designation",
                child: Text("Select Designation",
                  style: styleMedium1.copyWith(color: black,
                      fontWeight: FontWeight.w600),),
              ),);
          }

        }
      ),
    );
  }

  Widget passwordTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      validator: validateStrongPassword,
      obscureText: !_passwordVisible,
      controller: _passwordController,
      focusNode: _nodePassword,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          labelText: "Password",
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
                _passwordVisible ? AppImages.icEyePassword
                    : AppImages.icEyeClose,
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
          hintText: "Password",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: const TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget confirmPasswordTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      validator: validateStrongPassword,
      obscureText: !_confirmPasswordVisible,
      controller: _confirmPasswordController,
      focusNode: _nodeConfirmPassword,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          labelText: "Confirm Password",
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
                _confirmPasswordVisible ? AppImages.icEyePassword
                    : AppImages.icEyeClose,
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
          hintText: "Confirm Password",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: const TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget dateOfBirthField(){
    return   TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      readOnly: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _dateOfBirthController,
      focusNode: _nodeDateOfBirth,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,
      validator: validateDOB,
      onTap: () async {

        DateTime? pickedDate = await showDatePicker(
            builder: (context, child) {

              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: secondaryColor, // <-- SEE HERE
                    onPrimary: white, // <-- SEE HERE
                    onSurface: black, // <-- SEE HERE
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      primary: black, // button text color
                    ),
                  ),
                ), child: child!,
              );
            },
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2100));

        if (pickedDate != null) {
          print(
              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate =
          DateFormat('dd-MM-yyyy').format(pickedDate);
          print(
              formattedDate); //formatted date output using intl package =>  2021-03-16
          setState(() {
            _dateOfBirthController.text = formattedDate; //set output date to TextField value.
          });
        } else {}

      },
      textInputAction: TextInputAction.next,
      decoration:  InputDecoration(
          suffixIconConstraints: BoxConstraints(minHeight: 25.h,minWidth: 25.w),
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset(
              AppImages.icCalenderOutline,
              color: textGrayColor,
              // fit: BoxFit.fill,
            ),
          ),
          labelText: "Date of Birth",
          labelStyle: const TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: textGrayColor,
            fontSize: 13,
          ),
          contentPadding: const EdgeInsetsDirectional.symmetric(vertical: 22,horizontal: 20),
          fillColor:  darkTextFieldFillColor,
          filled: true,
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
          hintText: "Date of Birth",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: const TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget anniversaryDateField(){
    return   TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      readOnly: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _anniversaryDateController,
      focusNode: _nodeAnniversary,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,
      // validator: validateAnniversaryDate,
      onTap: () async {

        DateTime? pickedDate = await showDatePicker(
            builder: (context, child) {

              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: secondaryColor, // <-- SEE HERE
                    onPrimary: white, // <-- SEE HERE
                    onSurface: black, // <-- SEE HERE
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      primary: black, // button text color
                    ),
                  ),
                ), child: child!,
              );
            },
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2100));

        if (pickedDate != null) {
          print(
              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate =
          DateFormat('dd-MM-yyyy').format(pickedDate);
          print(
              formattedDate); //formatted date output using intl package =>  2021-03-16
          setState(() {
            _anniversaryDateController.text = formattedDate; //set output date to TextField value.
          });
        } else {}

      },
      textInputAction: TextInputAction.next,
      decoration:  InputDecoration(
          suffixIconConstraints: BoxConstraints(minHeight: 25.h,minWidth: 25.w),
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset(
              AppImages.icCalenderOutline,
              color: textGrayColor,
              // fit: BoxFit.fill,
            ),
          ),
          labelText: "Anniversary Date",
          labelStyle: const TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: textGrayColor,
            fontSize: 13,
          ),
          contentPadding: const EdgeInsetsDirectional.symmetric(vertical: 22,horizontal: 20),
          fillColor:  darkTextFieldFillColor,
          filled: true,
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
          hintText: "Anniversary Date",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: const TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget uploadDocument(){
    return Row(children: [

      StreamBuilder<String?>(
        stream: companyPDFFileText?.stream,
        builder: (context, snapshot) {
          return Expanded(
            child: InkWell(onTap: (){
              _pickCompanyPDFFile();
            },
              child: Container(height: 90.h,decoration :
              BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
                  border: Border.all(color: borderColor, ),color: darkTextFieldFillColor ),
                  child: selectCompanyPdfAfterWidget(snapshot.data)
               ),
            ),
          );
        }
      ),

      SizedBox(width: 10.w,),

      StreamBuilder<String?>(
        stream: aadhaarCardPDFText?.stream,
        builder: (context, snapshot) {
          return Expanded(
            child: InkWell(onTap: (){
              _pickAadhaarCardPDFFile();
            },
              child: Container(height: 90.h,decoration :
              BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
                  border: Border.all(color: borderColor, ),color: darkTextFieldFillColor ),
                  child: selectedAadhaarCardAfterWidget(snapshot.data)
              ),
            ),
          );
        }
      ),

      SizedBox(width: 10.w,),

      StreamBuilder<String?>(
        stream: photoOrCameraFile?.stream,
        builder: (context, snapshot) {
          return Expanded(
            child: InkWell(onTap: (){
              showOptions();
            },
              child: Container(height: 90.h,decoration :
              BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
                  border: Border.all(color: borderColor, ),color: darkTextFieldFillColor ),
                  child: selectedPhotoWidget(snapshot.data)
              ),
            ),
          );
        }
      ),


    ],);
  }

  Widget termAndcondition(){
    return Row(
      children: [
        SizedBox(
          width: 20.w,
          height: 20.h,
          child: Checkbox(
              side: MaterialStateBorderSide.resolveWith(
                    (states) =>  const BorderSide(
                    width: 1.0,color: secondaryColor),
              ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
            checkColor: white,
            activeColor: secondaryColor,
            focusColor: secondaryColor,
            value: agree,
            onChanged: (value) {
              setState(() {
                agree = value ?? true;
              });
            },
          ),
        ),
         SizedBox(width: 15.w,),
         Text('I Agree With User Terms And Condition',
          style: styleSmall4.copyWith(
            color: black,
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }

  Widget submitButton() {
    return ButtonView(string('label_register'),false, () async {

      // showMessageBar('COMPANY PDF FILE ${companyPDFFileText?.value}');


      print('${companyPDFFileText?.value}');
      var state = _formKey.currentState!;
      if(state.validate()){

        if(aadhaarCardPDFText!.value.length > 1 &&
            companyPDFFileText!.value.length >1
            && photoOrCameraFile!.value.length > 1){


          hideKeyboard(context);

          String firstName =  _firstNameController.text.trim().toString();
          String lastName =  _secondNameController.text..trim().toString();
          String employeeCode =  _employeeCodeController.text.trim().toString();
          String contactNumber =  _contactNumberController.text..trim().toString();
          String emailAddress =  _emailAddressController.text.trim().toString();
          String dateOfBirth =  _dateOfBirthController.text.trim().toString();
          String anniversaryDate =  _anniversaryDateController.text.trim().toString();
          String companyName =  companyNameDropdown.toString();
          String departmentName =  departMentDropdown.toString();
          String designation =  designationDropdown.toString();
          String officeAddress =  officeAddressDropdown.toString();
          String aadhaarNumber =  _aadharNumberController.toString();
          String password =  _passwordController.text.trim().toString();
          String confirmPassword =  _confirmPasswordController.text.toString();


          FormData formData = FormData.fromMap({
            "firstName" : firstName,
            "lastName" : lastName,
            "empCode" : employeeCode,
            "departmentID" : findDepartIdByName(),
            "designationID" : findDesignationIdByName(),
            "email" : emailAddress,
            "phone" : contactNumber,
            "companyID" : findCompanyIdByName(),
            "officeID" : findOfficeAddressByName(),
            "password" : password,
            "roleID" : findRoleIdByName(),
            "empAadharCard" :  await MultipartFile.fromFile(aadhaarCardPDFText?.value ?? "",
              filename: aadhaarCardPDFText?.value.split('/').last,) ?? "",
            "birthData" : dateOfBirth,
            "empIDCard" : await MultipartFile.fromFile(companyPDFFileText?.value ?? "",
              filename: companyPDFFileText?.value.split('/').last,),
            "empProfileIMg" : await MultipartFile.fromFile(photoOrCameraFile?.value ?? "",
              filename: photoOrCameraFile?.value.split('/').last,),
            "joiningDate" : anniversaryDate,

          });

          print("FORM DATA  ${formData.fields.toString()}");

          Map requestData = {
            "firstName" : firstName,
            "lastName" : lastName,
            "empCode" : employeeCode,
            "departmentID" : findDepartIdByName(),
            "designationID" : findDesignationIdByName(),
            "email" : emailAddress,
            "phone" : contactNumber,
            "companyID" : findCompanyIdByName(),
            "officeID" : 10,
            "password" : password,
            "roleID" : -2,
            "empAadharCard" : "",
            "birthData" : dateOfBirth,
            "empIDCard" : formData,
            "empProfileIMg" : "",
            "joiningDate" : anniversaryDate
          };


          getBloc().doRegister(formData, (response) {
            String status = response.responseType ?? success;

            if(status.toLowerCase() == success){
              showThankYouDialog(context,_firstNameController.text.toString());
            }
            else if(status.toLowerCase() == failed) {
              showMessageBar('Failed :  ${response.message ?? ""}');
            }
            else {
              showMessageBar('ERROR :${response.message ?? ""}');
            }

          },);

        }
       else if(!agree){
          showMessageBar("Please Agree Terms And Condition");
        }
        else {
          showMessageBar("Please Upload Document or Photo ");
        }


      }
      else if(!agree){
        showMessageBar("Please Agree Terms And Condition");
      }
    });
  }


  void showThankYouDialog(BuildContext context, String name) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.8),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  ImageView(
                    height: 78.h,
                    width: 65.w,
                    boxFit:  BoxFit.fitHeight,
                    image: AppImages.recruitmentImage,
                    imageType: ImageType.asset,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Mr/Mrs. $name ',
                    textAlign: TextAlign.start,
                    style: styleMedium2.copyWith(
                        decoration: TextDecoration.none,
                        color: black,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    string("label_register_dialog_header"),
                    textAlign: TextAlign.start,
                    style: styleSmall4.copyWith(
                        decoration: TextDecoration.none,
                        color: black,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 18,horizontal: 18),
                    child: ButtonView("Done",false, () {
                      Navigator.pop(context);
                      Navigator.pushAndRemoveUntil(context, LoginScreen.route(),(route) => false);
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  _pickCompanyPDFFile() async {
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
        type: FileType.custom,
      allowedExtensions: ['pdf']
    );

    if(filePickerResult != null &&
        filePickerResult.files.single.path != null)
    {

      PlatformFile file = filePickerResult.files.first;
      if(file.extension ==  "pdf"){
        File file = File(filePickerResult.files.single.path!);
        companyPDFFileText?.add(file.path);
      }
      else {
        showMessageBar("You have to Select only PDF format");
      }

    }

  }

  _pickAadhaarCardPDFFile() async {
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf']
    );

    if(filePickerResult != null &&
        filePickerResult.files.single.path != null){


      PlatformFile file = filePickerResult.files.first;

      if(file.extension ==  "pdf")
      {
        File file = File(filePickerResult.files.single.path!);
        aadhaarCardPDFText?.add(file.path);
      }
      else {
        showMessageBar("You have to Select only PDF format");
        aadhaarCardPDFText?.add("");
      }



    }

  }


  selectCompanyPdfAfterWidget(String? data){
    if(data?.length != null && data!.length > 1){
      return  Center(child: Image.asset(AppImages.imgPDf,
        height: 50,width: 50,));
    }else{
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SvgPicture.asset(AppImages.icScan),

          SizedBox(height: 7.h,),

          Text('Company\nEmpolye ID card\nPhoto(PDF)',
              textAlign: TextAlign.center,
              style: styleSmall3.copyWith(
                color: textGrayColor,
                fontWeight: FontWeight.w500,
              )),
        ],);
    }
  }

  selectedAadhaarCardAfterWidget(String? aadhaarCardData){
    if(aadhaarCardData != null && aadhaarCardData.length  > 1)
    {
      return  Center(child: Image.asset(AppImages.imgPDf,
        height: 50,width: 50,));
    }else{
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          SvgPicture.asset(AppImages.icCamera),

          SizedBox(height: 7.h,),

          Text("Aadhaarcard\n(Document)\n(PDF)",
              textAlign: TextAlign.center,
              style: styleSmall3.copyWith(
                color: textGrayColor,
                fontWeight: FontWeight.w500,
              )),
        ],);
    }

  }

  _pickImage() async{
    XFile? image = await imagePicker?.pickImage(source: ImageSource.gallery);

    print(image);
    if(image != null){
      photoOrCameraFile?.add(image.path);
    }
  }

 Future<Object> pickedAadhaarItemString() async {

    if(aadhaarCardPDFText!.value.isNotEmpty)
    {

      return await MultipartFile.fromFile(aadhaarCardPDFText?.value ?? "",
        filename: aadhaarCardPDFText?.value.split('/').last,) ?? "";
    }
   return "";

  }

  _pickCamera() async{
    XFile? image = await imagePicker?.pickImage(source:
    ImageSource.camera);

    if(image != null){
      photoOrCameraFile?.add(image.path);
    }
  }


  selectedPhotoWidget(String? data){

    if(data != null && data.length > 1)
    {
      return Center(child: Image.file(File(data.toString()),
        height: 60.h,
        width: 70.w,),);
    }
    else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          SvgPicture.asset(AppImages.icCamera),

          SizedBox(height: 7.h,),

          Text("Add Photo\n(upload and Live photo)",
              textAlign: TextAlign.center,
              style: styleSmall3.copyWith(
                color: textGrayColor,
                fontWeight: FontWeight.w500,
              )),
        ],);
    }

  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child:  Text('Photo Gallery',
                style: styleLarge1.copyWith(
            color: secondaryColor,
        fontWeight: FontWeight.w600,
      )),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              _pickImage();
            },
          ),
          CupertinoActionSheetAction(
            child:  Text('Camera', style: styleLarge1.copyWith(
              color: secondaryColor,
              fontWeight: FontWeight.w600,
            )),
            onPressed: () {

              Navigator.of(context).pop();

              _pickCamera();
            },
          ),
        ],
      ),
    );
  }

  void callCompanyListAPI() {

    getBloc().getCompanyList((response) {
      String status = response.responseType ?? success;

      if(status.toLowerCase() == success) {
        if (!getBloc().companyList.isClosed) {
          getBloc().companyList.add(response.responseData);

          List<dynamic> tempList = [];
          tempList.insert(0, "Select Company Name");
          getBloc().companyList.value.data?.forEach((element) {
            tempList.add(element.name);
            print('DARA ${element.name}');
          });


          companyNameList?.add(tempList);
          // print("List LENGTH ->> ${companyNameList?.value.length}");

        }
      }
      else if(status.toLowerCase() == failed){
        showMessageBar('Failed :  ${response.message ?? ""}');
      }
      else {
        showMessageBar('ERROR :${response.message ?? ""}');
      }
    },);

  }

  void callOfficeListAPI(int? companyCode){



    Map requestDate = {
      "companyID" : companyCode
    };

    getBloc().getOfficeList(companyCode.toString(),requestDate, (response) {

      String status = response.responseType ?? success;

      if(status.toLowerCase() ==  success){


        if(!getBloc().officeAddressList.isClosed) {
          getBloc().officeAddressList.add(response.responseData);


          List<dynamic>? officeTempList = [];
          officeList?.add([]);
          if (getBloc().officeAddressList.value.data?.isNotEmpty ?? false) {
            if (!officeTempList.contains("Select Office Address")) {
              officeTempList.insert(0, "Select Office Address");
            }
          }


          getBloc().officeAddressList.value.data?.forEach((element) {
            officeTempList.add(element.address);
            print('Office Address Address : ${element.address}');
          });
          officeList?.add(officeTempList ?? []);
          print("List LENGTH ->> ${officeList?.value.length}");


          ////
          officeTempList.forEach((element) {
            print("FINAL TEMP LIST ${element}");
          });
          print("FINAL LIST FOR DROP LENGTH- ()()()()() ${officeList?.value
              .length}");
          officeList?.value.forEach((element) {
            print("FINAL LIST FOR DROP ${element}");
          });
        }
      }
      else if(status.toLowerCase() == failed){
        showMessageBar('Failed :  ${response.message ?? ""}');
      }
      else {
        showMessageBar('ERROR :${response.message ?? ""}');
      }

    },);

  }

  @override
  void dispose() {
    companyNameList?.close();
    designationList?.close();
    departmentList?.close();
    officeList?.close();
    roleList?.close();
    super.dispose();
  }

  void callDepartmentAPI() {

    getBloc().getDepartmentList((response) {
      String status = response.responseType ?? success;

      if(status.toLowerCase() == success){
        if(!getBloc().departmentList.isClosed) {
          getBloc().departmentList.add(response.responseData);

          List<dynamic> tempList = [];
          tempList.insert(0, "Select Department");
          getBloc().departmentList.value.data?.forEach((element) {
            tempList.add(element.department);
          });

          departmentList?.add(tempList);
        }
      }  else if(status.toLowerCase() == failed){
        showMessageBar('Failed :  ${response.message ?? ""}');
      }
      else {
        showMessageBar('ERROR :${response.message ?? ""}');
      }
    },);
  }

  void callDesignationAPI() {

    getBloc().getDesignationList((response) {
      String status = response.responseType ?? success;

      if(status.toLowerCase() == success){
        if(!getBloc().designationList.isClosed) {
          getBloc().designationList.add(response.responseData);

          List<dynamic> tempList = [];
          tempList.insert(0, "Select Designation");
          getBloc().designationList.value.data?.forEach((element) {
            tempList.add(element.designation);
            print('DARA ${element.designation}');
          });

          designationList?.add(tempList);
          // print("List LENGTH ->> ${designationList?.value.length}");

        }
      }  else if(status.toLowerCase() == failed){
        showMessageBar('Failed :  ${response.message ?? ""}');
      }
      else {
        showMessageBar('ERROR :${response.message ?? ""}');
      }
    },);
  }

  void callRoleAPI() {

    getBloc().getRoleList((response) {
      String status = response.responseType ?? success;

      if(status.toLowerCase() == success){
        if(!getBloc().roleList.isClosed) {
          getBloc().roleList.add(
              response.responseData ?? roleData.ResponseData());

          List<dynamic> tempList = [];
          tempList.insert(0, "Select Role");
          getBloc().roleList.value.data?.forEach((element) {
            tempList.add(element.role);
            print('DARA ${element.role}');
          });

          roleList?.add(tempList);
          // print("List LENGTH ->> ${designationList?.value.length}");

        }
      }  else if(status.toLowerCase() == failed){
        showMessageBar('Failed :  ${response.message ?? ""}');
      }
      else {
        showMessageBar('ERROR :${response.message ?? ""}');
      }
    },);
  }

  String findDepartIdByName() {
    String result = "";
    if(!getBloc().departmentList.isClosed) {
      getBloc().departmentList.value.data?.forEach((element) {
        if (element.department == departMentDropdown) {
          result = element.departmentId.toString();
          print("Department ID $result");
        }
      });
    }

    return result;
  }

  String findRoleIdByName() {
    String result = "";
    if(!getBloc().roleList.isClosed) {
      getBloc().roleList.value.data?.forEach((element) {
        if (element.role == roleDropdown) {
          result = element.roleId.toString();
          print("Role ID $result");
        }
      });
    }
    return result;
  }

  String findCompanyIdByName() {
    String result = "";
    if(!getBloc().companyList.isClosed) {
      getBloc().companyList.value.data?.forEach((element) {
        if (element.name == companyNameDropdown) {
          result = element.companyId.toString();
        }
      });
    }

    return result;
  }


  String findOfficeAddressByName() {
    String result = "";
    if(!getBloc().officeAddressList.isClosed) {
      getBloc().officeAddressList.value.data?.forEach((element) {
        if (element.address == officeAddressDropdown) {
          result = element.officeId.toString();
        }
      });
    }
    return result;
  }


  String findDesignationIdByName() {

    String result = "";
    if(!getBloc().designationList.isClosed) {
      getBloc().designationList.value.data?.forEach((element) {
        if (element.designation == designationDropdown) {
          result = element.designationId.toString();
          print("Designation ID $result");
        }
      });
    }
    return result;
  }
}


