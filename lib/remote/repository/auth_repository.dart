import 'package:dio/dio.dart';
import 'package:rise_and_grow/remote/model/getDepartmentList_response_model.dart';
import 'package:rise_and_grow/remote/model/get_compantlist_response_model.dart';
import 'package:rise_and_grow/remote/model/get_designationList_response_model.dart';
import 'package:rise_and_grow/remote/model/get_officelist_response_model.dart';
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
