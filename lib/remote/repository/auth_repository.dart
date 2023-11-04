import 'package:dio/dio.dart';
import 'package:rise_and_grow/remote/model/add_visitor_register_response_model.dart';
import 'package:rise_and_grow/remote/model/create_meeting_response_model.dart';
import 'package:rise_and_grow/remote/model/getDepartmentList_response_model.dart';
import 'package:rise_and_grow/remote/model/get_compantlist_response_model.dart';
import 'package:rise_and_grow/remote/model/get_created_meeting_list_respinse_model.dart';
import 'package:rise_and_grow/remote/model/get_designationList_response_model.dart';
import 'package:rise_and_grow/remote/model/get_employee_list_response_model.dart';
import 'package:rise_and_grow/remote/model/get_meeting_mode_response_model.dart';
import 'package:rise_and_grow/remote/model/get_meeting_type_list_response_model.dart';
import 'package:rise_and_grow/remote/model/get_officelist_response_model.dart';
import 'package:rise_and_grow/remote/model/get_role_list_response_model.dart';
import 'package:rise_and_grow/remote/model/get_visitor_list_response_model.dart';
import 'package:rise_and_grow/remote/model/loginWithEmailResponse.dart';
import 'package:rise_and_grow/remote/model/register_response_model.dart';

import '../../base/constants/app_endpoint.dart';
import '../../network/error/net_exception.dart';
import 'net_manager.dart';

/// Login API
void apiVerifyUser(Map? data , Function(LoginWithEmailResponse) onSuccess, Function(NetWorkException) onError) {
  post<String>(AppEndpoint.login, params: data, isAuth: false).then((value) {


    final response =  loginWithEmailResponseFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      print("ERROR- ${error.message}");
      onError(error);
    }else{
      onError(NetWorkException(101010,error.toString()));
      print("ERROR FAIL- ${error.message}");
    }
  });
}


/// Register API
void apiRegister(FormData? data , Function(RegisterResponseModel) onSuccess, Function(NetWorkException) onError) {
  post<String>(AppEndpoint.register, params: data, isAuth: false,options: Options(contentType: 'multipart/form-data') ).then((value) {


    final response =  registerResponseModelFromJson(value!);
    onSuccess(response);
    }).catchError((error) {
    if (error is NetWorkException) {
      print("ERROR ${error.message}");
      onError(error);
    }else{
      onError(NetWorkException(101010,error.toString()));
    }
  });

}



/// Get CompanyList API
void apiGetCompanyList(Function(GetCompanyListResponseModel) onSuccess, Function(NetWorkException) onError) {
  get<String>(AppEndpoint.getCompany, isAuth: false).then((value) {


    final response =  getCompanyListResponseModelFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      print("ERROR ${error.message}");
      onError(error);
    }else{
      onError(NetWorkException(101010,error.toString()));
    }
  });

}


/// Get Department API
void apiGetDepartmentList(Function(GetDepartmentListResponseModel) onSuccess,
    Function(NetWorkException) onError) {
  get<String>(AppEndpoint.getDepartment, isAuth: false).then((value) {


    final response =  getDepartmentListResponseModelFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      print("ERROR ${error.message}");
      onError(error);
    }else{
      onError(NetWorkException(101010,error.toString()));
    }
  });

}


/// Get Designation API
void apiGetDesignation(Function(GetDesignationListResponseModel) onSuccess,
    Function(NetWorkException) onError) {
  get<String>(AppEndpoint.getDesignation, isAuth: false).then((value) {


    final response =  getDesignationListResponseModelFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      print("ERROR ${error.message}");
      onError(error);
    }else{
      onError(NetWorkException(101010,error.toString()));
    }
  });

}


/// Get OfficeList API

void apiOfficeList(String? companyID,Map? data , Function(GetOfficeListResponseModel) onSuccess, Function(NetWorkException) onError) {
  get<String>("${AppEndpoint.getOffice}/${companyID!}", isAuth: false).then((value) {

    final response =  getOfficeListResponseModelFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      print("ERROR- ${error.message}");
      onError(error);
    }else{
      onError(NetWorkException(101010,error.toString()));
      print("ERROR FAIL- ${error.message}");
    }
  });
}


