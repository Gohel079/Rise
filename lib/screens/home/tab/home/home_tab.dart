
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/base/constants/app_colors.dart';
import 'package:rise_and_grow/screens/created_meeting/created_meeting_screen.dart';
import 'package:rise_and_grow/screens/emp_visitor_registration_meeting/emp_visitor_meeting.dart';
import 'package:rise_and_grow/screens/home/tabbarView/appointment_screen/appointment_screen.dart';
import 'package:rise_and_grow/screens/home/tabbarView/meeting_screen/meeting.dart';
import 'package:rise_and_grow/screens/home/tabbarView/site_visit_screen/site_visit_screen.dart';
import 'package:rise_and_grow/screens/notification/notification_screen.dart';
import 'package:rise_and_grow/screens/outer_meeting/outer_meeting_screen.dart';
import 'package:rise_and_grow/screens/visitor_registation/visitior_registation_screen.dart';
import 'package:rise_and_grow/screens/visitor_registation/visitor_registration_item.dart';
import 'package:rise_and_grow/utils/shared_pref_utils.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../base/constants/app_constant.dart';
import '../../../../base/constants/app_images.dart';
import '../../../../base/constants/app_styles.dart';
import '../../../../base/constants/app_widgets.dart';
import '../../../../base/widgets/custom_page_route.dart';
import '../../../../base/widgets/image_view.dart';
import '../../../../remote/model/get_visitor_list_response_model.dart' as GetVisitor;
import '../../../../utils/common_utils.dart';
import '../../../add_visitor_registation/add_visitor_registation_screen.dart';
import '../../../visitor_approve/visitor_approve_screen.dart';
import 'home_tab_bloc.dart';

class HomeTab extends BasePage<HomeTabBloc>{
  const HomeTab({super.key});


  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
   return _homeTabState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => const HomeTab());
  }
}

class _homeTabState  extends BasePageState<HomeTab,HomeTabBloc>{

 HomeTabBloc bloc  = HomeTabBloc();

 List<String> tabList = [
   "Meeting",
   "Appointment",
   "Outer Meeting"
 ];

 var selectedIndex = 0;

 int indexOfData = 1;
 int totalPages = 1;
 int limit = 10;


 List<String> chipList = ["All","Pending","Accepted","Rejected"];
 int? _value = 0;
 var selectedStatusFilter;


 late BehaviorSubject<List<GetVisitor.Datum>> getFinalVisitorList;



