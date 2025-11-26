import 'AdhesiveModel.dart';

class AdhesiveResponse {
  final int status;
  final bool success;
  final String message;
  final List<AdhesiveModel> data;

  AdhesiveResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory AdhesiveResponse.fromJson(Map<String, dynamic> json) {
    return AdhesiveResponse(
      status: json['status'] ?? 0,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List?)?.where((element) => element != null).map((item) => AdhesiveModel.fromJson(item)).toList() ?? [],
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