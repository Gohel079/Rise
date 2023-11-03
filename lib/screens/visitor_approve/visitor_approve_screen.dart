import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/base/constants/app_widgets.dart';
import 'package:rise_and_grow/remote/model/get_visitor_list_response_model.dart';
import 'package:rise_and_grow/screens/upcoming_appointment/upcoming_appointment_bloc.dart';
import 'package:rise_and_grow/screens/visitor_approve/visitor_approve_bloc.dart';

import '../../base/constants/app_colors.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/widgets/button_view.dart';
import '../../base/widgets/custom_page_route.dart';
import '../../base/widgets/image_view.dart';
import '../../utils/common_utils.dart';
import '../reception_approve/reception_approve_screen.dart';

class VisitorApproveScreen extends BasePage<VisitorApproveBloc> {
  Datum? data;
   VisitorApproveScreen({this.data,super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return VisitorApproveScreenState();
  }

  static Route<dynamic> route(Datum? data) {
    return CustomPageRoute(
        builder: (context) =>  VisitorApproveScreen(data: data,));
  }

}

class VisitorApproveScreenState extends BasePageState<VisitorApproveScreen,VisitorApproveBloc> {
  VisitorApproveBloc bloc = VisitorApproveBloc();

  final TextEditingController _reasonTextFieldController = TextEditingController();
  final FocusNode _nodeReason = FocusNode();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isSearching =false;

  @override
  Widget buildWidget(BuildContext context) {
    var day = widget.data?.reqRequestMap?.isEmpty ?? false ? "" : widget.data?.reqRequestMap?.first.reqVisitorMap?.vDateOfBirth?.day ?? "";
    var month = widget.data?.reqRequestMap?.isEmpty ?? false ? "" : widget.data?.reqRequestMap?.first.reqVisitorMap?.vDateOfBirth?.month ?? "";
    var year = widget.data?.reqRequestMap?.isEmpty ?? false ? "" : widget.data?.reqRequestMap?.first.reqVisitorMap?.vDateOfBirth?.year ?? "";
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 19,
          titleSpacing: 30.w,

          title: !isSearching ? Row(children: [

            InkWell(onTap: (){
              Navigator.pop(context);
            }, child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(AppImages.icPrev,height: 15.h),
            )),

            SizedBox(width: 10.w,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text('Visitor Approves',
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
        body:  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(color: Colors.white,
              child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(height: 10.h,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(65)),
                      child: Image.network(widget.data?.reqRequestMap?.isEmpty ?? false ? "" : widget.data?.reqRequestMap?.first.reqVisitorMap?.vImage ?? "",
                        height: 100,width: 100,fit: BoxFit.fill,)
                  ),
                ],
              ),
                SizedBox(height: 15.h,),

                Text(widget.data?.reqRequestMap?.isEmpty ?? false ? "" : widget.data?.reqRequestMap?.first.reqVisitorMap?.vFirstName ?? "",
                    style: styleMedium2.copyWith(
                      color: black,
                      fontWeight: FontWeight.w600,
                    )),

                SizedBox(height: 35.h,),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  decoration: BoxDecoration(
                  color: darkTextFieldFillColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: lightGrayBorder)
                ),
                child: Column(
                  children: [

                    visitDataRow("Purpose of\nVisit :",widget.data?.reqRequestMap?.isEmpty ?? false ? "" : widget.data?.reqRequestMap?.first.reqVisitorMap?.vPurposeOfVisit ?? ""),
                    SizedBox(height: 25.h,),
                    visitDataRow("Company\nName :",widget.data?.reqRequestMap?.isEmpty ?? false ? "" : widget.data?.reqRequestMap?.first.reqVisitorMap?.vCompanyName ?? ""),
                    SizedBox(height: 25.h,),
                    visitDataRow("Designation :",widget.data?.reqRequestMap?.isEmpty ?? false ? "" : widget.data?.reqRequestMap?.first.reqVisitorMap?.vDesignation ?? ""),
                    SizedBox(height: 25.h,),
                    visitDataRow("Contact\nNumber :",widget.data?.reqRequestMap?.isEmpty ?? false ? "" : widget.data?.reqRequestMap?.first.reqVisitorMap?.vCompanyContact ?? ""),
                    SizedBox(height: 25.h,),
                    visitDataRow("Company\nAddress :",widget.data?.reqRequestMap?.isEmpty ?? false ? "" : widget.data?.reqRequestMap?.first.reqVisitorMap?.vCompanyAddress ?? ""),
                    SizedBox(height: 25.h,),
                    visitDataRow("Company\nMail Address :",widget.data?.reqRequestMap?.isEmpty ?? false ? "" : widget.data?.reqRequestMap?.first.reqVisitorMap?.vCompanyAddress ?? ""),
                    SizedBox(height: 25.h,),
                    visitDataRow("DOB :","${day.toString()}/${month.toString()}/${year.toString()}"),
                    SizedBox(height: 25.h,),
                    visitDataRow("Anniversary\nDate :","${day.toString()}/${month.toString()}/${year.toString()}"),
                    SizedBox(height: 35.h,),
                    documentImage(),
                    SizedBox(height: 20.h,),
                  ],
                ),),

