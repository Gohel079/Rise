
import 'package:dio/src/form_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/remote/model/getDepartmentList_response_model.dart' as departMentData;
import 'package:rise_and_grow/remote/model/get_compantlist_response_model.dart' as companyData;
import 'package:rise_and_grow/remote/model/get_designationList_response_model.dart' as designationData;
import 'package:rise_and_grow/remote/model/get_officelist_response_model.dart' as officeData;
import 'package:rise_and_grow/remote/model/register_response_model.dart';
import 'package:rise_and_grow/remote/repository/auth_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/constants/app_widgets.dart';


class RegisterScreenBloc extends BasePageBloc {


  late BehaviorSubject<companyData.ResponseData> companyList;
  late BehaviorSubject<departMentData.ResponseData> departmentList;
  late BehaviorSubject<designationData.ResponseData> designationList;
  late BehaviorSubject<officeData.ResponseData> officeAddressList;

  RegisterScreenBloc(){
    companyList = BehaviorSubject<companyData.ResponseData>.seeded(companyData.ResponseData());
    departmentList = BehaviorSubject<departMentData.ResponseData>.seeded(departMentData.ResponseData());
    designationList = BehaviorSubject<designationData.ResponseData>.seeded(designationData.ResponseData());
    officeAddressList = BehaviorSubject<officeData.ResponseData>.seeded(officeData.ResponseData());
  }


  void doRegister(FormData? data, Function(RegisterResponseModel) onSuccess) {
    showLoadingDialog();
    apiRegister(data, (response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar(error.message ?? "");
    });
  }

  void getCompanyList(Function(companyData.GetCompanyListResponseModel) onSuccess) {
    showLoadingDialog();
    apiGetCompanyList((response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar(error.message ?? "");
    });
  }

  void getDepartmentList(Function(departMentData.GetDepartmentListResponseModel) onSuccess) {
    showLoadingDialog();
    apiGetDepartmentList((response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar(error.message ?? "");
    });
  }

  void getDesignationList(Function(designationData.GetDesignationListResponseModel) onSuccess) {
    showLoadingDialog();
    apiGetDesignation((response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar(error.message ?? "");
    });
  }


  void getOfficeList(String? companyId,Map? data,Function(officeData.GetOfficeListResponseModel) onSuccess) {
    showLoadingDialog();
    apiOfficeList(companyId,data, (response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar(error.message ?? "");
    });
  }

}