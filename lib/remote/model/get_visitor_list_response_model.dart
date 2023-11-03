// To parse this JSON data, do
//
//     final getVisitorResponseModel = getVisitorResponseModelFromJson(jsonString);

import 'dart:convert';

GetVisitorResponseModel getVisitorResponseModelFromJson(String str) => GetVisitorResponseModel.fromJson(json.decode(str));

String getVisitorResponseModelToJson(GetVisitorResponseModel data) => json.encode(data.toJson());

class GetVisitorResponseModel {
  ResponseData? responseData;
  String? responseType;
  bool? toast;
  dynamic message;

  GetVisitorResponseModel({
    this.responseData,
    this.responseType,
    this.toast,
    this.message,
  });

  GetVisitorResponseModel copyWith({
    ResponseData? responseData,
    String? responseType,
    bool? toast,
    dynamic message,
  }) =>
      GetVisitorResponseModel(
        responseData: responseData ?? this.responseData,
        responseType: responseType ?? this.responseType,
        toast: toast ?? this.toast,
        message: message ?? this.message,
      );

  factory GetVisitorResponseModel.fromJson(Map<String, dynamic> json) => GetVisitorResponseModel(
    responseData: json["responseData"] is String ? json["responseData"] :json["responseData"] == null ? null : ResponseData.fromJson(json["responseData"]),
    responseType: json["response_type"],
    toast: json["toast"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "responseData": responseData is String ? responseData : responseData?.toJson(),
    "response_type": responseType,
    "toast": toast,
    "message": message,
  };
}

class ResponseData {
  List<Datum>? data;
  int? count;
  int? currentPage;
  int? limit;
  int? lastPage;

  ResponseData({
    this.data,
    this.count,
    this.currentPage,
    this.limit,
    this.lastPage,
  });

  ResponseData copyWith({
    List<Datum>? data,
    int? count,
    int? currentPage,
    int? limit,
    int? lastPage,
  }) =>
      ResponseData(
        data: data ?? this.data,
        count: count ?? this.count,
        currentPage: currentPage ?? this.currentPage,
        limit: limit ?? this.limit,
        lastPage: lastPage ?? this.lastPage,
      );

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    count: json["count"],
    currentPage: json["currentPage"],
    limit: json["limit"],
    lastPage: json["lastPage"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "count": count,
    "currentPage": currentPage,
    "limit": limit,
    "lastPage": lastPage,
  };
}

class Datum {
  int? requestId;
  String? systemId;
  String? purposeOfMeeting;
  String? tokenNumber;
  Status? reqStatus;
  dynamic recRemark;
  List<ReqRequestMap>? reqRequestMap;

  Datum({
    this.requestId,
    this.systemId,
    this.purposeOfMeeting,
    this.tokenNumber,
    this.reqStatus,
    this.recRemark,
    this.reqRequestMap,
  });

