import 'package:pidilite/Utill/app_required.dart';

class AppTheme {
  static ThemeData geteasydialTheme() {
    return ThemeData(
      fontFamily: AppConstants.fontFamily,
      primaryColor: AppColors.primaryColor,
      appBarTheme: const AppBarTheme(elevation: 5.0,centerTitle: true,color: AppColors.primaryColor),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
        TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
      }),
      // TODO FOR BUTTON GLOBALLY decoration
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}