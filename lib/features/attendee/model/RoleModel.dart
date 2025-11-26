class RoleModelResponse {
  final int status;
  final bool success;
  final String message;
  final List<RoleModel> data;

  RoleModelResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory RoleModelResponse.fromJson(Map<String, dynamic> json) {
    return RoleModelResponse(
      status: json['status'] ?? 0,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List?)?.where((element) => element != null).map((item) => RoleModel.fromJson(item)).toList() ?? [],
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
class RoleModel {
  final int fldSid;
  final String fldRole;
  //final int fldStatus;
  //final DateTime fldCreatedAt;
  //final DateTime fldUpdatedAt;

  RoleModel({
    required this.fldSid,
    required this.fldRole,
   // required this.fldStatus,
   // required this.fldCreatedAt,
    //required this.fldUpdatedAt,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      fldSid: int.tryParse(json['fld_sid'].toString())??0,
      fldRole: json['fld_role']??"",
     // fldStatus: json['fld_status']??1,
     // fldCreatedAt: DateTime.parse(json['fld_created_at']),
      //fldUpdatedAt: DateTime.parse(json['fld_updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fld_sid': fldSid,
      'fld_role': fldRole,
      //'fld_status': fldStatus,
     // 'fld_created_at': fldCreatedAt.toIso8601String(),
      //'fld_updated_at': fldUpdatedAt.toIso8601String(),
    };
  }
}
