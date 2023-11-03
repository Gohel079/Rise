import 'dart:convert';

CreateMeetingResponseModel createMeetingResponseModelFromJson(String str) => CreateMeetingResponseModel.fromJson(json.decode(str));

String createMeetingResponseModelToJson(CreateMeetingResponseModel data) => json.encode(data.toJson());

class CreateMeetingResponseModel {
  String? responseType;
  dynamic? data;
  bool? toast;
  String? message;

  CreateMeetingResponseModel({
    this.responseType,
    this.data,
    this.toast,
    this.message,
  });

  CreateMeetingResponseModel copyWith({
    String? responseType,
    Data? data,
    bool? toast,
    String? message,
  }) =>
      CreateMeetingResponseModel(
        responseType: responseType ?? this.responseType,
        data: data ?? this.data,
        toast: toast ?? this.toast,
        message: message ?? this.message,
      );

  factory CreateMeetingResponseModel.fromJson(Map<String, dynamic> json) => CreateMeetingResponseModel(
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
  int? requestID;
  int? officeID;
  int? meetingTypeID;
  int? meetingModeID;
  String? meetingRoom;
  String? meetingPurpose;
  String? meetingDate;
  String? meetingTime;
  bool? isActive;

  Data(
      {this.requestID,
        this.officeID,
        this.meetingTypeID,
        this.meetingModeID,
        this.meetingRoom,
        this.meetingPurpose,
        this.meetingDate,
        this.meetingTime,
        this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    requestID = json['requestID'];
    officeID = json['officeID'];
    meetingTypeID = json['MeetingTypeID'];
    meetingModeID = json['MeetingModeID'];
    meetingRoom = json['MeetingRoom'];
    meetingPurpose = json['MeetingPurpose'];
    meetingDate = json['MeetingDate'];
    meetingTime = json['MeetingTime'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestID'] = this.requestID;
    data['officeID'] = this.officeID;
    data['MeetingTypeID'] = this.meetingTypeID;
    data['MeetingModeID'] = this.meetingModeID;
    data['MeetingRoom'] = this.meetingRoom;
    data['MeetingPurpose'] = this.meetingPurpose;
    data['MeetingDate'] = this.meetingDate;
    data['MeetingTime'] = this.meetingTime;
    data['isActive'] = this.isActive;
    return data;
  }
}