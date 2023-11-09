import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/screens/internal_team_selection/internal_team_selection_bloc.dart';
import 'package:rise_and_grow/screens/start_meeting/start_meeting_screen.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rise_and_grow/remote/model/get_employee_list_response_model.dart' as getEmployeeData;

import '../../base/constants/app_colors.dart';
import '../../base/constants/app_constant.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/constants/app_widgets.dart';
import '../../base/widgets/button_view.dart';
import '../../base/widgets/custom_page_route.dart';
import '../../remote/model/internal_team_member_model.dart';
import '../../utils/common_utils.dart';

class InternalTeamSelectionScreen extends BasePage<InternalTeamSelectionBloc>{
  const InternalTeamSelectionScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return InternalTeamSelectionState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => const InternalTeamSelectionScreen());
  }

}

class InternalTeamSelectionState extends BasePageState<InternalTeamSelectionScreen,InternalTeamSelectionBloc> {

  InternalTeamSelectionBloc bloc = InternalTeamSelectionBloc();
  bool isSearching =false;

  BehaviorSubject<getEmployeeData.Datum>? selectedTeamMember;
  BehaviorSubject<List<getEmployeeData.Datum>>? selectedTeamMemberList;

  int limit = 10;
  int indexOfData = 1;
  int totalPages = 1;

  BehaviorSubject<List<getEmployeeData.Datum>>? employeeList;


