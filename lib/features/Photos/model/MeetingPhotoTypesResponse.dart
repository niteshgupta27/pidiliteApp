class MeetingPhotoTypesData {
  final int fldPtId;
  final String fldTypeName;
  final String fldPurpose;

  MeetingPhotoTypesData({
    required this.fldPtId,
    required this.fldTypeName,
    required this.fldPurpose,
  });

  factory MeetingPhotoTypesData.fromJson(Map<String, dynamic> json) {
    return MeetingPhotoTypesData(
      fldPtId: json['fld_pt_id'] ?? 0,
      fldTypeName: json['fld_type_name'] ?? '',
      fldPurpose: json['fld_purpose'] ?? '',
    );
  }
}

class MeetingPhotoTypesResponse {
  final int status;
  final bool success;
  final String message;
  final List<MeetingPhotoTypesData> data;

  MeetingPhotoTypesResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory MeetingPhotoTypesResponse.fromJson(Map<String, dynamic> json) {
    return MeetingPhotoTypesResponse(
      status: json['status'] ?? 0,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => MeetingPhotoTypesData.fromJson(item))
          .toList() ??
          [],
    );
  }
}
