import 'package:flutter/services.dart';

class CallService {

  static const platform = MethodChannel('com.nebula.pidilite/call');

  static makeDirectCall(String phoneNumber) async {
    try {
      await platform.invokeMethod('makeCall', {"number": phoneNumber});
    } on PlatformException catch (e) {
      print("Failed to make call: '${e.message}'.");
    }
  }
// final Uri launchUri = Uri(
//   scheme: 'tel',
//   path: phoneNumber,
// );
// await launchUrl(launchUri);

}