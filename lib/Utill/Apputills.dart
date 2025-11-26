
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:url_launcher/url_launcher.dart';

import 'app_required.dart';

class AppUtils {
  AppUtils._();

  static showSnackbar( String message,String Title) {
    Get.snackbar(
      Title, // Title
      message, // Message
      snackPosition: SnackPosition.BOTTOM, // Position of the SnackBar
      backgroundColor: Colors.blue, // Background color
      colorText: Colors.white, // Text color
      duration: Duration(seconds: 4), // Duration for how long the SnackBar stays
    );
  }
  static Future<bool> checkInternetConnectivity() async {
    final birlaivityResult = await (Connectivity().checkConnectivity());
    if (birlaivityResult == ConnectivityResult.mobile) {
      debugPrint("User is connectivity to mobile network");
      return true;
    } else if (birlaivityResult == ConnectivityResult.wifi) {
      debugPrint("User is connectivity to wifi network");
      return true;
    } else {
//showToast("Check Internet birlaivity");
      return false;
    }
  }
  static Future<void> launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalNonBrowserApplication)) {
      throw Exception('Could not launch $url');
    }
  }
  static String formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final secs = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$hours:$minutes:$secs";
  }
 static Future<String> editImage(String? path) async {
    if (path == null || path.toLowerCase() == "null"||path=="") return "";
if(path.contains("https://assets")){
  return path;
}else{
    try {
      File file = File(path);
      if (await file.exists()) {
        List<int> imageBytes = await file.readAsBytes();
        String base64Image = base64Encode(imageBytes);
        return "data:image/jpeg;base64,$base64Image";
      } else {
        return "Null";
      }
    } catch (e) {
      return "Null"; // Handle error safely
    }
  }}
 static bool isValidMobileNumber(String number) {
    String regexPattern = r'^[6-9]\d{9}$';
    RegExp regExp = RegExp(regexPattern);
    return regExp.hasMatch(number);
  }

}