 @override
  void initState() {
    super.initState();
    getFinalVisitorList = BehaviorSubject<List<GetVisitor.Datum>>.seeded([]);
    // getFinalVisitorList.add(bloc.getVisitorList.value);

  }
 @override
  Widget buildWidget(BuildContext context) {

   return Scaffold(
     appBar: AppBar(
       title: Row(children: [

          CircleAvatar(
           backgroundColor: Colors.transparent,
           maxRadius: 25,
           minRadius: 24,
           backgroundImage: NetworkImage(getProfileImage()),
         ),
         SizedBox(width: 10.w,),
         Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [

             Text('Good Morning 🖐',
                 style: styleSmall3.copyWith(
                   color: white,
                   fontWeight: FontWeight.w600,
                 )),

             SizedBox(height: 3.h,),
             Text("Mr/Mrs. ${getLastName().toString()}",
                 style: styleMedium2.copyWith(
                   color: white,
                   fontWeight: FontWeight.w700,
                 )),

           ],)
       ],),

       automaticallyImplyLeading: false,
       backgroundColor: secondaryColor,
       actions:   [

         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [

             SvgPicture.asset(
               AppImages.icSearch,
               color: white,
               height: 24.h,
               width: 24.w,
             ),
             SizedBox(width: 16.w,),
           ],)
       ],),
     floatingActionButton: getRole().toString() == "Receptionist"
         ?
     FloatingActionButton(backgroundColor: secondaryColor,
       onPressed: (){

         Navigator.push(context, AddVisitorRegistrationScreen.route());

     },
       child: const Icon(Icons.add,
         color: Colors.white,),)
         : const SizedBox(),
     body: Container(
       padding: const EdgeInsets.all(22.0),
         child: Column(
       children: [

         SizedBox(height: 7.h,),

         topTabButton(),

         getRole().toString() == "Receptionist" ? const SizedBox() : SizedBox(height: 30.h,),

         /*getRole().toString() != "Receptionist" ? Align(
           alignment: Alignment.topLeft,
           child: Text('Upcoming',
               style: styleMedium2.copyWith(
                 color: black,
                 fontWeight: FontWeight.w700,
               )),
         ) : const SizedBox(),
*/
         UiChangeAsPerRoleFor(),

         SizedBox(height: 15.h,),

         tabBarItemView()
       ],
     )),
   );
  }

  @override
  void onReady() {
    super.onReady();
    if(getRole().toString() == "Receptionist"){
      callGetVisitorAPI();
      getFinalVisitorList.add(bloc.getVisitorList.value);
    }
  }

  @override
  HomeTabBloc getBloc() {
   return bloc;
  }

  Widget tabBarItemView(){
    return Expanded(child:
    getRole().toString() == "Receptionist" ?

    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

       /* Wrap(
          children: List.generate(
            chipList.length,
                (int index) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: ChoiceChip(
                  padding: const EdgeInsets.all(2),
                  label: Text(chipList[index].toString(),
                      style: styleSmall4.copyWith(
                    color: _value == index ?white : black,
                    fontWeight: FontWeight.w600,
                  )),
                  selectedColor: secondaryColor,
                  selected: _value == index,

                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected ? index : null;
                      print("Chcip Selected  $_value $selected");

                      tempList = [];
                      tempList = bloc.getVisitorList.value.where((element) {
                        return element.reqStatus?.contains("Pending") ?? true;
                      },).toList();
                      bloc.getVisitorList.add(tempList);

                      print("Chicj tempList Size ${tempList.length}");
                      print("Chicj Final Lisst Size ${bloc.getVisitorList.value.length}");
                    });
                  },
                ),
              );
            },
          ).toList(),
        ),*/

        // Wrap(
        //   children: chipList.map((status) {
        //    return ChoiceChip(label: Text(status),
        //     selected: selectedStatusFilter == status,
        //     onSelected: (value) {
        //        filterItemByStatus(status);
        //     },);
        //   }).toList(),
        // ),

        Expanded(
          child: Container(
            child:  receptionListVisitorListUI() ),
        ),
      ],
    )
        :
    Container(
      color: Colors.white,
      child: viewSelection(),)
    );
  }

  Widget viewSelection(){
    if(selectedIndex == 0) {
      return const MeetingView();
    }
    if(selectedIndex == 1 ){
      return const AppointmentScreen();
    }
    if(selectedIndex ==  2){
      return const SiteVisitScreen();
    }
    return SizedBox();
  }

  Widget tabView(){
    return Container(height: 40.h,
    color: Colors.red,
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
              style: styleMedium1.copyWith(
            color: selectedIndex == index ?white : secondaryColor,
            fontWeight: FontWeight.w600,
          ))),
        ),),
    );
  }

  Widget topTabButton(){
    return topTabButtonUIChangeAsPerRole();
  }

  Widget createMeetingBtn(){
    return InkWell(onTap: (){

      /*PersistentNavBarNavigator
          .pushNewScreen(context, screen: const CreatedMeetingScreen(),
          withNavBar: false);*/
    },
      child: Column(
        children: [
          Container(decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [

              BoxShadow(blurRadius:2,color: Colors.grey)
            ],
            color: secondaryColor,
          ),child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: SvgPicture.asset(
              AppImages.icVideo,
              height: 30,
            ),
          ),),
          SizedBox(height: 7.h,),
          Text(string("label_create_meeting"),
              textAlign: TextAlign.center,
              style:styleSmall4.copyWith(
                  color: black,
                  fontWeight: FontWeight.w500))

        ],
      ),
    );
  }

 Widget bookAnAppointmentBtn(){
   return Column(
     children: [
       Container(decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(10),
         color: magento,
         boxShadow: const [

           BoxShadow(blurRadius:2,color: Colors.grey)
         ]
       ),child: Padding(
         padding: const EdgeInsets.all(17.0),
         child: SvgPicture.asset(
           AppImages.icCalender,
           height: 30,
         ),
       ),),
       SizedBox(height: 7.h,),
       Text(string("label_book_appointment"),
           textAlign: TextAlign.center,
           style:styleSmall4.copyWith(
               color: black,
               fontWeight: FontWeight.w500))

     ],
   );
 }

 Widget outerMeetingBtn(){
   return InkWell(
     onTap: () {
       PersistentNavBarNavigator
           .pushNewScreen(context, screen: const OuterMeetingScreen(),
           withNavBar: false);
     },
     child: Column(
       children: [
         Container(decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10),
             color: outerBg,
             boxShadow: const [

               BoxShadow(blurRadius:2,color: Colors.grey)
             ]
         ),child: Padding(
           padding: const EdgeInsets.all(17.0),
           child: SvgPicture.asset(
             AppImages.icPlus,
             height: 30,
           ),
         ),),

         SizedBox(height: 7.h,),
         Text(string("label_outer_meeting"),
             textAlign: TextAlign.center,
             style:styleSmall4.copyWith(
                 color: black,
                 fontWeight: FontWeight.w500))

       ],
     ),
   );
 }

 Widget visitorRegBtn(){
   return InkWell(
     onTap: (){

       if(getRole() == "Employee"){
         PersistentNavBarNavigator
             .pushNewScreen(context, screen: const EmpVisitorMeeting(),
             withNavBar: false);
       }else
       {
         PersistentNavBarNavigator
             .pushNewScreen(context, screen: const VisitorRegistationScreen(),
             withNavBar: false);
       }


     },
     child: Column(
       children: [
         Container(decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(10),
           color: visitorBg,
             boxShadow: const [

               BoxShadow(blurRadius:2,color: Colors.grey)
             ]
         ),child: Padding(
           padding: const EdgeInsets.all(17.0),
           child: SvgPicture.asset(
             AppImages.icAddUserHome,
             height: 30,
           ),
         ),),

         SizedBox(height: 7.h,),
         Text(string("label_visitor_reg"),
             textAlign: TextAlign.center,
             style:styleSmall4.copyWith(
                 color: black,
                 fontWeight: FontWeight.w500))

       ],
     ),
   );
 }

 Widget callTabBar(){
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            // color: Colors.red,
            height: 50,
            width: double.infinity,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                  color: white,
                  border: Border(bottom:
                  BorderSide(color: tabBG, width: 0.7))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 300,
                   color: Colors.brown,
                    child: ButtonsTabBar(
                     labelSpacing:6.0,
                      radius: 10,
                      backgroundColor: secondaryColor,
                      borderWidth: 1,
                      contentPadding: const EdgeInsets.all(10),
                      borderColor: secondaryColor,
                      labelStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        color: secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      tabs: [
                        Tab(
                            child:  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Meeting',
                                  textAlign: TextAlign.center,
                                    style:styleMedium1.copyWith(
                                      fontWeight: FontWeight.w600)),
                            )),
                        Tab(
                          child:  Container(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Center(
                                child: Text('Appointment',
                                    textAlign: TextAlign.center,
                                    style:styleSmall4.copyWith(
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          )
                        ),
                        Tab(
                          child:  Text('Site visit',
                              textAlign: TextAlign.center,
                              style:styleSmall4.copyWith(
                                  fontWeight: FontWeight.w500))
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: TabBarView(
              children: [

                Container(color: Colors.red,height: 20,),
                Container(color: Colors.black,height: 20,),
                Container(color: Colors.yellow,height: 20,)
                // KeepAlivePage(child: AMCProductsScreen()),
                // KeepAlivePage(child: AMCReceiptList())
              ],
            ),
          ),
          //cartButton()
        ],
      ),
    );
 }

 Widget topTabButtonUIChangeAsPerRole() {
    return
      getRole().toString() == "Receptionist" ?
         /*Row(
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             visitorRegBtn(),
           ],
         )*/
          Container() :
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
      [

      createMeetingBtn(),
      bookAnAppointmentBtn(),
       outerMeetingBtn(),
        visitorRegBtn(),
   ],);
  }

