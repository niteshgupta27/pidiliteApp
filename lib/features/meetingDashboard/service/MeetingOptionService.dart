import '../../../Utill/AppConstants.dart';
import '../../../Utill/app_base_client.dart';
import '../../../model/GenralResponceModel.dart';
import '../../meeting/model/HomeModelResponse.dart';
import '../model/progressModel.dart';

class MeetingOptionService {
  String TAG = "MeetingOptionService";

  Future<progressResponceModel> gethomedata({body}) async {
    try {
      final response = await BaseClient.sharedClient.postRequest(
          endPoint: AppConstants.PROGRESS_CHECK,body:body );
      print("response=====$response");
      return progressResponceModel.fromJson(response as Map<String, dynamic>);
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