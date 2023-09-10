import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/screens/add_visitor_registation/add_visitor_registation_bloc.dart';

import '../../base/bloc/base_bloc.dart';
import '../../base/constants/app_colors.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/widgets/button_view.dart';
import '../../base/widgets/custom_page_route.dart';
import '../../utils/common_utils.dart';
import '../../utils/date_util.dart';
import '../other_details_add_visitor_registration/other_details_add_visitor_registration_screen.dart';

class AddVisitorRegistrationScreen extends BasePage<AddVisitorRegistationBloc>{
  const AddVisitorRegistrationScreen({super.key});


  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _addVisitorRegistationState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => const AddVisitorRegistrationScreen());
  }

}

class _addVisitorRegistationState extends BasePageState<AddVisitorRegistrationScreen,AddVisitorRegistationBloc>{

  AddVisitorRegistationBloc bloc = AddVisitorRegistationBloc();
  bool isSearching =false;

  String dropdownvalue = 'Designation';
  String dropdownvalue1 = 'Company Address';

  var items = [
    'Designation',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  var items2 = [
    'Company Address',
    'Value 2',
    'Value 3',
    'Value 4',
    'Value 5',
  ];


  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _purposeOfVisitController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _companyContactNumberController = TextEditingController();
  final TextEditingController _companyMailAddressController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _anniversaryDateController = TextEditingController();

  final FocusNode _nodeFirstName = FocusNode();
  final FocusNode _nodeSecondName = FocusNode();
  final FocusNode _nodepurpose = FocusNode();
  final FocusNode _nodeCompany = FocusNode();
  final FocusNode _nodeCompanyContact = FocusNode();
  final FocusNode _nodeMailAddress = FocusNode();
  final FocusNode _nodeDateOfBirth = FocusNode();
  final FocusNode _nodeAnniversary = FocusNode();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget buildWidget(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       leadingWidth: 19,
       titleSpacing: 30.w,
       leading: InkWell(onTap: (){
         Navigator.pop(context);
       },
         child: Padding(
           padding:   const EdgeInsets.only(left: 10),
           child: SvgPicture.asset(AppImages.icPrev),
         ),
       ),
       title: !isSearching ? Row(children: [


         Text('Add Visitor Registration',
             style: styleMedium2.copyWith(
               color: white,
               fontWeight: FontWeight.w600,
             )),

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
       automaticallyImplyLeading: !isSearching ? true : false,
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

           firstNameTextField(),

           SizedBox(height: 20.h,),

           secondNameTextField(),

           SizedBox(height: 20.h,),

           purposeOfTextField(),

           SizedBox(height: 20.h,),

           companyNameTextField(),

           SizedBox(height: 20.h,),

           Container(width: double.infinity,decoration :
           BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
               border: Border.all(color: borderColor, ),color: darkTextFieldFillColor ),
               child: designationDropDown()),

           SizedBox(height: 20.h,),

           Container(width: double.infinity,decoration :
           BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
               border: Border.all(color: borderColor, ),color: darkTextFieldFillColor ),
               child: companyAddressDropDown()),

           SizedBox(height: 20.h,),

           companyContactNumberTextField(),

           SizedBox(height: 20.h,),

           companyMailAddressTextField(),

           SizedBox(height: 20.h,),

           dateOfBirthField(),

           SizedBox(height: 20.h,),

           anniversaryDateField(),

           SizedBox(height: 20.h,),

            uploadPhoto(),

           SizedBox(height: 20.h,),

           uploadCardDetail(),

           SizedBox(height: 20.h,),

           submitButton()

         ],),
       ),),
     )
   );
  }


  Widget submitButton() {
    return ButtonView(string('label_next'),true, () {
      Navigator.push(context, OtherDetailsAddRegistrationScreen.route());
    });
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
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          labelText: "First Name",
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
          hintText: "First Name",
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

  Widget purposeOfTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _purposeOfVisitController,
      focusNode: _nodepurpose,
      maxLines: 4,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          labelText: "Purpose of visit",
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
          hintText: "Purpose of visit",
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget companyNameTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _companyNameController,
      focusNode: _nodeCompany,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          labelText: "Company Name",
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
          hintText: "Company Name",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget designationDropDown(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
      child: DropdownButton(
        value: dropdownvalue,
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down,color: black,),
        items: items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items,
              style: styleMedium1.copyWith(color: black,
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
        icon: const Icon(Icons.keyboard_arrow_down,color: black,),
        items: items2.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items,
              style: styleMedium1.copyWith(color: black,
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

  Widget companyContactNumberTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _companyContactNumberController,
      focusNode: _nodeCompanyContact,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          labelText: "Company Contact Number",
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
          hintText: "Company Contact Number",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget companyMailAddressTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,
          fontWeight: FontWeight.w600),
      controller: _companyMailAddressController,
      focusNode: _nodeMailAddress,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          labelText: "Company Mail Address",
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
          hintText: "Company Contact Number",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: TextStyle(
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
            DateFormat('yyyy-MM-dd').format(pickedDate);
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
            errorStyle: TextStyle(
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
          DateFormat('yyyy-MM-dd').format(pickedDate);
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

  Widget uploadPhoto(){
    return Row(children: [

      Expanded(
        child: Container(height: 90.h,decoration :
        BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
            border: Border.all(color: borderColor, ),color: darkTextFieldFillColor ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

              SvgPicture.asset(AppImages.icCamera),

                SizedBox(height: 6.h,),

                Text('Photo',
                    style: styleSmall3.copyWith(
                      color: textGrayColor,
                      fontWeight: FontWeight.w500,
                    )),
            ],)),
      ),

      SizedBox(width: 10.w,),

      Expanded(
        child: Container(height: 90.h,decoration :
        BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
            border: Border.all(color: borderColor, ),color: darkTextFieldFillColor ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SvgPicture.asset(AppImages.icCamera),

                SizedBox(height: 6.h,),

                Text("Photo I'D Proof \n(Aadharcard in pdf format only)",
                    textAlign: TextAlign.center,
                    style: styleSmall3.copyWith(
                      color: textGrayColor,
                      fontWeight: FontWeight.w500,
                    )),
              ],)),
      ),


    ],);
  }

  Widget uploadCardDetail(){
    return Row(children: [

      Expanded(
        child: Container(height: 90.h,decoration :
        BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
            border: Border.all(color: borderColor, ),color: darkTextFieldFillColor ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SvgPicture.asset(AppImages.icScan),

                SizedBox(height: 6.h,),

                Text('Card Detail \nscanner',
                    textAlign: TextAlign.center,
                    style: styleSmall3.copyWith(
                      color: textGrayColor,
                      fontWeight: FontWeight.w500,
                    )),
              ],)),
      ),

      SizedBox(width: 10.w,),

      Expanded(
        child: Container(height: 90.h,decoration :
        BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
            border: Border.all(color: borderColor, ),color: darkTextFieldFillColor ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SvgPicture.asset(AppImages.icCamera),

                SizedBox(height: 6.h,),

                Text("Visiting Card Photo",
                    textAlign: TextAlign.center,
                    style: styleSmall3.copyWith(
                      color: textGrayColor,
                      fontWeight: FontWeight.w500,
                    )),
              ],)),
      ),


    ],);
  }

  @override
  AddVisitorRegistationBloc getBloc() {
   return bloc;
  }

}