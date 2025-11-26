
class MeetingImagesResponce {
  final int? status;
  final bool? success;
  final String? message;
  final Map<String, List<Meetingimage>>? data;

  MeetingImagesResponce({
    this.status,
    this.success,
    this.message,
    this.data,
  });

  factory MeetingImagesResponce.fromJson(Map<String, dynamic> json) {
    Map<String, List<Meetingimage>> parsedData = {};

    if (json['data'] is Map<String, dynamic>) {
      Map<String, dynamic> rawData = json['data'];

      rawData.forEach((key, value) {
        if (value is List) {
          parsedData[key] = value.map((e) => Meetingimage.fromJson(e)).toList();
        }
      });
    }

    return MeetingImagesResponce(
      status: json['status'] as int?,
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: parsedData.isNotEmpty ? parsedData : null,
    );
  }
}

class Meetingimage {
  final int? id;
  final String? meetingId;
  final String? fileName;
  final String? filePath;
  final String? ptId;
  final String? purpose;
  final String? typeName;
  final String? imageUrl;

  Meetingimage({
    this.id,
    this.meetingId,
    this.fileName,
    this.filePath,
    this.ptId,
    this.purpose,
    this.typeName,
    this.imageUrl,
  });

  factory Meetingimage.fromJson(Map<String, dynamic> json) {
    return Meetingimage(
      id: json['fld_mi_id'] as int?,
      meetingId: json['fld_meeting_id']?.toString(),
      fileName: json['fld_file_name'] as String?,
      filePath: json['fld_file_path'] as String?,
      ptId: json['fld_pt_id']?.toString(),
      purpose: json['fld_purpose'] as String?,
      typeName: json['fld_type_name'] as String?,
      imageUrl: json['image_url'] as String?,
    );
  }
}