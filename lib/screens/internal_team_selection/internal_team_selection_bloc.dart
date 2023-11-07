import 'package:rise_and_grow/base/src_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rise_and_grow/remote/model/get_employee_list_response_model.dart' as getEmployeeData;

import '../../base/constants/app_widgets.dart';
import '../../remote/repository/auth_repository.dart';

class InternalTeamSelectionBloc extends BasePageBloc{
  late BehaviorSubject<List<getEmployeeData.Datum>>  employeeList;

  InternalTeamSelectionBloc(){
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

  @override
  void dispose() {
    employeeList.close();
    super.dispose();
  }
}