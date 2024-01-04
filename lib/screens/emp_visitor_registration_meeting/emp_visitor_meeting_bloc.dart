import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/remote/model/get_visitorlist_by_employee_id_response_model.dart' as empVisitor;
import 'package:rise_and_grow/remote/repository/auth_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/constants/app_widgets.dart';

class EmpVisitorMeetingBloc extends BasePageBloc {


  late BehaviorSubject<List<empVisitor.Datum>> getEmpVisitorList;
  List<empVisitor.Datum>? originalVisitorList = [];

  EmpVisitorMeetingBloc()
  {
    getEmpVisitorList = BehaviorSubject<List<empVisitor.Datum>>.seeded([]);
  }


  void getEmpVisitorMeetingList(int? data,Function(empVisitor.GetVisitorListByEmployeeResponseModel) onSuccess) {
    showLoadingDialog();
    apiGetVisitorListByEmployeeID(data,(response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar('ERROR ${error.message ?? ""}');
    });
  }






  @override
  void dispose() {
    super.dispose();
  }


}