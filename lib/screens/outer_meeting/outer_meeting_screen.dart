import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/screens/outer_meeting/outer_meeting_bloc.dart';
import 'package:rise_and_grow/screens/outer_meeting/outer_meeting_item.dart';
import 'package:rise_and_grow/screens/outer_meeting_approve/outer_meeting_approve_screen.dart';
import 'package:rise_and_grow/screens/outer_meeting_form/outer_meeting_form_screen.dart';

import '../../base/bloc/base_bloc.dart';
import '../../base/constants/app_colors.dart';
import '../../base/constants/app_constant.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/constants/app_widgets.dart';
import '../../base/widgets/custom_page_route.dart';
import '../../remote/model/create_meeting_response_model.dart' as GetOuterMeeting;

class OuterMeetingScreen extends BasePage<OuterMeetingBloc>{
  const OuterMeetingScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _outerMeetingState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => const OuterMeetingScreen());
  }

}

class _outerMeetingState extends BasePageState<OuterMeetingScreen,OuterMeetingBloc>{
  OuterMeetingBloc bloc = OuterMeetingBloc();
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
            child: Text('Outer Meetings',
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
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(height: 10,),

              tabView(),

              SizedBox(height: 10.h,),


              outerMeeting()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: lightred,
        child: const Icon(
          Icons.add,color: white,size: 40,
            ),
        onPressed: () {
          Navigator.push(context, OuterMeetingFormScreen.route());
        },
      ),
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

  Widget outerMeeting(){
    return Expanded(
      child: ListView.builder(
        itemCount: 20,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return OuterMeetingItem();
        },

      ),
      // child: StreamBuilder<List<GetOuterMeeting.Data>>(
      //   stream: getBloc().getOuterMeetingList.stream,
      //   builder: (context, snapshot){
      //     if(snapshot.hasData && snapshot.data?.isNotEmpty == true ) {
      //       return ListView.builder(
      //         itemCount: snapshot.data?.length,
      //         shrinkWrap: true,
      //         itemBuilder: (context, index) {
      //           print("DARA ${snapshot.data?.elementAt(index).meetingTypeID}");
      //
      //           return  InkWell(
      //               onTap: () {
      //
      //               },
      //               child: OuterMeetingItem(snapshot.data?.elementAt(index)));
      //         },
      //       );
      //     }else {
      //       return const SizedBox();
      //     }
      //   },
      // ),
    );
  }

  @override
  OuterMeetingBloc getBloc() {
    return bloc;
  }

  @override
  void onReady() {
    super.onReady();
    callGetOuterMeetingAPI();
  }

  void callGetOuterMeetingAPI() {
    if(indexOfData <= totalPages) {
      Map<String, dynamic> param = {
        "limit": limit,
        "page": indexOfData,
        "sort": "DESC",
        "sortBy": "createdAt",
        "search": "client-k"
      };

      bloc.getOuterMeetingsListFunc(param,(response) {
        String status = response.responseType ?? success;

        if (status.toLowerCase() == success) {

          totalPages  = response.responseData?.lastPage ?? 0;
          print("Total Page ${totalPages}");
          print("IndexOFData Page ${indexOfData}");

          if (!getBloc().getOuterMeetingList.isClosed) {
            print("GetCreatedMeetingList ->> ${getBloc().getOuterMeetingList.value.length}");

            // List<GetOuterMeeting.Data> tempList = bloc.getOuterMeetingList.value ?? [];
            // tempList.addAll(response.responseData?.data ?? []);
            // bloc.getOuterMeetingList.add(tempList);
          }
          indexOfData++;
          callGetOuterMeetingAPI();

        }
        else if (status.toLowerCase() == failed) {
          showMessageBar('Failed :  ${response.message ?? ""}');
        }
        else {
          showMessageBar('ERROR :${response.message ?? ""}');
        }
      },
      );
    }
  }

}