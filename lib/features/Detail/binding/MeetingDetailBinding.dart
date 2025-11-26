import 'package:birla/Utill/app_required.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../../meeting/services/Meeting_services.dart';
import '../controller/MeetingDetailController.dart';
import '../service/MeetingDetailService.dart';

class MeetingDetailBinding extends Bindings {


  @override
  void dependencies() {
    Get.lazyPut<MeetingDetailController>(() => MeetingDetailController());
    Get.lazyPut<MeetingDetailService>(
          () => MeetingDetailService(),
    );
  }


}