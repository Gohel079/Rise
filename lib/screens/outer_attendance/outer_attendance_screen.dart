import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/base/src_bloc.dart';
import 'package:rise_and_grow/screens/internal_attendance/internal_attendance_bloc.dart';

import '../../base/constants/app_colors.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/widgets/custom_page_route.dart';
import 'outer_attendance_bloc.dart';

class OuterAttendanceScreen extends BasePage<OuterAttendanceBloc>{
  const OuterAttendanceScreen({super.key});



  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return OuterAttendanceState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => const OuterAttendanceScreen());
  }

}

class OuterAttendanceState  extends BasePageState<OuterAttendanceScreen,OuterAttendanceBloc>{

  OuterAttendanceBloc bloc = OuterAttendanceBloc();
  bool isSearching =false;
  bool checkValue = false;

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

          Text('Outer Attendance',
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
                width: 24.w,) : const SizedBox(),
              !isSearching ? SizedBox(width: 10.w,) : SizedBox(),
            ],)
        ],),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Text('Outer Team Members',
                style: styleMedium3.copyWith(
                  color: black,
                  fontWeight: FontWeight.w600,
                )),


            SizedBox(height: 10.h,),

            Expanded(
              child: ListView.builder(
                itemCount: 10,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return internalTeamMemberSingleItem();
                },),
            )
          ],),
      ),
    );
  }

  @override
  OuterAttendanceBloc getBloc() {
    return bloc;
  }

  Widget internalTeamMemberSingleItem(){
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
                });
              },
            ),
          ),

          SizedBox(width: 20.w,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text('Andrew starus',
                  style: styleMedium3.copyWith(
                    color: black,
                    fontWeight: FontWeight.w600,
                  ))

              ,SizedBox(height:4.h,),

              Text('Admin',
                  style: styleMedium2.copyWith(
                    color: black,
                    fontWeight: FontWeight.w400,
                  )),
            ],)

        ],),
      );


    ListTile(
      horizontalTitleGap: 1,
      minVerticalPadding: 0.1,
      minLeadingWidth: 40,
      titleAlignment: ListTileTitleAlignment.center,

      leading:  SizedBox(
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
            });
          },
        ),
      ),
      title:  Text('Andrew starus',
          style: styleMedium3.copyWith(
            color: black,
            fontWeight: FontWeight.w600,
          )),
      subtitle:  Text('Admin',
          style: styleMedium2.copyWith(
            color: black,
            fontWeight: FontWeight.w400,
          )),);
  }
}