                SizedBox(height: 20.h,),

                Row(children: [


                  declineBtn(),

                  SizedBox(width: 10.w,),

                  confirmBtn()
                ],),

                SizedBox(height: 10.h,)



            ],),),
          ),
        )
    );
  }

  @override
  VisitorApproveBloc getBloc() {
    return bloc;
  }

  Widget declineBtn(){
    return  Expanded(
      child: InkWell(onTap: (){
        showDeclineDialog();
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

                Text('Decline',
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


  Widget confirmBtn(){
    return  Expanded(
    child: Container(
    height: 56.h,
    decoration:
    BoxDecoration(color: darkGreen,borderRadius:
    BorderRadius.circular(6),),child:
    Row(mainAxisAlignment: MainAxisAlignment.center,
    children: [

    InkWell(onTap: (){
      Navigator.push(context,ReceptionApproveScreen.route(widget.data));
    },
      child: Row(
      children: [
      Text('Confirm',
      style: styleMedium2.copyWith(
      color: white,
      fontWeight: FontWeight.w700,
      )),

      SizedBox(width: 7.w,),
      SvgPicture.asset(AppImages.icTrue,
      height: 14.h,width: 19.w
      ,color: white,)
      ],
      ),
    ),


    ],),),
    );
  }
  Widget documentImage(){
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          Container(decoration:
          BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(8),)
              ,child:Image.network(
              widget.data?.reqRequestMap?.isEmpty ?? false ? "" : widget.data?.reqRequestMap?.first.reqVisitorMap?.vImage ?? "",
              height: 90.h,
              width: 140.w,
              fit:  BoxFit.fill,
            ),),
          SizedBox(width: 10.w,),
          Container(decoration:
          BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(8),)
            ,child:Image.network(
                widget.data?.reqRequestMap?.isEmpty ?? false ? "" : widget.data?.reqRequestMap?.first.reqVisitorMap?.vImage ?? "",
                height: 90.h,
                width: 140.w,
                fit:  BoxFit.fill,
              )),
        ],
      ),
    );
  }

  Widget visitDataRow(String data,String value){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Expanded(flex:2,child: Text(data,
          textAlign: TextAlign.start,
          style: styleSmall4.copyWith(
            color: textGrayColor,
            fontWeight: FontWeight.w500,
          )),),
       Expanded(flex:3,
      child: Text(value,
          style: styleSmall4.copyWith(
            color: lightBlack,
            fontWeight: FontWeight.w500,
          )))
    ],);
  }

  void showDeclineDialog(){
    showAdaptiveDialog
      (barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.8)
      ,context: context, builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(color:
            Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   SizedBox(
                    height: 30.h,
                  ),
                  Text(string('label_reason_for_declined'),
                    textAlign: TextAlign.start,
                    style: styleMedium3.copyWith(
                        decoration: TextDecoration.none,
                        color: black,
                        fontWeight: FontWeight.w600),
                  ),
                   SizedBox(
                    height: 10.h,
                  ),

                  Text(
                    string("label_reason_for_declined_header"),
                    textAlign: TextAlign.center,
                    style: styleMedium1.copyWith(
                        decoration: TextDecoration.none,
                        color: lightBlack,
                        fontWeight: FontWeight.w500),
                  ),
                   SizedBox(
                    height: 30.h,
                  ),

                  reasonTextField(),


                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 18,horizontal: 18),
                    child: ButtonView("Submit",false, () {
                      Navigator.pop(context);
                    }),
                  ),




                ],
              ),
            ),
          ),
        ),
      );
    },);
  }

  Widget reasonTextField(){
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          autofocus: false,
          enableSuggestions: true,
          autocorrect: true,
          textCapitalization: TextCapitalization.none,
          style: styleMedium1.copyWith(color:
          textGrayColor,fontWeight: FontWeight.w600),
          controller: _reasonTextFieldController,
          focusNode: _nodeReason,
          autovalidateMode: autoValidateMode,
          maxLines: 2,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
              contentPadding: EdgeInsetsDirectional.symmetric(vertical: 22,horizontal: 20),
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
              hintText: "Write Reason",
              floatingLabelBehavior: FloatingLabelBehavior.never,
              errorStyle: TextStyle(
                fontFamily: fontFamilyMontserrat,
                color: Colors.red,
                fontSize: 12,
              )),
        ),
      ),
    );
  }

}