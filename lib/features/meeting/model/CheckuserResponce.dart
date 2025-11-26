class Checkuserresponce {
  final int status;
  final bool success;
  final String message;
  final AppData data;

  Checkuserresponce({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory Checkuserresponce.fromJson(Map<String, dynamic> json) {
    return Checkuserresponce(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      data: AppData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'success': success,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class AppData {
  final String userId;
  final String version;
  final String versionMessage;
  final String linkMessage;
  final String appLink;

  AppData({
    required this.userId,
    required this.version,
    required this.versionMessage,
    required this.linkMessage,
    required this.appLink,
  });

  factory AppData.fromJson(Map<String, dynamic> json) {
    return AppData(
      userId: json['user_id'],
      version: json['version'],
      versionMessage: json['versionmessage'],
      linkMessage: json['linkmessage'],
      appLink: json['applink'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'dialer': version,
      'versionmessage': versionMessage,
      'linkmessage': linkMessage,
      'applink': appLink,
    };
  }
}