// To parse this JSON data, do
//
//     final getDesignationListResponseModel = getDesignationListResponseModelFromJson(jsonString);

import 'dart:convert';

GetDesignationListResponseModel getDesignationListResponseModelFromJson(String str) => GetDesignationListResponseModel.fromJson(json.decode(str));

String getDesignationListResponseModelToJson(GetDesignationListResponseModel data) => json.encode(data.toJson());

class GetDesignationListResponseModel {
  dynamic? responseData;
  String? responseType;
  bool? toast;
  dynamic message;

  GetDesignationListResponseModel({
    this.responseData,
    this.responseType,
    this.toast,
    this.message,
  });

  GetDesignationListResponseModel copyWith({
    ResponseData? responseData,
    String? responseType,
    bool? toast,
    dynamic message,
  }) =>
      GetDesignationListResponseModel(
        responseData: responseData ?? this.responseData,
        responseType: responseType ?? this.responseType,
        toast: toast ?? this.toast,
        message: message ?? this.message,
      );

  factory GetDesignationListResponseModel.fromJson(Map<String, dynamic> json) => GetDesignationListResponseModel(
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
  int? designationId;
  String? designation;
  bool? isActive;
  bool? isDeleted;
  String? createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? departmentId;

  Datum({
    this.designationId,
    this.designation,
    this.isActive,
    this.isDeleted,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.departmentId,
  });

  Datum copyWith({
    int? designationId,
    String? designation,
    bool? isActive,
    bool? isDeleted,
    String? createdBy,
    dynamic updatedBy,
    dynamic deletedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    int? departmentId,
  }) =>
      Datum(
        designationId: designationId ?? this.designationId,
        designation: designation ?? this.designation,
        isActive: isActive ?? this.isActive,
        isDeleted: isDeleted ?? this.isDeleted,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
        deletedBy: deletedBy ?? this.deletedBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        departmentId: departmentId ?? this.departmentId,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    designationId: json["designationID"],
    designation: json["designation"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    createdBy: json["createdBy"],
    updatedBy: json["updatedBy"],
    deletedBy: json["deletedBy"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    deletedAt: json["deletedAt"],
    departmentId: json["departmentID"],
  );

  Map<String, dynamic> toJson() => {
    "designationID": designationId,
    "designation": designation,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "createdBy": createdBy,
    "updatedBy": updatedBy,
    "deletedBy": deletedBy,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "deletedAt": deletedAt,
    "departmentID": departmentId,
  };
}
