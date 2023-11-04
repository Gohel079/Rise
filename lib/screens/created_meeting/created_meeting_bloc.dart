import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/remote/repository/auth_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/constants/app_widgets.dart';
import '../../remote/model/get_created_meeting_list_respinse_model.dart' as GetCreatedMeeting;

class CreatedMeetingBloc extends BasePageBloc {
  late BehaviorSubject<List<GetCreatedMeeting.Data>> getCreatedMeetingList;

  VisitorRegistrationBloc(){
    getCreatedMeetingList = BehaviorSubject<List<GetCreatedMeeting.Data>>.seeded([]);
  }

  void getCreatedMeetingsList(Function(GetCreatedMeeting.GetCreatedMeetingResponseModel) onSuccess) {
    showLoadingDialog();
    apiGetCreatedMeetingList((response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar('ERROR ${error.message ?? ""}');
    });
  }

  @override
  void dispose() {
    getCreatedMeetingList.close();
    super.dispose();
  }

}