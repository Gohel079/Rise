import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/cus_dialog/response_dialog.dart';
import 'package:rise_and_grow/screens/notification/notification_bloc.dart';

import '../../base/basePage.dart';
import '../../base/constants/app_colors.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/widgets/custom_page_route.dart';
import '../../utils/common_utils.dart';

class NotificationScreen extends BasePage<NotificationBloc>{
  const NotificationScreen({super.key});



  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _NotificationScreenState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => const NotificationScreen());
  }

}

class _NotificationScreenState extends BasePageState<NotificationScreen,NotificationBloc> {
  NotificationBloc bloc  = NotificationBloc();
  bool isSearching =false;
  @override
  Widget buildWidget(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          leadingWidth: 19,
          titleSpacing: 30.w,
          leading: InkWell(onTap: (){
            Navigator.pop(context);
          },
            child: Padding(
              padding:   const EdgeInsets.only(left: 10),
              child: SvgPicture.asset(AppImages.icPrev),
            ),
          ),
          title: !isSearching ? Row(children: [


            Text('Notifcation',
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
          automaticallyImplyLeading: !isSearching ? true : false,
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
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Text(string("label_today"),
                  style: styleMedium2.copyWith(
                    color: black,
                    fontWeight: FontWeight.w600,
                  )),

              notificationList()
            ],),)
    );
  }

  @override
  NotificationBloc getBloc() {
   return bloc;
  }

  Widget notificationList(){
    return Expanded(
      child: ListView.builder(
        itemCount: 20,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding:  EdgeInsets.symmetric(
                vertical: 8.h),
            child: Row(children: [
              const CircleAvatar(
                backgroundColor: Colors.transparent,
                maxRadius: 25,
                minRadius: 24,
                backgroundImage: AssetImage(AppImages.profileDP),
              ),
              SizedBox(width: 10.w),
              Expanded(child:
              Container(
              padding: EdgeInsets.only(bottom: 10.h),
                decoration: const BoxDecoration(border:
                Border(bottom:
                BorderSide(width: 1,color: lightGrey))),
                child: Row(children: [
                  Expanded(flex:4,child:
                  Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          SizedBox(height: 5.h,),
                          Text('Hari Patel Requested to Join A Meeting ',
                              style: styleMedium1.copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.w400,
                              )),
                          SizedBox(height: 6.h,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [


                              Text('9:01am',
                                  style: styleSmall4.copyWith(
                                    color: black,
                                    fontWeight: FontWeight.w400,
                                  )),

                              SizedBox(width: 2.w,),
                              Text('|',
                                  style: styleSmall4.copyWith(
                                    color: secondaryColor,
                                    fontWeight: FontWeight.w400,
                                  )),

                              SizedBox(width: 2.w,),
                              Text('45 Min Left',
                                  style: styleSmall4.copyWith(
                                    color: black,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ],),

                        ]),)),
                  Expanded(flex:2,child:
                  Container(
                    // color: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    // ,height: 0,
                    child: Column(
                      children: [

                        InkWell(onTap: (){
                          showAdaptiveDialog(context: context, builder: (context) {
                            return const ResponseDialog();
                          },);
                        },
                          child: Container(decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(9),
                              color: secondaryColor,
                              border: Border.all(color:
                              secondaryColor,width: 1)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8,
                                  vertical: 8),
                              child: Text('Response',
                                  style: styleSmall4.copyWith(
                                    color: white,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                          ),
                        ),


                      ],),))
                ],),
              ))


            ],),
          );
        },),
    );
  }



}