import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/screens/home/home_screen.dart';
import 'package:rise_and_grow/screens/other_details_add_visitor_registration/otherDetailsAddRegistrationBloc.dart';

import '../../base/constants/app_colors.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/widgets/button_view.dart';
import '../../base/widgets/custom_page_route.dart';
import '../../utils/common_utils.dart';

class OtherDetailsAddRegistrationScreen  extends BasePage<OtherDetailsAddVisitorRegistrationBloc>{
  const OtherDetailsAddRegistrationScreen({super.key});


  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
   return OtherDetailsAddRegistrationScreenState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => OtherDetailsAddRegistrationScreen());
  }

}

class OtherDetailsAddRegistrationScreenState  extends BasePageState<OtherDetailsAddRegistrationScreen,OtherDetailsAddVisitorRegistrationBloc>{

  OtherDetailsAddVisitorRegistrationBloc bloc = OtherDetailsAddVisitorRegistrationBloc();
  bool isSearching =false;

  String dropdownvalue = 'Which Company visit';
  String dropdownvalue1 = 'Company address';
  String dropdownvalue2 = 'Department';

  var items = [
    'Which Company visit',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  var items2 = [
    'Company address',
    'Value 2',
    'Value 3',
    'Value 4',
    'Value 5',
  ];
  var items3 = [
    'Department',
    'Value 2',
    'Value 3',
    'Value 4',
    'Value 5',
  ];

  final TextEditingController _contactPersonNameController = TextEditingController();
  final TextEditingController _employeeCodeController = TextEditingController();
  final TextEditingController _desginationController = TextEditingController();
  final TextEditingController _tokenNumberController = TextEditingController();

  final FocusNode _nodeContactPersonName = FocusNode();
  final FocusNode _nodeEmployeeCode = FocusNode();
  final FocusNode _nodeDesignation = FocusNode();
  final FocusNode _nodeTokenNumber = FocusNode();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      leadingWidth: 19,
      titleSpacing: 30.w,

      title: !isSearching ? Row(children: [

        InkWell(onTap: (){
          Navigator.pop(context);
        }, child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(AppImages.icPrev,height: 14.h),
        )),

        SizedBox(width: 10.w,),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text('Visitor Registration',
              style: styleMedium2.copyWith(
                color: white,
                fontWeight: FontWeight.w600,
              )),
        ),

      ],) : SizedBox(
        height: 45.h,
        child: TextField(
          textAlign: TextAlign.start,
          autofocus: isSearching ? true :false,
          textAlignVertical: TextAlignVertical.center,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 15),
              hintText: 'Search Anything',
              hintStyle: styleSmall4.copyWith(
                color: secondaryColor,
                fontWeight: FontWeight.w400,
              ),
              suffixIcon: InkWell(onTap : () {
                setState(() {
                  isSearching = !isSearching;
                });
              },child: const Icon(Icons.cancel,color: secondaryColor,))
          ),),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: secondaryColor,
      actions:   [

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            !isSearching ?
            InkWell(onTap: (){
              setState(() {
                isSearching = !isSearching;
              });
            },
              child: SvgPicture.asset(
                AppImages.icSearch,
                color: white,
                height: 24.h,
                width: 24.w,
              ),
            ) : SizedBox(),
            !isSearching ? SizedBox(width: 16.w,) : SizedBox(),
            !isSearching ? SvgPicture.asset(AppImages.icNotification,
              height: 24.h,
              width: 24.w,) : SizedBox(),
            !isSearching ? SizedBox(width: 10.w,) : SizedBox(),
          ],)
      ],),
        body:  SingleChildScrollView(
          child: Container(child:
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17,vertical: 15),
            child: Column(children: [

              SizedBox(height: 10,),

              Container(width: double.infinity,decoration :
              BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
                  border: Border.all(color: borderColor, ),color: darkTextFieldFillColor ),
                  child: companyVisitDropDown()),

              SizedBox(height: 20.h,),

              Container(width: double.infinity,decoration :
              BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
                  border: Border.all(color: borderColor, ),color: darkTextFieldFillColor ),
                  child: companyAddressDropDown()),

              SizedBox(height: 20.h,),

              Container(width: double.infinity,decoration :
              BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
                  border: Border.all(color: borderColor, ),color: darkTextFieldFillColor ),
                  child: departmentDropDown()),

              SizedBox(height: 20.h,),

              contactPersonNameTextField(),

              SizedBox(height: 20.h,),

              employeeCodeTextField(),

              SizedBox(height: 20.h,),

              designationTextField(),

              SizedBox(height: 20.h,),

              tokenNumberTextField(),

              SizedBox(height: 20.h,),

              submitButton()

            ],),
          ),),
        )
    );
  }

  @override
  OtherDetailsAddVisitorRegistrationBloc getBloc() {
   return bloc;
  }

  Widget companyVisitDropDown(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
      child: DropdownButton(
        value: dropdownvalue,
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down,color: textGrayColor,),
        items: items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items,
              style: styleMedium1.copyWith(color: textGrayColor,
                  fontWeight: FontWeight.w600),),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            dropdownvalue = newValue!;
          });
        },
      ),
    );
  }

  Widget companyAddressDropDown(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
      child: DropdownButton(
        value: dropdownvalue1,
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down,color: textGrayColor,),
        items: items2.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items,
              style: styleMedium1.copyWith(color: textGrayColor,
                  fontWeight: FontWeight.w600),),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            dropdownvalue1 = newValue!;
          });
        },
      ),
    );
  }

  Widget departmentDropDown(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
      child: DropdownButton(
        value: dropdownvalue2,
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down,color: textGrayColor,),
        items: items3.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items,
              style: styleMedium1.copyWith(color: textGrayColor,
                  fontWeight: FontWeight.w600),),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            dropdownvalue2 = newValue!;
          });
        },
      ),
    );
  }

  Widget contactPersonNameTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,
          fontWeight: FontWeight.w600),
      controller: _contactPersonNameController,
      focusNode: _nodeContactPersonName,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          labelText: "Contact Person Name",
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
          hintText: "Contact Person Name",
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

  Widget designationTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _desginationController,
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
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget tokenNumberTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _tokenNumberController,
      focusNode: _nodeTokenNumber,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          labelText: "Token Number",
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
          hintText: "Token Number",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget submitButton() {
    return ButtonView(string('label_submit'),true, () {
      Navigator.push(context, HomeScreen.route());
      showApprovedDialog();
    });
  }

  void showApprovedDialog(){
    showAdaptiveDialog
      (barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.8)
      ,context: context, builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(color:
              Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Image.asset(AppImages.imgApproveLoader),
                    SizedBox(
                      height: 20.h,
                    ),

                    Text('Your Registration from success fully summited\nYou can login after approved by\nMr Pradeep Patel',
                      textAlign: TextAlign.center,
                      style: styleSmall4.copyWith(
                          decoration: TextDecoration.none,
                          color: lightBlack,
                          fontWeight: FontWeight.w500),
                    ),

                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 18,horizontal: 18),
                      child: ButtonView("Done",false, () {
                        Navigator.pop(context);
                      }),
                    ),




                  ],
                ),
              ),
            ),
          ),
        );
      },);
  }
}