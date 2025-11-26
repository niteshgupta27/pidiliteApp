import '../../../Utill/app_required.dart';
import '../controller/SplashController.dart';


class SplashBindings extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }

}