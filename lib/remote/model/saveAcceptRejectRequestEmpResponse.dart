// To parse this JSON data, do
//
//     final saveAccepteRejectRequestEmp = saveAccepteRejectRequestEmpFromJson(jsonString);

import 'dart:convert';

SaveAccepteRejectRequestEmp saveAccepteRejectRequestEmpFromJson(String str) => SaveAccepteRejectRequestEmp.fromJson(json.decode(str));

String saveAccepteRejectRequestEmpToJson(SaveAccepteRejectRequestEmp data) => json.encode(data.toJson());

class SaveAccepteRejectRequestEmp {
  String? responseType;
  dynamic data;
  bool? toast;
  dynamic message;

  SaveAccepteRejectRequestEmp({
    this.responseType,
    this.data,
    this.toast,
    this.message,
  });

  SaveAccepteRejectRequestEmp copyWith({
    String? responseType,
    dynamic data,
    bool? toast,
    dynamic message,
  }) =>
      SaveAccepteRejectRequestEmp(
        responseType: responseType ?? this.responseType,
        data: data ?? this.data,
        toast: toast ?? this.toast,
        message: message ?? this.message,
      );

  factory SaveAccepteRejectRequestEmp.fromJson(Map<String, dynamic> json) => SaveAccepteRejectRequestEmp(
    responseType: json["response_type"],
    data: json["data"],
    toast: json["toast"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "response_type": responseType,
    "data": data,
    "toast": toast,
    "message": message,
  };
}