/// Get MeetingType List API
void apiMeetingTypeList(Function(GetmeetingTypeResponseModel) onSuccess, Function(NetWorkException) onError) {
  get<String>(AppEndpoint.getMeetingList, isAuth: false).then((value) {

    final response =  getmeetingTypeResponseModelFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      print("ERROR- ${error.message}");
      onError(error);
    }else{
      onError(NetWorkException(101010,error.toString()));
      print("ERROR FAIL- ${error.message}");
    }
  });
}


/// Get MeetingMode List API
void apiMeetingModeList(Function(GetMeetingModeResponseModel) onSuccess, Function(NetWorkException) onError) {
  get<String>(AppEndpoint.getMeetingModeList, isAuth: false).then((value) {

    final response =  getMeetingModeResponseModelFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      print("ERROR- ${error.message}");
      onError(error);
    }else{
      onError(NetWorkException(101010,error.toString()));
      print("ERROR FAIL- ${error.message}");
    }
  });
}

//Create Meeting API
void apiCreateMeeting(FormData? data, Function(CreateMeetingResponseModel) onSuccess, Function(NetWorkException) onError) {
  post<String>(AppEndpoint.createMeeting, params: data, isAuth: false, options: Options(contentType: 'multipart/form-data') ).then((value) {
    final response = createMeetingResponseModelFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      print("ERROR ${error.message}");
      onError(error);
    }else{
      onError(NetWorkException(101010,error.toString()));
    }
  });
}

void apiGetVisitorLis( Function(GetVisitorResponseModel) onSuccess, Function(NetWorkException) onError) {
  get<String>(AppEndpoint.getVisitorRegister, isAuth: false ).then((value) {


    final response =  getVisitorResponseModelFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      print("ERROR ${error.message}");
      onError(error);
    }else{
      onError(NetWorkException(101010,error.toString()));
    }
  });

}

/// Get Role List API
void apiGetRoleList(Function(GetRoleListResponseModel) onSuccess, Function(NetWorkException) onError) {
  get<String>(AppEndpoint.getRoleList, isAuth: false).then((value) {

    final response =  getRoleListResponseModelFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      print("ERROR- ${error.message}");
      onError(error);
    }else{
      onError(NetWorkException(101010,error.toString()));
      print("ERROR FAIL- ${error.message}");
    }
  });
}


/// Get ContactPerosn API
void apiEmployeeList(Map? data, Function(GetEmployeeListResponseModel) onSuccess, Function(NetWorkException) onError) {
  get<String>("${AppEndpoint.getEmployee}",params: data, isAuth: false).then((value) {

    final response =  getEmployeeListResponseModelFromJson(value ?? "");
    print("SUCCESS ***** ${response}");
    onSuccess(response);

  }).catchError((error) {
    if (error is NetWorkException) {
      print("ERROR- ${error.message}");
      onError(error);
    }else{
      onError(NetWorkException(101010,error.toString()));
      print("ERROR FAIL- ${error.message}");
    }
  });
}


/// Register API
void apiAddVisitorRegistration(Map? data , Function(AddVisitorRegisterResponseModel) onSuccess, Function(NetWorkException) onError) {
  post<String>(AppEndpoint.visitorRegister, params: data, isAuth: false ).then((value) {


    final response =  addVisitorRegisterResponseModelFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      print("ERROR ${error.message}");
      onError(error);
    }else{
      onError(NetWorkException(101010,error.toString()));
    }
  });

}



/// Get VisitorList API
void apiGetVisitorList( Function(GetVisitorResponseModel) onSuccess, Function(NetWorkException) onError) {
  get<String>(AppEndpoint.getVisitorRegister, isAuth: false ).then((value) {


    final response =  getVisitorResponseModelFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      print("ERROR ${error.message}");
      onError(error);
    }else{
      onError(NetWorkException(101010,error.toString()));
    }
  });

}

//Get CreatedMeetingList API
void apiGetCreatedMeetingList(Function(GetCreatedMeetingResponseModel) onSuccess, Function(NetWorkException) onError) {
  get<String>(AppEndpoint.getCreatedMeeting, isAuth: false).then((value) {
    final response = getCreatedMeetingResponseModelFromJson(value!);
    onSuccess(response);
  }).catchError((error) {
    if (error is NetWorkException) {
      print("ERROR ${error.message}");
      onError(error);
    }else{
      onError(NetWorkException(101010,error.toString()));
    }
  });
}