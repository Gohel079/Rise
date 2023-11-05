// To parse this JSON data, do
//
//     final getCompanyListResponseModel = getCompanyListResponseModelFromJson(jsonString);

import 'dart:convert';

GetCompanyListResponseModel getCompanyListResponseModelFromJson(String str) => GetCompanyListResponseModel.fromJson(json.decode(str));

String getCompanyListResponseModelToJson(GetCompanyListResponseModel data) => json.encode(data.toJson());

class GetCompanyListResponseModel {
  dynamic? responseData;
  String? responseType;
  bool? toast;
  dynamic message;

  GetCompanyListResponseModel({
    this.responseData,
    this.responseType,
    this.toast,
    this.message,
  });

  GetCompanyListResponseModel copyWith({
    ResponseData? responseData,
    String? responseType,
    bool? toast,
    dynamic message,
  }) =>
      GetCompanyListResponseModel(
        responseData: responseData ?? this.responseData,
        responseType: responseType ?? this.responseType,
        toast: toast ?? this.toast,
        message: message ?? this.message,
      );

  factory GetCompanyListResponseModel.fromJson(Map<String, dynamic> json) => GetCompanyListResponseModel(
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
  int? companyId;
  String? name;
  String? contact;
  String? email;
  bool? isActive;
  bool? isDeleted;
  String? createdBy;
  String? updatedBy;
  String? deletedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Datum({
    this.companyId,
    this.name,
    this.contact,
    this.email,
    this.isActive,
    this.isDeleted,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Datum copyWith({
    int? companyId,
    String? name,
    String? contact,
    String? email,
    bool? isActive,
    bool? isDeleted,
    String? createdBy,
    String? updatedBy,
    String? deletedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
  }) =>
      Datum(
        companyId: companyId ?? this.companyId,
        name: name ?? this.name,
        contact: contact ?? this.contact,
        email: email ?? this.email,
        isActive: isActive ?? this.isActive,
        isDeleted: isDeleted ?? this.isDeleted,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
        deletedBy: deletedBy ?? this.deletedBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    companyId: json["companyID"],
    name: json["Name"],
    contact: json["contact"],
    email: json["email"],
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
    "companyID": companyId,
    "Name": name,
    "contact": contact,
    "email": email,
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