  @override
  void initState() {
    super.initState();
    selectedTeamMember = BehaviorSubject<getEmployeeData.Datum>.seeded(getEmployeeData.Datum());
    selectedTeamMemberList = BehaviorSubject<List<getEmployeeData.Datum>>.seeded([]);
    employeeList = BehaviorSubject<List<getEmployeeData.Datum>>.seeded([]);


    List<InternalTeamMemberModel>? list = [];
    list.add(InternalTeamMemberModel("Madhavesh","Flutter"));
    list.add(InternalTeamMemberModel("Andrew","HR"));
    list.add(InternalTeamMemberModel("Simns","Accountatn"));
    list.add(InternalTeamMemberModel("Raju","Sr.Dev"));
    list.add(InternalTeamMemberModel("Rahul","Flutter"));

    // teamMemberList?.add(list);
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
             child: Text('Internal Team Selection',
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
       body:     Column(
        crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [



           Expanded(
             child: SingleChildScrollView(
               child: Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 17),
                     child:

                     StreamBuilder<List<getEmployeeData.Datum>>(
                       stream: selectedTeamMemberList?.stream,
                       builder: (context, snapshot) {
                         if(snapshot.hasData && snapshot.data?.isNotEmpty == true){
                           return Align(
                             alignment: Alignment.topLeft,
                             child: Container(
                               height: 90.h,
                               // width: double.infinity,
                               child: ListView.builder(
                                 itemCount: snapshot.data?.length,
                                 shrinkWrap: true,
                                 scrollDirection: Axis.horizontal,
                                 itemBuilder: (context, index) {
                                   return roundedSelectedMemberList(snapshot.data?[index],index);
                                 },),
                             ),
                           );
                         }else {
                           return Container(height: 90.h,);
                         }

                       }

                     )
                    
                   ),


                   const Divider(color: borderColor,thickness: 2,)


                   , Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 17),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [

                         Text('Internal Team Members',
                             style: styleMedium2.copyWith(
                               color: lightBlack,
                               fontWeight: FontWeight.w600,
                             )),


                         SizedBox(height: 20.h,),

                         StreamBuilder<List<getEmployeeData.Datum>>(
                           stream: employeeList?.stream,
                           builder: (context, snapshot) {
                             if(snapshot.hasData && snapshot.data?.isNotEmpty == true ){

                               return ListView.builder(
                                 itemCount: snapshot.data?.length,
                                 physics: const NeverScrollableScrollPhysics(),
                                 shrinkWrap: true,
                                 itemBuilder: (context, index) {
                                   return teamMemberSingleItem(snapshot.data?[index]);

                                 },);
                             }else {
                               return Container(color: Colors.white,height: 30,);
                             }

                           }
                         )
                       ],),
                   )
                 ],
               ),
             ),
           ),


           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
             child: submitButton(),
           ),
         ],
       ));
  }

  @override
  void onReady() {
    super.onReady();
    callEmployeeListAPI();
  }

  @override
  void dispose() {
    employeeList?.close();
    super.dispose();
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
    List<getEmployeeData.Datum> tempList = [];

    if(!bloc.employeeList.isClosed) {
      for (var element in bloc.employeeList.value) {
        Object str = "${element.firstName} ${element.lastName} - ${element
            .designation?.designation ?? ""}";

        if (!tempList.contains(str)) {
          tempList.add(element);
              // "${element.firstName} ${element.lastName} - ${element.designation?.designation ?? ""}");
        }
      }
      if(!employeeList!.isClosed){
        employeeList?.add(tempList);
      }
    }
  }


  Widget submitButton() {
    return ButtonView(string('label_add'),false, () {
      Navigator.push(context, StartMeetingScreen.route());
    });
  }

  Widget teamMemberSingleItem(getEmployeeData.Datum? data) {
    return InkWell(onTap: () {
      selectedTeamMember?.add(data ?? getEmployeeData.Datum());

      List<getEmployeeData.Datum> list = selectedTeamMemberList?.value ?? [];
      list.add(selectedTeamMember?.value ?? getEmployeeData.Datum());
      selectedTeamMemberList?.add(list);

      print("Selected Item List ${selectedTeamMemberList?.value.length}");
    },
      child: ListTile(contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 10,
          leading:
          data?.empProfileIMg != null ?
              CircleAvatar(
                backgroundImage: NetworkImage(data?.empProfileIMg ?? "")
              ) :
          Text("${data?.firstName![0].toUpperCase()}${data?.lastName![0].toUpperCase()}",
            style: styleSmall3.copyWith(
                color: white,
                fontWeight: FontWeight.w400
            ),
          ),
      title: Text("${data?.firstName} ${data?.lastName}" ?? "",
          overflow: TextOverflow.ellipsis,
          style: styleSmall4.copyWith(
            color: lightBlack,
            fontWeight: FontWeight.w500,
          )),
          // trailing: Text(data?.designation?.designation ?? "",
          //     overflow: TextOverflow.ellipsis,
          //     style: styleSmall4.copyWith(
          //       color: lightBlack,
          //       fontWeight: FontWeight.w400,
          //     ))
        subtitle: Text(data?.designation?.designation ?? "",
            overflow: TextOverflow.ellipsis,
            style: styleSmall4.copyWith(
              color: lightBlack,
              fontWeight: FontWeight.w400,
            )),
      ),
    );


  }


  roundedSelectedMemberList(getEmployeeData.Datum? data, int index){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: Column(mainAxisAlignment : MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack  (
            // alignment: Alignment.bottomRight,
              children :[

                Container(
                  decoration: const BoxDecoration(
                    color: redBrown,
                    shape: BoxShape.circle,
                  ), height: 60, width: 60,
                  child:
                  data?.empProfileIMg != null ?
                  CircleAvatar(
                      backgroundImage: NetworkImage(data?.empProfileIMg ?? "")
                  ) :
                  Center(
                    child: Flexible(
                      child: Column(
                        children: [
                          Text("${data?.firstName![0].toUpperCase()}",
                              style: styleSmall3.copyWith(
                                color: white,
                                fontWeight: FontWeight.w600,
                              )),
                          Text("${data?.lastName![0].toUpperCase()}",
                              style: styleSmall4.copyWith(
                                color: white,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                    ),
                  ),
                  ),

                /*Container(
                               height :60,width:60,
                               decoration: BoxDecoration(color: redBrown,borderRadius:
                               BorderRadius.circular(40)),
                               child: Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 5,
                                     vertical: 10),
                                 child: Center(
                                   child: Text('AS',
                                       style: styleMedium2.copyWith(
                                         color: white,
                                         fontWeight: FontWeight.w600,
                                       )),
                                 ),
                               ),),*/


                Positioned(
                  left: 36,
                  top: 33,
                  child: InkWell(onTap: (){
                    List<getEmployeeData.Datum> list = selectedTeamMemberList?.value ?? [];
                    list.removeAt(index);
                    selectedTeamMemberList?.add(list);
                  },
                    child: Container(
                      height: 27,
                      width: 27,
                      decoration: BoxDecoration(color: Colors.white,borderRadius:
                      BorderRadius.circular(40)),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(decoration :  const BoxDecoration(
                            color: gray4,
                            shape: BoxShape.circle),
                            child: const Icon(Icons.close_outlined,size:16,color: white,)),
                      ),
                    ),
                  ),
                ),

              ]
          ),


          SizedBox(height: 10.h,),
          Text(data?.firstName ?? "",
              style: styleSmall3.copyWith(
                color: lightBlack,
                fontWeight: FontWeight.w400,
              ))
        ],
      ),
    );
  }

  @override
  InternalTeamSelectionBloc getBloc() {
  return bloc;
  }

}
