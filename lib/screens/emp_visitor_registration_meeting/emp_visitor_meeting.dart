import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/base/constants/app_colors.dart';
import 'package:rise_and_grow/base/constants/app_constant.dart';
import 'package:rise_and_grow/remote/model/get_visitorlist_by_employee_id_response_model.dart' as empVisitor;
import 'package:rise_and_grow/screens/add_visitor_registation/add_visitor_registation_screen.dart';
import 'package:rise_and_grow/screens/emp_visitor_create_meeting_approve/emp_visitor_create_meeting_approve.dart';
import 'package:rise_and_grow/screens/emp_visitor_registration_meeting/emp_visitor_meeting_bloc.dart';
import 'package:rise_and_grow/screens/emp_visitor_registration_meeting/emp_visitor_registration_item.dart';
import 'package:rise_and_grow/screens/visitor_approve/visitor_approve_screen.dart';
import 'package:rise_and_grow/screens/visitor_registation/visitor_registation_bloc.dart';
import 'package:rise_and_grow/screens/visitor_registation/visitor_registration_item.dart';
import 'package:rise_and_grow/utils/shared_pref_utils.dart';

import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/constants/app_widgets.dart';
import '../../base/widgets/custom_page_route.dart';
import '../reception_approve/reception_approve_screen.dart';

class EmpVisitorMeeting extends BasePage<EmpVisitorMeetingBloc>{
  const EmpVisitorMeeting({super.key});


  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _empVisitorMeetingState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => const EmpVisitorMeeting());
  }

}

class _empVisitorMeetingState extends BasePageState<EmpVisitorMeeting,EmpVisitorMeetingBloc>{

  EmpVisitorMeetingBloc bloc = EmpVisitorMeetingBloc();
  bool isSearching =false;

  int limit = 10;
  int indexOfData = 1;
  int totalPages = 1;

  List<String> tabList = [
    "ALL",
    "Today",
    "Upcoming",
    "Canceled",
    "Completed"
  ];

  var selectedIndex = 0;


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
            onChanged: onSearch,
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
      body:  Container(child:
      Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(children: [

          const SizedBox(height: 10,),

          tabView(),

          SizedBox(height: 10.h,),


          employeeMeetingUI()
        ],),
      ),),
      floatingActionButton: FloatingActionButton(backgroundColor: lightred,
        child: const Icon(Icons.add,color: white,size: 40,),onPressed: ()
        { Navigator.push(context, AddVisitorRegistrationScreen.route()); },),
    );
  }

  Widget tabView(){
    return Container(height: 40.h,
        color: Colors.white,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tabList.length,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: (){
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: singleTabItem(tabList[index],selectedIndex,index));
          },));
  }

  Widget singleTabItem(String itemName, int selectedIndex, int index){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        decoration:
        BoxDecoration(color: selectedIndex==index ? secondaryColor :tabBG,
            borderRadius: BorderRadius.circular(7)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 15),
          child: Center(child: Text(itemName,
              style: styleSmall4.copyWith(
                color: selectedIndex == index ?white : secondaryColor,
                fontWeight: FontWeight.w600,
              ))),
        ),),
    );
  }


  Widget employeeMeetingUI(){
    return Expanded(
      child: StreamBuilder<List<empVisitor.Datum>>(
          stream: getBloc().getEmpVisitorList.stream,
          builder: (context, snapshot) {
            if(snapshot.hasData && snapshot.data?.isNotEmpty == true ) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  print("Employee ${snapshot.data?.elementAt(index).tokenNumber}");

                  return
                    InkWell(onTap: () {

                      Navigator.push(context, EmpVisitorCreateMeetingApproveScreen.route(
                          selectVisitorList(snapshot.data?.elementAt(index)),
                          snapshot.data?.elementAt(index).purposeOfMeeting ?? "",
                          selectEmpList(snapshot.data?.elementAt(index)),
                          snapshot.data?.elementAt(index).requestId.toString()));

                    },child: EmpVisitorRegistrationItem(data: selectVisitorList(snapshot.data?.elementAt(index))));
                },);
            }else {
              return const SizedBox();
            }
          }
      ),
    );
  }

  @override
  EmpVisitorMeetingBloc getBloc() {
    return bloc;
  }


  empVisitor.ReqRequestMap? selectVisitorList(empVisitor.Datum? datum){
    empVisitor.ReqRequestMap?  result;
    datum?.reqRequestMap?.forEach((element) {
      if(element.visitorId != null && element.reqVisitorMap?.isMeetingRequester == true){

        result = element;
      }
    });
    return result;
  }

  empVisitor.ReqEmployeeMap? selectEmpList(empVisitor.Datum? datum){
    empVisitor.ReqEmployeeMap?  result;
    datum?.reqRequestMap?.forEach((element) {
      if(element.empId != null){

        result = element.reqEmployeeMap;
      }
    });
    return result;
  }

  @override
  void onReady() {
    super.onReady();
    callAccordingEmployeeName();
  }

  @override
  void initState() {
    super.initState();

  }





  void onSearch(String text){
    // getBloc().onSearch(text);
  }

  void callAccordingEmployeeName() {
    if(indexOfData <= totalPages) {

      Map<String, dynamic> param = {
        "empID": int.parse(getEmployeeId()),
        // "limit": limit,
        // "page": indexOfData,
        // "sort": "DESC",
        // "sortBy": "createdAt",
        // "search": "client-k"
      };
      
      

      bloc.getEmpVisitorMeetingList(int.parse(getEmployeeId()),(response) {
        String status = response.responseType ?? success;

        if (status.toLowerCase() == success) {

          totalPages  = response.responseData?.lastPage ?? 0;
          print("Total Page ${totalPages}");
          print("IndexOFData Page ${indexOfData}");
          // print("Total Page ${indexOfData}");

          if (!getBloc().getEmpVisitorList.isClosed) {
            // getBloc().getVisitorList.add(response.responseData?.data ?? []);
            print("GetVisitorList ->> ${getBloc().getEmpVisitorList.value.length}");

            List<empVisitor.Datum> tempList = bloc.getEmpVisitorList.value ?? [];
            tempList.addAll(response.responseData?.data ?? []);


            bloc.getEmpVisitorList.add(tempList);
            bloc.originalVisitorList = tempList;
          }
          indexOfData++;
          callAccordingEmployeeName();

        }
        else if (status.toLowerCase() == failed) {
          showMessageBar('Failed :  ${response.message ?? ""}');
        }
        else {
          showMessageBar('ERROR :${response.message ?? ""}');
        }
      },);
    }
  }
}