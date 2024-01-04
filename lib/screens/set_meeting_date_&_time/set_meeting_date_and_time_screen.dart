import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/base/src_bloc.dart';
import 'package:rise_and_grow/screens/set_meeting_date_&_time/set_meeting_date_and_time_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../base/constants/app_colors.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/widgets/button_view.dart';
import '../../base/widgets/custom_page_route.dart';
import '../../utils/common_utils.dart';

class SetMeetingDateAndTimeScreen extends BasePage<SetMeetingDateAndTimeBloc>{
    Function? callBackForSelctedDateAndTime;
   SetMeetingDateAndTimeScreen({this.callBackForSelctedDateAndTime,super.key});



  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return SetMeetingDateAndTimeScreenState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) =>  SetMeetingDateAndTimeScreen());
  }


}

class SetMeetingDateAndTimeScreenState  extends BasePageState<SetMeetingDateAndTimeScreen,SetMeetingDateAndTimeBloc>{

  SetMeetingDateAndTimeBloc bloc = SetMeetingDateAndTimeBloc();
  bool isSearching =false;

  DateTime? chosenDay;
  DateTime? selectFocusDate;

  BehaviorSubject<bool>? morningSelectView;
  BehaviorSubject<bool>? noonSelectView;
  BehaviorSubject<bool>? eveningSelectView;
  BehaviorSubject<int>? gridSelectItem;

  BehaviorSubject<String>? selectedDate;
  String? selectedSlot;


  List<String> morningTimeSlotList = [
    "08:00 to 08:30",
    "08:30 to 09:00",
    "09:00 to 09:30",
    "09:30 to 10:00",
    "10:00 to 10:30",
    "10:30 to 11:00",
    "11:00 to 11:30",
    "11:30 to 12:00"
  ];

  List<String> noonTimeSlotList = [
    "12:00 to 12:30",
    "12:30 to 01:00",
    "01:00 to 01:30",
    "01:30 to 02:00",
    "02:00 to 02:30",
    "02:30 to 03:00",
    "03:00 to 03:30",
    "03:30 to 04:00"
  ];

  List<String> eveningTimeSlotList = [
    "04:00 to 04:30",
    "04:30 to 05:00",
    "05:00 to 05:30",
    "05:30 to 06:00",
    "06:00 to 06:30",
    "06:30 to 07:00",
    "07:00 to 07:30",
    "07:30 to 08:00"
  ];

  final List<String> one = [
    'Ahmedabad Conf. Room -1',
    'Ahmedabad Conf. Room -2',
    'Ahmedabad Conf. Room -3'
  ];


  String _oneValue = '';

