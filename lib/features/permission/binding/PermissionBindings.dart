import 'package:pidilite/features/meeting/controller/Meeting_DashboardController.dart';
import 'package:pidilite/features/meeting/services/Meeting_services.dart';
import 'package:pidilite/features/permission/controller/PermissionController.dart';
import 'package:get/get.dart';

class PermissionBindings extends Bindings {


  @override
  void dependencies() {
    Get.lazyPut<PermissionController>(() => PermissionController());
    // Get.lazyPut<MeetingServices>(
    //       () => MeetingServices(),
    // );
  }


}