
import 'package:birla/Utill/app_required.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../Utill/AppConstants.dart';
import '../../../Utill/app_storage.dart';
import '../../../model/CallLogModel.dart';
import '../../../model/Timemodel.dart';
import '../../../model/UserDataModel.dart';



class SplashController extends GetxController {

  String TAG = "SplashController";
  final appStorage = Get.find<AppStorage>();

  Future startAnimation() async {
    ReadUserData();
    Future.delayed(const Duration(seconds: 2), () {
      if(appStorage.loggedInUserToken != ""){
        Get.offNamed(Routes.ProductsDashboard);
      }else{
        Get.offNamed(Routes.LOGINSCREEN);
      }

    });
  }
  ReadUserData() async {
    var loggedInUserInformation =

    await appStorage.read(AppConstants.loginUserInformation);
    if(loggedInUserInformation != null) {
      appStorage.loggedInUser =
          UserData.fromJson(loggedInUserInformation);
      print(appStorage.loggedInUser.id);
      appStorage.loggedInUserToken = await appStorage.read(AppConstants.loginUserInformationToken);
      final List<dynamic> rawList = await appStorage.read(AppConstants.callLogList) ?? [];
      appStorage.CalllogArray.value = rawList.map((item) => CallLogModel.fromJson(item)).toList();
      final List<dynamic> rawtimeList = await appStorage.read(AppConstants.lastUpdate) ?? [];
      appStorage.lastTimeArray.value = rawtimeList.map((item) => Timemodel.fromJson(item)).toList();
    }
  }

}