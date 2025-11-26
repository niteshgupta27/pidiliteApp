import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../Utill/Apputills.dart';
import '../../../Utill/app_required.dart';
import '../model/TableMeetingsModel.dart';
import '../services/Meeting_services.dart';

class MeetingDashboardController extends GetxController {
  RxBool isLoading = true.obs;
  var productServices = Get.find<MeetingServices>();
  var brands = <TableMeetingsModel>[].obs;
  var headerbannerType = "image".obs;
  var headerUrl = "".obs;
  var tages = <String?>[].obs;
  var appStorage = Get.find<AppStorage>();
  late List<TableMeetingsModel> childes = [];
  final ScrollController scrollController = ScrollController();
  var sentCount = 0.obs;
  var remainingCount = 0.obs;
  String TAG = "ProductsDashboardController";

  RxBool isButtonPressed = false.obs;
  RxInt selected = 0.obs;
  RxString appName = "".obs;

  @override
  void onInit() {
    super.onInit();
    CallGetdata();
    getversion();
    checkPermissions(); // Keep this call
  }

  Future<void> getversion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName.value = packageInfo.version;
  }

  Future<void> CallGetdata() async {
    if (await AppUtils.checkInternetConnectivity()) {
      checkUser();
    } else {
      AppUtils.showSnackbar("Please check Internet Connection", "Info");
    }
  }

  void HomeApi() {
    isLoading.value = true;

    var requestBody = {'user_id': appStorage.loggedInUser.id};
    productServices
        .gethomedata(body: requestBody)
        .then((value) async {
          isLoading.value = false;
          if (value.status == true) {
            brands.value = value.data;
            _getUniqueDates();
            getmeeting_by_date(selected.value);

            if (appStorage.CalllogArray.length > 0) {
              startSendingData();
            }
          } else {
            AppUtils.showSnackbar(value.message.toString(), "Info");
          }
        })
        .catchError((err) {
          isLoading.value = false;
          AppUtils.showSnackbar("Something went wrong", "Oops");
        });
    // checkPermissions(); // REMOVE this redundant call if already in onInit
  }

  void _getUniqueDates() {
    tages.value = brands
        .map((item) => item.fldMDate as String)
        .toSet()
        .toList();
  }

  void scrollToSelectedIndex(int index) {
    double position = index * 96.0;
    scrollController.animateTo(
      position,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void getmeeting_by_date(int index) {
    String date = tages[index]!;
    childes = brands.where((data) => data.fldMDate == date).toList();
  }

  String getOwnerName(TableMeetingsModel meetingModel) {
    try {
      if (meetingModel.dealers!.length > 1) {
        return "Multi Retailers";
      } else if (meetingModel.dealers!.length == 1) {
        return meetingModel.dealers![0].fldRname ?? "";
      } else {
        return "";
      }
    } catch (e) {
      print(e);
      return "";
    }
  }

  void checkUser() async {
    isLoading.value = true;

    var requestBody = {'user_id': appStorage.loggedInUser.id};
    productServices.CheckUser(body: requestBody)
        .then((value) async {
          isLoading.value = false;
          if (value.success == true) {
            print(appName);
            print(value.data.version);
            if (value.data.version == appName.value) {
              HomeApi();
            } else {
              Get.dialog(
                AlertDialog(
                  title: Text(value.data.versionMessage),
                  content: Text(
                    '${value.data.linkMessage}\n${value.data.appLink}',
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        AppUtils.launchURL(value.data.appLink);
                      },
                      child: const Text('Ok'),
                    ),
                  ],
                ),
              );
            }
          } else {
            AppUtils.showSnackbar(value.message.toString(), "Info");
          }
        })
        .catchError((err) {
          isLoading.value = false;
          AppUtils.showSnackbar("Something went wrong", "Oops");
        });
  }

  static const platform = MethodChannel('com.nebulahub.birla/permissions');
  String permissionStatus = "Unknown";

  Future<void> checkPermissions() async {
    final permissionService = PermissionService();
    permissionService
        .listenForPermissionResults(); // Ensure listener is set up first

    // Call the method channel to request permissions from the Android side
    final result = await permissionService.requestPermissions();

    if (result == "Granted") {
      // AppUtils.showSnackbar('All required permissions granted!', "");
      print("Permissions granted. Proceeding with functionality.");
      fetchLocation();
    } else if (result.startsWith("Denied")) {
      // Check for "Denied" prefix
      Get.offNamed(Routes.Permission);
      print("Permissions denied. Navigating to denied page. Details: $result");
    } else {
      print("Error occurred during permission request: $result");
      // Optionally navigate to permission page on error too, depending on desired behavior
      // Get.offNamed(Routes.Permission);
    }
  }

  // REMOVE THE handlePermission FUNCTION COMPLETELY, as it's now handled by Kotlin
  // Future<void> handlePermission(Permission permission) async {
  //   // ... (remove this function)
  // }

  Future<void> fetchLocation() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    print("location======$isLocationEnabled");
    if (!isLocationEnabled) {
      await Geolocator.openLocationSettings();

      // Wait for a moment and check again
      await Future.delayed(Duration(seconds: 3));
      isLocationEnabled = await Geolocator.isLocationServiceEnabled();

      if (!isLocationEnabled) {
        AppUtils.showSnackbar('Please enable your location', "");
        // If still not enabled after user interaction, consider navigating
        // Get.offAllNamed(Routes.Permission);
      }
      return;
    }

    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever) {
      Get.offNamed(Routes.Permission);
      return;
    }
    print(locationPermission);
    Geolocator.getPositionStream().listen((Position position) {
      appStorage.lat.value = position.latitude;
      appStorage.long.value = position.longitude;
    });
  }

  void startSendingData() {
    showProgressDialog(Get.context!);
    sendBatchData().then((_) {
      // After sending all data, update dialog to show completion
      // Optionally show a dialog to indicate completion
    });
  }

  void showProgressDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: Text('Sending Records'),
        content: Obx(() {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Icon(Icons.check_circle, color: Colors.green, size: 50),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(sentCount.value.toString()),
                  SizedBox(width: 5),
                  Expanded(
                    child: LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primaryColor,
                      ),
                      value: appStorage.CalllogArray.isEmpty
                          ? 0.0
                          : (sentCount / appStorage.CalllogArray.length).clamp(
                              0.0,
                              1.0,
                            ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(appStorage.CalllogArray.length.toString()),
                ],
              ),
            ],
          );
        }),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog if not sending
            },
            child: Text('Close'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> sendBatchData() async {
    sentCount.value = 0;
    remainingCount.value = appStorage.CalllogArray.length;

    for (var record in appStorage.CalllogArray) {
      await updatecallDetailApi(
        record.fldNumber,
        record.fldStatus,
        record.fldCalltime,
        record.fldDuration,
        record.fldMid,
      );
    }
  }

  Future<void> updatecallDetailApi(
    fld_number,
    fld_status,
    fld_calltime,
    fld_duration,
    fldmeeting_Id,
  ) async {
    print("updatecallDetailApi");

    var requestBody = {
      "fld_mid": fldmeeting_Id,
      "fld_uid": appStorage.loggedInUser.id,
      "fld_number": fld_number.toString().replaceAll("+91", ""),
      "fld_status": fld_status.toString().replaceAll("CallType.", ""),
      "fld_calltime": fld_calltime,
      "fld_duration": fld_duration,
    };
    print(requestBody);
    productServices.SendcallDetail(body: requestBody)
        .then((value) async {
          sentCount.value++;

          if (value.success == true) {
            if (sentCount.value == appStorage.CalllogArray.length) {
              Get.back();
              appStorage.CalllogArray.value = []; // Close the dialog once done
              await appStorage.write(
                AppConstants.callLogList,
                appStorage.CalllogArray,
              );
              showCompletionDialog();
            }
          } else {
            AppUtils.showSnackbar(value.message.toString(), "Info");
          }
        })
        .catchError((err) {
          print(err);
          isLoading.value = false;
          AppUtils.showSnackbar("Something went wrong", "Oops");
        });
  }

  void showCompletionDialog() {
    Get.snackbar(
      'Success',
      'All records have been sent successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  bool isFutureDate(String dateStr) {
    DateTime inputDate = DateFormat("yyyy-MM-dd").parse(dateStr);
    return inputDate.isAfter(DateTime.now());
  }
}

class PermissionService {
  static const _channel = MethodChannel("com.nebulahub.birla/permissions");

  Future<String> requestPermissions() async {
    try {
      // Invoke a generic requestPermissions method on the Android side
      final result = await _channel.invokeMethod("requestPermissions");
      return result as String;
    } catch (e) {
      print("Error requesting permissions: $e");
      return "Error";
    }
  }

  void listenForPermissionResults() {
    _channel.setMethodCallHandler((call) async {
      if (call.method == "permissionsResult") {
        final result = call.arguments as String;
        if (result == "Granted") {
          final dashboardCtrl = Get.find<MeetingDashboardController>();
          dashboardCtrl.fetchLocation();
          // This part is handled by the controller's checkPermissions method directly now.
          // It's good to keep this listener for potential future real-time updates if needed.
          print("Permissions granted via MethodChannel: $result");
        } else if (result.startsWith("Denied")) {
          // Check for "Denied" prefix
          print("Permissions denied via MethodChannel: $result");
          Get.offNamed(Routes.Permission);
          // Navigation to Routes.Permission should be handled in the controller's checkPermissions
        }
      }
    });
  }
}
