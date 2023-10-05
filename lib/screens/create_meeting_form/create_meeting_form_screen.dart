import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/base/constants/app_colors.dart';
import 'package:rise_and_grow/base/constants/app_constant.dart';
import 'package:rise_and_grow/screens/add_visitor_registation/add_visitor_registation_screen.dart';
import 'package:rise_and_grow/screens/created_meeting/created_meeting_bloc.dart';
import 'package:rise_and_grow/screens/internal_team_selection/internal_team_selection_screen.dart';
import 'package:rise_and_grow/screens/set_meeting_date_&_time/set_meeting_date_and_time_screen.dart';
import 'package:rise_and_grow/screens/visitor_registation/visitor_registation_bloc.dart';
import 'package:rise_and_grow/utils/app_valid.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/constants/app_widgets.dart';
import '../../base/widgets/button_view.dart';
import '../../base/widgets/custom_page_route.dart';
import '../../utils/common_utils.dart';
import '../../utils/date_util.dart';
import 'create_meeting_form_bloc.dart';

class CreateMeetingFormScreen extends BasePage<CreateMeetingFormBloc>{
  const CreateMeetingFormScreen({super.key});


  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _creatMeetingFormScreenState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => const CreateMeetingFormScreen());
  }

}

class _creatMeetingFormScreenState extends BasePageState<CreateMeetingFormScreen,CreateMeetingFormBloc>{

  CreateMeetingFormBloc bloc = CreateMeetingFormBloc();
  bool isSearching =false;


  String typeOfMeeting = 'Type of Meeting';
  String meetingVenue = 'Meeting Venue';
  String meetingMode = 'Meeting Mode';
  String selectPlatform = 'Select Platform';

  var typeOfMeetingList = [
    'Type of Meeting',
    'Visitor',
    'Visitor 2',
    'Item 4',
    'Item 5',
  ];

  var meetingVenueList = [
    'Meeting Venue',
    'venue 2',
    'venue 3',
    'venue 4',
    'Value 5',
  ];

  var meetingModeList = [
    'Offline',
    'Online'
  ];

  var selectPlatformList = [
    'Select Platform',
    'selectPlatform 2',
    'selectPlatform 3',
    'Meeting Mode 4',
    'Meeting Mode 5',
  ];

  var selectedIndex = 0;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _meetingPurposeController = TextEditingController();
  final TextEditingController _meetingVenue = TextEditingController();
  final TextEditingController _companyContactNumberController = TextEditingController();
  final TextEditingController _externalTeamSelect = TextEditingController();
  final TextEditingController _setDateAndTimeController = TextEditingController();
  final TextEditingController _internalTeamSelect = TextEditingController();

