import '../../../../model/UserDataModel.dart';

class LoginResponse {
  bool? success;
  String message;
  String token;
  UserData data;

  LoginResponse({
    this.success,
    required this.message,
   required this.token,
    required this.data,

  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        success: json["success"],
        message: json["message"],
        //statusCode: json["statusCode"],
        data: json["data"] != null && json["data"] is Map<String, dynamic> ?UserData.fromJson(json["data"]):UserData.fromJson({}),
    token:json["data"] is Map<String, dynamic> ?json['data'].containsKey('token') && json['data']['token'] != null?json["data"]["token"]:"":"",

      );

  Map<String, dynamic> toJson() => {
       // "success": success,
        "message": message,
       // "statusCode": statusCode,
        "data": data,
"token":token
      };
}
