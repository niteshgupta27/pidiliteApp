import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/CallLogModel.dart';
import '../model/Timemodel.dart';
import '../model/UserDataModel.dart';
import 'AppConstants.dart';

class AppStorage extends GetxService {

  UserData loggedInUser = UserData();
  String loggedInUserToken = '';
//int lastUpdate=0;
RxDouble lat=0.0.obs;
  RxDouble long=0.0.obs;
  RxList<CallLogModel> CalllogArray = <CallLogModel>[].obs;
  RxList<Timemodel> lastTimeArray = <Timemodel>[].obs;

Future<AppStorage> init() async {
    await GetStorage.init();
    return this;
  }

  Future<void> write(String key, dynamic value) async {
    return await GetStorage().write(key, value);
  }

  dynamic read(String key) async {
    return await GetStorage().read<dynamic>(key);
  }

  Future<void> delete(String key) {
    return GetStorage().remove(key);
  }

  resetStorage() {
     loggedInUser = UserData();
    loggedInUserToken = '';
    lat.value=0.0;
    long.value=0.0;
     GetStorage().remove(AppConstants.loginUserInformation);
     GetStorage().remove(AppConstants.loginUserInformationToken);
     GetStorage().remove(AppConstants.callLogList);
     GetStorage().remove(AppConstants.lastUpdate);
  }

// Add a new item to the list
  void addItem(int fldMid, int lastTime) {
    lastTimeArray.add(Timemodel(fldMid: fldMid, lastTime: lastTime));
  }

  // Get lastTime where fldMid matches
  int? getLastTime(int fldMid) {
    return lastTimeArray.firstWhere(
          (item) => item.fldMid == fldMid,
      orElse: () => Timemodel(fldMid: fldMid, lastTime: null),
    ).lastTime;
  }

  // Update lastTime for a specific fldMid
  void updateLastTime(int fldMid, int newLastTime) {
    for (var item in lastTimeArray) {
      if (item.fldMid == fldMid) {
        item.lastTime = newLastTime;
        return;
      }
    }
  }

}