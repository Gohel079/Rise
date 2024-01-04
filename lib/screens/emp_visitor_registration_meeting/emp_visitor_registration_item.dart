import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';

import '../../base/constants/app_colors.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../remote/model/get_visitorlist_by_employee_id_response_model.dart';

class EmpVisitorRegistrationItem extends StatefulWidget {

  ReqRequestMap? data;
  EmpVisitorRegistrationItem({this.data,super.key});

  @override
  State<EmpVisitorRegistrationItem> createState() => _EmpVisitorRegistrationItemState();
}

class _EmpVisitorRegistrationItemState extends State<EmpVisitorRegistrationItem> {
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
                          child: Text(widget.data?.reqVisitorMap?.vCompanyName ?? "",
                              style: styleMedium1.copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h,),

                    Text(widget.data?.reqVisitorMap?.vFirstName ?? "",
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
                        Text("${widget.data?.reqVisitorMap?.vDateOfBirth?.day.toString() ?? ""}/${widget.data?.reqVisitorMap?.vDateOfBirth?.month.toString() ?? ""}/${widget.data?.reqVisitorMap?.vDateOfBirth?.year.toString() ?? ""}",
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
                        Text("${widget.data?.createdAt?.hour ?? ""} : ${widget.data?.createdAt?.minute ?? ""} ",
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
                        Text('+91 ${widget.data?.reqVisitorMap?.vCompanyContact ?? ""}',
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


                  Container(width : 75.w,height: 85.h,decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(2))
                      ,child: Image.network(widget.data?.reqVisitorMap?.vImage ?? "",
                     fit: BoxFit.fill,)
                      // Image.asset(AppImages.imgPerson1,fit: BoxFit.fill,)
                  ),


                  SizedBox(height: 8.h,),

                  Container(decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20),
                      color: white,border: Border.all(color: widget.data?.evStatus.toString() == "Pending" ? darkRed :green2,width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                      child: Text("Pending" ?? "",
                          style: styleSmall3.copyWith(
                            color: widget.data?.evStatus.toString() == "Pending" ? darkRed :green2,
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
