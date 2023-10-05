// To parse this JSON data, do
//
//     final addVisitorRegisterResponseModel = addVisitorRegisterResponseModelFromJson(jsonString);

import 'dart:convert';

AddVisitorRegisterResponseModel addVisitorRegisterResponseModelFromJson(String str) => AddVisitorRegisterResponseModel.fromJson(json.decode(str));

String addVisitorRegisterResponseModelToJson(AddVisitorRegisterResponseModel data) => json.encode(data.toJson());

class AddVisitorRegisterResponseModel {
  String? responseType;
  List<Datum>? data;
  bool? toast;
  dynamic message;

  AddVisitorRegisterResponseModel({
    this.responseType,
    this.data,
    this.toast,
    this.message,
  });

  AddVisitorRegisterResponseModel copyWith({
    String? responseType,
    List<Datum>? data,
    bool? toast,
    dynamic message,
  }) =>
      AddVisitorRegisterResponseModel(
        responseType: responseType ?? this.responseType,
        data: data ?? this.data,
        toast: toast ?? this.toast,
        message: message ?? this.message,
      );

  factory AddVisitorRegisterResponseModel.fromJson(Map<String, dynamic> json) => AddVisitorRegisterResponseModel(
    responseType: json["response_type"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    toast: json["toast"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "response_type": responseType,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "toast": toast,
    "message": message,
  };
}

class Datum {
  int? requestId;

  Datum({
    this.requestId,
  });

  Datum copyWith({
    int? requestId,
  }) =>
      Datum(
        requestId: requestId ?? this.requestId,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    requestId: json["requestID"],
  );

  Map<String, dynamic> toJson() => {
    "requestID": requestId,
  };
}