Widget UiChangeAsPerRoleFor(){
    return   getRole().toString() == "Receptionist" ?

    Align(
      alignment: Alignment.topLeft,
      child: Text('Visitor List',
          style: styleMedium2.copyWith(
            color: secondaryColor,
            fontWeight: FontWeight.w700,
          )),
    )  :
    Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text('Upcoming',
              style: styleMedium2.copyWith(
                color: black,
                fontWeight: FontWeight.w700,
              )),
        ),

        SizedBox(height: 15.h,),

        tabView()
      ],
    );

}

  Widget receptionListVisitorListUI() {
    return StreamBuilder<List<GetVisitor.Datum>>(
        stream: bloc.getVisitorList.stream,
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data?.isNotEmpty == true ) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                print("DARA ${snapshot.data?.elementAt(index).tokenNumber}");

                return
                  InkWell(onTap: () {

                    Navigator.push(context, VisitorApproveScreen.route(
                        selectVisitorList(snapshot.data?.elementAt(index)),
                        snapshot.data?.elementAt(index).purposeOfMeeting ?? "",
                        selectEmpList(snapshot.data?.elementAt(index)),
                        snapshot.data?.elementAt(index).requestId.toString()));

                  },
                      child: VisitorRegistrationItem(data: selectVisitorList(snapshot.data?.elementAt(index))));
              },);
          }else {
            return const SizedBox();
          }
        }
    );
  }

 GetVisitor.ReqRequestMap? selectVisitorList(GetVisitor.Datum? datum){
   GetVisitor.ReqRequestMap?  result;
   datum?.reqRequestMap?.forEach((element) {
     if(element.visitorId != null && element.reqVisitorMap?.isMeetingRequester == true){

       result = element;
     }
   });
   return result;
 }

 GetVisitor.ReqEmployeeMap? selectEmpList(GetVisitor.Datum? datum){
   GetVisitor.ReqEmployeeMap?  result;
   datum?.reqRequestMap?.forEach((element) {
     if(element.empId != null){

       result = element.reqEmployeeMap;
     }
   });
   return result;
 }

 void callGetVisitorAPI() {

   if(indexOfData <= totalPages) {
     Map<String, dynamic> param = {
       "limit": limit,
       "page": indexOfData,
       "sort": "DESC",
       "sortBy": "createdAt",
       "search": "client-k"
     };

     bloc.getVisitorRegList(param,(response) {
       String status = response.responseType ?? success;

       if (status.toLowerCase() == success) {

         totalPages  = response.responseData?.lastPage ?? 0;
         print("Total Page ${totalPages}");
         print("IndexOFData Page ${indexOfData}");
         // print("Total Page ${indexOfData}");

         if (!getBloc().getVisitorList.isClosed) {
           // getBloc().getVisitorList.add(response.responseData?.data ?? []);
           print("GetVisitorList ->> ${getBloc().getVisitorList.value.length}");

           List<GetVisitor.Datum> tempList = bloc.getVisitorList.value ?? [];
           tempList.addAll(response.responseData?.data ?? []);


           bloc.getVisitorList.add(tempList);
           bloc.originalVisitorList = tempList;
         }
         indexOfData++;
         callGetVisitorAPI();

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

  void filterItemByStatus(String status) {
   setState(() {
     selectedStatusFilter = status;
     if(status == 'All'){
       getFinalVisitorList.value =List.from(bloc.getVisitorList.value);
     }else{
       getFinalVisitorList.value = bloc.getVisitorList.value.where((element) {
         print("Chips Selected List Status  ${element.reqStatus}");
         return element.reqStatus?.contains("$status")??false;
       },).toList();

       print("Chips Selected List  ${getFinalVisitorList.value.length}");
     }
   });
  }

}