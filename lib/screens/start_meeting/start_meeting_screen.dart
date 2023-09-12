import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/base/src_bloc.dart';
import 'package:rise_and_grow/screens/internal_attendance/internal_attendance_screen.dart';
import 'package:rise_and_grow/screens/outer_attendance/outer_attendance_screen.dart';
import 'package:rise_and_grow/screens/start_meeting/start_meeting_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/constants/app_colors.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/widgets/custom_page_route.dart';

class StartMeetingScreen extends BasePage<StartMeetingBloc>{
  const StartMeetingScreen({super.key});


  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
   return StartMeetingScreenState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => const StartMeetingScreen());
  }

}

class StartMeetingScreenState  extends BasePageState<StartMeetingScreen,StartMeetingBloc>
{

  StartMeetingBloc bloc = StartMeetingBloc();
  bool isSearching =false;
  bool checkValue = false;

  List<String> numberOfOverLapping = [
    "AS",
    "BS",
    "MG",
    "MJ"
  ];

  List<Color> colorsList = [
   redBrown,
   secondaryColor,
    buttonColor,
    linkBlue,
  ];

  final TextEditingController _meetingPurposeController = TextEditingController();
  final TextEditingController _uploadDocumentField = TextEditingController();

  final FocusNode _nodeMeetingPurpose = FocusNode();
  final FocusNode _nodeUploadDocumentData = FocusNode();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
           child: SvgPicture.asset(AppImages.icPrev,height: 14.h),
         )),

         SizedBox(width: 10.w,),
         Padding(
           padding: const EdgeInsets.symmetric(vertical: 10),
           child: Text('Start Meeting',
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
     body: Container(child
         :  SingleChildScrollView(
         child:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,
              vertical: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
          [
            Text('Attendance system',
                style: styleMedium3.copyWith(
                  color: black,
                  fontWeight: FontWeight.w600,
                )),

            SizedBox(height: 20.h,)

            ,selectAttendanceWidget()


            ,SizedBox(height: 20.h,),

            Text('Task Matrix',
                style: styleMedium3.copyWith(
                  color: black,
                  fontWeight: FontWeight.w600,
                )),

          SizedBox(height: 10.h,),


             Container(
               height: 220.h,
               child: ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder:
                    (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7,),
                    child: taskMatrixWidget(),
                  );
                },),
             ),

            SizedBox(height: 10.h,),

            Text('Meeting Purpose',
                style: styleMedium3.copyWith(
                  color: black,
                  fontWeight: FontWeight.w600,
                )),

            SizedBox(height: 20.h,),

            meetingPurposeTextField(),

            SizedBox(height: 20.h,),

            Text('Attachment adding',
                style: styleMedium3.copyWith(
                  color: black,
                  fontWeight: FontWeight.w600,
                )),

            SizedBox(height: 20.h,),

            uploadDocumentField()

            ,SizedBox(height: 40.h,),

            Row(children: [
              endBtn(),

              SizedBox(width: 10.w,),

              rescheduleBtn()
            ],),
          ],),
        )),) ,

   );
  }


  Widget taskMatrixWidget(){
    return Container(width: 240.w,decoration: BoxDecoration(color: lightPink,
        borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

            Column(children: [

              Text('Task No.',
                  style: styleSmall3.copyWith(
                    color: black,
                    fontWeight: FontWeight.w400,
                  )),

              SizedBox(height: 4.h,),
              Text('78686',
                  style: styleSmall4.copyWith(
                    color: secondaryColor,
                    fontWeight: FontWeight.w500,
                  ))
            ],),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: overlappingNameWidget(),
            )
          ],),

          SizedBox(height: 15.h,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

            Text('Task Details',
                style: styleSmall3.copyWith(
                  color: black,
                  fontWeight: FontWeight.w400,
                )),
            SizedBox(height: 5.h),

            Text('Need create new project design, disscuss the flow with the cilent',
                style: styleMedium1.copyWith(
                  color: secondaryColor,
                  fontWeight: FontWeight.w600,
                ))
          ],),

            SizedBox(height: 15.h,),

            Container(child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Row(children: [

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

                  SizedBox(width: 8.w,),

                  Text('Supporter',
                      style: styleSmall4.copyWith(
                        color: black,
                        fontWeight: FontWeight.w500,
                      ))

                ],)

                ,Column(children: [

                  Text('Due Date',
                      style: styleSmall2.copyWith(
                        color: black,
                        fontWeight: FontWeight.w400,
                      )),

                  Row(children: [

                    SvgPicture.asset(AppImages.icCalenderOutline
                      ,color: secondaryColor,),

                    SizedBox(width: 10.w,),

                    Text('7 July 2030',
                        style: styleSmall4.copyWith(
                          color: secondaryColor,
                          fontWeight: FontWeight.w500,
                        ))

                  ],),

                ],),
              ],),),

    ],),
      ),);
  }

  @override
  StartMeetingBloc getBloc() {
    return bloc;
  }


  Widget overlappingNameWidget(){
    return Row(children: [

      for(int i=0;i< numberOfOverLapping.length ;i++)
        Align(widthFactor: 0.55,
          child: Container(width: 37.w,height: 37.h,decoration:
           BoxDecoration(shape:
          BoxShape.circle,color: white,border:
           Border.all(color: Colors.white,width: 2)),
            child: Container(width: 25.w,height: 25.h,decoration:
             BoxDecoration(shape:
            BoxShape.circle,color: colorsList[i],)
              ,child:  Padding(
                padding: const EdgeInsets.only(left: 5,top: 10),
                child: Text(numberOfOverLapping[i],
                  style: styleSmall2.copyWith(
                    color: white,
                    fontWeight: FontWeight.w600,
                  )),
              ),),
          ) ,)
    ],);
  }


  Widget meetingPurposeTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _meetingPurposeController,
      focusNode: _nodeMeetingPurpose,
      maxLines: 5,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          // labelText: "Meeting Purpose",
          labelStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: textGrayColor,
            fontSize: 13,
          ),
          contentPadding: EdgeInsetsDirectional.symmetric(vertical: 10,
              horizontal: 20),
          fillColor:  darkTextFieldFillColor,
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          errorMaxLines: 2,
          isDense: true,
          // hintText: "Meeting Purpose",
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget uploadDocumentField(){
    return   TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      readOnly: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _uploadDocumentField,
      focusNode: _nodeUploadDocumentData,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,

      onTap: ()  {
      },
      textInputAction: TextInputAction.next,
      decoration:  InputDecoration(
          suffixIconConstraints: BoxConstraints(minHeight: 25.h,
              minWidth: 25.w),
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset(
              AppImages.icUploadDoc,
              color: textGrayColor,
              // fit: BoxFit.fill,
            ),
          ),
          labelText: "All Type of Document, Photos, Videos,",
          labelStyle: const TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: textGrayColor,
            fontSize: 13,
          ),
          contentPadding: const EdgeInsetsDirectional.symmetric(vertical: 22,horizontal: 20),
          fillColor:  darkTextFieldFillColor,
          filled: true,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          errorMaxLines: 2,
          isDense: true,
          hintText: "All Type of Document, Photos, Videos,",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: const TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }


  Widget endBtn(){
    return  Expanded(
      child: InkWell(onTap: (){
      },
        child: Container(
          height: 56.h,decoration:
        BoxDecoration(color: darkRed,borderRadius:
        BorderRadius.circular(6),),child:
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text('Exit',
                    style: styleMedium2.copyWith(
                      color: white,
                      fontWeight: FontWeight.w700,
                    )),

                SizedBox(width: 7.w,),
                SvgPicture.asset(AppImages.icDecline,
                  height: 24.h,width: 24.w
                  ,color: white,)
              ],
            ),


          ],),),
      ),
    );
  }


  Widget rescheduleBtn(){
    return  Expanded(
      child: Container(
        height: 56.h,
        decoration:
        BoxDecoration(color: darkGreen,borderRadius:
        BorderRadius.circular(6),),child:
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Row(
            children: [
              Text('Reschedule',
                  style: styleMedium2.copyWith(
                    color: white,
                    fontWeight: FontWeight.w700,
                  )),

              SizedBox(width: 7.w,),
              SvgPicture.asset(AppImages.icLogout,
                height: 22.h,width: 22.w
                ,color: white,)
            ],
          ),


        ],),),
    );
  }

  Widget selectAttendanceWidget(){
    return  Container(
      // color: Colors.deepPurple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

        InkWell(onTap: (){
          Navigator.push(context, InternalAttendanceScreen.route());
        },
          child:
          Container(height: 80.h,
              decoration:
          BoxDecoration(color: lightPink,borderRadius:
          BorderRadius.circular(10)),child:
          Container(
            // color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [

              Text('Internal \nAttendance',
                  textAlign: TextAlign.center,
                  style: styleSmall4.copyWith(
                    color: secondaryColor,
                    fontWeight: FontWeight.w600,
                  )),
              Container(width: 80,height: 90,
                  child: Image.asset(AppImages.imgGirl2,
                    fit: BoxFit.fill,))
                ],),
            ),
          )

          ),
        )


        ,SizedBox(width: 10.w,)


        ,InkWell(onTap: (){
          Navigator.push(context, OuterAttendanceScreen.route());
        },
          child: Container(
              height: 80.h,
              // width:double.infinity,
              decoration:
              BoxDecoration(color: lightPink,borderRadius:
              BorderRadius.circular(10)),child:
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Text('Outer \nAttendance',
                    textAlign: TextAlign.center,
                    style: styleSmall4.copyWith(
                      color: secondaryColor,
                      fontWeight: FontWeight.w600,
                    )),
                Container(width: 60,height: 80,
                    child: Image.asset(AppImages.imgBoy2,
                      fit: BoxFit.fill,))
              ],),
          )),
        )
      ],),
    );
  }

}


