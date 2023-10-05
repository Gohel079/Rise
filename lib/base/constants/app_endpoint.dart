class AppEndpoint {
  AppEndpoint._();

  static const String appName = "Rise and Grow";

  /// api end-point
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String getCompany = "company/getCompanyList";
  static const String getDepartment = "department/get_department_list";
  static const String getDesignation = "designation/get_designation_list";
  static const String getOffice = "company/office/getOfficelistByCompany";
  static const String getMeetingList = "meetingtype/get_meetingType_list";
  static const String getMeetingModeList = "meetingmode/get_meetingMode_list";
  static const String getRoleList = "role/getRoleList";
  static const String getEmployee = "employee/getEmployeeList";
  static const String visitorRegister = "visitor/visitor_request_meeting";
  static const String getVisitorRegister = "visitor/get_visitor_req_list";



}
