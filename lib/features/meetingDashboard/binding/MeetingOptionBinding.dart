
import 'package:birla/Utill/app_required.dart';
import 'package:birla/features/meetingDashboard/service/MeetingOptionService.dart';

import 'package:birla/features/meetingDashboard/controller/MeetingOptionController.dart';


class MeetingOptionBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<MeetingOptionController>(() => MeetingOptionController());
    Get.lazyPut<MeetingOptionService>(() => MeetingOptionService());

  }

}