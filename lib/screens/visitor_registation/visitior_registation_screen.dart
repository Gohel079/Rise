import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/base/constants/app_colors.dart';
import 'package:rise_and_grow/screens/add_visitor_registation/add_visitor_registation_screen.dart';
import 'package:rise_and_grow/screens/visitor_registation/visitor_registation_bloc.dart';

import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/widgets/custom_page_route.dart';

class VisitorRegistationScreen extends BasePage<VisitorRegistationBloc>{
  const VisitorRegistationScreen({super.key});


  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
   return _visitorRegistationState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => const VisitorRegistationScreen());
  }

}

class _visitorRegistationState extends BasePageState<VisitorRegistationScreen,VisitorRegistationBloc>{

  VisitorRegistationBloc bloc = VisitorRegistationBloc();
  bool isSearching =false;

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
          leading: InkWell(onTap: (){
            Navigator.pop(context);
          },
            child: Padding(
              padding:   const EdgeInsets.only(left: 10),
              child: SvgPicture.asset(AppImages.icPrev),
            ),
          ),
          title: !isSearching ? Row(children: [


            Text('Visitor Registation',
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
        body:  Container(child:
         Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(children: [

            const SizedBox(height: 10,),

            tabView(),

            SizedBox(height: 10.h,),


            visitorRegistation()

          ],),
        ),),
      floatingActionButton: FloatingActionButton(backgroundColor: lightred,
        child: const Icon(Icons.add,color: white,size: 40,),onPressed: () { Navigator.push(context, AddVisitorRegistrationScreen.route()); },),
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


  Widget visitorRegistation(){
    return Expanded(
      child: ListView.builder(
        itemCount: 20,
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

                          Row(children: [

                            SvgPicture.asset(
                              AppImages.icCall,
                              color: lightBlack,
                            ),
                            SizedBox(width: 5.h,),

                            Text('RTPL Pvt. LTD.',
                                style: styleMedium1.copyWith(
                                  color: lightBlack,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],)


                          ,SizedBox(height: 5.h,),
                          Text('RTPL Mobile app',
                              style: styleMedium1.copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.w500,
                              )),
                          SizedBox(height: 12.h,),

                          Text('Mr.Harsh Patel',
                              style: styleMedium1.copyWith(
                                color: black,
                                fontWeight: FontWeight.w600,
                              )),

                          SizedBox(height: 14.h,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [


                              SvgPicture.asset(
                                AppImages.icCall,
                                color: lightBlack,
                              ),
                              SizedBox(width: 1.w,),
                              Text('+91 756779909',
                                  style: styleSmall4.copyWith(
                                    color: lightBlack,
                                    fontWeight: FontWeight.w500,
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
        },),
    );
  }

  @override
  VisitorRegistationBloc getBloc() {
   return bloc;
  }
}