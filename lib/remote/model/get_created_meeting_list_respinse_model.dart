import 'dart:convert';

GetCreatedMeetingResponseModel getCreatedMeetingResponseModelFromJson(String str) => GetCreatedMeetingResponseModel.fromJson(json.decode(str));

String getCreatedMeetingResponseModelToJson(GetCreatedMeetingResponseModel data) => json.encode(data.toJson());

class GetCreatedMeetingResponseModel {
  ResponseData? responseData;
  String? responseType;
  bool? toast;
  dynamic message;

  GetCreatedMeetingResponseModel({
    this.responseData,
    this.responseType,
    this.toast,
    this.message,
  });

  GetCreatedMeetingResponseModel copyWith({
    ResponseData? responseData,
    String? responseType,
    bool? toast,
    dynamic message,
  }) =>
      GetCreatedMeetingResponseModel(
        responseData: responseData ?? this.responseData,
        responseType: responseType ?? this.responseType,
        toast: toast ?? this.toast,
        message: message ?? this.message,
      );

  factory GetCreatedMeetingResponseModel.fromJson(Map<String, dynamic> json) => GetCreatedMeetingResponseModel(
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
  List<Data>? data;
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
    List<Data>? data,
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
    data: json["data"] == null ? [] : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
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

class Data {
  int? meetingID;
  int? requestID;
  int? officeID;
  int? meetingTypeID;
  int? meetingModeID;
  String? meetingRoom;
  String? meetingPurpose;
  String? meetingDate;
  String? meetingTime;
  bool? isActive;
  bool? isReschedule;
  dynamic rescMeetingDate;
  dynamic rescMeetingTime;
  dynamic rescMeetingRoom;
  bool? isDeleted;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  Office? office;
  MeetingType? meetingType;
  MeetingMode? meetingMode;
  RequestMeeting? requestMeeting;

  Data(
      {this.meetingID,
        this.requestID,
        this.officeID,
        this.meetingTypeID,
        this.meetingModeID,
        this.meetingRoom,
        this.meetingPurpose,
        this.meetingDate,
        this.meetingTime,
        this.isActive,
        this.isReschedule,
        this.rescMeetingDate,
        this.rescMeetingTime,
        this.rescMeetingRoom,
        this.isDeleted,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.office,
        this.meetingType,
        this.meetingMode,
        this.requestMeeting});

  Data.fromJson(Map<String, dynamic> json) {
    meetingID = json['meetingID'];
    requestID = json['requestID'];
    officeID = json['officeID'];
    meetingTypeID = json['MeetingTypeID'];
    meetingModeID = json['MeetingModeID'];
    meetingRoom = json['MeetingRoom'];
    meetingPurpose = json['MeetingPurpose'];
    meetingDate = json['MeetingDate'];
    meetingTime = json['MeetingTime'];
    isActive = json['isActive'];
    isReschedule = json['isReschedule'];
    rescMeetingDate = json['rescMeetingDate'];
    rescMeetingTime = json['rescMeetingTime'];
    rescMeetingRoom = json['rescMeetingRoom'];
    isDeleted = json['isDeleted'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    deletedBy = json['deletedBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    office =
    json['office'] != null ? new Office.fromJson(json['office']) : null;
    meetingType = json['meetingType'] != null
        ? new MeetingType.fromJson(json['meetingType'])
        : null;
    meetingMode = json['meetingMode'] != null
        ? new MeetingMode.fromJson(json['meetingMode'])
        : null;
    requestMeeting = json['requestMeeting'] != null
        ? new RequestMeeting.fromJson(json['requestMeeting'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meetingID'] = this.meetingID;
    data['requestID'] = this.requestID;
    data['officeID'] = this.officeID;
    data['MeetingTypeID'] = this.meetingTypeID;
    data['MeetingModeID'] = this.meetingModeID;
    data['MeetingRoom'] = this.meetingRoom;
    data['MeetingPurpose'] = this.meetingPurpose;
    data['MeetingDate'] = this.meetingDate;
    data['MeetingTime'] = this.meetingTime;
    data['isActive'] = this.isActive;
    data['isReschedule'] = this.isReschedule;
    data['rescMeetingDate'] = this.rescMeetingDate;
    data['rescMeetingTime'] = this.rescMeetingTime;
    data['rescMeetingRoom'] = this.rescMeetingRoom;
    data['isDeleted'] = this.isDeleted;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['deletedBy'] = this.deletedBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.office != null) {
      data['office'] = this.office!.toJson();
    }
    if (this.meetingType != null) {
      data['meetingType'] = this.meetingType!.toJson();
    }
    if (this.meetingMode != null) {
      data['meetingMode'] = this.meetingMode!.toJson();
    }
    if (this.requestMeeting != null) {
      data['requestMeeting'] = this.requestMeeting!.toJson();
    }
    return data;
  }
}

class Office {
  int? officeID;
  String? address;
  int? companyID;

  Office({this.officeID, this.address, this.companyID});

  Office.fromJson(Map<String, dynamic> json) {
    officeID = json['officeID'];
    address = json['Address'];
    companyID = json['companyID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['officeID'] = this.officeID;
    data['Address'] = this.address;
    data['companyID'] = this.companyID;
    return data;
  }
}

class MeetingType {
  int? meetingTypeID;
  String? meetingType;

  MeetingType({this.meetingTypeID, this.meetingType});

  MeetingType.fromJson(Map<String, dynamic> json) {
    meetingTypeID = json['MeetingTypeID'];
    meetingType = json['meetingType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MeetingTypeID'] = this.meetingTypeID;
    data['meetingType'] = this.meetingType;
    return data;
  }
}

class MeetingMode {
  int? meetingModeID;
  String? meetingMode;

  MeetingMode({this.meetingModeID, this.meetingMode});

  MeetingMode.fromJson(Map<String, dynamic> json) {
    meetingModeID = json['MeetingModeID'];
    meetingMode = json['meetingMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MeetingModeID'] = this.meetingModeID;
    data['meetingMode'] = this.meetingMode;
    return data;
  }
}

class RequestMeeting {
  int? requestID;
  String? purposeOfMeeting;
  String? tokenNumber;
  String? reqStatus;
  dynamic recRemark;
  bool? isDeleted;
  dynamic createdBy;
  String? updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  List<ReqRequestMap>? reqRequestMap;

  RequestMeeting(
      {this.requestID,
        this.purposeOfMeeting,
        this.tokenNumber,
        this.reqStatus,
        this.recRemark,
        this.isDeleted,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.reqRequestMap});

  RequestMeeting.fromJson(Map<String, dynamic> json) {
    requestID = json['requestID'];
    purposeOfMeeting = json['purposeOfMeeting'];
    tokenNumber = json['TokenNumber'];
    reqStatus = json['ReqStatus'];
    recRemark = json['RecRemark'];
    isDeleted = json['isDeleted'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    deletedBy = json['deletedBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    if (json['reqRequestMap'] != null) {
      reqRequestMap = <ReqRequestMap>[];
      json['reqRequestMap'].forEach((v) {
        reqRequestMap!.add(new ReqRequestMap.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestID'] = this.requestID;
    data['purposeOfMeeting'] = this.purposeOfMeeting;
    data['TokenNumber'] = this.tokenNumber;
    data['ReqStatus'] = this.reqStatus;
    data['RecRemark'] = this.recRemark;
    data['isDeleted'] = this.isDeleted;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['deletedBy'] = this.deletedBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.reqRequestMap != null) {
      data['reqRequestMap'] =
          this.reqRequestMap!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReqRequestMap {
  int? reqMapMeetID;
  int? requestID;
  int? visitorID;
  String? evStatus;
  bool? attendance;
  bool? isDeleted;
  dynamic createdAt;
  ReqVisitorMap? reqVisitorMap;
  ReqEmployeeMap? reqEmployeeMap;

  ReqRequestMap(
      {this.reqMapMeetID,
        this.requestID,
        this.visitorID,
        this.evStatus,
        this.attendance,
        this.isDeleted,
        this.createdAt,
        this.reqVisitorMap,
        this.reqEmployeeMap});

  ReqRequestMap.fromJson(Map<String, dynamic> json) {
    reqMapMeetID = json['reqMapMeetID'];
    requestID = json['requestID'];
    visitorID = json['visitorID'];
    evStatus = json['evStatus'];
    attendance = json['Attendance'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    reqVisitorMap = json['reqVisitorMap'] != null
        ? new ReqVisitorMap.fromJson(json['reqVisitorMap'])
        : null;
    reqEmployeeMap = json['reqEmployeeMap'] != null
        ? new ReqEmployeeMap.fromJson(json['reqEmployeeMap'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reqMapMeetID'] = this.reqMapMeetID;
    data['requestID'] = this.requestID;
    data['visitorID'] = this.visitorID;
    data['evStatus'] = this.evStatus;
    data['Attendance'] = this.attendance;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    if (this.reqVisitorMap != null) {
      data['reqVisitorMap'] = this.reqVisitorMap!.toJson();
    }
    if (this.reqEmployeeMap != null) {
      data['reqEmployeeMap'] = this.reqEmployeeMap!.toJson();
    }
    return data;
  }
}

class ReqVisitorMap {
  int? visitorID;
  String? vFirstName;
  String? vLastName;
  String? vDateOfBirth;
  String? vImage;
  String? vIDDoc;
  String? vCompanyName;
  String? vDesignation;
  String? vCompanyAddress;
  String? vCompanyContact;
  String? vCompanyEmail;
  String? vAnniversaryDate;
  String? createdAt;
  dynamic deletedAt;
  String? updatedAt;

  ReqVisitorMap(
      {this.visitorID,
        this.vFirstName,
        this.vLastName,
        this.vDateOfBirth,
        this.vImage,
        this.vIDDoc,
        this.vCompanyName,
        this.vDesignation,
        this.vCompanyAddress,
        this.vCompanyContact,
        this.vCompanyEmail,
        this.vAnniversaryDate,
        this.createdAt,
        this.deletedAt,
        this.updatedAt});

  ReqVisitorMap.fromJson(Map<String, dynamic> json) {
    visitorID = json['visitorID'];
    vFirstName = json['vFirstName'];
    vLastName = json['vLastName'];
    vDateOfBirth = json['vDateOfBirth'];
    vImage = json['vImage'];
    vIDDoc = json['vIDDoc'];
    vCompanyName = json['vCompanyName'];
    vDesignation = json['vDesignation'];
    vCompanyAddress = json['vCompanyAddress'];
    vCompanyContact = json['vCompanyContact'];
    vCompanyEmail = json['vCompanyEmail'];
    vAnniversaryDate = json['vAnniversaryDate'];
    createdAt = json['createdAt'];
    deletedAt = json['deletedAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['visitorID'] = this.visitorID;
    data['vFirstName'] = this.vFirstName;
    data['vLastName'] = this.vLastName;
    data['vDateOfBirth'] = this.vDateOfBirth;
    data['vImage'] = this.vImage;
    data['vIDDoc'] = this.vIDDoc;
    data['vCompanyName'] = this.vCompanyName;
    data['vDesignation'] = this.vDesignation;
    data['vCompanyAddress'] = this.vCompanyAddress;
    data['vCompanyContact'] = this.vCompanyContact;
    data['vCompanyEmail'] = this.vCompanyEmail;
    data['vAnniversaryDate'] = this.vAnniversaryDate;
    data['createdAt'] = this.createdAt;
    data['deletedAt'] = this.deletedAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class ReqEmployeeMap {
  int? empID;
  String? firstName;
  String? lastName;
  String? empCode;
  String? birthDate;
  String? joiningDate;
  String? empProfileIMg;
  String? empIDCard;
  String? empAadharCard;
  int? departmentID;
  int? designationID;
  String? email;
  String? phone;
  String? aadharNumber;
  String? password;
  int? companyID;
  int? officeID;
  int? roleID;
  bool? isActive;
  dynamic isAdmin;
  dynamic featureString;
  bool? isDeleted;
  dynamic createdBy;
  String? updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  Company? company;
  Office? office;
  Role? role;
  Department? department;
  Designation? designation;

  ReqEmployeeMap(
      {this.empID,
        this.firstName,
        this.lastName,
        this.empCode,
        this.birthDate,
        this.joiningDate,
        this.empProfileIMg,
        this.empIDCard,
        this.empAadharCard,
        this.departmentID,
        this.designationID,
        this.email,
        this.phone,
        this.aadharNumber,
        this.password,
        this.companyID,
        this.officeID,
        this.roleID,
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
        this.designation});

  ReqEmployeeMap.fromJson(Map<String, dynamic> json) {
    empID = json['empID'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    empCode = json['empCode'];
    birthDate = json['birthDate'];
    joiningDate = json['joiningDate'];
    empProfileIMg = json['empProfileIMg'];
    empIDCard = json['empIDCard'];
    empAadharCard = json['empAadharCard'];
    departmentID = json['departmentID'];
    designationID = json['designationID'];
    email = json['email'];
    phone = json['phone'];
    aadharNumber = json['aadharNumber'];
    password = json['password'];
    companyID = json['companyID'];
    officeID = json['officeID'];
    roleID = json['roleID'];
    isActive = json['isActive'];
    isAdmin = json['isAdmin'];
    featureString = json['featureString'];
    isDeleted = json['isDeleted'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    deletedBy = json['deletedBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
    office =
    json['office'] != null ? new Office.fromJson(json['office']) : null;
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
    designation = json['designation'] != null
        ? new Designation.fromJson(json['designation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['empID'] = this.empID;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['empCode'] = this.empCode;
    data['birthDate'] = this.birthDate;
    data['joiningDate'] = this.joiningDate;
    data['empProfileIMg'] = this.empProfileIMg;
    data['empIDCard'] = this.empIDCard;
    data['empAadharCard'] = this.empAadharCard;
    data['departmentID'] = this.departmentID;
    data['designationID'] = this.designationID;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['aadharNumber'] = this.aadharNumber;
    data['password'] = this.password;
    data['companyID'] = this.companyID;
    data['officeID'] = this.officeID;
    data['roleID'] = this.roleID;
    data['isActive'] = this.isActive;
    data['isAdmin'] = this.isAdmin;
    data['featureString'] = this.featureString;
    data['isDeleted'] = this.isDeleted;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['deletedBy'] = this.deletedBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    if (this.office != null) {
      data['office'] = this.office!.toJson();
    }
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    if (this.department != null) {
      data['department'] = this.department!.toJson();
    }
    if (this.designation != null) {
      data['designation'] = this.designation!.toJson();
    }
    return data;
  }
}

class Company {
  int? companyID;
  String? name;
  String? contact;
  String? email;
  bool? isDeleted;

  Company(
      {this.companyID, this.name, this.contact, this.email, this.isDeleted});

  Company.fromJson(Map<String, dynamic> json) {
    companyID = json['companyID'];
    name = json['Name'];
    contact = json['contact'];
    email = json['email'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyID'] = this.companyID;
    data['Name'] = this.name;
    data['contact'] = this.contact;
    data['email'] = this.email;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}

class Office1 {
  int? officeID;
  String? address;
  int? companyID;
  bool? isDeleted;

  Office1({this.officeID, this.address, this.companyID, this.isDeleted});

  Office1.fromJson(Map<String, dynamic> json) {
    officeID = json['officeID'];
    address = json['Address'];
    companyID = json['companyID'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['officeID'] = this.officeID;
    data['Address'] = this.address;
    data['companyID'] = this.companyID;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}

class Role {
  int? roleID;
  String? role;
  bool? isDeleted;

  Role({this.roleID, this.role, this.isDeleted});

  Role.fromJson(Map<String, dynamic> json) {
    roleID = json['roleID'];
    role = json['role'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roleID'] = this.roleID;
    data['role'] = this.role;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}

class Department {
  int? departmentID;
  String? department;
  bool? isDeleted;

  Department({this.departmentID, this.department, this.isDeleted});

  Department.fromJson(Map<String, dynamic> json) {
    departmentID = json['departmentID'];
    department = json['department'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['departmentID'] = this.departmentID;
    data['department'] = this.department;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}

class Designation {
  int? designationID;
  String? designation;
  bool? isDeleted;

  Designation({this.designationID, this.designation, this.isDeleted});

  Designation.fromJson(Map<String, dynamic> json) {
    designationID = json['designationID'];
    designation = json['designation'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['designationID'] = this.designationID;
    data['designation'] = this.designation;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}