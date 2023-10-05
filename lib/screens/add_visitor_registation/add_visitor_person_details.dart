import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/constants/app_colors.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/constants/app_widgets.dart';
import '../../base/widgets/button_view.dart';
import '../../utils/app_valid.dart';
import '../../utils/common_utils.dart';
import '../../utils/date_util.dart';

class AddVisitorPersonDetails extends StatefulWidget {
  final Function(Map)? callBackPerson;
   const AddVisitorPersonDetails(this.callBackPerson,{super.key});

  @override
  State<AddVisitorPersonDetails> createState() => _AddVisitorPersonDetailsState();
}

class _AddVisitorPersonDetailsState extends State<AddVisitorPersonDetails> {


  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _anniversaryDateController = TextEditingController();


  final FocusNode _nodeFirstName = FocusNode();
  final FocusNode _nodeSecondName = FocusNode();
  final FocusNode _nodeDesignation = FocusNode();
  final FocusNode _nodeDateOfBirth = FocusNode();
  final FocusNode _nodeAnniversary = FocusNode();

  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  BehaviorSubject<String>? aadhaarCardPDFText;
  BehaviorSubject<String>? photoOrCameraFile;
  ImagePicker? imagePicker  = ImagePicker();

  @override
  void initState() {
    super.initState();
    photoOrCameraFile = BehaviorSubject<String>.seeded("");
    aadhaarCardPDFText = BehaviorSubject<String>.seeded("");
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // alignment: Alignment.center,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          // height: 770.h,
          padding: const EdgeInsets.only(left: 15,top: 15, right: 15,bottom: 15),
          margin: const EdgeInsets.only(top:15),

          decoration: BoxDecoration(
            // shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(color: Colors.black,offset: Offset(0,10), blurRadius: 10),
              ]),
          child: Column(children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                 SizedBox(width: 20.w),

              Text('Person 1',
                  style: styleMedium2.copyWith(
                    color: secondaryColor,
                    fontWeight: FontWeight.w700,
                  )),


              InkWell(onTap: (){
                Navigator.pop(context);
              },
                child: const Icon(Icons.close,
                  color: secondaryColor,
                  size: 20,),
              ),
            ],)

            ,SizedBox(height: 2.h,),

            const Divider(thickness: 1,color: secondaryColor,)


            ,SizedBox(height: 10.h),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  firstNameTextField(),

                  SizedBox(height: 20.h,),

                  secondNameTextField(),

                  SizedBox(height: 20.h,),


                  designationTextField(),

                  SizedBox(height: 20.h,),

                  dateOfBirthField(),

                  SizedBox(height: 20.h,),

                  anniversaryDateField(),

                  SizedBox(height: 20.h,),
                ],
              ),
            ),


          Row(children: [


            StreamBuilder<String?>(
                stream: aadhaarCardPDFText?.stream,
                builder: (context, snapshot) {
                  return Expanded(
                    child: InkWell(onTap: (){
                      _pickAadhaarCardPDFFile();
                    },
                      child: Container(height: 90.h,decoration :
                      BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
                          border: Border.all(color: borderColor, ),color: darkTextFieldFillColor ),
                          child: selectedAadhaarCardAfterWidget(snapshot.data)
                      ),
                    ),
                  );
                }
            ),

            SizedBox(width: 10.w,),

            StreamBuilder<String?>(
                stream: photoOrCameraFile?.stream,
                builder: (context, snapshot) {
                  return Expanded(
                    child: InkWell(onTap: (){
                      showOptions();
                    },
                      child: Container(height: 90.h,decoration :
                      BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(7)),
                          border: Border.all(color: borderColor, ),color: darkTextFieldFillColor ),
                          child: selectedPhotoWidget(snapshot.data)
                      ),
                    ),
                  );
                }
            ),

            ]),

            SizedBox(height: 20.h,),

            submitButton(),


          ],),
        ),
      ),
    );
  }

  Widget firstNameTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,
          fontWeight: FontWeight.w600),
      controller: _firstNameController,
      focusNode: _nodeFirstName,
      validator: validateFirstName,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          labelText: "First Name",
          labelStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: textGrayColor,
            fontSize: 13,
          ),
          contentPadding: EdgeInsetsDirectional.
          symmetric(vertical: 22,horizontal: 20),
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
          // isDense: true,
          hintText: "First Name",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget secondNameTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _secondNameController,
      focusNode: _nodeSecondName,
      autovalidateMode: autoValidateMode,
      validator: validateLastName,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          labelText: "Last Name",
          labelStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: textGrayColor,
            fontSize: 13,
          ),
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
          hintText: "Last Name",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget designationTextField(){
    return TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _designationController,
      focusNode: _nodeDesignation,
      autovalidateMode: autoValidateMode,
      validator: validateDesignation,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          labelText: "Designation",
          labelStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: textGrayColor,
            fontSize: 13,
          ),
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
          hintText: "Designation",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }


  Widget dateOfBirthField(){
    return   TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      readOnly: true,
      textCapitalization: TextCapitalization.none,
      validator: validateDOB,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _dateOfBirthController,
      focusNode: _nodeDateOfBirth,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,

      onTap: () async {

        DateTime? pickedDate = await showDatePicker(
            builder: (context, child) {

              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: secondaryColor, // <-- SEE HERE
                    onPrimary: white, // <-- SEE HERE
                    onSurface: black, // <-- SEE HERE
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      primary: black, // button text color
                    ),
                  ),
                ), child: child!,
              );
            },
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2100));

        if (pickedDate != null) {
          print(pickedDate);
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          print(formattedDate); //formatted date output using intl package =>  2021-03-16
          setState(() {
            _dateOfBirthController.text = formattedDate; //set output date to TextField value.
          });
        } else {

        }

      },
      textInputAction: TextInputAction.next,
      decoration:  InputDecoration(
          suffixIconConstraints: BoxConstraints(minHeight: 25.h,minWidth: 25.w),
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset(
              AppImages.icCalenderOutline,
              color: textGrayColor,
              // fit: BoxFit.fill,
            ),
          ),
          labelText: "Date of Birth",
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
          hintText: "Date of Birth",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: const TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  Widget anniversaryDateField(){
    return   TextFormField(
      autofocus: false,
      enableSuggestions: true,
      autocorrect: true,
      readOnly: true,
      textCapitalization: TextCapitalization.none,
      style: styleMedium1.copyWith(color: black,fontWeight: FontWeight.w600),
      controller: _anniversaryDateController,
      focusNode: _nodeAnniversary,
      autovalidateMode: autoValidateMode,
      keyboardType: TextInputType.text,

      onTap: () async {

        DateTime? pickedDate = await showDatePicker(
            builder: (context, child) {

              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: secondaryColor, // <-- SEE HERE
                    onPrimary: white, // <-- SEE HERE
                    onSurface: black, // <-- SEE HERE
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      primary: black, // button text color
                    ),
                  ),
                ), child: child!,
              );
            },
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2100));

        if (pickedDate != null) {
          print(
              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate =
          DateFormat('yyyy-MM-dd').format(pickedDate);
          print(
              formattedDate); //formatted date output using intl package =>  2021-03-16
          setState(() {
            _anniversaryDateController.text = formattedDate; //set output date to TextField value.
          });
        } else {}

      },
      textInputAction: TextInputAction.next,
      decoration:  InputDecoration(
          suffixIconConstraints: BoxConstraints(minHeight: 25.h,minWidth: 25.w),
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset(
              AppImages.icCalenderOutline,
              color: textGrayColor,
              // fit: BoxFit.fill,
            ),
          ),
          labelText: "Anniversary Date",
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
          hintText: "Anniversary Date",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: const TextStyle(
            fontFamily: fontFamilyMontserrat,
            color: Colors.red,
            fontSize: 12,
          )),
    );
  }

  selectedAadhaarCardAfterWidget(String? aadhaarCardData){
    if(aadhaarCardData != null && aadhaarCardData.length  > 1)
    {
      return  Center(child: Image.asset(AppImages.imgPDf,
        height: 50,width: 50,));
    }else{
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          SvgPicture.asset(AppImages.icCamera),

          SizedBox(height: 7.h,),

          Text("Aadhaarcard\n(Document)\n(PDF)",
              textAlign: TextAlign.center,
              style: styleSmall3.copyWith(
                color: textGrayColor,
                fontWeight: FontWeight.w500,
              )),
        ],);
    }

  }

  _pickAadhaarCardPDFFile() async {
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf']
    );

    if(filePickerResult != null &&
        filePickerResult.files.single.path != null){


      PlatformFile file = filePickerResult.files.first;

      if(file.extension ==  "pdf")
      {
        File file = File(filePickerResult.files.single.path!);
        aadhaarCardPDFText?.add(file.path);
      }
      else {
        showMessageBar("You have to Select only PDF format");
        aadhaarCardPDFText?.add("");
      }



    }

  }

  _pickImage() async{
    XFile? image = await imagePicker?.pickImage(source: ImageSource.gallery);

    print(image);
    if(image != null){
      photoOrCameraFile?.add(image.path);
    }
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child:  Text('Photo Gallery',
                style: styleLarge1.copyWith(
                  color: secondaryColor,
                  fontWeight: FontWeight.w600,
                )),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              _pickImage();
            },
          ),
          CupertinoActionSheetAction(
            child:  Text('Camera', style: styleLarge1.copyWith(
              color: secondaryColor,
              fontWeight: FontWeight.w600,
            )),
            onPressed: () {

              Navigator.of(context).pop();

              _pickCamera();
            },
          ),
        ],
      ),
    );
  }

  selectedPhotoWidget(String? data){

    if(data != null && data.length > 1)
    {
      return Center(child: Image.file(File(data.toString()),
        height: 60.h,
        width: 70.w,),);
    }
    else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          SvgPicture.asset(AppImages.icCamera),

          SizedBox(height: 7.h,),

          Text("Add Photo\n(upload and Live photo)",
              textAlign: TextAlign.center,
              style: styleSmall3.copyWith(
                color: textGrayColor,
                fontWeight: FontWeight.w500,
              )),
        ],);
    }

  }


  _pickCamera() async{
    XFile? image = await imagePicker?.pickImage(source:
    ImageSource.camera);

    if(image != null){
      photoOrCameraFile?.add(image.path);
    }
  }

  Widget submitButton() {
    return ButtonView(string('label_submit'),false, () async {

      var state = _formKey.currentState!;
      if(state.validate()) {

        if(aadhaarCardPDFText!.value.length > 1
            && photoOrCameraFile!.value.length > 1) {

          hideKeyboard(context);
          Map? personData = {
            "fName": _firstNameController.text.trim().toString(),
            "lName": _secondNameController.text.trim().toString(),
            "designation": _designationController.text.trim().toString(),
            "DOB": _dateOfBirthController.text.trim().toString(),
            "aDate": _anniversaryDateController.text.trim().toString(),
            "document": aadhaarCardPDFText?.value.toString().split('/').last,
            "image": photoOrCameraFile?.value.toString()
          };


          widget.callBackPerson?.call(personData);
          Navigator.pop(context);
        } else {
          showMessageBar("Please Upload Document or Photo ");
        }
      }


    });
  }
}
