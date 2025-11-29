
import '../../../Utill/AppConstants.dart';
import '../../../Utill/app_base_client.dart';
import '../../../model/GenralResponceModel.dart';
import '../model/meetingDetailResponse.dart';

class MeetingDetailService {
  String TAG = "MeetingDetailService";

  Future<meetingDetailResponse> gethomedata({body}) async {
    try {
      final response = await BaseClient.sharedClient.postRequest(
          endPoint: AppConstants.Get_Meeting_Details,body:body );
      print("response=====$response");
      return meetingDetailResponse.fromJson(response as Map<String, dynamic>);
    } catch (exception) {
      print("response=====$exception");
      rethrow;
    }
  }
Future<GenralResponceModel> Add_meeting_info({body}) async {
  try {
    final response = await BaseClient.sharedClient.postRequest(
        endPoint: AppConstants.UPLOAD_MEETING_DETAILS,body:body );
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