  @override
  void initState() {
    super.initState();
    morningSelectView = BehaviorSubject<bool>.seeded(true);
    noonSelectView = BehaviorSubject<bool>.seeded(false);
    eveningSelectView = BehaviorSubject<bool>.seeded(false);
    gridSelectItem = BehaviorSubject<int>.seeded(0);
    selectedSlot = morningTimeSlotList.elementAt(0);

    selectedDate = BehaviorSubject<String>.seeded("${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}" ?? "");
    _oneValue = one[0];
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 19,
          titleSpacing: 30.w,

          title:  Row(children: [

            InkWell(onTap: (){
              Navigator.pop(context);
            }, child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(AppImages.icPrev,height: 14.h),
            )),

            SizedBox(width: 10.w,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text('Set Meeting Date & Time',
                  style: styleMedium2.copyWith(
                    color: white,
                    fontWeight: FontWeight.w600,
                  )),
            ),

          ],) ,
          automaticallyImplyLeading: false,
          backgroundColor: secondaryColor,
         ),
        body:    SingleChildScrollView(
          child: Column(children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 17),
              child: Column(
                children: [

                  /* Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('Select Date',
                    style: styleMedium2.copyWith(
                      color: black,
                      fontWeight: FontWeight.w600,
                    )),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('July 2023',
                    style: styleMedium2.copyWith(
                      color: black,
                      fontWeight: FontWeight.w600,
                    )),
              )
            ],),
            SizedBox(height: 20.h,),*/

                  buildCalenderView(),

                ],
              ),
            ),


            const Divider(color: borderColor,thickness: 2,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 17),
              child: InkWell(onTap: (){
                showAddressChangeDialog();
              },
                child: Row(children: [

                  Expanded(
                    flex: 4,
                    child: Text(_oneValue,
                        style: styleSmall4.copyWith(
                          color: secondaryColor,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ), ),
                  ),

                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(6.0)
                      ),
                      padding: const EdgeInsets.all(4.0),
                      child: Text('Change',
                          style: styleSmall4.copyWith(
                            color: white,
                            fontWeight: FontWeight.w700,
                          )),
                    ),
                  )
                ],),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 17),
              child: Column(
                children: [


                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Select Time Slot(15 min)',
                        style: styleMedium2.copyWith(
                          color: black,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),

                 SizedBox(height: 20.h,),

                 timeSlotTab(),

                  SizedBox(height: 40.h,),

                 timeSlotSelection(),

                  SizedBox(height: 40.h,),

                  submitButton()

              ],),
            )
          ],),
        ));
  }

  Widget timeSlotSelection(){

    if(morningSelectView?.value ?? false) {
      return morningTimeSlotGrid();
    }
    if(noonSelectView?.value ?? false) {
      return  noonTimeSlotGrid();
    }
    if(eveningSelectView?.value ?? false) {
      return eveningTimeSlotGrid();
    }
    return Container();
  }

   Widget buildCalenderView(){
    return  TableCalendar(
      calendarBuilders: CalendarBuilders(),
      firstDay: DateTime.utc(2010,10,20),
      lastDay: DateTime.utc(2040,10,20),
      focusedDay: selectFocusDate ?? DateTime.now(),
      headerVisible: true,
      currentDay: chosenDay ,
      daysOfWeekVisible: true,
      rowHeight: 44,
      selectedDayPredicate: (day) =>isSameDay(day, chosenDay),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          print(selectedDay);
          chosenDay = selectedDay;
          selectFocusDate = focusedDay;// update `_focusedDay` here as well
          String? date = "${selectedDay.day}-${selectedDay.month}-${selectedDay.year}";
          selectedDate?.add(date);
          print(selectedDate?.value);
        });
      },
      sixWeekMonthsEnforced: true,
      shouldFillViewport: false,
      headerStyle:  HeaderStyle(formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: styleMedium2.copyWith(
        color: black,
        fontWeight: FontWeight.w600,
      )),
      availableGestures: AvailableGestures.all,
      calendarStyle: CalendarStyle(todayTextStyle:
      styleMedium4.copyWith(
        color: black,
        fontWeight: FontWeight.w500,
        ))
    );
   }

   Widget timeSlotTab(){
    return  Row(
      children: [


        InkWell(
          onTap: (){

            morningSelectView?.add(true);
            noonSelectView?.add(false);
            eveningSelectView?.add(false);
            setState(() {
            });

          },
          child: StreamBuilder<bool>(
              stream: morningSelectView?.stream,
              builder: (context, snapshot) {
                return Container(decoration:  BoxDecoration(
                  color:  snapshot.data ?? false ? secondaryColor : tabBG,
                  border: Border.all(color: tabBorder),
                  borderRadius:
                  const BorderRadius.only(topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8)),)
                  ,child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3,
                        vertical: 8),
                    child: Row(children: [

                      Image.asset(AppImages.imgMorningSun,height: 27.h,width: 27.w,),

                      SizedBox(width: 2.w,),

                      Text('8 to 12 AM',
                          style: styleMedium1.copyWith(
                            color: snapshot.data ?? false ? white: secondaryColor,
                            fontWeight: FontWeight.w600,
                          ))
                    ],),
                  ),);
              }
          ),
        ),

        InkWell(onTap: (){

          morningSelectView?.add(false);
          noonSelectView?.add(true);
          eveningSelectView?.add(false);
          setState(() {

          });

        },
          child: StreamBuilder<bool>(
              stream: noonSelectView?.stream,
              builder: (context, snapshot) {
                return Container(decoration:  BoxDecoration(
                    border: Border.all(color: tabBorder),
                    color: snapshot.data ?? false ? secondaryColor : tabBG)
                  ,child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 8),
                    child: Row(children: [


                      Image.asset(AppImages.imgNoonSun,height: 27.h,width: 27.w,),

                      SizedBox(width: 2.w,),

                      Text('12 to 4 PM',
                          style: styleMedium1.copyWith(
                            color: snapshot.data ?? false ? white: secondaryColor,
                            fontWeight: FontWeight.w600,
                          ))
                    ],),
                  ),);
              }
          ),
        ),

        InkWell(
          onTap: (){

            morningSelectView?.add(false);
            noonSelectView?.add(false);
            eveningSelectView?.add(true);
            setState(() {

            });

          },
          child: StreamBuilder<bool>(
              stream: eveningSelectView?.stream,
              builder: (context, snapshot) {
                return Container(decoration:  BoxDecoration(
                  border: Border.all(color: tabBorder),
                  color: snapshot.data ?? false ? secondaryColor : tabBG,
                  borderRadius:
                  const BorderRadius.only(topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)),)
                  ,child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 8),
                    child: Row(children: [


                      Image.asset(AppImages.imgEveningSun,height: 27.h,width: 27.w,),

                      SizedBox(width: 2.w,),

                      Text('4 to 8 PM',
                          style: styleMedium1.copyWith(
                            color: snapshot.data ?? false ? white: secondaryColor,
                            fontWeight: FontWeight.w600,
                          ))
                    ],),
                  ),);
              }
          ),
        ),
      ],
    );
   }

   Widget morningTimeSlotGrid(){
    return GridView.builder(
      shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            childAspectRatio: 10 / 4,
            crossAxisSpacing: 15,
            mainAxisSpacing: 20),
        itemCount: morningTimeSlotList.length,
        itemBuilder: (BuildContext ctx, index) {
          return morningGridSingleItem(index);
        });
   }

   Widget morningGridSingleItem(int index){
    return InkWell(onTap: (){
      gridSelectItem?.add(index);
      print("00000000000");
      print("Slot ${selectedSlot}");
      // selectedSlot?.add("");
      print("Index oF ${index}");
      selectedSlot = morningTimeSlotList.elementAt(index);
      print("Slo after ${selectedSlot}");
    },
      child: StreamBuilder<int>(
        stream: gridSelectItem?.stream,
        builder: (context, snapshot) {
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: snapshot.data == index ? secondaryColor : tabBG,
                borderRadius: BorderRadius.circular(5)),
            child:  Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(morningTimeSlotList[index],
                  style: styleSmall4.copyWith(
                    color: snapshot.data == index ? white : secondaryColor,
                    fontWeight: FontWeight.w600,
                  )),
            ),
          );
        }
      ),
    );
   }


  Widget noonTimeSlotGrid(){
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            childAspectRatio: 10 / 4,
            crossAxisSpacing: 15,
            mainAxisSpacing: 20),
        itemCount: noonTimeSlotList.length,
        itemBuilder: (BuildContext ctx, index) {
          return noonGridSingleItem(index);
        });
  }

  Widget noonGridSingleItem(int index){
    return InkWell(onTap: (){
      gridSelectItem?.add(index);
      print("Time :${gridSelectItem?.value}");
      print("Slot ${selectedSlot}");
      // selectedSlot?.add("");
      print("Index oF ${index}");
      selectedSlot = noonTimeSlotList.elementAt(index);
    },
      child: StreamBuilder<int>(
          stream: gridSelectItem?.stream,
          builder: (context, snapshot) {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: snapshot.data == index ? secondaryColor : tabBG,
                  borderRadius: BorderRadius.circular(5)),
              child:  Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(noonTimeSlotList[index],
                    style: styleSmall4.copyWith(
                      color: snapshot.data == index ? white : secondaryColor,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            );
          }
      ),
    );
  }

  Widget eveningTimeSlotGrid(){
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            childAspectRatio: 10 / 4,
            crossAxisSpacing: 15,
            mainAxisSpacing: 20),
        itemCount: eveningTimeSlotList.length,
        itemBuilder: (BuildContext ctx, index) {
          return eveningGridSingleItem(index);
        });
  }

  Widget eveningGridSingleItem(int index){
    return InkWell(onTap: (){
      gridSelectItem?.add(index);
      print("Slot ${selectedSlot}");
      // selectedSlot?.add("");
      print("Index oF ${index}");
      selectedSlot = eveningTimeSlotList.elementAt(index);
    },
      child: StreamBuilder<int>(
          stream: gridSelectItem?.stream,
          builder: (context, snapshot) {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: snapshot.data == index ? secondaryColor : tabBG,
                  borderRadius: BorderRadius.circular(5)),
              child:  Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(eveningTimeSlotList[index],
                    style: styleSmall4.copyWith(
                      color: snapshot.data == index ? white : secondaryColor,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            );
          }
      ),
    );
  }

  Widget submitButton() {
    return ButtonView(string('label_done'),true, () {

      Map meetingDateMap = {
        "Date" : selectedDate?.value,
        "Time" : selectedSlot.toString()
      };

      Navigator.pop(context,meetingDateMap);

    });
  }

  void showAddressChangeDialog(){
    showAdaptiveDialog
      (barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.8)
      ,context: context, builder: (context) {
        return alertDialogView();
      },);
  }

  Widget alertDialogView(){
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      content: Container(
        width: double.maxFinite,
        child: ListView.separated(
          itemCount: one.length,
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(color: secondaryColor,
              thickness: 0.4,height: 0.5,);
          },
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                title: Text(one[index],
                    style: styleMedium2.copyWith(
                      color: lightBlack,
                      fontWeight: FontWeight.w500,
                    )),
                trailing: Radio(
                  value: one[index],
                  groupValue: _oneValue,
                  onChanged: (value) {
                    setState(() {
                      _oneValue = value ?? "";
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  SetMeetingDateAndTimeBloc getBloc() {
    return bloc;
  }
}