import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/remote/model/get_employee_list_response_model.dart';

import '../../base/constants/app_colors.dart';
import '../../base/constants/app_styles.dart';

class SingleItemInternalAttendanceTeamMember extends StatefulWidget {
  Datum? datum;
  final ValueChanged<bool>? onCheckboxChanged;
   SingleItemInternalAttendanceTeamMember({super.key,this.datum, this.onCheckboxChanged,});

  @override
  State<SingleItemInternalAttendanceTeamMember> createState() => _SingleItemInternalAttendanceTeamMemberState();
}

class _SingleItemInternalAttendanceTeamMemberState extends State<SingleItemInternalAttendanceTeamMember> {

  bool checkValue = false;

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        child: Row(children: [

          SizedBox(
            width: 15.w,
            height: 15.h,
            child: Checkbox(
              side: MaterialStateBorderSide.resolveWith(
                    (states) =>  const BorderSide(
                    width: 1.0,color: secondaryColor),
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
              checkColor: white,
              activeColor: secondaryColor,
              focusColor: secondaryColor,
              value: checkValue,
              onChanged: (value) {
                setState(() {
                  checkValue = value ?? false;
                  widget.onCheckboxChanged?.call(value ?? false);
                });
              },
            ),
          ),

          SizedBox(width: 20.w,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text("${widget.datum?.firstName ?? ""} - ${widget.datum?.lastName ?? ""}",
                  style: styleMedium3.copyWith(
                    color: black,
                    fontWeight: FontWeight.w600,
                  ))

              ,SizedBox(height:4.h,),

              Text(widget.datum?.designation?.designation ?? "",
                  style: styleMedium2.copyWith(
                    color: black,
                    fontWeight: FontWeight.w400,
                  )),
            ],)

        ],),
      );
  }
}
