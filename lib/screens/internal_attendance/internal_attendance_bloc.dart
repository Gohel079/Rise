import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/constants/app_widgets.dart';
import '../../remote/model/get_employee_list_response_model.dart'as getEmployeeData;
import '../../remote/repository/auth_repository.dart';

class InternalAttendanceBloc extends BasePageBloc{

  late BehaviorSubject<List<getEmployeeData.Datum>>  employeeList;

  InternalAttendanceBloc(){
    employeeList = BehaviorSubject<List<getEmployeeData.Datum>>.seeded([]);
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
}