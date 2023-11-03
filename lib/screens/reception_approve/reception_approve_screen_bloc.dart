import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/constants/app_widgets.dart';
import '../../remote/model/get_compantlist_response_model.dart';
import '../../remote/repository/auth_repository.dart';
import 'package:rise_and_grow/remote/model/getDepartmentList_response_model.dart' as departMentData;
import 'package:rise_and_grow/remote/model/get_officelist_response_model.dart' as officeData;
import 'package:rise_and_grow/remote/model/get_compantlist_response_model.dart' as companyData;

class ReceptionApproveScreenBloc extends BasePageBloc {

  late BehaviorSubject<companyData.ResponseData> companyList;
  late BehaviorSubject<officeData.ResponseData> officeAddressList;
  late BehaviorSubject<departMentData.ResponseData> departmentList;

  ReceptionApproveScreenBloc(){

    companyList = BehaviorSubject<companyData.ResponseData>.seeded(companyData.ResponseData());
    officeAddressList = BehaviorSubject<officeData.ResponseData>.seeded(officeData.ResponseData());
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

  void getOfficeList(String? companyId,Map? data,Function(officeData.GetOfficeListResponseModel) onSuccess) {
    showLoadingDialog();
    apiOfficeList(companyId,data, (response) {
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

  @override
  void dispose() {
    companyList.close();
    officeAddressList.close();
    super.dispose();
  }

}