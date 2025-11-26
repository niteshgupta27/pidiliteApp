class MeetingInfoResponse {
  final int status;
  final bool success;
  final String message;
  final List<MeetingInfoData> data;

  MeetingInfoResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory MeetingInfoResponse.fromJson(Map<String, dynamic> json) {
    return MeetingInfoResponse(
      status: json['status'] ?? 0,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List?)?.map((item) => MeetingInfoData.fromJson(item)).toList() ?? [],
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

class MeetingInfoData {
 // final int fldMiId;
  // final int fldMtypeId;
  // final int fldMeetingId;
 // final int fldCustomerId;
  final String? fldHotelName;
  final String? fldManagerName;
  final String? fldMmobile;
  final String? fldPImage1;
  final String? fldPImagePath1;
  final String? fldPImage2;
  final String? fldPImagePath2;
  final String? fldTImage1;
  final String? fldTImagePath1;
  final String? fldTImage2;
  final String? fldTImagePath2;
  final String? fldCImage1;
  final String? fldCImagePath1;
  final String? fldCImage2;
  final String? fldCImagePath2;
  // final double? fldLat;
  // final double? fldLong;
  // final String? fldCreatedAt;
  // final String? fldUpdatedAt;

  MeetingInfoData({
    // required this.fldMiId,
    // required this.fldMtypeId,
    // required this.fldMeetingId,
    // required this.fldCustomerId,
    this.fldHotelName,
    this.fldManagerName,
    this.fldMmobile,
    this.fldPImage1,
    this.fldPImagePath1,
    this.fldPImage2,
    this.fldPImagePath2,
    this.fldTImage1,
    this.fldTImagePath1,
    this.fldTImage2,
    this.fldTImagePath2,
    this.fldCImage1,
    this.fldCImagePath1,
    this.fldCImage2,
    this.fldCImagePath2,
    // this.fldLat,
    // this.fldLong,
    // this.fldCreatedAt,
    // this.fldUpdatedAt,
  });

  factory MeetingInfoData.fromJson(Map<String, dynamic> json) {
    return MeetingInfoData(
      // fldMiId: json['fld_mi_id'] ?? 0,
      // fldMtypeId: json['fld_mtype_id'] ?? 0,
      // fldMeetingId: json['fld_meeting_id'] ?? 0,
      // fldCustomerId: json['fld_customer_id'] ?? 0,
      fldHotelName: json['fld_hotel_name'],
      fldManagerName: json['fld_manager_name'],
      fldMmobile: json['fld_mmobile']?.toString(),
      fldPImage1: json['fld_p_image_1'],
      fldPImagePath1: json['fld_p_image_path_1'],
      fldPImage2: json['fld_p_image_2'],
      fldPImagePath2: json['fld_p_image_path_2'],
      fldTImage1: json['fld_t_image_1'],
      fldTImagePath1: json['fld_t_image_path_1'],
      fldTImage2: json['fld_t_image_2'],
      fldTImagePath2: json['fld_t_image_path_2'],
      fldCImage1: json['fld_c_image_1'],
      fldCImagePath1: json['fld_c_image_path_1'],
      fldCImage2: json['fld_c_image_2'],
      fldCImagePath2: json['fld_c_image_path_2'],
      // fldLat: (json['fld_lat'] as num?)?.toDouble(),
      // fldLong: (json['fld_long'] as num?)?.toDouble(),
      // fldCreatedAt: json['fld_created_at'],
      // fldUpdatedAt: json['fld_updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'fld_mi_id': fldMiId,
      // 'fld_mtype_id': fldMtypeId,
      // 'fld_meeting_id': fldMeetingId,
      // 'fld_customer_id': fldCustomerId,
      'fld_hotel_name': fldHotelName,
      'fld_manager_name': fldManagerName,
      'fld_mmobile': fldMmobile,
      'fld_p_image_1': fldPImage1,
      'fld_p_image_path_1': fldPImagePath1,
      'fld_p_image_2': fldPImage2,
      'fld_p_image_path_2': fldPImagePath2,
      'fld_t_image_1': fldTImage1,
      'fld_t_image_path_1': fldTImagePath1,
      'fld_t_image_2': fldTImage2,
      'fld_t_image_path_2': fldTImagePath2,
      'fld_c_image_1': fldCImage1,
      'fld_c_image_path_1': fldCImagePath1,
      'fld_c_image_2': fldCImage2,
      'fld_c_image_path_2': fldCImagePath2,
      // 'fld_lat': fldLat,
      // 'fld_long': fldLong,
      // 'fld_created_at': fldCreatedAt,
      // 'fld_updated_at': fldUpdatedAt,
    };
  }
}