

import '../../../Utill/AppConstants.dart';
import '../../../Utill/app_base_client.dart';
import '../InviteesModal.dart';


class InviteServices {
  String TAG = "AuthServices";

  Future<InviteesModal> getinvite({body}) async {
    try {
      final response = await BaseClient.sharedClient.postRequest(
          endPoint: AppConstants.MEETING_INVITES_LIST,body:body );
      print("response=====$response");
      return InviteesModal.fromJson(response as Map<String, dynamic>);
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