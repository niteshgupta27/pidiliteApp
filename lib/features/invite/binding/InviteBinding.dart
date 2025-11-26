
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../controller/inviteController.dart';
import '../service/InviteService.dart';

class InviteBindings extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<InviteController>(() => InviteController());
    Get.lazyPut<InviteServices>(() => InviteServices());
  }

}