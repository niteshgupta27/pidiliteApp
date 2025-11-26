class progressResponceModel {
  int? status;
  bool? success;
  String? message;
  progressModel? data;

  progressResponceModel({this.status, this.success, this.message, this.data});

  factory progressResponceModel.fromJson(Map<String, dynamic> json) {
    return progressResponceModel(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? progressModel.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'success': success,
      'message': message,
     // 'data': data?.toJson(),
    };
  }
}
class progressModel {
  int meetingInfo;
  int meetingPhoto;
  int meetingDetails;
  int meetingAttendees;
  int meetingFinish;
  String messageTextPhoto;
  String messageTextDetail;
  String messageTextAttendees;
  int meetingAttendeesCount;
int meeting_nonparticipants_count;
  progressModel({
    this.meetingInfo = 0,
    this.meetingPhoto = 0,
    this.meetingDetails = 0,
    this.meetingAttendees = 0,
    this.meetingFinish = 0,
    this.messageTextPhoto = "",
    this.messageTextDetail = "",
    this.messageTextAttendees = "",
    this.meetingAttendeesCount = 0,
    this.meeting_nonparticipants_count=0,
  });

  factory progressModel.fromJson(Map<String, dynamic> json) {
    return progressModel(
      meetingInfo: json['meeting_info'] ?? 0,
      meetingPhoto: json['meeting_photo'] ?? 0,
      meetingDetails: json['meeting_details'] ?? 0,
      meetingAttendees: json['meeting_attendees'] ?? 0,
      meetingFinish: json['meeting_finish'] ?? 0,
      messageTextPhoto: json['message_text_photo'] ?? "",
      messageTextDetail: json['message_text_detail'] ?? "",
      messageTextAttendees: json['message_text_attendees'] ?? "",
      meetingAttendeesCount: json['meeting_attendees_count'] ?? 0,
        meeting_nonparticipants_count:json["meeting_nonparticipants_count"] ?? 0
    );
  }
}
