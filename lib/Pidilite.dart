
import 'dart:ui';

import 'package:pidilite/routes/app_pages.dart';
import 'package:flutter/services.dart';

import 'Utill/AppConstants.dart';
import 'Utill/app_required.dart';
import 'Utill/app_storage.dart';
import 'Utill/app_theme.dart';
import 'main.dart';

class PidiliteApp extends StatelessWidget {
  const PidiliteApp({super.key});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return ValueListenableBuilder<Color>(
      valueListenable: appBarColorNotifier,
      builder: (context, color, child) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: color,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ));
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(size.width < 380 ?  0.8 : 1)),
          child: GetMaterialApp(
            title: AppConstants.appName,
            initialRoute: Routes.SPLASH,
            getPages: AppPages.routes,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.geteasydialTheme(),
            initialBinding: BindingsBuilder(
                  () {
                Get.lazyPut<GetConnect>(
                      () => GetConnect(),
                );
                Get.lazyPut<AppStorage>(
                      () => AppStorage(),
                );
              },
            ),
            scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown,
            }),
            builder: (context, child) {
              return SafeArea(
                top: false, // keep status bar overlay
                bottom:true, // protect navigation bar area
                child: child ?? const SizedBox(),
              );}
          ),
        );
      },);
  }}