// To parse this JSON data, do
//
//     final startMeetingResponseModel = startMeetingResponseModelFromJson(jsonString);

import 'dart:convert';

StartMeetingResponseModel startMeetingResponseModelFromJson(String str) => StartMeetingResponseModel.fromJson(json.decode(str));

String startMeetingResponseModelToJson(StartMeetingResponseModel data) => json.encode(data.toJson());

class StartMeetingResponseModel {
  String? responseType;
  List<Datum>? data;
  bool? toast;
  String? message;

  StartMeetingResponseModel({
    this.responseType,
    this.data,
    this.toast,
    this.message,
  });

  StartMeetingResponseModel copyWith({
    String? responseType,
    List<Datum>? data,
    bool? toast,
    String? message,
  }) =>
      StartMeetingResponseModel(
        responseType: responseType ?? this.responseType,
        data: data ?? this.data,
        toast: toast ?? this.toast,
        message: message ?? this.message,
      );

  factory StartMeetingResponseModel.fromJson(Map<String, dynamic> json) => StartMeetingResponseModel(
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
  int? pMeetingId;
  int? pRequestId;

  Datum({
    this.pMeetingId,
    this.pRequestId,
  });

  Datum copyWith({
    int? pMeetingId,
    int? pRequestId,
  }) =>
      Datum(
        pMeetingId: pMeetingId ?? this.pMeetingId,
        pRequestId: pRequestId ?? this.pRequestId,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    pMeetingId: json["pMeetingID"],
    pRequestId: json["pRequestID"],
  );

  Map<String, dynamic> toJson() => {
    "pMeetingID": pMeetingId,
    "pRequestID": pRequestId,
  };
}
