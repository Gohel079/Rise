import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/remote/model/get_visitor_list_response_model.dart';

import '../../base/constants/app_colors.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';

class VisitorRegistrationItem extends StatefulWidget {
  Datum? data;
   VisitorRegistrationItem(this.data, {super.key});

  @override
  State<VisitorRegistrationItem> createState() => _VisitorRegistrationItemState();
}

class _VisitorRegistrationItemState extends State<VisitorRegistrationItem> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
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
            Container(
              // width: 10,height: 100,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Row(
                      children: [

                        SvgPicture.asset(
                          AppImages.icBookmark  ,
                          color: lightBlack,
                        ),
                        SizedBox(width: 5.w,),
                        Flexible(
                          child: Text(widget.data?.reqRequestMap?.first.reqVisitorMap?.vCompanyName ?? "",
                              style: styleMedium1.copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h,),

                    Text(widget.data?.reqRequestMap?.first.reqVisitorMap?.vFirstName ?? "",
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
                          AppImages.icCall,
                          color: lightBlack,
                        ),
                        SizedBox(width: 1.w,),
                        Text('+91 ${widget.data?.reqRequestMap?.first.reqVisitorMap?.vCompanyContact ?? ""}',
                            style: styleSmall4.copyWith(
                              color: lightBlack,
                              fontWeight: FontWeight.w500,
                            )),
                      ],),

                  ]),)),
            Expanded(flex:2,child:
            Container(width: 10,
              padding: const EdgeInsets.symmetric(horizontal: 7),
              // ,height: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  Container(width : 55.w,height: 55.h,decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(2))
                      ,child: Image.asset(AppImages.imgPerson1,fit: BoxFit.fill,)),


                  SizedBox(height: 8.h,),

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