  final FocusNode _nodeFirstName = FocusNode();
  final FocusNode _nodeSecondName = FocusNode();
  final FocusNode _nodeMeetingPurpose = FocusNode();
  final FocusNode _nodeMeetingVenue = FocusNode();
  final FocusNode _nodeCompanyContact = FocusNode();
  final FocusNode _nodeExternalTeamSelect = FocusNode();
  final FocusNode _nodeDateAndTime = FocusNode();
  final FocusNode _nodeInternalTeamSelect = FocusNode();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  BehaviorSubject<List<dynamic>>? meetingTypeList;
  BehaviorSubject<List<dynamic>>? meetingModeListForStream;

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
              child: Text('Create Meeting',
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
      body:   SingleChildScrollView(child:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17,vertical: 15),
        child:
        Column(children: [

          Form(
            key: _formKey,
            child: Column(
              children: [


                Container(width: double.infinity,decoration :
                BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
                    border: Border.all(color: borderColor, ),
                    color: darkTextFieldFillColor ),
                    child: typeOfMeetingDropDown()),

                SizedBox(height: 20.h,),

                meetingPurposeTextField(),

                SizedBox(height: 20.h,),

                Container(width: double.infinity,decoration :
                BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
                    border: Border.all(color: borderColor, ),
                    color: darkTextFieldFillColor ),
                    child: meetingVenueDropDown()),

                SizedBox(height: 20.h,),

                setDateAndTimeField(),

                SizedBox(height: 20.h,),

                Container(width: double.infinity,decoration :
                BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
                    border: Border.all(color: borderColor, ),
                    color: darkTextFieldFillColor ),
                    child: meetingModeDropDown()),


                SizedBox(height: 20.h,),

                Visibility(
                  visible: meetingMode == "Online" ? true : false,
                  child: Column(
                    children: [
                      Container(width: double.infinity,decoration :
                      BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
                          border: Border.all(color: borderColor, ),
                          color: darkTextFieldFillColor ),
                          child: selectPlatformDropDown()),

                      SizedBox(height: 20.h,),
                    ],
                  ),
                ),


                internalTeamSelection(),

                SizedBox(height: 20.h,),

                externalTeamSelection(),

                SizedBox(height: 40.h,),
              ],
            ),
          ),



          submitButton()


        ],),
      )));
  }

  Widget typeOfMeetingDropDown(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
      child: StreamBuilder<List<dynamic>>(
        stream: meetingTypeList?.stream,
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data!.length > 1){
            return DropdownButtonFormField(
              // value: typeOfMeeting,
              hint: Text("Type of Meeting",
                style: styleMedium1.copyWith(color: textGrayColor,
                  fontWeight: FontWeight.w600),),
              isExpanded: true,
              decoration: const InputDecoration(border: InputBorder.none),
              validator: validateTypeOfMeeting,
              autovalidateMode: autoValidateMode,
              icon: const Icon(Icons.keyboard_arrow_down,color: black,),
              items: snapshot.data?.map((dynamic? items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items,
                    style: styleMedium1.copyWith(color: black,
                        fontWeight: FontWeight.w600),),
                );
              }).toList(),
              onChanged: (dynamic? newValue) {
                setState(() {
                  typeOfMeeting = newValue!;
                });
              },
            );
          }else {
            return SizedBox(height: 40.h,);
          }

        }
      ),
    );
  }

  Widget meetingPurposeTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _meetingPurposeController,
      focusNode: _nodeMeetingPurpose,
      maxLines: 3,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          labelText: "Meeting Purpose",
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
          hintText: "Meeting Purpose",
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget meetingVenueDropDown(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
      child: DropdownButton(
        value: meetingVenue,
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down,color: black,),
        items: meetingVenueList.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items,
              style: styleMedium1.copyWith(color: black,
                  fontWeight: FontWeight.w600),),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            meetingVenue = newValue!;
          });
        },
      ),
    );
  }

  Widget setDateAndTimeField(){
    return   TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      readOnly: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _setDateAndTimeController,
      focusNode: _nodeDateAndTime,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,

      onTap: ()  {
        Navigator.push(context, SetMeetingDateAndTimeScreen.route());

      },
      textInputAction: TextInputAction.next,
      decoration:  InputDecoration(
          suffixIconConstraints: BoxConstraints(minHeight: 25.h,
              minWidth: 25.w),
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset(
              AppImages.icCalenderOutline,
              color: textGrayColor,
              // fit: BoxFit.fill,
            ),
          ),
          labelText: "Set Meeting Date & Time",
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
          hintText: "Set Meeting Date & Time",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: const TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget meetingModeDropDown(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
      child: DropdownButtonFormField(
        hint: Text("Meeting Mode",
          style: styleMedium1.copyWith(color: textGrayColor,
              fontWeight: FontWeight.w600),),
        isExpanded: true,
        autovalidateMode: autoValidateMode,
        validator: validateMeetingMode,
        decoration: const InputDecoration(border: InputBorder.none),
        icon: const Icon(Icons.keyboard_arrow_down,color: black,),
        items: meetingModeList.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items,
              style: styleMedium1.copyWith(color: black,
                  fontWeight: FontWeight.w600),),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            meetingMode = newValue!;
            if(meetingMode == "Online"){
              callGetMeetingModeListAPI();
            }
          });
        },
      ),
    );
  }

  Widget selectPlatformDropDown(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
      child: StreamBuilder<List<dynamic>>(
        stream: meetingModeListForStream?.stream,
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data!.length  > 1  ){
            return DropdownButtonFormField(
              hint: Text("Select Online Platform",
                style: styleMedium1.copyWith(color: textGrayColor,
                    fontWeight: FontWeight.w600),),
              isExpanded: true,
              validator:  validateMeetingPlatform,
              autovalidateMode: autoValidateMode,
              decoration: const InputDecoration(border: InputBorder.none),
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
                  selectPlatform = newValue!;
                });
              },
            );
          }else {
            return SizedBox(height: 40.h,);
          }

        }
      ),
    );
  }

  Widget internalTeamSelection(){
    return   TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      readOnly: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _internalTeamSelect,
      focusNode: _nodeInternalTeamSelect,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,

      onTap: () async {

        Navigator.push(context, InternalTeamSelectionScreen.route());

      },
      textInputAction: TextInputAction.next,
      decoration:  const InputDecoration(

          labelText: "Internal Team Selection",
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
          hintText: "Internal Team Selection",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget externalTeamSelection(){
    return   TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      readOnly: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _externalTeamSelect,
      focusNode: _nodeExternalTeamSelect,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,

      onTap: () async {


      },
      textInputAction: TextInputAction.next,
      decoration:  const InputDecoration(

          labelText: "External Team Selection",
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
          hintText: "External Team Selection",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }


  Widget submitButton() {
    return ButtonView(string('label_submit'),true, ()
    {
      onSubmit();
    });
  }

  onSubmit(){

    var state = _formKey.currentState!;

    if(state.validate()){


      Map? requestData = {

      };


      showMessageBar("SUCCESS");
    }
  }

  @override
  CreateMeetingFormBloc getBloc() {
    return bloc;
  }



  @override
  void initState() {
    super.initState();
    meetingTypeList = BehaviorSubject<List<dynamic>>.seeded([]);
    meetingModeListForStream = BehaviorSubject<List<dynamic>>.seeded([]);
  }

  @override
  onReady(){
    callGetMeetingListAPI();

  }

  callGetMeetingListAPI(){

    getBloc().getMeetingList((response) {
      String status = response.responseType ?? success;

      if(status.toLowerCase() == success){

        getBloc().meetingList.add(response.responseData);

        List<dynamic> tempList =[];
        getBloc().meetingList.value.data?.forEach((element) {
          tempList.add(element.meetingType);
        });
          meetingTypeList?.add(tempList);
        }
      else if(status.toLowerCase() == failed){
        showMessageBar('Failed :  ${response.message ?? ""}');
      }
      else {
        showMessageBar('ERROR :${response.message ?? ""}');
      }
    });
  }

  callGetMeetingModeListAPI(){

    getBloc().getMeetingModeList((response) {
      String status = response.responseType ?? success;

      if(status.toLowerCase() == success){

        getBloc().meetingModeList.add(response.responseData);

        List<dynamic> tempList =[];
        getBloc().meetingModeList.value.data?.forEach((element) {
          if(element.meetingMode != "Online"){
            tempList.add(element.meetingMode);
          }
        });
        meetingModeListForStream?.add(tempList);
      }
      else if(status.toLowerCase() == failed){
        showMessageBar('Failed :  ${response.message ?? ""}');
      }
      else {
        showMessageBar('ERROR :${response.message ?? ""}');
      }
    });
  }
}