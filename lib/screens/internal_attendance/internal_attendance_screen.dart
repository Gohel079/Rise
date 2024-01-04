import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/base/src_bloc.dart';
import 'package:rise_and_grow/screens/internal_attendance/internal_attendance_bloc.dart';
import 'package:rise_and_grow/screens/internal_attendance/single_item_internal_attendace_team_member.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/constants/app_colors.dart';
import '../../base/constants/app_constant.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/constants/app_widgets.dart';
import '../../base/widgets/button_view.dart';
import '../../base/widgets/custom_page_route.dart';
import '../../remote/model/get_employee_list_response_model.dart'as getEmployeeData;
import '../../utils/common_utils.dart';
import '../internal_team_selection/internal_team_selection_bloc.dart';

class InternalAttendanceScreen extends BasePage<InternalAttendanceBloc>{
  const InternalAttendanceScreen({super.key});



  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return InternalAttendanceState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => const InternalAttendanceScreen());
  }

}

class InternalAttendanceState  extends BasePageState<InternalAttendanceScreen,InternalAttendanceBloc>{

  InternalAttendanceBloc bloc = InternalAttendanceBloc();
  bool isSearching =false;
  bool checkValue = false;

  int limit = 10;
  int indexOfData = 1;
  int totalPages = 1;

  BehaviorSubject<List<getEmployeeData.Datum>>? employeeList;


  List<getEmployeeData.Datum>? selectedInternalAttendance;


  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching ? Row(children: [

          InkWell(onTap: (){
            Navigator.pop(context);
          },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(AppImages.icPrev),
            ),
          ),

          SizedBox(width: 10.w,),

          Text('Internal Attendance',
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
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
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
        automaticallyImplyLeading: !isSearching ? false : true,
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
                width: 24.w,) : const SizedBox(),
              !isSearching ? SizedBox(width: 10.w,) : SizedBox(),
            ],)
        ],),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


          Text('Internal Team Members',
              style: styleMedium3.copyWith(
                color: black,
                fontWeight: FontWeight.w600,
              )),


          SizedBox(height: 10.h,),

            Expanded(
              child: StreamBuilder<List<getEmployeeData.Datum>>(
                  stream: employeeList?.stream,
                  builder: (context, snapshot) {
                    if(snapshot.hasData && snapshot.data?.isNotEmpty == true ){

                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          // return Container(height: 10,color: Colors.black);
                          return SingleItemInternalAttendanceTeamMember(datum: snapshot.data?.elementAt(index),
                            onCheckboxChanged: (value) {
                            if(value){
                              print("Attendecea $value");
                              selectedInternalAttendance?.add(snapshot.data?.elementAt(index) ?? getEmployeeData.Datum());
                            } else {
                              selectedInternalAttendance?.remove(snapshot.data?.elementAt(index) ?? getEmployeeData.Datum());
                            }

                          },);

                        },);
                    }else {
                      return Container(color: Colors.white,height: 30,);
                    }

                  }
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: submitButton(),
            ),
        ],),
      ),
    );
  }


  Widget submitButton() {
    return ButtonView(string('label_add'),false, () {


      Map listOfEmpId = {
        "list": findSelectedEmplyoeeIdByName()
      };
      Navigator.pop(context,listOfEmpId);
    });
  }

  List<int> findSelectedEmplyoeeIdByName(){
    List<int> selectedEmpId = [];

    selectedInternalAttendance?.forEach((element) {
      selectedEmpId.add(element.empId ?? 0);
    });
    return selectedEmpId;
  }

  @override
  void initState() {
    super.initState();
    employeeList = BehaviorSubject<List<getEmployeeData.Datum>>.seeded([]);

    selectedInternalAttendance = [];
  }

  @override
  void onReady() {
    super.onReady();
    callEmployeeListAPI();
  }
  
  @override
  InternalAttendanceBloc getBloc() {
    return bloc;
  }

  Widget internalTeamMemberSingleItem(){
    return
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
      child: Row(children: [

        SizedBox(
          width: 15.w,
          height: 15.h,
          child: Checkbox(
            side: MaterialStateBorderSide.resolveWith(
                  (states) =>  const BorderSide(
                  width: 1.0,color: secondaryColor),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
            checkColor: white,
            activeColor: secondaryColor,
            focusColor: secondaryColor,
            value: checkValue,
            onChanged: (value) {
              setState(() {
                checkValue = value ?? false;
              });
            },
          ),
        ),

        SizedBox(width: 20.w,),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          Text('Andrew starus',
              style: styleMedium3.copyWith(
                color: black,
                fontWeight: FontWeight.w600,
              ))

          ,SizedBox(height:4.h,),

          Text('Admin',
              style: styleMedium2.copyWith(
                color: black,
                fontWeight: FontWeight.w400,
              )),
        ],)

      ],),
    );


      ListTile(
      horizontalTitleGap: 1,
      minVerticalPadding: 0.1,
      minLeadingWidth: 40,
      titleAlignment: ListTileTitleAlignment.center,

      leading:  SizedBox(
      width: 15.w,
      height: 15.h,
      child: Checkbox(
        side: MaterialStateBorderSide.resolveWith(
              (states) =>  const BorderSide(
              width: 1.0,color: secondaryColor),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        checkColor: white,
        activeColor: secondaryColor,
        focusColor: secondaryColor,
        value: checkValue,
        onChanged: (value) {
          setState(() {
            checkValue = value ?? false;
          });
        },
      ),
    ),
      title:  Text('Andrew starus',
          style: styleMedium3.copyWith(
            color: black,
            fontWeight: FontWeight.w600,
          )),
    subtitle:  Text('Admin',
        style: styleMedium2.copyWith(
          color: black,
          fontWeight: FontWeight.w400,
        )),);
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
            print(" ${bloc.employeeList.value.length}");
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
    List<getEmployeeData.Datum> tempList = [];

    if(!bloc.employeeList.isClosed) {
      for (var element in bloc.employeeList.value) {
        Object str = "${element.firstName} ${element.lastName} - ${element
            .designation?.designation ?? ""}";

        // if (!tempList.contains(str)) {
          tempList.add(element);
          // "${element.firstName} ${element.lastName} - ${element.designation?.designation ?? ""}");
        // }
      }
      if(!employeeList!.isClosed){
        employeeList?.add(tempList);
      }
    }
  }
}