
import '../../../Utill/app_required.dart';
import '../Login/controller/login_controller.dart';
import '../services/auth_services.dart';


class AuthBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<AuthServices>(
      () => AuthServices(),
    );

  }
}
