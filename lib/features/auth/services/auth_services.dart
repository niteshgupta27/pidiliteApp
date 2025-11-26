
import '../../../Utill/AppConstants.dart';
import '../../../Utill/app_base_client.dart';
import '../Login/models/login_response.dart';

class AuthServices {
  String TAG = "AuthServices";

  Future<LoginResponse> authenticate({body}) async {
    try {
      final response = await BaseClient.sharedClient.postPreLogin(
        endPoint: AppConstants.login,
        body: body,
      );
     // print("response=====$response");
      print("response=====$response");
      return LoginResponse.fromJson(response as Map<String, dynamic>);
    } catch (exception) {
      print("response=====$exception");
      rethrow;
    }
  }

}