import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/screens/upcoming_site_visit/upcoming_site_visit_bloc.dart';

import '../../base/constants/app_colors.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/widgets/custom_page_route.dart';
import '../../base/widgets/image_view.dart';
import '../../utils/common_utils.dart';

class UpComingSiteVisitScreen  extends BasePage<UpComingSiteVisitBloc> {
  const UpComingSiteVisitScreen({super.key});



  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _upComingSiteVisitScreenState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => const UpComingSiteVisitScreen());
  }
}

class _upComingSiteVisitScreenState  extends BasePageState<UpComingSiteVisitScreen,UpComingSiteVisitBloc>{

  UpComingSiteVisitBloc bloc = UpComingSiteVisitBloc();
  bool isSearching =false;
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
              child: SvgPicture.asset(AppImages.icPrev,height: 17.h),
            )),

            SizedBox(width: 10.w,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text('Upcoming Outer\nMeetings',
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
        body:  Container(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Text(string("label_today"),
                  style: styleMedium2.copyWith(
                    color: black,
                    fontWeight: FontWeight.w600,
                  )),

              siteVisitList()
            ],),)
    );
  }

  @override
  UpComingSiteVisitBloc getBloc() {
    return bloc;
  }

  Widget siteVisitList(){
    return Expanded(
      child: ListView.builder(
        itemCount: 3,
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
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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

                              SizedBox(width: 6.w,),
                              SvgPicture.asset(
                                AppImages.icLocation,
                                color: passwordIconColor,
                              ),
                              SizedBox(width: 6.w,),
                              Container(
                                width: 130.w,
                                child: Text('Ananad nagar setelite,ahemdabad',
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.fade,
                                    style: styleSmall4.copyWith(
                                      color: lightBlack,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),



                            ],),

                        ]),)),
                  Expanded(flex:1,child:
                  Container(width: 10,
                    // color: Colors.white,
                    // padding: const EdgeInsets.symmetric(horizontal: 7),
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