
import 'package:dio/dio.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/remote/model/add_visitor_register_response_model.dart';
import 'package:rise_and_grow/remote/model/get_employee_list_response_model.dart' as getEmployeeData;
import 'package:rise_and_grow/remote/repository/auth_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/constants/app_widgets.dart';

class AddVisitorRegistrationBloc extends BasePageBloc {


  late BehaviorSubject<List<getEmployeeData.Datum>>  employeeList;



  AddVisitorRegistrationBloc(){
    employeeList = BehaviorSubject<List<getEmployeeData.Datum>>.seeded([]);

  }


  void doVisitorRegistration(FormData? data,Function(AddVisitorRegisterResponseModel) onSuccess) {
    showLoadingDialog();
    apiAddVisitorRegistration(data, (response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar('ERROR ${error.message ?? ""}');
    });
  }


  void doGetApiEmployeeList(Map? data,Function(getEmployeeData.GetEmployeeListResponseModel) onSuccess) {
    showLoadingDialog();
    apiEmployeeList(data, (response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar('ERROR ${error.message ?? ""}');
    });
  }

  @override
  void dispose() {
    employeeList.close();
    super.dispose();
  }
}