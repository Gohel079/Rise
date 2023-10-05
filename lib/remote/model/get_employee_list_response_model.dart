// To parse this JSON data, do
//
//     final getEmployeeListResponseModel = getEmployeeListResponseModelFromJson(jsonString);

import 'dart:convert';

GetEmployeeListResponseModel getEmployeeListResponseModelFromJson(String str) => GetEmployeeListResponseModel.fromJson(json.decode(str));

String getEmployeeListResponseModelToJson(GetEmployeeListResponseModel data) => json.encode(data.toJson());

class GetEmployeeListResponseModel {
  ResponseData? responseData;
  String? responseType;
  bool? toast;
  dynamic message;

  GetEmployeeListResponseModel({
    this.responseData,
    this.responseType,
    this.toast,
    this.message,
  });

  GetEmployeeListResponseModel copyWith({
    ResponseData? responseData,
    String? responseType,
    bool? toast,
    dynamic message,
  }) =>
      GetEmployeeListResponseModel(
        responseData: responseData ?? this.responseData,
        responseType: responseType ?? this.responseType,
        toast: toast ?? this.toast,
        message: message ?? this.message,
      );

  factory GetEmployeeListResponseModel.fromJson(Map<String, dynamic> json) => GetEmployeeListResponseModel(
    responseData: json["responseData"] is String ? json["responseData"] : json["responseData"] == null ? null : ResponseData.fromJson(json["responseData"]),
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
  String? password;
  int? companyId;
  int? officeId;
  int? roleId;
  bool? isActive;
  bool? isDeleted;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Company? company;
  Office? office;
  Role? role;
  DepartmentClass? department;
  DesignationClass? designation;

  Datum({
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
    this.department,
    this.designation,
  });

  Datum copyWith({
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
    String? password,
    int? companyId,
    int? officeId,
    int? roleId,
    bool? isActive,
    bool? isDeleted,
    dynamic createdBy,
    dynamic updatedBy,
    dynamic deletedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    Company? company,
    Office? office,
    Role? role,
    DepartmentClass? department,
    DesignationClass? designation,
  }) =>
      Datum(
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
        department: department ?? this.department,
        designation: designation ?? this.designation,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    department: json["department"] == null ? null : DepartmentClass.fromJson(json["department"]),
    designation: json["designation"] == null ? null : DesignationClass.fromJson(json["designation"]),
  );

  Map<String, dynamic> toJson() => {
    "empID": empId,
    "firstName": firstName,
    "lastName": lastName,
    "empCode": empCode,
    "birthDate": "${birthDate?.year.toString().padLeft(4, '0')}-${birthDate?.month.toString().padLeft(2, '0')}-${birthDate?.day.toString().padLeft(2, '0')}",
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
    "department": department?.toJson(),
    "designation": designation?.toJson(),
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

class DepartmentClass {
  int? departmentId;
  String? department;
  bool? isDeleted;

  DepartmentClass({
    this.departmentId,
    this.department,
    this.isDeleted,
  });

  DepartmentClass copyWith({
    int? departmentId,
    String? department,
    bool? isDeleted,
  }) =>
      DepartmentClass(
        departmentId: departmentId ?? this.departmentId,
        department: department ?? this.department,
        isDeleted: isDeleted ?? this.isDeleted,
      );

  factory DepartmentClass.fromJson(Map<String, dynamic> json) => DepartmentClass(
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

/*enum DepartmentEnum {
  HERO_DEPARTMENT,
  LET_DO_MANAGEMENT,
  MARKETING_DEPARTMENT
}*/

/*final departmentEnumValues = EnumValues({
  "hero Department": DepartmentEnum.HERO_DEPARTMENT,
  "Let Do Management": DepartmentEnum.LET_DO_MANAGEMENT,
  "Marketing Department": DepartmentEnum.MARKETING_DEPARTMENT
});*/

class DesignationClass {
  int? designationId;
  String? designation;
  bool? isDeleted;

  DesignationClass({
    this.designationId,
    this.designation,
    this.isDeleted,
  });

  DesignationClass copyWith({
    int? designationId,
    String? designation,
    bool? isDeleted,
  }) =>
      DesignationClass(
        designationId: designationId ?? this.designationId,
        designation: designation ?? this.designation,
        isDeleted: isDeleted ?? this.isDeleted,
      );

  factory DesignationClass.fromJson(Map<String, dynamic> json) => DesignationClass(
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
/*
enum DesignationEnum {
  CEO,
  MARKETING_MANAGER,
  PRODUCT_MANAGER
}*/

/*
final designationEnumValues = EnumValues({
  "CEO": DesignationEnum.CEO,
  "Marketing Manager": DesignationEnum.MARKETING_MANAGER,
  "Product Manager": DesignationEnum.PRODUCT_MANAGER
});
*/

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
