
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:url_launcher/url_launcher.dart';

import 'app_required.dart';

class AppUtils {
  AppUtils._();

  static showSnackbar(BuildContext context, String message,String Title) {
    Future.delayed(const Duration(milliseconds: 200), () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }
  static Future<bool> checkInternetConnectivity() async {
    final results = await (Connectivity().checkConnectivity());
    if (results.contains(ConnectivityResult.none)) {
      return false;
    }
    return true;
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