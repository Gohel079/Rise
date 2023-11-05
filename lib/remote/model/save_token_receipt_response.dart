// To parse this JSON data, do
//
//     final saveTokenReceiptResponse = saveTokenReceiptResponseFromJson(jsonString);

import 'dart:convert';

SaveTokenReceiptResponse saveTokenReceiptResponseFromJson(String str) => SaveTokenReceiptResponse.fromJson(json.decode(str));

String saveTokenReceiptResponseToJson(SaveTokenReceiptResponse data) => json.encode(data.toJson());

class SaveTokenReceiptResponse {
  String? responseType;
  bool? toast;
  String? message;

  SaveTokenReceiptResponse({
    this.responseType,
    this.toast,
    this.message,
  });

  SaveTokenReceiptResponse copyWith({
    String? responseType,
    bool? toast,
    String? message,
  }) =>
      SaveTokenReceiptResponse(
        responseType: responseType ?? this.responseType,
        toast: toast ?? this.toast,
        message: message ?? this.message,
      );

  factory SaveTokenReceiptResponse.fromJson(Map<String, dynamic> json) => SaveTokenReceiptResponse(
    responseType: json["response_type"],
    toast: json["toast"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "response_type": responseType,
    "toast": toast,
    "message": message,
  };
}
