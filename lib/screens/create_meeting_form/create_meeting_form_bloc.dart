import 'package:dio/dio.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/remote/model/get_meeting_mode_response_model.dart' as meetingMode;
import 'package:rise_and_grow/remote/repository/auth_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/constants/app_widgets.dart';
import '../../remote/model/create_meeting_response_model.dart';
import '../../remote/model/get_meeting_type_list_response_model.dart' as meetingType;

class CreateMeetingFormBloc extends BasePageBloc {

  late BehaviorSubject<meetingType.ResponseData> meetingList;
  late BehaviorSubject<meetingMode.ResponseData> meetingModeList;

  CreateMeetingFormBloc(){
    meetingList = BehaviorSubject<meetingType.ResponseData>.seeded(meetingType.ResponseData());
    meetingModeList = BehaviorSubject<meetingMode.ResponseData>.seeded(meetingMode.ResponseData());
  }

  void getMeetingList(Function(meetingType.GetmeetingTypeResponseModel) onSuccess) {
    showLoadingDialog();
    apiMeetingTypeList((response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar(error.message ?? "");
    });
  }

  void getMeetingModeList(Function(meetingMode.GetMeetingModeResponseModel) onSuccess) {
    showLoadingDialog();
    apiMeetingModeList((response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar(error.message ?? "");
    });
  }

  void createMeeting(FormData? data, Function(CreateMeetingResponseModel) onSuccess){
    showLoadingDialog();
    apiCreateMeeting(data, (response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar('Server Error :${error.message ?? ""}');
    });
  }

}

