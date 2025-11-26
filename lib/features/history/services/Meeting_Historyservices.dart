
import '../../../Utill/AppConstants.dart';
import '../../../Utill/app_base_client.dart';
import '../model/HomeModelResponse.dart';


class Meeting_Historyservices {
  String TAG = "Meeting_Historyservices";

  Future<HomeModelResponse> gethomedata({body}) async {
    try {
      final response = await BaseClient.sharedClient.postRequest(
          endPoint: AppConstants.Meeting_History,body:body );
      print("response=====$response");
      return HomeModelResponse.fromJson(response as Map<String, dynamic>);
    } catch (exception) {
      print("response=====$exception");
      rethrow;
    }
  }


}