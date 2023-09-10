import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/screens/internal_team_selection/internal_team_selection_bloc.dart';
import 'package:rise_and_grow/screens/start_meeting/start_meeting_screen.dart';

import '../../base/constants/app_colors.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/widgets/button_view.dart';
import '../../base/widgets/custom_page_route.dart';
import '../../utils/common_utils.dart';

class InternalTeamSelectionScreen extends BasePage<InternalTeamSelectionBloc>{
  const InternalTeamSelectionScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return InternalTeamSelectionState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => const InternalTeamSelectionScreen());
  }

}

class InternalTeamSelectionState extends BasePageState<InternalTeamSelectionScreen,InternalTeamSelectionBloc> {

  InternalTeamSelectionBloc bloc = InternalTeamSelectionBloc();
  bool isSearching =false;

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

           Text('Internal Team Selection',
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
       body:     Column(
        crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [



           Expanded(
             child: SingleChildScrollView(
               child: Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 17),
                     child: Row(children: [


                       Column(mainAxisAlignment : MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Stack  (
                               // alignment: Alignment.bottomRight,
                               children :[


                                 Container(
                                   decoration: const BoxDecoration(
                                     color: redBrown,
                                       shape: BoxShape.circle,
                                   ), height: 60, width: 60,
                                   child: Center(
                                     child: Text('AS',
                                         style: styleMedium2.copyWith(
                                           color: white,
                                           fontWeight: FontWeight.w600,
                                         )),
                                   ),),

                             /*Container(
                               height :60,width:60,
                               decoration: BoxDecoration(color: redBrown,borderRadius:
                               BorderRadius.circular(40)),
                               child: Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 5,
                                     vertical: 10),
                                 child: Center(
                                   child: Text('AS',
                                       style: styleMedium2.copyWith(
                                         color: white,
                                         fontWeight: FontWeight.w600,
                                       )),
                                 ),
                               ),),*/


                                 Positioned(
                                   left: 36,
                                   top: 33,
                                   child: Container(
                                     height: 27,
                                     width: 27,
                                     decoration: BoxDecoration(color: Colors.white,borderRadius:
                                     BorderRadius.circular(40)),
                                     child: Padding(
                                       padding: const EdgeInsets.all(3.0),
                                       child: Container(decoration :  const BoxDecoration(
                                           color: gray4,
                                          shape: BoxShape.circle),
                                           child: Icon(Icons.close_outlined,size:16,color: white,)),
                                     ),
                                   ),
                                 ),

         ]
                           ),


                           SizedBox(height: 10.h,),
                           Text('Andrew starus',
                               style: styleSmall3.copyWith(
                                 color: lightBlack,
                                 fontWeight: FontWeight.w400,
                               ))
                         ],
                       ),



                     ],),
                   ),


                   const Divider(color: borderColor,thickness: 2,)


                   , Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 17),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [

                         Text('Internal Team Members',
                             style: styleMedium2.copyWith(
                               color: lightBlack,
                               fontWeight: FontWeight.w600,
                             )),


                         SizedBox(height: 20.h,),

                         ListView.builder(
                           itemCount: 10,
                           physics: const NeverScrollableScrollPhysics(),
                           shrinkWrap: true,
                           itemBuilder: (context, index) {
                             return teamMemberSingleItem();

                           },)
                       ],),
                   )
                 ],
               ),
             ),
           ),


           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
             child: submitButton(),
           ),
         ],
       ));
  }


  Widget submitButton() {
    return ButtonView(string('label_add'),false, () {
      Navigator.push(context, StartMeetingScreen.route());
    });
  }

  Widget teamMemberSingleItem() {
    return ListTile(contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 10,
        // minVerticalPadding:1.0,
        leading:
    Container(height: 40,width: 40,decoration: const BoxDecoration(color: redBrown,
      shape: BoxShape.circle,),
      child: Center(
        child: Text('AS',
            style: styleSmall3.copyWith(
              color: white,
              fontWeight: FontWeight.w600,
            )),
      ),),
    title: Text('Andrew starus',
        style: styleSmall4.copyWith(
          color: lightBlack,
          fontWeight: FontWeight.w500,
        )),
        trailing: Text('APP Developer',
            style: styleSmall4.copyWith(
              color: lightBlack,
              fontWeight: FontWeight.w400,
            )));


  }

  @override
  InternalTeamSelectionBloc getBloc() {
  return bloc;
  }
}
