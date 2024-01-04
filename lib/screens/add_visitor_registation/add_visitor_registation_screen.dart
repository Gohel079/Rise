
import 'dart:io' as IO;

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/base/constants/app_constant.dart';
import 'package:rise_and_grow/screens/add_visitor_registation/add_visitor_person_details.dart';
import 'package:rise_and_grow/screens/add_visitor_registation/add_visitor_registation_bloc.dart';
import 'package:rise_and_grow/utils/app_valid.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/bloc/base_bloc.dart';
import '../../base/constants/app_colors.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/constants/app_widgets.dart';
import '../../base/widgets/button_view.dart';
import '../../base/widgets/custom_page_route.dart';
import '../../utils/common_utils.dart';
import '../../utils/date_util.dart';
  import 'package:rise_and_grow/remote/model/get_employee_list_response_model.dart' as getEmployeeData;
import '../home/home_screen.dart';
import '../other_details_add_visitor_registration/other_details_add_visitor_registration_screen.dart';
import '../reception_approve/reception_approve_screen.dart';

class AddVisitorRegistrationScreen extends BasePage<AddVisitorRegistrationBloc>{
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

class _addVisitorRegistationState extends BasePageState<AddVisitorRegistrationScreen,AddVisitorRegistrationBloc>{

  AddVisitorRegistrationBloc bloc = AddVisitorRegistrationBloc();
  bool isSearching =false;

  String contactPersonValue = '';
  String dropdownvalue1 = 'Company Address';


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
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _companyMailAddressController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _anniversaryDateController = TextEditingController();
  final TextEditingController _companyAddressController = TextEditingController();

  final FocusNode _nodeFirstName = FocusNode();
  final FocusNode _nodeSecondName = FocusNode();
  final FocusNode _nodepurpose = FocusNode();
  final FocusNode _nodeCompany = FocusNode();
  final FocusNode _nodeDesignation = FocusNode();
  final FocusNode _nodeCompanyContact = FocusNode();
  final FocusNode _nodeMailAddress = FocusNode();
  final FocusNode _nodeDateOfBirth = FocusNode();
  final FocusNode _nodeAnniversary = FocusNode();
  final FocusNode _nodeCompanyAddress = FocusNode();

  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  int limit = 10;
  int indexOfData = 1;
  int totalPages = 1;

  BehaviorSubject<List<dynamic>>? employeeList;
  BehaviorSubject<List<Map<dynamic,dynamic>>>? personDataList;
  List<Map<dynamic,dynamic>> personTempList = [];


  List<Widget> views = [];
  int viewCount = 0;

  BehaviorSubject<String>? photoOrCameraFile;
  BehaviorSubject<String>? aadhaarCardPDFText;
  BehaviorSubject<String>? visitingCardPhoto;
  ImagePicker? imagePicker  = ImagePicker();

