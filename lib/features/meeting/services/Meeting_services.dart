
import '../../../Utill/AppConstants.dart';
import '../../../Utill/app_base_client.dart';
import '../../invite/InviteesModal.dart';
import '../model/CheckuserResponce.dart';
import '../model/HomeModelResponse.dart';


class MeetingServices {
  String TAG = "AuthServices";

  Future<HomeModelResponse> gethomedata({body}) async {
    try {
      final response = await BaseClient.sharedClient.postRequest(
          endPoint: AppConstants.MEETING_LIST,body:body );
      print("response=====$response");
      return HomeModelResponse.fromJson(response as Map<String, dynamic>);
    } catch (exception) {
      print("response=====$exception");
      rethrow;
    }
  }
  Future<Checkuserresponce> CheckUser({body}) async {
    try {
      final response = await BaseClient.sharedClient.postRequest(
          endPoint: AppConstants.USER_CHECK,body:body );
      print("response=====$response");
      return Checkuserresponce.fromJson(response as Map<String, dynamic>);
    } catch (exception) {
      print("response=====$exception");
      rethrow;
    }
  }
  Future<InviteesModal> SendcallDetail({body}) async {
    try {
      final response = await BaseClient.sharedClient.postRequest(
          endPoint: AppConstants.add_meeting_call,body:body );
      print("response=====$response");
      return InviteesModal.fromJson(response as Map<String, dynamic>);
    } catch (exception) {
      print("response=====$exception");
      rethrow;
    }
  }
}