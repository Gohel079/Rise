
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/base/constants/app_colors.dart';
import 'package:rise_and_grow/screens/created_meeting/created_meeting_screen.dart';
import 'package:rise_and_grow/screens/home/tabbarView/appointment_screen/appointment_screen.dart';
import 'package:rise_and_grow/screens/home/tabbarView/meeting_screen/meeting.dart';
import 'package:rise_and_grow/screens/home/tabbarView/site_visit_screen/site_visit_screen.dart';
import 'package:rise_and_grow/screens/notification/notification_screen.dart';
import 'package:rise_and_grow/screens/outer_meeting/outer_meeting_screen.dart';
import 'package:rise_and_grow/screens/visitor_registation/visitior_registation_screen.dart';

import '../../../../base/constants/app_images.dart';
import '../../../../base/constants/app_styles.dart';
import '../../../../base/widgets/custom_page_route.dart';
import '../../../../base/widgets/image_view.dart';
import '../../../../utils/common_utils.dart';
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



  @override
  Widget buildWidget(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Row(children: [

         const CircleAvatar(
           backgroundColor: Colors.transparent,
           maxRadius: 25,
           minRadius: 24,
           backgroundImage: AssetImage(AppImages.profileDP),
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
             Text('Pradeep Patel',
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
             InkWell(onTap: (){

               PersistentNavBarNavigator
                   .pushNewScreen(context, screen: const NotificationScreen(),
                   withNavBar: false);
             },
               child: SvgPicture.asset(AppImages.icNotification,
                 height: 24.h,
                 width: 24.w,),
             ),
             SizedBox(width: 10.w,),
           ],)
       ],),
     body: Container(
       padding: const EdgeInsets.all(22.0),
         child: Column(
       children: [

         SizedBox(height: 7.h,),

         topTabButton(),

         SizedBox(height: 30.h,),

         Align(
           alignment: Alignment.topLeft,
           child: Text('Upcoming',
               style: styleMedium2.copyWith(
                 color: black,
                 fontWeight: FontWeight.w700,
               )),
         ),

         SizedBox(height: 15.h,),


         tabView(),

         SizedBox(height: 15.h,),

         tabBarItemView()


       ],
     )),
   );
  }

  @override
  HomeTabBloc getBloc() {
   return bloc;
  }

  Widget tabBarItemView(){
    return Expanded(child:
    Container(
      color: Colors.white,
      child: viewSelection(),));
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
              style: styleMedium1.copyWith(
            color: selectedIndex == index ?white : secondaryColor,
            fontWeight: FontWeight.w600,
          ))),
        ),),
    );
  }
  Widget topTabButton(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

      createMeetingBtn(),
      bookAnAppointmentBtn(),
     outerMeetingBtn(),
     visitorRegBtn()
    ],);
  }

  Widget createMeetingBtn(){
    return InkWell(onTap: (){

      PersistentNavBarNavigator
          .pushNewScreen(context, screen: const CreatedMeetingScreen(),
          withNavBar: false);
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
       PersistentNavBarNavigator
           .pushNewScreen(context, screen: const VisitorRegistationScreen(),
           withNavBar: false);


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
             AppImages.icAddUser,
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
}