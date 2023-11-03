// To parse this JSON data, do
//
//     final loginWithEmailResponse = loginWithEmailResponseFromJson(jsonString);

import 'dart:convert';

LoginWithEmailResponse loginWithEmailResponseFromJson(String str) => LoginWithEmailResponse.fromJson(json.decode(str));

String loginWithEmailResponseToJson(LoginWithEmailResponse data) => json.encode(data.toJson());

class LoginWithEmailResponse {
  String? responseType;
  LoginWithEmailResponseData? data;
  bool? toast;
  String? message;

  LoginWithEmailResponse({
    this.responseType,
    this.data,
    this.toast,
    this.message,
  });

  LoginWithEmailResponse copyWith({
    String? responseType,
    LoginWithEmailResponseData? data,
    bool? toast,
    String? message,
  }) =>
      LoginWithEmailResponse(
        responseType: responseType ?? this.responseType,
        data: data ?? this.data,
        toast: toast ?? this.toast,
        message: message ?? this.message,
      );

  factory LoginWithEmailResponse.fromJson(Map<String, dynamic> json) => LoginWithEmailResponse(
    responseType: json["response_type"],
    data: json["data"] is String ? json["data"] : json["data"] == null ? null : LoginWithEmailResponseData.fromJson(json["data"]),
    toast: json["toast"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "response_type": responseType,
    "data": data is String ? data : data?.toJson(),
    "toast": toast,
    "message": message,
  };
}

class LoginWithEmailResponseData {
  DataData? data;
  String? accessToken;

  LoginWithEmailResponseData({
    this.data,
    this.accessToken,
  });

  LoginWithEmailResponseData copyWith({
    DataData? data,
    String? accessToken,
  }) =>
      LoginWithEmailResponseData(
        data: data ?? this.data,
        accessToken: accessToken ?? this.accessToken,
      );

  factory LoginWithEmailResponseData.fromJson(Map<String, dynamic> json) => LoginWithEmailResponseData(
    data: json["data"] == null ? null : DataData.fromJson(json["data"]),
    accessToken: json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "access_token": accessToken,
  };
}

class DataData {
  int? empId;
  String? firstName;
  String? lastName;
  String? empCode;
  dynamic birthDate;
  String? joiningDate;
  dynamic empProfileIMg;
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
  Company? company;
  Office? office;
  Role? role;

  DataData({
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
    this.company,
    this.office,
    this.role,
  });

  DataData copyWith({
    int? empId,
    String? firstName,
    String? lastName,
    String? empCode,
    dynamic birthDate,
    String? joiningDate,
    dynamic empProfileIMg,
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
    Company? company,
    Office? office,
    Role? role,
  }) =>
      DataData(
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
        company: company ?? this.company,
        office: office ?? this.office,
        role: role ?? this.role,
      );

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
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
    company: json["company"] == null ? null : Company.fromJson(json["company"]),
    office: json["office"] == null ? null : Office.fromJson(json["office"]),
    role: json["role"] == null ? null : Role.fromJson(json["role"]),
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
    "company": company?.toJson(),
    "office": office?.toJson(),
    "role": role?.toJson(),
  };
}

class Company {
  int? companyId;
  String? name;
  String? contact;
  String? email;
  bool? isDeleted;

  Company({
    this.companyId,
    this.name,
    this.contact,
    this.email,
    this.isDeleted,
  });

  Company copyWith({
    int? companyId,
    String? name,
    String? contact,
    String? email,
    bool? isDeleted,
  }) =>
      Company(
        companyId: companyId ?? this.companyId,
        name: name ?? this.name,
        contact: contact ?? this.contact,
        email: email ?? this.email,
        isDeleted: isDeleted ?? this.isDeleted,
      );

  factory Company.fromJson(Map<String, dynamic> json) => Company(
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
