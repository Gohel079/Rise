import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rise_and_grow/base/src_components.dart';
import 'package:rise_and_grow/base/src_constants.dart';
import 'package:rise_and_grow/screens/visitor_approve/visitor_approve_screen.dart';

import '../base/widgets/button_view.dart';
import '../utils/common_utils.dart';

class ResponseDialog extends StatefulWidget {
  const ResponseDialog({super.key});

  @override
  State<ResponseDialog> createState() => _ResponseDialogState();
}

class _ResponseDialogState extends State<ResponseDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: content(context),);
  }

  Widget content(BuildContext context) {
    return Stack(
      children: [
        containerBottomPart(),
        topPart()
      ],
    );
  }
  Widget containerBottomPart(){
    return Container(
      padding: const EdgeInsets.only(left: 20,top: 40, right: 20,bottom: 25
      ),
      margin: const EdgeInsets.only(top:45),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.black,offset: Offset(0,10),
                blurRadius: 10
            ),
          ]
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[


          SizedBox(height: 10.h),
          Text(' Mr. Pradeep Patel',
              style: styleMedium2.copyWith(
                color: black,
                fontWeight: FontWeight.w700,
              )),
          SizedBox(height: 7.h),

          Text('Is Waiting for Your Response',
              style: styleMedium1.copyWith(
                color: lightBlack,
                fontWeight: FontWeight.w500,
              )),
          SizedBox(height: 20.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(decoration: BoxDecoration(
                  color: darkTextFieldFillColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: lightGrayBorder,width: 1)

              ),child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('59',
                    style: styleMedium2.copyWith(
                      color: secondaryColor,
                      fontWeight: FontWeight.w500,
                    )),
              ))

              ,SizedBox(width: 15.w,),
              Text(':',
                  style: styleMedium3.copyWith(
                    color: lightBlack,
                    fontWeight: FontWeight.w600,
                  )),
              SizedBox(width: 15.w,)

              ,Container(decoration: BoxDecoration(
                  color: darkTextFieldFillColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: lightGrayBorder,width: 1)

              ),child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('59',
                    style: styleMedium2.copyWith(
                      color: secondaryColor,
                      fontWeight: FontWeight.w500,
                    )),
              ))
            ],)

          ,SizedBox(height: 20.h,),
          submitButton()


        ],
      ),
    );
  }



  Widget submitButton() {
    return ButtonView(string('label_viewDetails'),false, () {
      Navigator.pop(context);
      // Navigator.push(context, VisitorApproveScreen.route());
    });
  }

  Widget topPart(){
    return  Positioned(
        left: 20,
        right: 20,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 45,
          child: Container(
            decoration: BoxDecoration(border:
            Border.all(color: lightred,width: 1),
                borderRadius: BorderRadius.circular(45)),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(45)),
                child: Image.asset(AppImages.imgPerson1,height: 80,width: 80,fit: BoxFit.fill,)
            ),
          ),
        ));

  }


}