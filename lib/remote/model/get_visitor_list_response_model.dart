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
    message: json["message"] == null ? "" : json["message"] ,
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
  String? purposeOfMeeting;
  String? tokenNumber;
  Status? reqStatus;
  dynamic recRemark;
  String? updatedBy;
  DateTime? createdAt;
  List<ReqRequestMap>? reqRequestMap;
  List<ReqRequestmeetDet>? reqRequestmeetDet;

  Datum({
    this.requestId,
    this.purposeOfMeeting,
    this.tokenNumber,
    this.reqStatus,
    this.recRemark,
    this.updatedBy,
    this.createdAt,
    this.reqRequestMap,
    this.reqRequestmeetDet,
  });

  Datum copyWith({
    int? requestId,
    String? purposeOfMeeting,
    String? tokenNumber,
    Status? reqStatus,
    dynamic recRemark,
    String? updatedBy,
    DateTime? createdAt,
    List<ReqRequestMap>? reqRequestMap,
    List<ReqRequestmeetDet>? reqRequestmeetDet,
  }) =>
      Datum(
        requestId: requestId ?? this.requestId,
        purposeOfMeeting: purposeOfMeeting ?? this.purposeOfMeeting,
        tokenNumber: tokenNumber ?? this.tokenNumber,
        reqStatus: reqStatus ?? this.reqStatus,
        recRemark: recRemark ?? this.recRemark,
        updatedBy: updatedBy ?? this.updatedBy,
        createdAt: createdAt ?? this.createdAt,
        reqRequestMap: reqRequestMap ?? this.reqRequestMap,
        reqRequestmeetDet: reqRequestmeetDet ?? this.reqRequestmeetDet,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    requestId: json["requestID"],
    purposeOfMeeting: json["purposeOfMeeting"],
    tokenNumber: json["TokenNumber"],
    reqStatus: statusValues.map[json["ReqStatus"]]!,
    recRemark: json["RecRemark"],
    updatedBy: json["updatedBy"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    reqRequestMap: json["reqRequestMap"] == [] ? [] : json["reqRequestMap"] == null ? [] : List<ReqRequestMap>.from(json["reqRequestMap"]!.map((x) => ReqRequestMap.fromJson(x))),
    reqRequestmeetDet: json["reqRequestmeetDet"] == null ? [] : List<ReqRequestmeetDet>.from(json["reqRequestmeetDet"]!.map((x) => ReqRequestmeetDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "requestID": requestId,
    "purposeOfMeeting": purposeOfMeeting,
    "TokenNumber": tokenNumber,
    "ReqStatus": statusValues.reverse[reqStatus],
    "RecRemark": recRemark,
    "updatedBy": updatedBy,
    "createdAt": createdAt?.toIso8601String(),
    "reqRequestMap": reqRequestMap == null ? [] : List<dynamic>.from(reqRequestMap!.map((x) => x.toJson())),
    "reqRequestmeetDet": reqRequestmeetDet == null ? [] : List<dynamic>.from(reqRequestmeetDet!.map((x) => x.toJson())),
  };
}

class ReqRequestMap {
  int? reqMapMeetId;
  int? requestId;
  bool? isVisitorSelected;
  dynamic evRemark;
  bool? attendance;
  dynamic empId;
  int? visitorId;
  Status? evStatus;
  bool? isDeleted;
  DateTime? createdAt;
  ReqVisitorMap? reqVisitorMap;
  dynamic reqEmployeeMap;

  ReqRequestMap({
    this.reqMapMeetId,
    this.requestId,
    this.isVisitorSelected,
    this.evRemark,
    this.attendance,
    this.empId,
    this.visitorId,
    this.evStatus,
    this.isDeleted,
    this.createdAt,
    this.reqVisitorMap,
    this.reqEmployeeMap,
  });

  ReqRequestMap copyWith({
    int? reqMapMeetId,
    int? requestId,
    bool? isVisitorSelected,
    dynamic evRemark,
    bool? attendance,
    dynamic empId,
    int? visitorId,
    Status? evStatus,
    bool? isDeleted,
    DateTime? createdAt,
    ReqVisitorMap? reqVisitorMap,
    dynamic reqEmployeeMap,
  }) =>
      ReqRequestMap(
        reqMapMeetId: reqMapMeetId ?? this.reqMapMeetId,
        requestId: requestId ?? this.requestId,
        isVisitorSelected: isVisitorSelected ?? this.isVisitorSelected,
        evRemark: evRemark ?? this.evRemark,
        attendance: attendance ?? this.attendance,
        empId: empId ?? this.empId,
        visitorId: visitorId ?? this.visitorId,
        evStatus: evStatus ?? this.evStatus,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
        reqVisitorMap: reqVisitorMap ?? this.reqVisitorMap,
        reqEmployeeMap: reqEmployeeMap ?? this.reqEmployeeMap,
      );

  factory ReqRequestMap.fromJson(Map<String, dynamic> json) => ReqRequestMap(
    reqMapMeetId: json["reqMapMeetID"],
    requestId: json["requestID"],
    isVisitorSelected: json["isVisitorSelected"],
    evRemark: json["evRemark"],
    attendance: json["Attendance"],
    empId: json["empID"],
    visitorId: json["visitorID"],
    evStatus: statusValues.map[json["evStatus"]]!,
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    reqVisitorMap: json["reqVisitorMap"] == null ? null : ReqVisitorMap.fromJson(json["reqVisitorMap"]),
    reqEmployeeMap: json["reqEmployeeMap"],
  );

  Map<String, dynamic> toJson() => {
    "reqMapMeetID": reqMapMeetId,
    "requestID": requestId,
    "isVisitorSelected": isVisitorSelected,
    "evRemark": evRemark,
    "Attendance": attendance,
    "empID": empId,
    "visitorID": visitorId,
    "evStatus": statusValues.reverse[evStatus],
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "reqVisitorMap": reqVisitorMap?.toJson(),
    "reqEmployeeMap": reqEmployeeMap,
  };
}

enum Status {
  PENDING
}

final statusValues = EnumValues({
  "Pending": Status.PENDING
});

class ReqVisitorMap {
  int? visitorId;
  String? vFirstName;
  String? vLastName;
  dynamic vPurposeOfVisit;
  DateTime? vDateOfBirth;
  String? vImage;
  String? vIdDoc;
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
    String? vImage,
    String? vIdDoc,
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
    vImage: json["vImage"],
    vIdDoc: json["vIDDoc"],
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

class ReqRequestmeetDet {
  int? reqMetDetId;
  int? companyId;
  int? departmentId;
  DateTime? autoTime;
  int? officeId;
  int? createdBy;
  dynamic createdAt;
  ComReqMeet? comReqMeet;
  dynamic offReqMeet;
  DeprtReqMeet? deprtReqMeet;

  ReqRequestmeetDet({
    this.reqMetDetId,
    this.companyId,
    this.departmentId,
    this.autoTime,
    this.officeId,
    this.createdBy,
    this.createdAt,
    this.comReqMeet,
    this.offReqMeet,
    this.deprtReqMeet,
  });

  ReqRequestmeetDet copyWith({
    int? reqMetDetId,
    int? companyId,
    int? departmentId,
    DateTime? autoTime,
    int? officeId,
    int? createdBy,
    dynamic createdAt,
    ComReqMeet? comReqMeet,
    dynamic offReqMeet,
    DeprtReqMeet? deprtReqMeet,
  }) =>
      ReqRequestmeetDet(
        reqMetDetId: reqMetDetId ?? this.reqMetDetId,
        companyId: companyId ?? this.companyId,
        departmentId: departmentId ?? this.departmentId,
        autoTime: autoTime ?? this.autoTime,
        officeId: officeId ?? this.officeId,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        comReqMeet: comReqMeet ?? this.comReqMeet,
        offReqMeet: offReqMeet ?? this.offReqMeet,
        deprtReqMeet: deprtReqMeet ?? this.deprtReqMeet,
      );

  factory ReqRequestmeetDet.fromJson(Map<String, dynamic> json) => ReqRequestmeetDet(
    reqMetDetId: json["ReqMetDetID"],
    companyId: json["CompanyID"],
    departmentId: json["DepartmentID"],
    autoTime: json["AutoTime"] == null ? null : DateTime.parse(json["AutoTime"]),
    officeId: json["officeID"],
    createdBy: json["createdBy"],
    createdAt: json["createdAt"],
    comReqMeet: json["comReqMeet"] == null ? null : ComReqMeet.fromJson(json["comReqMeet"]),
    offReqMeet: json["offReqMeet"],
    deprtReqMeet: json["DeprtReqMeet"] == null ? null : DeprtReqMeet.fromJson(json["DeprtReqMeet"]),
  );

  Map<String, dynamic> toJson() => {
    "ReqMetDetID": reqMetDetId,
    "CompanyID": companyId,
    "DepartmentID": departmentId,
    "AutoTime": autoTime?.toIso8601String(),
    "officeID": officeId,
    "createdBy": createdBy,
    "createdAt": createdAt,
    "comReqMeet": comReqMeet?.toJson(),
    "offReqMeet": offReqMeet,
    "DeprtReqMeet": deprtReqMeet?.toJson(),
  };
}

class ComReqMeet {
  int? companyId;
  String? name;
  String? contact;
  String? email;
  bool? isDeleted;

  ComReqMeet({
    this.companyId,
    this.name,
    this.contact,
    this.email,
    this.isDeleted,
  });

  ComReqMeet copyWith({
    int? companyId,
    String? name,
    String? contact,
    String? email,
    bool? isDeleted,
  }) =>
      ComReqMeet(
        companyId: companyId ?? this.companyId,
        name: name ?? this.name,
        contact: contact ?? this.contact,
        email: email ?? this.email,
        isDeleted: isDeleted ?? this.isDeleted,
      );

  factory ComReqMeet.fromJson(Map<String, dynamic> json) => ComReqMeet(
    companyId: json["companyID"],
    name: json["Name"],
    contact: json["contact"],
    email: json["email"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "companyID": companyId,
    "Name": name,
    "contact": contact,
    "email": email,
    "isDeleted": isDeleted,
  };
}

class DeprtReqMeet {
  int? departmentId;
  String? department;
  bool? isDeleted;

  DeprtReqMeet({
    this.departmentId,
    this.department,
    this.isDeleted,
  });

  DeprtReqMeet copyWith({
    int? departmentId,
    String? department,
    bool? isDeleted,
  }) =>
      DeprtReqMeet(
        departmentId: departmentId ?? this.departmentId,
        department: department ?? this.department,
        isDeleted: isDeleted ?? this.isDeleted,
      );

  factory DeprtReqMeet.fromJson(Map<String, dynamic> json) => DeprtReqMeet(
    departmentId: json["departmentID"],
    department: json["department"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "departmentID": departmentId,
    "department": department,
    "isDeleted": isDeleted,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
