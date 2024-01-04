import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/remote/model/start_meeting_response_model.dart';

import '../../base/constants/app_widgets.dart';
import '../../remote/repository/auth_repository.dart';

class StartMeetingBloc  extends BasePageBloc{



  void startMeetingApicall(Map? data,Function(StartMeetingResponseModel) onSuccess) {
    showLoadingDialog();
    apiStartMeetingCall(data,(response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar('ERROR ${error.message ?? ""}');
    });
  }
}