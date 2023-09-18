// To parse this JSON data, do
//
//     final registerResponseModel = registerResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) => RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) => json.encode(data.toJson());

class RegisterResponseModel {
  String? responseType;
  dynamic? data;
  bool? toast;
  String? message;

  RegisterResponseModel({
    this.responseType,
    this.data,
    this.toast,
    this.message,
  });

  RegisterResponseModel copyWith({
    String? responseType,
    Data? data,
    bool? toast,
    String? message,
  }) =>
      RegisterResponseModel(
        responseType: responseType ?? this.responseType,
        data: data ?? this.data,
        toast: toast ?? this.toast,
        message: message ?? this.message,
      );

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => RegisterResponseModel(
    responseType: json["response_type"],
    data: json["data"] is String ? json["data"] : json["data"] == null ? null : Data.fromJson(json["data"]),
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

class Data {
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isActive;
  bool? isDeleted;
  int? empId;
  String? firstName;
  String? lastName;
  String? empCode;
  String? joiningDate;
  String? empProfileIMg;
  String? empIdCard;
  String? empAadharCard;
  String? departmentId;
  String? designationId;
  String? email;
  String? phone;
  String? password;
  String? companyId;
  String? officeId;
  String? roleId;

  Data({
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.isDeleted,
    this.empId,
    this.firstName,
    this.lastName,
    this.empCode,
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
  });

  Data copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    bool? isDeleted,
    int? empId,
    String? firstName,
    String? lastName,
    String? empCode,
    String? joiningDate,
    String? empProfileIMg,
    String? empIdCard,
    String? empAadharCard,
    String? departmentId,
    String? designationId,
    String? email,
    String? phone,
    String? password,
    String? companyId,
    String? officeId,
    String? roleId,
  }) =>
      Data(
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isActive: isActive ?? this.isActive,
        isDeleted: isDeleted ?? this.isDeleted,
        empId: empId ?? this.empId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        empCode: empCode ?? this.empCode,
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
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    empId: json["empID"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    empCode: json["empCode"],
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
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "isActive": isActive,
    "isDeleted": isDeleted,
    "empID": empId,
    "firstName": firstName,
    "lastName": lastName,
    "empCode": empCode,
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
  };
}
