class GenralResponceModel {
  bool success;
  int statusCode;
 // String method;
  String message;
  //List<TagData> data;

  GenralResponceModel({
    required this.success,
    required this.statusCode,
  //  required this.method,
    required this.message,
   // required this.data,
  });

  factory GenralResponceModel.fromJson(Map<String, dynamic> json) {
    return GenralResponceModel(
      success: json['success'] ?? false,
      statusCode: json['status_code'] ?? 0,
      //method: json['method'] ?? '',
      message: json['message'] ?? ''

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'status_code': statusCode,
     // 'method': method,
      'message': message,

    };
  }
}