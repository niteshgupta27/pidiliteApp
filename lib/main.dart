import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'Utill/app_colors.dart';
import 'Pidilite.dart';
ValueNotifier<Color> appBarColorNotifier = ValueNotifier<Color>(AppColors.yellow);
late List<CameraDescription> cameras;

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await GetStorage.init();
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: AppColors.primaryColor,
    //   statusBarBrightness: Brightness.dark,
    //   statusBarIconBrightness: Brightness.light,
    // ));

    //await Firebase.initializeApp();
    cameras = await availableCameras();
    runApp(PidiliteApp());
  },(error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });


}



class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}