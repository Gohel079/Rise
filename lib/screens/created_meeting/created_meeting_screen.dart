import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/base/constants/app_colors.dart';
import 'package:rise_and_grow/screens/created_meeting/created_meeting_bloc.dart';
import 'package:rise_and_grow/screens/created_meeting/created_meeting_item.dart';
import '../../remote/model/get_created_meeting_list_respinse_model.dart' as GetCreatedMeeting;

import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/widgets/custom_page_route.dart';
import '../create_meeting_form/create_meeting_form_screen.dart';
import 'package:rise_and_grow/base/constants/app_constant.dart';
import '../../base/constants/app_widgets.dart';

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
              child: Text('Created Meeting',
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
      // child: ListView.builder(
      //   itemCount: 20,
      //   shrinkWrap: true,
      //   itemBuilder: (context, index) {
      //     // return ;
      //   },),
      child: StreamBuilder<List<GetCreatedMeeting.Data>>(
        stream: getBloc().getCreatedMeetingList.stream,
        builder: (context, snapshot){
          if(snapshot.hasData && snapshot.data?.isNotEmpty == true ) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                print("DARA ${snapshot.data?.elementAt(index).meetingTypeID}");

                return  InkWell(
                    onTap: () {
                      // Navigator.push(context, VisitorApproveScreen.route(snapshot.data?.elementAt(index)));
                      // Navigator.push(context,ReceptionApproveScreen.route(snapshot.data?.elementAt(index)));
                    },
                    child: CreatedMeetingItem(data: snapshot.data?.elementAt(index)));
              },
            );
          }else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  @override
  CreatedMeetingBloc getBloc() {
    return bloc;
  }

  @override
  void onReady() {
    super.onReady();
    callGetCreatedMeetingAPI();
  }

  void callGetCreatedMeetingAPI() {
    if(indexOfData <= totalPages) {
      Map<String, dynamic> param = {
        "limit": limit,
        "page": indexOfData,
        "sort": "DESC",
        "sortBy": "createdAt",
        "search": "client-k"
      };

      bloc.getCreatedMeetingsListFunc(param,(response) {
        String status = response.responseType ?? success;

        if (status.toLowerCase() == success) {

          totalPages  = response.responseData?.lastPage ?? 0;
          print("Total Page ${totalPages}");
          print("IndexOFData Page ${indexOfData}");

          if (!getBloc().getCreatedMeetingList.isClosed) {
            print("GetCreatedMeetingList ->> ${getBloc().getCreatedMeetingList.value.length}");

            List<GetCreatedMeeting.Data> tempList = bloc.getCreatedMeetingList.value ?? [];
            tempList.addAll(response.responseData?.data ?? []);


            bloc.getCreatedMeetingList.add(tempList);
          }
          indexOfData++;
          callGetCreatedMeetingAPI();

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