import 'package:dio/dio.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/remote/model/get_meeting_mode_response_model.dart' as meetingMode;
import 'package:rise_and_grow/remote/repository/auth_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/constants/app_widgets.dart';
import '../../remote/model/create_meeting_response_model.dart';
import 'package:rise_and_grow/remote/model/get_compantlist_response_model.dart' as companyData;
import '../../remote/model/get_meeting_type_list_response_model.dart' as meetingType;
import '../../remote/model/get_officelist_response_model.dart' as officeData;

class CreateMeetingFormBloc extends BasePageBloc {

  late BehaviorSubject<meetingType.ResponseData> meetingList;
  late BehaviorSubject<meetingMode.ResponseData> meetingModeList;
  late BehaviorSubject<companyData.ResponseData> companyList;
  late BehaviorSubject<officeData.ResponseData> officeAddressList;

  CreateMeetingFormBloc(){
    companyList = BehaviorSubject<companyData.ResponseData>.seeded(companyData.ResponseData());
    officeAddressList = BehaviorSubject<officeData.ResponseData>.seeded(officeData.ResponseData());
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

  void getOfficeList(int? companyId,Function(officeData.GetOfficeListResponseModel) onSuccess) {
    showLoadingDialog();
    apiOfficeList(companyId, (response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar('Server Error :${error.message ?? ""}');
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

  void createMeeting(Map? data, Function(CreateMeetingResponseModel) onSuccess){
    showLoadingDialog();
    apiCreateMeeting(data, (response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar('Server Error :${error.message ?? ""}');
    });
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
}

