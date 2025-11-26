import 'package:birla/Utill/app_required.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../../meeting/services/Meeting_services.dart';
import '../controller/MeetingStartController.dart';
import '../service/MeetingStartService.dart';

class MeetingStartBinding extends Bindings {


  @override
  void dependencies() {
    Get.lazyPut<MeetingStartController>(() => MeetingStartController());
    Get.lazyPut<MeetingStartService>(
          () => MeetingStartService(),
    );
  }


}