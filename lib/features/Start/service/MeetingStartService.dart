
import '../../../Utill/AppConstants.dart';
import '../../../Utill/app_base_client.dart';
import '../../../model/GenralResponceModel.dart';
import '../../meetingDashboard/model/progressModel.dart';
import '../model/meetinginfoResponse.dart';

class MeetingStartService {
  String TAG = "MeetingStartService";

  Future<MeetingInfoResponse> gethomedata({body}) async {
    try {
      final response = await BaseClient.sharedClient.postRequest(
          endPoint: AppConstants.Info_LIST,body:body );
      print("response=====$response");
      return MeetingInfoResponse.fromJson(response as Map<String, dynamic>);
    } catch (exception) {
      print("response=====$exception");
      rethrow;
    }
  }
Future<GenralResponceModel> Add_meeting_info({body}) async {
  try {
    final response = await BaseClient.sharedClient.postRequest(
        endPoint: AppConstants.UPLOAD_MEETING_INFO,body:body );
    print("response=====$response");
    return GenralResponceModel.fromJson(response as Map<String, dynamic>);
  } catch (exception) {
    print("response=====$exception");
    rethrow;
  }
}
  Future<GenralResponceModel> UpdateStatus({body}) async {
    try {
      final response = await BaseClient.sharedClient.postRequest(
          endPoint: AppConstants.MEETING_STATUS_UPDATE,body:body );
      print("response=====$response");
      return GenralResponceModel.fromJson(response as Map<String, dynamic>);
    } catch (exception) {
      print("response=====$exception");
      rethrow;
    }
  }
}