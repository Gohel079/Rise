import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/constants/app_widgets.dart';
import '../../remote/model/get_outer_meeting_list_response_model.dart' as GetOuterMeeting;
import '../../remote/repository/auth_repository.dart';

class OuterMeetingBloc extends BasePageBloc{

  late BehaviorSubject<List<GetOuterMeeting.Data>> getOuterMeetingList;

  OuterMeetingBloc() {
    getOuterMeetingList =
    BehaviorSubject<List<GetOuterMeeting.Data>>.seeded([]);
  }

  void getOuterMeetingsListFunc(Map? data, Function(GetOuterMeeting.GetOuterMeetingResponseModel) onSuccess) {
    showLoadingDialog();
    apiGetOuterMeetingList((response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar('ERROR ${error.message ?? ""}');
    });
  }

  @override
  void dispose() {
    getOuterMeetingList.close();
    super.dispose();
  }
}