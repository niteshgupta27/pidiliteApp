import 'Table_Attendee.dart';

class AttendeeListresponseModel {
  final int status;
  final bool success;
  final String message;
  final List<Table_Attendee> data;

  AttendeeListresponseModel({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory AttendeeListresponseModel.fromJson(Map<String, dynamic> json) {
    return AttendeeListresponseModel(
      status: json['status'] ?? 0,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List?)?.where((element) => element != null).map((item) => Table_Attendee.fromJson(item)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'success': success,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}