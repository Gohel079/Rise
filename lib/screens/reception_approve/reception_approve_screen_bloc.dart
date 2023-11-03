import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/remote/model/save_token_receipt_response.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/constants/app_widgets.dart';
import '../../remote/model/get_compantlist_response_model.dart';
import '../../remote/model/get_designationList_response_model.dart';
import '../../remote/repository/auth_repository.dart';
import 'package:rise_and_grow/remote/model/getDepartmentList_response_model.dart' as departMentData;
import 'package:rise_and_grow/remote/model/get_officelist_response_model.dart' as officeData;
import 'package:rise_and_grow/remote/model/get_compantlist_response_model.dart' as companyData;
import 'package:rise_and_grow/remote/model/get_designationList_response_model.dart' as designationData;

class ReceptionApproveScreenBloc extends BasePageBloc {

  late BehaviorSubject<companyData.ResponseData> companyList;
  late BehaviorSubject<officeData.ResponseData> officeAddressList;
  late BehaviorSubject<departMentData.ResponseData> departmentList;
  late BehaviorSubject<designationData.ResponseData> designationList;

  ReceptionApproveScreenBloc(){

    companyList = BehaviorSubject<companyData.ResponseData>.seeded(companyData.ResponseData());
    officeAddressList = BehaviorSubject<officeData.ResponseData>.seeded(officeData.ResponseData());
    designationList = BehaviorSubject<designationData.ResponseData>.seeded(designationData.ResponseData());
    departmentList = BehaviorSubject<departMentData.ResponseData>.seeded(departMentData.ResponseData());
  }
  void getCompanyList(Function(companyData.GetCompanyListResponseModel) onSuccess) {
    showLoadingDialog();
    apiGetCompanyList((response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar('Server Error :${error.message ?? ""}');
    });
  }

  void getOfficeList(int? companyId,Function(officeData.GetOfficeListResponseModel) onSuccess) {
    showLoadingDialog();
    apiOfficeList(companyId, (response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar('Server Error :${error.message ?? ""}');
    });
  }

  void getDepartmentList(Function(departMentData.GetDepartmentListResponseModel) onSuccess) {
    showLoadingDialog();
    apiGetDepartmentList((response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar('Server Error :${error.message ?? ""}');
    });
  }

  void getDesignationList(Map? data,Function(designationData.GetDesignationListResponseModel) onSuccess) {
    showLoadingDialog();
    apiGetDesignationList(data,(response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar('Server Error :${error.message ?? ""}');
    });
  }

  void doSaveTokenByReceipt(Map? data,Function(SaveTokenReceiptResponse) onSuccess) {
    showLoadingDialog();
    apiSaveTokenReceipt(data,(response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar('Server Error :${error.message ?? ""}');
    });
  }


  @override
  void dispose() {
    companyList.close();
    officeAddressList.close();
    super.dispose();
  }

}