  Datum copyWith({
    int? requestId,
    String? systemId,
    String? purposeOfMeeting,
    String? tokenNumber,
    Status? reqStatus,
    dynamic recRemark,
    List<ReqRequestMap>? reqRequestMap,
  }) =>
      Datum(
        requestId: requestId ?? this.requestId,
        systemId: systemId ?? this.systemId,
        purposeOfMeeting: purposeOfMeeting ?? this.purposeOfMeeting,
        tokenNumber: tokenNumber ?? this.tokenNumber,
        reqStatus: reqStatus ?? this.reqStatus,
        recRemark: recRemark ?? this.recRemark,
        reqRequestMap: reqRequestMap ?? this.reqRequestMap,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    requestId: json["requestID"],
    systemId: json["SystemID "],
    purposeOfMeeting: json["purposeOfMeeting"],
    tokenNumber: json["TokenNumber"],
    reqStatus: statusValues.map[json["ReqStatus"]]!,
    recRemark: json["RecRemark"],
    reqRequestMap: json["reqRequestMap"] == null ? [] : List<ReqRequestMap>.from(json["reqRequestMap"]!.map((x) => ReqRequestMap.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "requestID": requestId,
    "SystemID ": systemId,
    "purposeOfMeeting": purposeOfMeeting,
    "TokenNumber": tokenNumber,
    "ReqStatus": statusValues.reverse[reqStatus],
    "RecRemark": recRemark,
    "reqRequestMap": reqRequestMap == null ? [] : List<dynamic>.from(reqRequestMap!.map((x) => x.toJson())),
  };
}

class ReqRequestMap {
  int? reqMapMeetId;
  int? requestId;
  int? visitorId;
  Status? evStatus;
  bool? attendance;
  bool? isDeleted;
  DateTime? createdAt;
  ReqVisitorMap? reqVisitorMap;
  ReqEmployeeMap? reqEmployeeMap;

  ReqRequestMap({
    this.reqMapMeetId,
    this.requestId,
    this.visitorId,
    this.evStatus,
    this.attendance,
    this.isDeleted,
    this.createdAt,
    this.reqVisitorMap,
    this.reqEmployeeMap,
  });

  ReqRequestMap copyWith({
    int? reqMapMeetId,
    int? requestId,
    int? visitorId,
    Status? evStatus,
    bool? attendance,
    bool? isDeleted,
    DateTime? createdAt,
    ReqVisitorMap? reqVisitorMap,
    ReqEmployeeMap? reqEmployeeMap,
  }) =>
      ReqRequestMap(
        reqMapMeetId: reqMapMeetId ?? this.reqMapMeetId,
        requestId: requestId ?? this.requestId,
        visitorId: visitorId ?? this.visitorId,
        evStatus: evStatus ?? this.evStatus,
        attendance: attendance ?? this.attendance,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
        reqVisitorMap: reqVisitorMap ?? this.reqVisitorMap,
        reqEmployeeMap: reqEmployeeMap ?? this.reqEmployeeMap,
      );

  factory ReqRequestMap.fromJson(Map<String, dynamic> json) => ReqRequestMap(
    reqMapMeetId: json["reqMapMeetID"],
    requestId: json["requestID"],
    visitorId: json["visitorID"],
    evStatus: statusValues.map[json["evStatus"]]!,
    attendance: json["Attendance"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    reqVisitorMap: json["reqVisitorMap"] == null ? null : ReqVisitorMap.fromJson(json["reqVisitorMap"]),
    reqEmployeeMap: json["reqEmployeeMap"] == null ? null : ReqEmployeeMap.fromJson(json["reqEmployeeMap"]),
  );

  Map<String, dynamic> toJson() => {
    "reqMapMeetID": reqMapMeetId,
    "requestID": requestId,
    "visitorID": visitorId,
    "evStatus": statusValues.reverse[evStatus],
    "Attendance": attendance,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "reqVisitorMap": reqVisitorMap?.toJson(),
    "reqEmployeeMap": reqEmployeeMap?.toJson(),
  };
}

enum Status {
  PENDING
}

final statusValues = EnumValues({
  "Pending": Status.PENDING
});

class ReqEmployeeMap {
  int? empId;
  String? firstName;
  String? lastName;
  String? empCode;
  String? birthDate;
  String? joiningDate;
  String? empProfileIMg;
  String? empIdCard;
  String? empAadharCard;
  int? departmentId;
  int? designationId;
  String? email;
  String? phone;
  String? password;
  int? companyId;
  int? officeId;
  int? roleId;
  bool? isActive;
  bool? isDeleted;
  dynamic createdBy;
  String? updatedBy;
  dynamic deletedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  ReqEmployeeMap({
    this.empId,
    this.firstName,
    this.lastName,
    this.empCode,
    this.birthDate,
    this.joiningDate,
    this.empProfileIMg,
    this.empIdCard,
    this.empAadharCard,
    this.departmentId,
    this.designationId,
    this.email,
    this.phone,
    this.password,
    this.companyId,
    this.officeId,
    this.roleId,
    this.isActive,
    this.isDeleted,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  ReqEmployeeMap copyWith({
    int? empId,
    String? firstName,
    String? lastName,
    String? empCode,
    String? birthDate,
    String? joiningDate,
    String? empProfileIMg,
    String? empIdCard,
    String? empAadharCard,
    int? departmentId,
    int? designationId,
    String? email,
    String? phone,
    String? password,
    int? companyId,
    int? officeId,
    int? roleId,
    bool? isActive,
    bool? isDeleted,
    dynamic createdBy,
    String? updatedBy,
    dynamic deletedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
  }) =>
      ReqEmployeeMap(
        empId: empId ?? this.empId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        empCode: empCode ?? this.empCode,
        birthDate: birthDate ?? this.birthDate,
        joiningDate: joiningDate ?? this.joiningDate,
        empProfileIMg: empProfileIMg ?? this.empProfileIMg,
        empIdCard: empIdCard ?? this.empIdCard,
        empAadharCard: empAadharCard ?? this.empAadharCard,
        departmentId: departmentId ?? this.departmentId,
        designationId: designationId ?? this.designationId,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        companyId: companyId ?? this.companyId,
        officeId: officeId ?? this.officeId,
        roleId: roleId ?? this.roleId,
        isActive: isActive ?? this.isActive,
        isDeleted: isDeleted ?? this.isDeleted,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
        deletedBy: deletedBy ?? this.deletedBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  factory ReqEmployeeMap.fromJson(Map<String, dynamic> json) => ReqEmployeeMap(
    empId: json["empID"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    empCode: json["empCode"],
    birthDate: json["birthDate"],
    joiningDate: json["joiningDate"],
    empProfileIMg: json["empProfileIMg"],
    empIdCard: json["empIDCard"],
    empAadharCard: json["empAadharCard"],
    departmentId: json["departmentID"],
    designationId: json["designationID"],
    email: json["email"],
    phone: json["phone"],
    password: json["password"],
    companyId: json["companyID"],
    officeId: json["officeID"],
    roleId: json["roleID"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    createdBy: json["createdBy"],
    updatedBy: json["updatedBy"],
    deletedBy: json["deletedBy"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    deletedAt: json["deletedAt"],
  );

  Map<String, dynamic> toJson() => {
    "empID": empId,
    "firstName": firstName,
    "lastName": lastName,
    "empCode": empCode,
    "birthDate": birthDate,
    "joiningDate": joiningDate,
    "empProfileIMg": empProfileIMg,
    "empIDCard": empIdCard,
    "empAadharCard": empAadharCard,
    "departmentID": departmentId,
    "designationID": designationId,
    "email": email,
    "phone": phone,
    "password": password,
    "companyID": companyId,
    "officeID": officeId,
    "roleID": roleId,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "createdBy": createdBy,
    "updatedBy": updatedBy,
    "deletedBy": deletedBy,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "deletedAt": deletedAt,
  };
}

class ReqVisitorMap {
  int? visitorId;
  String? vFirstName;
  String? vLastName;
  dynamic vPurposeOfVisit;
  DateTime? vDateOfBirth;
  VImage? vImage;
  VIdDoc? vIdDoc;
  String? vCompanyName;
  String? vDesignation;
  String? vCompanyAddress;
  String? vCompanyContact;
  String? vCompanyEmail;
  String? vAnniversaryDate;
  dynamic vContactPersonName;
  DateTime? createdAt;
  dynamic deletedAt;
  DateTime? updatedAt;

  ReqVisitorMap({
    this.visitorId,
    this.vFirstName,
    this.vLastName,
    this.vPurposeOfVisit,
    this.vDateOfBirth,
    this.vImage,
    this.vIdDoc,
    this.vCompanyName,
    this.vDesignation,
    this.vCompanyAddress,
    this.vCompanyContact,
    this.vCompanyEmail,
    this.vAnniversaryDate,
    this.vContactPersonName,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
  });

  ReqVisitorMap copyWith({
    int? visitorId,
    String? vFirstName,
    String? vLastName,
    dynamic vPurposeOfVisit,
    DateTime? vDateOfBirth,
    VImage? vImage,
    VIdDoc? vIdDoc,
    String? vCompanyName,
    String? vDesignation,
    String? vCompanyAddress,
    String? vCompanyContact,
    String? vCompanyEmail,
    String? vAnniversaryDate,
    dynamic vContactPersonName,
    DateTime? createdAt,
    dynamic deletedAt,
    DateTime? updatedAt,
  }) =>
      ReqVisitorMap(
        visitorId: visitorId ?? this.visitorId,
        vFirstName: vFirstName ?? this.vFirstName,
        vLastName: vLastName ?? this.vLastName,
        vPurposeOfVisit: vPurposeOfVisit ?? this.vPurposeOfVisit,
        vDateOfBirth: vDateOfBirth ?? this.vDateOfBirth,
        vImage: vImage ?? this.vImage,
        vIdDoc: vIdDoc ?? this.vIdDoc,
        vCompanyName: vCompanyName ?? this.vCompanyName,
        vDesignation: vDesignation ?? this.vDesignation,
        vCompanyAddress: vCompanyAddress ?? this.vCompanyAddress,
        vCompanyContact: vCompanyContact ?? this.vCompanyContact,
        vCompanyEmail: vCompanyEmail ?? this.vCompanyEmail,
        vAnniversaryDate: vAnniversaryDate ?? this.vAnniversaryDate,
        vContactPersonName: vContactPersonName ?? this.vContactPersonName,
        createdAt: createdAt ?? this.createdAt,
        deletedAt: deletedAt ?? this.deletedAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ReqVisitorMap.fromJson(Map<String, dynamic> json) => ReqVisitorMap(
    visitorId: json["visitorID"],
    vFirstName: json["vFirstName"],
    vLastName: json["vLastName"],
    vPurposeOfVisit: json["vPurposeOfVisit"],
    vDateOfBirth: json["vDateOfBirth"] == null ? null : DateTime.parse(json["vDateOfBirth"]),
    vImage: vImageValues.map[json["vImage"]]!,
    vIdDoc: vIdDocValues.map[json["vIDDoc"]]!,
    vCompanyName: json["vCompanyName"],
    vDesignation: json["vDesignation"],
    vCompanyAddress: json["vCompanyAddress"],
    vCompanyContact: json["vCompanyContact"],
    vCompanyEmail: json["vCompanyEmail"],
    vAnniversaryDate: json["vAnniversaryDate"],
    vContactPersonName: json["vContactPersonName"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    deletedAt: json["deletedAt"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "visitorID": visitorId,
    "vFirstName": vFirstName,
    "vLastName": vLastName,
    "vPurposeOfVisit": vPurposeOfVisit,
    "vDateOfBirth": vDateOfBirth?.toIso8601String(),
    "vImage": vImageValues.reverse[vImage],
    "vIDDoc": vIdDocValues.reverse[vIdDoc],
    "vCompanyName": vCompanyName,
    "vDesignation": vDesignation,
    "vCompanyAddress": vCompanyAddress,
    "vCompanyContact": vCompanyContact,
    "vCompanyEmail": vCompanyEmail,
    "vAnniversaryDate": vAnniversaryDate,
    "vContactPersonName": vContactPersonName,
    "createdAt": createdAt?.toIso8601String(),
    "deletedAt": deletedAt,
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

enum VCompanyName {
  ROTO,
  SFSFSF,
  TEST
}

final vCompanyNameValues = EnumValues({
  "ROTO": VCompanyName.ROTO,
  "sfsfsf": VCompanyName.SFSFSF,
  "test": VCompanyName.TEST
});

enum VIdDoc {
  SDS_SDSD_DASD
}

final vIdDocValues = EnumValues({
  "sds./sdsd/dasd/": VIdDoc.SDS_SDSD_DASD
});

enum VImage {
  URL_FDFDSLF_COM
}

final vImageValues = EnumValues({
  "url//fdfdslf.com": VImage.URL_FDFDSLF_COM
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
