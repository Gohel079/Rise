import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/remote/model/saveAcceptRejectRequestEmpResponse.dart';

import '../../base/constants/app_widgets.dart';
import '../../remote/repository/auth_repository.dart';

class EmpVisitorCreateMeetingBloc extends BasePageBloc{



  void getResultOfEmpRequest(Map? data,Function(SaveAccepteRejectRequestEmp) onSuccess) {
    showLoadingDialog();
    apiSaveAccepteRejectRequestEmp(data,(response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar('ERROR ${error.message ?? ""}');
    });
  }

}