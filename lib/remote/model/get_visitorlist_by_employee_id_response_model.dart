// To parse this JSON data, do
//
//     final getVisitorResponseModel = getVisitorResponseModelFromJson(jsonString);

import 'dart:convert';

GetVisitorListByEmployeeResponseModel getVisitorListByEmployeeResponseModelFromJson(String str) => GetVisitorListByEmployeeResponseModel.fromJson(json.decode(str));

String getVisitorListByEmployeeResponseModelToJson(GetVisitorListByEmployeeResponseModel data) => json.encode(data.toJson());

class GetVisitorListByEmployeeResponseModel {
  ResponseData? responseData;
  String? responseType;
  bool? toast;
  dynamic message;

  GetVisitorListByEmployeeResponseModel({
    this.responseData,
    this.responseType,
    this.toast,
    this.message,
  });

  GetVisitorListByEmployeeResponseModel copyWith({
    ResponseData? responseData,
    String? responseType,
    bool? toast,
    dynamic message,
  }) =>
      GetVisitorListByEmployeeResponseModel(
        responseData: responseData ?? this.responseData,
        responseType: responseType ?? this.responseType,
        toast: toast ?? this.toast,
        message: message ?? this.message,
      );

  factory GetVisitorListByEmployeeResponseModel.fromJson(Map<String, dynamic> json) => GetVisitorListByEmployeeResponseModel(
    responseData: json["responseData"] == null ? null : ResponseData.fromJson(json["responseData"]),
    responseType: json["response_type"],
    toast: json["toast"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "responseData": responseData?.toJson(),
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
  String? reqStatus;
  dynamic recRemark;
  String? updatedBy;
  DateTime? createdAt;
  List<ReqRequestMap>? reqRequestMap;
  List<ReqRequestmeetDet>? reqRequestmeetDet;

  Datum({
    this.requestId,
    this.systemId,
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
    String? systemId,
    String? purposeOfMeeting,
    String? tokenNumber,
    String? reqStatus,
    dynamic recRemark,
    String? updatedBy,
    DateTime? createdAt,
    List<ReqRequestMap>? reqRequestMap,
    List<ReqRequestmeetDet>? reqRequestmeetDet,
  }) =>
      Datum(
        requestId: requestId ?? this.requestId,
        systemId: systemId ?? this.systemId,
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
    systemId: json["SystemID "],
    purposeOfMeeting: json["purposeOfMeeting"],
    tokenNumber: json["TokenNumber"],
    reqStatus: json["ReqStatus"],
    recRemark: json["RecRemark"],
    updatedBy: json["updatedBy"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    reqRequestMap: json["reqRequestMap"] == null ? [] : List<ReqRequestMap>.from(json["reqRequestMap"]!.map((x) => ReqRequestMap.fromJson(x))),
    reqRequestmeetDet: json["reqRequestmeetDet"] == null ? [] : List<ReqRequestmeetDet>.from(json["reqRequestmeetDet"]!.map((x) => ReqRequestmeetDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "requestID": requestId,
    "SystemID ": systemId,
    "purposeOfMeeting": purposeOfMeeting,
    "TokenNumber": tokenNumber,
    "ReqStatus": reqStatus,
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
  int? empId;
  int? visitorId;
  String? evStatus;
  bool? isDeleted;
  DateTime? createdAt;
  ReqVisitorMap? reqVisitorMap;
  ReqEmployeeMap? reqEmployeeMap;

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
    int? empId,
    int? visitorId,
    String? evStatus,
    bool? isDeleted,
    DateTime? createdAt,
    ReqVisitorMap? reqVisitorMap,
    ReqEmployeeMap? reqEmployeeMap,
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
    evStatus: json["evStatus"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    reqVisitorMap: json["reqVisitorMap"] == null ? null : ReqVisitorMap.fromJson(json["reqVisitorMap"]),
    reqEmployeeMap: json["reqEmployeeMap"] == null ? null : ReqEmployeeMap.fromJson(json["reqEmployeeMap"]),
  );

  Map<String, dynamic> toJson() => {
    "reqMapMeetID": reqMapMeetId,
    "requestID": requestId,
    "isVisitorSelected": isVisitorSelected,
    "evRemark": evRemark,
    "Attendance": attendance,
    "empID": empId,
    "visitorID": visitorId,
    "evStatus": evStatus,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "reqVisitorMap": reqVisitorMap?.toJson(),
    "reqEmployeeMap": reqEmployeeMap?.toJson(),
  };
}

class ReqEmployeeMap {
  int? empId;
  String? firstName;
  String? lastName;
  String? empCode;
  DateTime? birthDate;
  String? joiningDate;
  String? empProfileIMg;
  String? empIdCard;
  String? empAadharCard;
  int? departmentId;
  int? designationId;
  String? email;
  String? phone;
  String? aadharNumber;
  String? password;
  int? companyId;
  int? officeId;
  int? roleId;
  bool? isActive;
  dynamic isAdmin;
  dynamic featureString;
  bool? isDeleted;
  dynamic createdBy;
  String? updatedBy;
  dynamic deletedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Com? company;
  Office? office;
  Role? role;
  Dep? department;
  Designation? designation;

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
    this.aadharNumber,
    this.password,
    this.companyId,
    this.officeId,
    this.roleId,
    this.isActive,
    this.isAdmin,
    this.featureString,
    this.isDeleted,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.company,
    this.office,
    this.role,
    this.department,
    this.designation,
  });

  ReqEmployeeMap copyWith({
    int? empId,
    String? firstName,
    String? lastName,
    String? empCode,
    DateTime? birthDate,
    String? joiningDate,
    String? empProfileIMg,
    String? empIdCard,
    String? empAadharCard,
    int? departmentId,
    int? designationId,
    String? email,
    String? phone,
    String? aadharNumber,
    String? password,
    int? companyId,
    int? officeId,
    int? roleId,
    bool? isActive,
    dynamic isAdmin,
    dynamic featureString,
    bool? isDeleted,
    dynamic createdBy,
    String? updatedBy,
    dynamic deletedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    Com? company,
    Office? office,
    Role? role,
    Dep? department,
    Designation? designation,
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
        aadharNumber: aadharNumber ?? this.aadharNumber,
        password: password ?? this.password,
        companyId: companyId ?? this.companyId,
        officeId: officeId ?? this.officeId,
        roleId: roleId ?? this.roleId,
        isActive: isActive ?? this.isActive,
        isAdmin: isAdmin ?? this.isAdmin,
        featureString: featureString ?? this.featureString,
        isDeleted: isDeleted ?? this.isDeleted,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
        deletedBy: deletedBy ?? this.deletedBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        company: company ?? this.company,
        office: office ?? this.office,
        role: role ?? this.role,
        department: department ?? this.department,
        designation: designation ?? this.designation,
      );

  factory ReqEmployeeMap.fromJson(Map<String, dynamic> json) => ReqEmployeeMap(
    empId: json["empID"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    empCode: json["empCode"],
    birthDate: json["birthDate"] == null ? null : DateTime.parse(json["birthDate"]),
    joiningDate: json["joiningDate"],
    empProfileIMg: json["empProfileIMg"],
    empIdCard: json["empIDCard"],
    empAadharCard: json["empAadharCard"],
    departmentId: json["departmentID"],
    designationId: json["designationID"],
    email: json["email"],
    phone: json["phone"],
    aadharNumber: json["aadharNumber"],
    password: json["password"],
    companyId: json["companyID"],
    officeId: json["officeID"],
    roleId: json["roleID"],
    isActive: json["isActive"],
    isAdmin: json["isAdmin"],
    featureString: json["featureString"],
    isDeleted: json["isDeleted"],
    createdBy: json["createdBy"],
    updatedBy: json["updatedBy"],
    deletedBy: json["deletedBy"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    deletedAt: json["deletedAt"],
    company: json["company"] == null ? null : Com.fromJson(json["company"]),
    office: json["office"] == null ? null : Office.fromJson(json["office"]),
    role: json["role"] == null ? null : Role.fromJson(json["role"]),
    department: json["department"] == null ? null : Dep.fromJson(json["department"]),
    designation: json["designation"] == null ? null : Designation.fromJson(json["designation"]),
  );

  Map<String, dynamic> toJson() => {
    "empID": empId,
    "firstName": firstName,
    "lastName": lastName,
    "empCode": empCode,
    "birthDate": "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
    "joiningDate": joiningDate,
    "empProfileIMg": empProfileIMg,
    "empIDCard": empIdCard,
    "empAadharCard": empAadharCard,
    "departmentID": departmentId,
    "designationID": designationId,
    "email": email,
    "phone": phone,
    "aadharNumber": aadharNumber,
    "password": password,
    "companyID": companyId,
    "officeID": officeId,
    "roleID": roleId,
    "isActive": isActive,
    "isAdmin": isAdmin,
    "featureString": featureString,
    "isDeleted": isDeleted,
    "createdBy": createdBy,
    "updatedBy": updatedBy,
    "deletedBy": deletedBy,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "deletedAt": deletedAt,
    "company": company?.toJson(),
    "office": office?.toJson(),
    "role": role?.toJson(),
    "department": department?.toJson(),
    "designation": designation?.toJson(),
  };
}

class Com {
  int? companyId;
  String? name;
  String? contact;
  String? email;
  bool? isDeleted;

  Com({
    this.companyId,
    this.name,
    this.contact,
    this.email,
    this.isDeleted,
  });

  Com copyWith({
    int? companyId,
    String? name,
    String? contact,
    String? email,
    bool? isDeleted,
  }) =>
      Com(
        companyId: companyId ?? this.companyId,
        name: name ?? this.name,
        contact: contact ?? this.contact,
        email: email ?? this.email,
        isDeleted: isDeleted ?? this.isDeleted,
      );

  factory Com.fromJson(Map<String, dynamic> json) => Com(
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

class Dep {
  int? departmentId;
  String? department;
  bool? isDeleted;

  Dep({
    this.departmentId,
    this.department,
    this.isDeleted,
  });

  Dep copyWith({
    int? departmentId,
    String? department,
    bool? isDeleted,
  }) =>
      Dep(
        departmentId: departmentId ?? this.departmentId,
        department: department ?? this.department,
        isDeleted: isDeleted ?? this.isDeleted,
      );

  factory Dep.fromJson(Map<String, dynamic> json) => Dep(
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

class Designation {
  int? designationId;
  String? designation;
  bool? isDeleted;

  Designation({
    this.designationId,
    this.designation,
    this.isDeleted,
  });

  Designation copyWith({
    int? designationId,
    String? designation,
    bool? isDeleted,
  }) =>
      Designation(
        designationId: designationId ?? this.designationId,
        designation: designation ?? this.designation,
        isDeleted: isDeleted ?? this.isDeleted,
      );

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
    designationId: json["designationID"],
    designation: json["designation"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "designationID": designationId,
    "designation": designation,
    "isDeleted": isDeleted,
  };
}

class Office {
  int? officeId;
  String? address;
  int? companyId;
  bool? isDeleted;

  Office({
    this.officeId,
    this.address,
    this.companyId,
    this.isDeleted,
  });

  Office copyWith({
    int? officeId,
    String? address,
    int? companyId,
    bool? isDeleted,
  }) =>
      Office(
        officeId: officeId ?? this.officeId,
        address: address ?? this.address,
        companyId: companyId ?? this.companyId,
        isDeleted: isDeleted ?? this.isDeleted,
      );

  factory Office.fromJson(Map<String, dynamic> json) => Office(
    officeId: json["officeID"],
    address: json["Address"],
    companyId: json["companyID"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "officeID": officeId,
    "Address": address,
    "companyID": companyId,
    "isDeleted": isDeleted,
  };
}

class Role {
  int? roleId;
  String? role;
  bool? isDeleted;

  Role({
    this.roleId,
    this.role,
    this.isDeleted,
  });

  Role copyWith({
    int? roleId,
    String? role,
    bool? isDeleted,
  }) =>
      Role(
        roleId: roleId ?? this.roleId,
        role: role ?? this.role,
        isDeleted: isDeleted ?? this.isDeleted,
      );

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    roleId: json["roleID"],
    role: json["role"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "roleID": roleId,
    "role": role,
    "isDeleted": isDeleted,
  };
}

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
  DateTime? vAnniversaryDate;
  bool? isMeetingRequester;
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
    this.isMeetingRequester,
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
    DateTime? vAnniversaryDate,
    bool? isMeetingRequester,
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
        isMeetingRequester: isMeetingRequester ?? this.isMeetingRequester,
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
    vAnniversaryDate: json["vAnniversaryDate"] == null ? null : DateTime.parse(json["vAnniversaryDate"]),
    isMeetingRequester: json["isMeetingRequester"],
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
    "vImage": vImage,
    "vIDDoc": vIdDoc,
    "vCompanyName": vCompanyName,
    "vDesignation": vDesignation,
    "vCompanyAddress": vCompanyAddress,
    "vCompanyContact": vCompanyContact,
    "vCompanyEmail": vCompanyEmail,
    "vAnniversaryDate": "${vAnniversaryDate!.year.toString().padLeft(4, '0')}-${vAnniversaryDate!.month.toString().padLeft(2, '0')}-${vAnniversaryDate!.day.toString().padLeft(2, '0')}",
    "isMeetingRequester" : isMeetingRequester,
    "vContactPersonName": vContactPersonName,
    "createdAt": createdAt?.toIso8601String(),
    "deletedAt": deletedAt,
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class ReqRequestmeetDet {
  int? reqMetDetId;
  int? companyId;
  int? departmentId;
  DateTime? autoTime;
  int? officeId;
  int? createdBy;
  dynamic createdAt;
  Com? comReqMeet;
  dynamic offReqMeet;
  Dep? deprtReqMeet;

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
    Com? comReqMeet,
    dynamic offReqMeet,
    Dep? deprtReqMeet,
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
    comReqMeet: json["comReqMeet"] == null ? null : Com.fromJson(json["comReqMeet"]),
    offReqMeet: json["offReqMeet"],
    deprtReqMeet: json["DeprtReqMeet"] == null ? null : Dep.fromJson(json["DeprtReqMeet"]),
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
