
import '../../../Utill/AppConstants.dart';
import '../../../Utill/app_base_client.dart';
import '../../../model/GenralResponceModel.dart';
import '../../Start/model/meetinginfoResponse.dart';
import '../../meetingDashboard/model/progressModel.dart';
import '../model/MeetingImagesResponce.dart';
import '../model/MeetingPhotoTypesResponse.dart';

class MeetingPhotosService {
  String TAG = "MeetingStartService";

  Future<MeetingPhotoTypesResponse> getPhotoTYpeata({body}) async {
    try {
      final response = await BaseClient.sharedClient.postRequest(
          endPoint: AppConstants.GET_PHOTO_TYPES,body:body );
      print("response=====$response");
      return MeetingPhotoTypesResponse.fromJson(response as Map<String, dynamic>);
    } catch (exception) {
      print("response=====$exception");
      rethrow;
    }
  }
  Future<MeetingImagesResponce> load_meeting_images({body}) async {
    try {
      final response = await BaseClient.sharedClient.postRequest(
          endPoint: AppConstants.Get_all_photo_list,body:body );
      print("response=====$response");
      return MeetingImagesResponce.fromJson(response as Map<String, dynamic>);
    } catch (exception) {
      print("response=====$exception");
      rethrow;
    }
  }
  Future<GenralResponceModel> UPLOAD_MEETING_IMAGE({body}) async {
    try {
      final response = await BaseClient.sharedClient.postRequest(
          endPoint: AppConstants.UPLOAD_MEETING_IMAGE,body:body );
      print("response=====$response");
      return GenralResponceModel.fromJson(response as Map<String, dynamic>);
    } catch (exception) {
      print("response=====$exception");
      rethrow;
    }
  }
  Future<GenralResponceModel> Delete_image({body}) async {
    try {
      final response = await BaseClient.sharedClient.postRequest(
          endPoint: AppConstants.Delete_photo_list,body:body );
      print("response=====$response");
      return GenralResponceModel.fromJson(response as Map<String, dynamic>);
    } catch (exception) {
      print("response=====$exception");
      rethrow;
    }
  }
}