  @override
  void initState() {
    super.initState();
    employeeList = BehaviorSubject<List<dynamic>>.seeded([]);
    personDataList = BehaviorSubject<List<Map<dynamic,dynamic>>>.seeded([]);
    photoOrCameraFile = BehaviorSubject<String>.seeded("");
    visitingCardPhoto = BehaviorSubject<String>.seeded("");
    aadhaarCardPDFText = BehaviorSubject<String>.seeded("");
    // tempList.insert(0, "Select Contact Person Name");
  }


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

             ],)
         ],),
     body:  SingleChildScrollView(
       child: Container(child:
        Padding(
         padding: const EdgeInsets.symmetric(horizontal: 17,vertical: 15),
         child: Form(
           key: _formKey,
           child: Column(children: [

              SizedBox(height: 10.h),

             firstNameTextField(),

             SizedBox(height: 20.h,),

             secondNameTextField(),

             SizedBox(height: 20.h,),

             purposeOfTextField(),

             SizedBox(height: 20.h,),

             companyNameTextField(),

             SizedBox(height: 20.h,),


             designationTextField(),
             /*Container(width: double.infinity,decoration :
             BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
                 border: Border.all(color: borderColor, ),color: darkTextFieldFillColor ),
                 child: designationDropDown()),*/

             SizedBox(height: 20.h,),


             Container(width: double.infinity,decoration :
             BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
                 border: Border.all(color: borderColor,)
                 ,color: darkTextFieldFillColor),
                 child: contactPersonNameDropDown()),

             SizedBox(height: 20.h,),

             companyAddressTextField(),

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

             // SizedBox(height: 20.h,),


             StreamBuilder<List<Map<dynamic,dynamic>>>(
               stream: personDataList?.stream,
               builder: (context, snapshot) {
                 if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                   return addPersonUI();
                 }else {
                   return const SizedBox();
                 }
               }
             ),

             SizedBox(height: 10.h,),


             submitButton()

           ],),
         ),
       ),),
     ),
     floatingActionButton: Visibility(visible: viewCount < 5,
       child: FloatingActionButton(backgroundColor: lightred,
       child: const Icon(Icons.add,color: white,size: 40,),onPressed: ()
         {
           addView();

           // Navigator.push(context, CreateMeetingFormScreen.route());
       },),
     )
   );
  }



  @override
  void onReady() {
    super.onReady();
    callEmployeeListAPI();
  }

  void addView() {
    if (viewCount < 5) {
      setState(() {
        viewCount++;
        showAddPersonDialog();
        // views.add(const AddVisitorPersonDetails());
      });
    } else {
      // You can show an error message or disable the button here.
    }
  }




  Widget submitButton() {
    return ButtonView(string('label_submit'),false, () async {

      var state = _formKey.currentState!;

      if(state.validate())
      {
        hideKeyboard(context);

        if(aadhaarCardPDFText!.value.length > 1 &&
            photoOrCameraFile!.value.length >1
            && visitingCardPhoto!.value.length > 1)
        {
          DateTime currentTime = DateTime.now();
          String formattedTime = '${currentTime.hour}:${currentTime
              .minute}:${currentTime.second}';



          List fNameList  = [];
          List lNameList = [];
          List designationList = [];
          List dateOfBirthList  = [];
          List anniversaryDateList  = [];
          List documentList  = [];
          List imageList  = [];



          FormData typeOfFormData = FormData();
          if(personDataList?.value.isNotEmpty ?? true){

            fNameList.add(_firstNameController.text.toString());
            personDataList?.value.forEach((element) {
              fNameList.add(element["fName"].toString());
            });

            lNameList.add(_secondNameController.text.toString());
            personDataList?.value.forEach((element) {
              lNameList.add(element["lName"].toString());
            });

            designationList.add(_designationController.text.toString());
            personDataList?.value.forEach((element) {
              designationList.add(element["designation"].toString());
            });

            dateOfBirthList.add(_dateOfBirthController.text.trim().toString());
            personDataList?.value.forEach((element) {
              dateOfBirthList.add(element["DOB"].toString());
            });

            anniversaryDateList.add(_anniversaryDateController.text.toString());
            personDataList?.value.forEach((element) {
              anniversaryDateList.add(element["aDate"].toString());
            });

            documentList.add(await MultipartFile.fromFile(aadhaarCardPDFText?.value ?? "",
              filename: aadhaarCardPDFText?.value.split('/').last,) ?? "");
            personDataList?.value.forEach((element) async {
              documentList.add(await MultipartFile.fromFile( element["document"].toString() ?? "",
                filename:  element["document"].toString().split('/').last,) ?? "");
            });


            imageList.add(await MultipartFile.fromFile(photoOrCameraFile?.value ?? "",
              filename: photoOrCameraFile?.value.split('/').last,) ?? "");

            personDataList?.value.forEach((element) async {
              imageList.add(await MultipartFile.fromFile(element["image"].toString() ?? "",
                filename: element["image"].toString().split('/').last,) ?? "");
            });

            typeOfFormData = FormData.fromMap({
              "vFirstName": fNameList,
              "vLastName": lNameList,
              "vDesignation":designationList,
              "empID": int.parse(findEmployeeIdByName()),
              // "visitors":["000","000"],
              "vDateOfBirth": dateOfBirthList,
              "vImage": imageList,
              "vIDDoc": documentList,
              "vAnniversaryDate" : anniversaryDateList,
              "vCompanyAddress":_companyAddressController.text.trim().toString(),
              "vCompanyName": _companyNameController.text.trim().toString(),
              "vCompanyEmail": _companyMailAddressController.text.trim().toString(),
              "vCompanyContact": _companyContactNumberController.text.trim().toString(),
              "purpose": _purposeOfVisitController.text.trim().toString()

             /* "vDesignation": _designationController.text.trim().toString(),
              "empID":-2,
              "vDateOfBirth":"15-05-1998",
              "vFirstName": dateOfBirthList,
              // "visitors":["ooo"],
              "vImage": await MultipartFile.fromFile(photoOrCameraFile?.value ?? "",
                filename: photoOrCameraFile?.value.split('/').last,) ?? "",
              "vIDDoc": await MultipartFile.fromFile(aadhaarCardPDFText?.value ?? "",
                filename: aadhaarCardPDFText?.value.split('/').last,) ?? "",
              "vAnniversaryDate":"10-02-2020",
              "vCompanyAddress": _companyAddressController.text.trim().toString(),
              "vCompanyName": _companyNameController.text.trim().toString(),
              "vCompanyEmail": _companyMailAddressController.text.trim().toString(),
              "vLastName": _secondNameController.text.trim().toString(),
              "vCompanyContact": int.parse(_companyContactNumberController.text.trim()),
              "purpose": _purposeOfVisitController.text.trim().toString()*/
            });


          }
          else {

            typeOfFormData = FormData.fromMap({
              "vDesignation": _designationController.text.trim().toString(),
              "empID":int.parse(findEmployeeIdByName()),
              "vDateOfBirth":_dateOfBirthController.text.trim().toString(),
              "vFirstName": _firstNameController.text.trim().toString(),
              // "visitors":["ooo"],
              "vImage": await MultipartFile.fromFile(photoOrCameraFile?.value ?? "",
                filename: photoOrCameraFile?.value.split('/').last,) ?? "",
              "vIDDoc": await MultipartFile.fromFile(aadhaarCardPDFText?.value ?? "",
                filename: aadhaarCardPDFText?.value.split('/').last,) ?? "",
              "vAnniversaryDate":_anniversaryDateController.text.trim().toString(),
              "vCompanyAddress": _companyAddressController.text.trim().toString(),
              "vCompanyName": _companyNameController.text.trim().toString(),
              "vCompanyEmail": _companyMailAddressController.text.trim().toString(),
              "vLastName": _secondNameController.text.trim().toString(),
              "vCompanyContact": int.parse(_companyContactNumberController.text.trim()),
              "purpose": _purposeOfVisitController.text.trim().toString()


            });

          }



          getBloc().doVisitorRegistration(typeOfFormData, (response) {
            String status = response.responseType ?? success;

            if (status.toLowerCase() == success) {
              Navigator.push(context, HomeScreen.route());
              showApprovedDialog(_firstNameController.text.toString(),
                  _secondNameController.text.toString());
              // showMessageBar("Your Registration Done");
            }
            else if (status.toLowerCase() == failed) {
              showMessageBar('Failed :  ${response.message ?? ""}');
            }
            else {
              showMessageBar('ERROR :${response.message ?? ""}');
            }
          });
        } else {
          showMessageBar("Please Upload Document or Photo ");
        }

      }
      // Navigator.push(context, OtherDetailsAddRegistrationScreen.route());
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
      validator: validateFirstName,
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
      validator: validateLastName,
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
      validator: validatePurposeOfVisit,
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
      validator: validateCompanyNameFillUp,
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

  Widget contactPersonNameDropDown(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
      child: StreamBuilder<List<dynamic>>(
        stream: employeeList?.stream,
        builder: (context, snapshot) {
          if(snapshot.data != null && snapshot.hasData && snapshot.data!.length > 1){
            return DropdownButtonHideUnderline(
              child: DropdownButtonFormField(
                // value: contactPersonValue,
                isExpanded: true,
                // isDense: false,
                validator: validateContactPersonNameDropDown,
                autovalidateMode: autoValidateMode,
                decoration: const InputDecoration(border: InputBorder.none),
                hint: Text("Select Contact Person Name",
                  style: styleMedium1.copyWith(color: textGrayColor,
                      fontWeight: FontWeight.w600),),
                icon: const Icon(Icons.keyboard_arrow_down,color: black,),
                items: [

                  DropdownMenuItem(value: "", child: Text("Select Contact Person Name",
                    style: styleMedium1.copyWith(color: black,
                        fontWeight: FontWeight.w600),)),

                  ...?snapshot.data?.map<DropdownMenuItem<String>>((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e,
                        style: styleMedium1.copyWith(color: black,
                            fontWeight: FontWeight.w600),),
                    );
                  },).toList()

                ]
                ,onChanged: (dynamic newValue) {
                  setState(() {
                    contactPersonValue = newValue!;
                    print("Employee IDDD---- ${findEmployeeIdByName()}");
                  });
                },
              ),
            );
          }
          else{
          return Container(height: 40.h,
              child: DropdownMenuItem(
                value: "Select Contact Person Name",
                child: Text("Select Contact Person Name",
                  style: styleMedium1.copyWith(color: black,
                      fontWeight: FontWeight.w600),),
              ),);
          }

        }
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
      validator: validateDesignation,
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

  Widget companyAddressTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _companyAddressController,
      validator: validateCompanyAddress,
      focusNode: _nodeCompanyAddress,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          labelText: "Company Address",
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
          hintText: "Company Address",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
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
      validator: validateMobile,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.number,
      maxLength: 10,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          counterText: "",
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
      validator: validateEmail,
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
          hintText: "Company Mail Address",
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
        validator: validateDOB,
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
              initialDate: DateTime(2000),
              firstDate:DateTime(1950),
              //DateTime.now() - not to allow to choose before today.
              lastDate:  DateTime.now().subtract(const Duration(days: 365 * 18)));

          if (pickedDate != null) {
            print(pickedDate);
            String formattedDate = DateFormat('MM-dd-yyyy').format(pickedDate);
            print(formattedDate); //formatted date output using intl package =>  2021-03-16
            setState(() {
              _dateOfBirthController.text = formattedDate; //set output date to TextField value.
            });
          } else {
            
          }

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
          DateFormat('MM-dd-yyyy').format(pickedDate);
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

  void showApprovedDialog(String fName, String lName){
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

                    Text('Your Registration from success fully summited\nYou can login after approved by\nMr/Mrs $fName $lName',
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

  Widget uploadPhoto(){
    return Row(children: [

      Expanded(
        child: StreamBuilder<String?>(
          stream:  photoOrCameraFile?.stream,
          builder: (context, snapshot) {
            return InkWell(onTap: (){
              showOptions(isFromPhoto: true);
            },
              child: Container(height: 90.h,decoration :
              BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
                  border: Border.all(color: borderColor, ),color: darkTextFieldFillColor ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      selectPhoto(snapshot.data)

                  ],)),
            );
          }
        ),
      ),

      SizedBox(width: 10.w,),

      Expanded(
        child: StreamBuilder<String?>(
          stream:  aadhaarCardPDFText?.stream,
          builder: (context, snapshot) {
            return InkWell(onTap: (){
              _pickAadhaarCardPDFFile();
            },
              child: Container(height: 90.h,decoration :
              BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
                  border: Border.all(color: borderColor, ),color: darkTextFieldFillColor ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      selectAadhaarCard(snapshot.data)
                    ],)
              ),
            );
          }
        ),
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
        child: StreamBuilder<String?>(
          stream: visitingCardPhoto?.stream,
          builder: (context, snapshot) {
            return InkWell(onTap: (){
              showOptions(isFromPhoto: false);
            },
              child: Container(height: 90.h,decoration :
              BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
                  border: Border.all(color: borderColor, ),color: darkTextFieldFillColor ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      selectedVisitingCardPhoto(snapshot.data),
                    /*  SvgPicture.asset(AppImages.icCamera),

                      SizedBox(height: 6.h,),

                      Text("Visiting Card Photo",
                          textAlign: TextAlign.center,
                          style: styleSmall3.copyWith(
                            color: textGrayColor,
                            fontWeight: FontWeight.w500,
                          )),*/
                    ],)),
            );
          }
        ),
      ),


    ],);
  }

  @override
  AddVisitorRegistrationBloc getBloc() {
   return bloc;
  }


  void callEmployeeListAPI() {

    if(indexOfData <= totalPages){


      Map<String,dynamic> param  = {
        "limit" : limit,
        "page" :indexOfData,
        "sort" : "DESC",
        "sortBy" : "createdAt",
        "search" : "client-k"
      };

      bloc.doGetApiEmployeeList(param,(response) {
        String status = response.responseType ?? success;

        if(status.toLowerCase() == success)
        {
          totalPages  = response.responseData?.lastPage ?? 0;

          print("Total Page ${totalPages}");

          if(!bloc.employeeList.isClosed) {
            List<getEmployeeData.Datum> tempList = bloc.employeeList.value ?? [];
            tempList.addAll(response.responseData?.data ?? []);


            bloc.employeeList.add(tempList);
          }

          indexOfData++;
          callEmployeeListAPI();
        }
        else if(status.toLowerCase() == failed){
          showMessageBar('Failed :  ${response.message ?? ""}');
        }
        else {
          showMessageBar('ERROR :${response.message ?? ""}');
        }


      },);
    }else{
      addEmployeeData();
    }


  }

  void addEmployeeData() {
    List<dynamic> tempList = [];

    if(!bloc.employeeList.isClosed) {
      for (var element in bloc.employeeList.value) {
        Object str = "${element.firstName} ${element.lastName} - ${element
            .designation?.designation ?? ""}";

        if (!tempList.contains(str)) {
          tempList.add(
              "${element.firstName} ${element.lastName} - ${element.designation
                  ?.designation ?? ""}");
        }
      }
      if(!employeeList!.isClosed){
        employeeList?.add(tempList);
      }
    }
  }

 Widget addPersonUI() {
    return Column(children: [

      SizedBox(height: 20.h,),

      const Divider(height: 1,thickness: 1,color: lightGray,),

      SizedBox(height: 20.h,),



      StreamBuilder<List<Map<dynamic,dynamic>>>(
        stream: personDataList?.stream,
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data!.isNotEmpty)
          {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: personData(snapshot.data?.elementAt(index),index),
                );
              },);
          }else {
           return const SizedBox();
          }

        }
      ),

      SizedBox(height: 20.h,),
    ],);
 }




  void showAddPersonDialog() {
    showAdaptiveDialog(
        barrierDismissible: false,
      context: context,
      builder: (context) {
        return  AddVisitorPersonDetails((p0) {


          if(!personDataList!.isClosed){
            personTempList = personDataList!.value;
            personTempList.add(p0);
            personDataList?.add(personTempList);


            print(personTempList.length);
            print(personDataList?.value.length);
          }

        },);
      },);
  }

  Widget personData(Map? mapData, int index){
    String? pName = mapData?["fName"] ?? "";
    String? pLName = mapData?["lName"] ?? "";
    String? pDesignation = mapData?["designation"] ?? "";
    String? pDOB = mapData?["DOB"] ?? "";
    String? pADOB = mapData?["aDate"] ?? "";
    String? pDocument= mapData?["document"] ?? "";
    String? pImage  = mapData?["image"] ?? "";
    

    return Column(
      children: [

      Align(alignment: Alignment.topLeft,
      child: Text("Person : ${index+1}",
          textAlign: TextAlign.center,
          style: styleMedium3.copyWith(
            color: secondaryColor,
            fontWeight: FontWeight.w700,
          ))),

         Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Card(
            elevation: 0.5,
            shape: RoundedRectangleBorder(borderRadius:
            BorderRadius.circular(10)),
            color: darkTextFieldFillColor ,
            child:
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12,
                  vertical: 17),
              child: Row(children: [

                SizedBox(width: 4.w),
                Expanded(flex:4,child:
                Container(
                  // width: 10,height: 100,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [


                        Row(
                          children: [

                            Icon(Icons.person_outline,size: 18,),
                            SizedBox(width: 5.w,),
                            Flexible(
                              child: Text('${pName ?? ""}  ${pLName ?? ""} ',
                                  style: styleMedium1.copyWith(
                                    color: black,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                          ],
                        ),

                        SizedBox(height: 5.h,),

                        Row(
                          children: [
                            SvgPicture.asset(
                              AppImages.icBookmark,
                              color: black,
                            ),
                            SizedBox(width: 5.w,),
                            Text(pDesignation ?? "",
                                style: styleMedium1.copyWith(
                                  color: black,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),

                        SizedBox(height: 5.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [


                            SvgPicture.asset(
                              AppImages.icCalenderOutline,
                              color: lightBlack,
                            ),
                            SizedBox(width: 6.w,),
                            Text(pDOB ?? "",
                                style: styleSmall4.copyWith(
                                  color: lightBlack,
                                  fontWeight: FontWeight.w500,
                                )),

                            SizedBox(width: 7.w,),
                            Text('|',
                                style: styleSmall4.copyWith(
                                  color: verticalDivier,
                                  fontWeight: FontWeight.w600,
                                )),

                            SizedBox(width: 7.w,),
                            SvgPicture.asset(
                              AppImages.icCalenderOutline,
                              color: lightBlack,
                            ),
                            SizedBox(width: 3.w,),
                            Flexible(
                              child: Text(pADOB ?? "",
                                  style: styleSmall4.copyWith(
                                    color: lightBlack,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                          ],),

                        // SizedBox(height: 14.h,),

                      ]),)),
                Expanded(flex:2,child:
                Container(width: 10,
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  // ,height: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


                      Container(width : 55.w,height: 55.h,decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(2))
                          ,child:  Center(child: Image.file(IO.File(pImage.toString()),
                  height: 60.h,
                  width: 70.w,),)),


                    ],),))

              ],),
            ),),
        ),
      ],
    );
  }

  Widget  selectPhoto(String? data){
    if(data != null && data.length > 1)
    {
      return Center(child: Image.file(IO.File(data.toString()),
        height: 60.h,
        width: 70.w,),);
    }
    else {
      return Column(children: [
        SvgPicture.asset(AppImages.icCamera),

        SizedBox(height: 6.h,),

        Text('Photo',
            style: styleSmall3.copyWith(
              color: textGrayColor,
              fontWeight: FontWeight.w500,
            )),
      ],);
    }
  }

  Widget  selectedVisitingCardPhoto(String? data){
    if(data != null && data.length > 1)
    {
      return Center(child: Image.file(IO.File(data.toString()),
        height: 60.h,
        width: 70.w,),);
    }
    else {
      return Column(children: [
        SvgPicture.asset(AppImages.icCamera),

        SizedBox(height: 6.h,),

        Text('Photo',
            style: styleSmall3.copyWith(
              color: textGrayColor,
              fontWeight: FontWeight.w500,
            )),
      ],);
    }
  }


  Future showOptions({bool? isFromPhoto}) async {
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
             if(isFromPhoto ?? true){
               _pickImage();
             }else{
               _pickVisitingCardImage();
             }
            },
          ),
          CupertinoActionSheetAction(
            child:  Text('Camera', style: styleLarge1.copyWith(
              color: secondaryColor,
              fontWeight: FontWeight.w600,
            )),
            onPressed: () {

              Navigator.of(context).pop();

              if(isFromPhoto ?? true){
                _pickCamera();
              }else{
                _pickVisitingCardCamera();
              }
            },
          ),
        ],
      ),
    );
  }

  _pickImage() async{
    XFile? image = await imagePicker?.pickImage(source: ImageSource.gallery);

    print(image);
    if(image != null){
      if(!photoOrCameraFile!.isClosed){
        photoOrCameraFile?.add(image.path);
      }
    }
  }

  _pickVisitingCardImage() async{
    XFile? image = await imagePicker?.pickImage(source: ImageSource.gallery);

    print(image);
    if(image != null){
      if(!visitingCardPhoto!.isClosed){
        visitingCardPhoto?.add(image.path);
      }
    }
  }

  _pickCamera() async{
    XFile? image = await imagePicker?.pickImage(source:
    ImageSource.camera);

    if(image != null){
      if(!photoOrCameraFile!.isClosed){
        photoOrCameraFile?.add(image.path);

      }
    }
  }

  _pickVisitingCardCamera() async{
    XFile? image = await imagePicker?.pickImage(source:
    ImageSource.camera);

    if(image != null){
      if(!visitingCardPhoto!.isClosed){
        visitingCardPhoto?.add(image.path);

      }
    }
  }

  selectAadhaarCard(String? aadhaarCardData){
    if(aadhaarCardData != null && aadhaarCardData.length  > 1)
    {
      return  Center(child: Image.asset(AppImages.imgPDf,
        height: 50,width: 50,));
    }else {
      return Column(
        children: [

          SvgPicture.asset(AppImages.icCamera),

          SizedBox(height: 6.h,),

          Text("Photo I'D Proof \n(Aadharcard in pdf format only)",
              textAlign: TextAlign.center,
              style: styleSmall3.copyWith(
                color: textGrayColor,
                fontWeight: FontWeight.w500,
              ))
        ],
      );
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

      if(!aadhaarCardPDFText!.isClosed){

      if(file.extension ==  "pdf")
      {
        IO.File file = IO.File(filePickerResult.files.single.path!);
        aadhaarCardPDFText?.add(file.path);
      }
      else {
        showMessageBar("You have to Select only PDF format");
        aadhaarCardPDFText?.add("");
      }
      }

    }

  }


  String findEmployeeIdByName() {

    String result = "";
    if(!getBloc().employeeList.isClosed) {
      String matchString;
      getBloc().employeeList.value.forEach((element) {
        matchString =  "${element.firstName} ${element.lastName} - ${element.designation?.designation ?? ""}";
        if (matchString == contactPersonValue) {
           result = element.empId.toString();
        }
      });
    }
    return result;
  }

  @override
  void dispose() {
    personDataList?.close();
    aadhaarCardPDFText?.close();
    photoOrCameraFile?.close();
    visitingCardPhoto?.close();
    employeeList?.close();
    super.dispose();
  }
}