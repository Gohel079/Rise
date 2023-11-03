import 'common_utils.dart';

String? validateEmail(String? value) {
  if (value!.trim().isEmpty) {
    return "Email Address is Required";
  }
  if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return "Email is invalid";
  }
  return null;
}

String? validateMobile(String? value) {
  if (value!.trim().isEmpty) {
    return "Mobile Number is required.";
  }
  if (value.trim().length!=10) {
    return "Mobile Number is invalid.";
  }
  return null;
}

String? validateDOB(String? value) {
  if (value!.trim().isEmpty) {
    return "Date of Birth is required.";
  }
  return null;
}

String? validateStrongPassword(String? value) {
  final capitalLetterRegex = RegExp(r'(?=.*[A-Z])');
  final specialCharacterRegex = RegExp(r'(?=.*[!@#$%^&()])');
  final lowercaseLetterRegex = RegExp(r'(?=.*[a-z])');
  final digitRegex = RegExp(r'(?=.*[0-9])');
  if (value!.trim().isEmpty) {
    return "Password is required.";
  }
  if(!capitalLetterRegex.hasMatch(value))
     return "Password needs to have at least one capital letter";

  if (!specialCharacterRegex.hasMatch(value)) {
    return "Password needs to have at least one special character";
  }

  if (!lowercaseLetterRegex.hasMatch(value)) {
    return "Password needs to have at least one lower case character";
  }

  if (!digitRegex.hasMatch(value)) {
    return "Password needs to have at least one number";
  }

  if (value.length < 9 || value.contains(' ')) {
    return "Password must contain minimum 8 letters without space";
  }
  return null;
}

String? validateLoginPassword(String? value){
  if(value!.trim().isEmpty){
    return "Password is Required";
  }

  return null;
}

String? validateAnniversaryDate(String? value) {
  if (value!.trim().isEmpty) {
    return "Anniversary Date is required.";
  }
  return null;
}

String? validateAadhaarNumber(String? value) {
  if (value!.trim().isEmpty) {
    return "Aadhaar Number is required.";
  }
  return null;
}

String? validateCompanyName(dynamic? value) {
  if (value!.trim().isEmpty || value == "Select Company Name") {
    return "Please Select Company Name";
  }
  return null;
}

String? validateCompanyNameFillUp(dynamic? value) {
  if (value!.trim().isEmpty) {
    return "Company Name is Required";
  }
  return null;
}

String? validateDepartment(dynamic? value) {
  if (value!.trim().isEmpty || value == "Select Department") {
    return "Please Select Department";
  }
  return null;
}


String? validateDesignationDropDown(dynamic? value) {
  if (value!.trim().isEmpty || value == "Select Designation") {
    return "Please Select Designation";
  }
  return null;
}

String? validateDesignation(dynamic? value) {
  if (value!.trim().isEmpty) {
    return "Designation Name is Required";
  }
  return null;
}




String? validateOfficeAddress(dynamic? value) {
  if (value!.trim().isEmpty || value == "Select Office Address") {
    return "Please Select Office Address";
  }
  return null;
}

String? validateRoleDropDown(dynamic? value) {
  if (value!.trim().isEmpty || value == "Select Role") {
    return "Please Select Role";
  }
  return null;
}


String? validateNameTitle(String? value) {
  if (value=="Title") {
    return "Title is required.";
  }
  return null;
}

String? validateOTP(String? value) {
  if (value!.trim().isEmpty) {
    return "OTP is required.";
  }
  return null;
}

String? validateCompanyAddress(String? value) {
  if (value!.trim().isEmpty) {
    return "Company Address is required.";
  }
  return null;
}

String? validateFirstName(String? value) {
  if (value!.trim().isEmpty) {
    return "Name is required.";
  }
  return null;
}

String? validateLastName(String? value) {
  if (value!.trim().isEmpty) {
    return "Last Name is required.";
  }
  return null;
}

String? validateEmployeeCode(String? value) {
  if (value!.trim().isEmpty) {
    return "Employee Code is required.";
  }
  return null;
}

String? validatePurposeOfVisit(String? value) {
  if (value!.trim().isEmpty) {
    return "Purpose of visit is required.";
  }
  return null;
}

String? validateCustomerAddress(String? value) {
  if (value!.trim().isEmpty) {
    return "Address is required.";
  }
  return null;
}

String? validateState(String? value) {
  if (value!.trim().isEmpty) {
    return "State is required.";
  }
  return null;
}

String? validateCity(String? value) {
  if (value!.trim().isEmpty) {
    return "City is required.";
  }
  return null;
}

String? validateArea(String? value) {
  if (value!.trim().isEmpty) {
    return "Area is required.";
  }
  return null;
}

String? validateDealer(String? value){
  if(value!.trim().isEmpty){
    return "Please Select purchase from !";
  }
  return null;
}

String? validateCategory(String? value){
  if(value!.trim().isEmpty || value == "Select"){
    return "Please Select Product Category !";
  }
  return null;
}

String? validateSubCategory(String? value){
  if(value!.trim().isEmpty|| value == "Select"){
    return "Please Select Product Sub Category !";
  }
  return null;
}
String? validateServiceCallType(String? value){
  if(value!.trim().isEmpty || value == "Select"){
    return "Please Select Service Call Type !";
  }
  return null;
}

String? validateNOC(String? value){
  if(value!.trim().isEmpty || value == "Select"){
    return "Please Select Nature of Complaint !";
  }
  return null;
}

String? validateCouponCode(String? value) {
  if (value!.trim().isEmpty) {
    return "Please Enter Coupon Code";
  }
  return null;
}


String? validateMobileAndEmail(String? value) {
  if (value!.trim().isEmpty) {
    return "Please Enter Your Email/Phone";
  }
  return null;
}

String? validateTypeOfMeeting(dynamic? value) {
  if (value == null) {
    return "Please Select Type of Meeting";
  }
  return null;
}

String? validateContactPersonName(dynamic? value) {
  if (value == null) {
    return "Please Contact Person";
  }
  if(value.toString().length < 1){
    return "Please Select Contact Person Name";
  }
  return null;
}

String? validateMeetingMode(dynamic? value) {
  if (value == null) {
    return "Please Select Meeting Mode";
  }
  return null;
}


String? validateMeetingPlatform(dynamic? value) {
  if (value == null) {
    return "Please Select Meeting Platform";
  }
  return null;
}

