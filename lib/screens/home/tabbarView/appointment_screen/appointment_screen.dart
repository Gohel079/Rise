import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/screens/home/tabbarView/meeting_screen/meeting_bloc.dart';

import '../../../../base/constants/app_colors.dart';
import '../../../../base/constants/app_images.dart';
import '../../../../base/constants/app_styles.dart';
import '../../../../base/widgets/custom_page_route.dart';
import '../../../../utils/common_utils.dart';
import '../../../upcoming_appointment/upcoming_appointment_screen.dart';
import 'appointment_bloc.dart';

class AppointmentScreen extends BasePage<MeetingBloc> {
  const AppointmentScreen({super.key});


  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _AppointmentScreenState();
  }


  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => const AppointmentScreen());
  }


}

class _AppointmentScreenState extends BasePageState<AppointmentScreen,AppointmentBloc> {

  AppointmentBloc bloc = AppointmentBloc();


  @override
  Widget buildWidget(BuildContext context) {
    return Container(color: white,
      child: Column(children: [

        SizedBox(height: 5.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(string("label_today"),
                style: styleMedium2.copyWith(
                  color: black,
                  fontWeight: FontWeight.w600,
                )),

            InkWell(onTap: (){
              Navigator.push(context, UpcomingAppointmentScreen.route());
            },
              child: Text(string("label_viewAll"),
                  style: styleSmall4.copyWith(
                    color: secondaryColor,
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ],),
        SizedBox(height: 10.h,),

        appointmentList()


      ],),);
  }

  @override
  AppointmentBloc getBloc() {
    return bloc;
  }

  Widget appointmentList(){
    return Expanded(
      child: ListView.builder(
        itemCount: 0,
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
                  Container(
                    // width: 10,height: 100,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          SizedBox(height: 5.h,),
                          Text('RTPL Mobile app',
                              style: styleMedium1.copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.w500,
                              )),
                          SizedBox(height: 12.h,),

                          Text('Ui/Ux Design Meeting ',
                              style: styleMedium1.copyWith(
                                color: black,
                                fontWeight: FontWeight.w600,
                              )),

                          SizedBox(height: 14.h,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [


                              SvgPicture.asset(
                                AppImages.icClock,
                                color: passwordIconColor,
                              ),
                              SizedBox(width: 6.w,),
                              Text('06:15PM',
                                  style: styleSmall4.copyWith(
                                    color: lightBlack,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ],),

                        ]),)),
                  Expanded(flex:2,child:
                  Container(width: 10,
                    // color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    // ,height: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [


                        Container(width : 55.w,height: 55.h,decoration: BoxDecoration(borderRadius: BorderRadius.circular(2))
                          ,child: Image.asset(AppImages.imgPerson1,fit: BoxFit.fill,)),


                        SizedBox(height: 8.h,),

                        Container(decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(6),
                            color: white,border: Border.all(color: secondaryColor,width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                            child: Text('Cancel',
                                style: styleSmall4.copyWith(
                                  color: secondaryColor,
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

}