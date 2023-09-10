import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/base/constants/app_colors.dart';
import 'package:rise_and_grow/screens/add_visitor_registation/add_visitor_registation_screen.dart';
import 'package:rise_and_grow/screens/create_meeting_form/create_meeting_form_bloc.dart';
import 'package:rise_and_grow/screens/created_meeting/created_meeting_bloc.dart';
import 'package:rise_and_grow/screens/visitor_registation/visitor_registation_bloc.dart';

import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/widgets/custom_page_route.dart';
import '../create_meeting_form/create_meeting_form_screen.dart';

class CreatedMeetingScreen extends BasePage<CreatedMeetingBloc>{
  const CreatedMeetingScreen({super.key});


  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _createdMeetingScreenState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => const CreatedMeetingScreen());
  }

}

class _createdMeetingScreenState extends BasePageState<CreatedMeetingScreen,CreatedMeetingBloc>{

  CreatedMeetingBloc bloc = CreatedMeetingBloc();
  bool isSearching =false;

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

          Text(' Created Meeting',
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
                width: 24.w,) : SizedBox(),
              !isSearching ? SizedBox(width: 10.w,) : SizedBox(),
            ],)
        ],),
      body:  Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(children: [

          const SizedBox(height: 10,),

          tabView(),

          SizedBox(height: 10.h,),


          createMeeting()

        ],),
      ),
        floatingActionButton: FloatingActionButton(backgroundColor: lightred,
          child: const Icon(Icons.add,color: white,size: 40,),onPressed: () {
          Navigator.push(context, CreateMeetingFormScreen.route()); },)
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


  Widget createMeeting(){
    return Expanded(
      child: ListView.builder(
        itemCount: 20,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Card(
              elevation: 0.5,
              shape: RoundedRectangleBorder(borderRadius:
              BorderRadius.circular(10)),
              color: listCardBG ,
              child:
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12,
                    vertical: 17),
                child: Row(children: [

                  SizedBox(width: 4.w),
                  Expanded(flex:4,child:
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Row(
                          children: [

                            SvgPicture.asset(
                              AppImages.icToll  ,
                              color: lightBlack,
                            ),
                            SizedBox(width: 5.w,),
                            Text('RTPL Mobile app',
                                style: styleMedium1.copyWith(
                                  color: lightBlack,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),
                        SizedBox(height: 12.h,),

                        Text('Mr.Harsh Patel',
                            style: styleMedium1.copyWith(
                              color: black,
                              fontWeight: FontWeight.w600,
                            )),

                        SizedBox(height: 14.h,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [


                            SvgPicture.asset(
                              AppImages.icCalenderOutline,
                              color: lightBlack,
                            ),
                            SizedBox(width: 6.w,),
                            Text('08/09/2023',
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
                              AppImages.icClock,
                              color: lightBlack,
                            ),
                            SizedBox(width: 3.w,),
                            Text('06:15',
                                style: styleSmall4.copyWith(
                                  color: lightBlack,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],),

                        SizedBox(height: 14.h,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [


                            SvgPicture.asset(
                              AppImages.icPerson,
                              height: 20,
                              color: green2,
                            ),
                            SizedBox(width: 2.w,),
                            Text('Andrew status',
                                style: styleSmall3.copyWith(
                                  color: green2,
                                  fontWeight: FontWeight.w500,
                                )),

                            SizedBox(width: 10.w,),
                            SvgPicture.asset(
                              AppImages.icPerson,
                              height: 20,
                              color: grayBlack,
                            ),
                            SizedBox(width: 3.w,),
                            Text('Fox Geroge',
                                style: styleSmall3.copyWith(
                                  color: grayBlack,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],),

                      ])),
                  Expanded(flex:2,child:
                  Container(width: 10,
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    // ,height: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [


                        Container(width : 50.w,
                            height: 50.h,decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5),
                            color: green3)
                            ,child: Image.asset(AppImages.imgGreenTrue,
                              height: 30.h,width: 30.w,)),


                        SizedBox(height: 10.h,),

                        Container(decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20),
                            color: white,border: Border.all(color: green2,width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                            child: Text('Accepted',
                                style: styleSmall3.copyWith(
                                  color: green2,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ),
                      ],),))

                ],),
              ),),
          );
        },),
    );
  }

  @override
  CreatedMeetingBloc getBloc() {
    return bloc;
  }
}