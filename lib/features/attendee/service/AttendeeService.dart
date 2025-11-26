
import '../../../Utill/AppConstants.dart';
import '../../../Utill/app_base_client.dart';
import '../../../model/GenralResponceModel.dart';
import '../model/AdhesiveModel.dart';
import '../model/AdhesiveResponse.dart';
import '../model/AttendeeListresponseModel.dart';
import '../model/RoleModel.dart';

class AttendeeService {
  String TAG = "AttendeeService";


  Future<AttendeeListresponseModel> gethomedata({body,modify}) async {
    try {
     // final response;



      final response = await BaseClient.sharedClient.postRequest(
          endPoint: AppConstants.attendee_LIST,body:body );
      print("response=====$response");
      return AttendeeListresponseModel.fromJson(response as Map<String, dynamic>);

    } catch (exception) {
      print("response=====$exception");
      rethrow;
    }
  }
  Future<GenralResponceModel> Addattendee({body, required bool modify}) async {
    try {
      if(modify){
        final response = await BaseClient.sharedClient.postRequest(
            endPoint: AppConstants.UPdate_MEETING_ATTENDEE,body:body );
        print("response=====$response");
        return GenralResponceModel.fromJson(response as Map<String, dynamic>);

      }
      else{
        final response = await BaseClient.sharedClient.postRequest(
            endPoint: AppConstants.UPLOAD_MEETING_ATTENDEE,body:body );
        print("response=====$response");
        return GenralResponceModel.fromJson(response as Map<String, dynamic>);
      }

    } catch (exception) {
      print("response=====$exception");
      rethrow;
    }
  }
  Future<AdhesiveResponse> getadhesives({fld_uid}) async {
    try {
      final response = await BaseClient.sharedClient.getRequest(
        endPoint: "${AppConstants.GET_adhesives}?user_id=$fld_uid",

      );
      // print("response=====$response");
      print("response=====$response");
      return AdhesiveResponse.fromJson(response as Map<String, dynamic>);
    } catch (exception) {
      print("response=====$exception");
      rethrow;
    }
  }
  Future<GenralResponceModel> getmisscall({cureentDate}) async {
    try {
      final response = await BaseClient.sharedClient.getRequest(
        endPoint: "${AppConstants.AttendeeRefresh}$cureentDate",

      );
      // print("response=====$response");
      print("response=====$response");
      return GenralResponceModel.fromJson(response as Map<String, dynamic>);
    } catch (exception) {
      print("response=====$exception");
      rethrow;
    }
  }
  Future<RoleModelResponse> getstaff() async {
    try {
      final response = await BaseClient.sharedClient.getRequest(
        endPoint: "${AppConstants.getstaff}",

      );
      // print("response=====$response");
      print("response=====$response");
      return RoleModelResponse.fromJson(response as Map<String, dynamic>);
    } catch (exception) {
      print("response=====$exception");
      rethrow;
    }
  }
}