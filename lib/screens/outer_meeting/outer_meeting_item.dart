import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';

import '../../base/constants/app_colors.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../remote/model/create_meeting_response_model.dart';
import '../../utils/date_util.dart';

class OuterMeetingItem extends StatefulWidget {
  // Data? data;
  OuterMeetingItem(
      // this.data,
      {super.key});

  @override
  State<OuterMeetingItem> createState() => _OuterMeetingItemState();
}

class _OuterMeetingItemState extends State<OuterMeetingItem> {
  String meetingTime = "";
  @override
  void initState() {
    super.initState();
    // List<String> timeComponents = widget.data!.meetingTime!.split(':');
    // meetingTime = "${timeComponents[0]}:${timeComponents[1]}";
  }

  @override
  Widget build(BuildContext context) {
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

                  Text(
                      // widget.data?.meetingPurpose ?? "",
                    "Mr. Bhavesh Patel",
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
                      Text(
                          // DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.data!.meetingDate!)),
                        "08/09/2023",
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
                      Text(meetingTime,
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

                  SizedBox(height: 14.h,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AppImages.icLocation,
                        height: 20,
                        color: grayBlack,
                      ),
                      SizedBox(width: 3.w,),
                      Expanded(
                        child: Text('Anand Nagar Satellite, Ahmedabad',
                          overflow: TextOverflow.ellipsis,
                          style: styleSmall3.copyWith(
                            color: grayBlack,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      )
                    ],
                  )

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
  }
}
