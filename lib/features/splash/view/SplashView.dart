
import 'package:birla/Utill/app_required.dart';

import '../controller/SplashController.dart';

class SplashView extends GetView<SplashController> {
   SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.startAnimation();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      appBarColorNotifier.value = AppColors.primaryColor;
    });
     return Scaffold(
      body:SizedBox.expand(
        child:
            Image.asset(
          Images.splash_logo,
          filterQuality: FilterQuality.high,
          fit: BoxFit.cover, // Ensures the image covers the entire screen
        ),
      ),

    );
  }
}
