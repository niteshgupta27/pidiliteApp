import 'dart:io';

import 'package:birla/Utill/app_required.dart';
import 'package:call_e_log/call_log.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../Utill/Apputills.dart';

class PermissionController extends GetxController with WidgetsBindingObserver {
  final appStorage = Get.find<AppStorage>();
  RxString _permissionStatus = 'Unknown'.obs;
  final permissionsStatus = <Permission, PermissionStatus>{}.obs;
  bool isFetchingCallLogs = false;

  @override
  void onInit() {
    super.onInit();
    // Add observer
    WidgetsBinding.instance.addObserver(this);
    _checkPermissions();
  }

  // This method is called whenever the app's lifecycle state changes
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Re-check permissions when the app comes back to the foreground
      if (allPermissionsGranted) {
        Future.delayed(const Duration(seconds: 2), () {
          if (appStorage.loggedInUserToken != "") {
            fetchLocation();
            Get.offNamed(Routes.ProductsDashboard);
          } else {
            Get.offNamed(Routes.LOGINSCREEN);
          }
        });
      } else {
        _checkPermissions();
      }
    }
  }

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

  @override
  void onClose() {
    // Stop listening when the controller is closed
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  Future<void> _checkPermissions() async {
    final status = await Future.wait([
      Permission.phone.status,
      // Permission.contacts.status, // Often used with CALL_PHONE
      Permission.microphone.status,
      Permission.camera.status,
      Permission.location.status, Permission.photos.status,
    ]);

    permissionsStatus[Permission.phone] = status[0];
    // permissionsStatus[Permission.contacts] = status[1];
    permissionsStatus[Permission.microphone] = status[1];
    permissionsStatus[Permission.camera] = status[2];
    permissionsStatus[Permission.location] = status[3];
    permissionsStatus[Permission.photos] = status[4];
    if (permissionsStatus[Permission.phone]?.isGranted == true) {
      await fetchCallLogs();
    }
  }

  Future<void> fetchCallLogs() async {
    if (isFetchingCallLogs) return; // prevent multiple calls
    isFetchingCallLogs = true;

    try {
      final logs = await CallLog.get();
      // handle logs
    } catch (e) {
      print("Error fetching call logs: $e");
    } finally {
      isFetchingCallLogs = false;
    }
  }

  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();
    print(status);
    permissionsStatus[permission] = status;
    if (status.isPermanentlyDenied) {
      Get.snackbar(
        backgroundColor: AppColors.primaryColor.withOpacity(0.2),
        'Permission Denied',
        'Please allow the permission from app settings.',
        mainButton: TextButton(
          onPressed: () {
            openAppSettings();
            Get.back();
          },
          child: const Text('Open Settings'),
        ),
      );
    } else if (status.isDenied) {
      Get.snackbar(
        backgroundColor: AppColors.primaryColor.withOpacity(0.2),
        'Permission Denied',
        'Please allow the permission from app settings.',
        mainButton: TextButton(
          onPressed: () {
            openAppSettings();
            Get.back();
          },
          child: const Text('Open Settings'),
        ),
      );
    }
  }

  Future<void> requestAllPermissions() async {
    await requestPermission(Permission.phone);
    // await requestPermission(Permission.contacts);
    await requestPermission(Permission.microphone);
    await requestPermission(Permission.camera);
    await requestPermission(Permission.location);
    await requestPermission(Permission.photos);
  }

  bool get allPermissionsGranted {
    return permissionsStatus[Permission.phone]?.isGranted == true &&
        permissionsStatus[Permission.microphone]?.isGranted == true &&
        permissionsStatus[Permission.camera]?.isGranted == true &&
        permissionsStatus[Permission.location]?.isGranted == true &&
        permissionsStatus[Permission.photos]?.isGranted == true;
  }

  void Logout() {
    appStorage.resetStorage();
    Get.offNamed(Routes.LOGINSCREEN);
  }

  // Open app settings
  Future<void> openSettingspage() async {
    bool result = await openAppSettings();
    if (result) {
      //Get.offNamed(Routes.ProductsDashboard);
      closeApp();
    } else {
      print('Failed to open app settings');
    }
  }

  void closeApp() {
    exit(0);
  }

  // Helper methods for the UI.
  String getButtonText(Permission permission) {
    return permissionsStatus[permission]?.isGranted == true
        ? 'Allowed'
        : 'Allow';
  }

  bool isPermissionAllowed(Permission permission) {
    return permissionsStatus[permission]?.isGranted == true;
  }
}
