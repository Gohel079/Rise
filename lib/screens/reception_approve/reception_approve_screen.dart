import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/screens/reception_approve/reception_approve_screen_bloc.dart';
import 'package:rise_and_grow/screens/register/register_screen_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/constants/app_colors.dart';
import '../../base/constants/app_constant.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/constants/app_widgets.dart';
import '../../base/widgets/button_view.dart';
import '../../base/widgets/custom_page_route.dart';
import '../../utils/app_valid.dart';
import '../../utils/common_utils.dart';

class ReceptionApproveScreen extends BasePage{
  const ReceptionApproveScreen({super.key});


  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
   return _receptionApproveScreenState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => const ReceptionApproveScreen());
  }

}

class _receptionApproveScreenState  extends BasePageState<ReceptionApproveScreen,ReceptionApproveScreenBloc>
{

  ReceptionApproveScreenBloc bloc = ReceptionApproveScreenBloc();

  BehaviorSubject<List<dynamic>>? companyNameList;
  BehaviorSubject<List<dynamic>>? officeList;
  BehaviorSubject<List<dynamic>>? departmentList;

  String companyNameDropdown = 'Select Company Name';
  String officeAddressDropdown = 'Select Office Address';
  String departMentDropdown = 'Select Department';

  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _contactPersonNameController = TextEditingController();
  final TextEditingController _employeeCodeController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _autoTimeController = TextEditingController();
  final TextEditingController _tokenNumberController = TextEditingController();

  final FocusNode _nodeContactPersonName = FocusNode();
  final FocusNode _nodeEmployeeCode = FocusNode();
  final FocusNode _nodeDesignation = FocusNode();
  final FocusNode _nodeAutoTime = FocusNode();
  final FocusNode _nodeTokenNumber = FocusNode();

  @override
  void initState() {
    super.initState();
    companyNameList = BehaviorSubject<List<dynamic>>.seeded([]);
    officeList = BehaviorSubject<List<dynamic>>.seeded([]);
    departmentList = BehaviorSubject<List<dynamic>>.seeded([]);

    DateTime currentTime = DateTime.now();
    String formattedTime =  '${currentTime.day}/${currentTime.month}/${currentTime.year} - ${currentTime.hour}:${currentTime.minute}:${currentTime.second}';
    _autoTimeController.text =formattedTime;

  }

  @override
  void onReady() {
    super.onReady();
    callCompanyListAPI();
    callDepartmentAPI();
  }
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 19,
          titleSpacing: 30.w,

          title: Row(children: [

            InkWell(onTap: (){
              Navigator.pop(context);
            }, child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(AppImages.icPrev,height: 14.h),
            )),

            SizedBox(width: 10.w,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text('Reception Approve',
                  style: styleMedium2.copyWith(
                    color: white,
                    fontWeight: FontWeight.w600,
                  )),
            ),

          ],) ,
          automaticallyImplyLeading: false,
          backgroundColor: secondaryColor,
          actions:   [

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                 InkWell(onTap: (){

                },
                  child: SvgPicture.asset(AppImages.icNotification,
                    height: 24.h,
                    width: 24.w,),
                )
              ],)
          ],),
        body:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Container(child: Column(children: [

              Form(child: Column(children: [

                Container(width: double.infinity,decoration :
                BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
                    border: Border.all(color: borderColor, ),
                    color: darkTextFieldFillColor ),
                    child: companyNameDropDown()),

                SizedBox(height:20.h),

                Container(width: double.infinity,decoration :
                BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
                    border: Border.all(color: borderColor, ),color: darkTextFieldFillColor ),
                    child: officeAddressDropDown()),

                SizedBox(height: 20.h,),

                Container(width: double.infinity,decoration :
                BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
                    border: Border.all(color: borderColor, ),color: darkTextFieldFillColor ),
                    child: departMentDropDown()),

                SizedBox(height: 20.h,),

                contactPersonTextField(),

                SizedBox(height: 20.h,),

                employeeCodeTextField(),

                SizedBox(height: 20.h,),

                designationTextField(),

                SizedBox(height: 20.h,),

                autoTimeTextField(),

                SizedBox(height: 20.h,),

                tokenNumberTextField(),

                SizedBox(height: 20.h,),

                submitButton(),

              ],)

              )

            ],),),
          ),
        )

    );
  }

  @override
  ReceptionApproveScreenBloc getBloc() {
   return bloc;
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

  Widget contactPersonTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _contactPersonNameController,
      focusNode: _nodeContactPersonName,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      validator: validateLastName,
      decoration: const InputDecoration(
          labelText: "Contact Person Name",
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

  Widget autoTimeTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _autoTimeController,
      focusNode: _nodeAutoTime,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          labelText: "Date and Time",
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
          hintText: "Date and Time",
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
    return ButtonView(string('label_submit'),false, () async {

    });
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


}