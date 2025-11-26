
import 'package:pidilite/Utill/app_required.dart';
import 'package:pidilite/features/meetingDashboard/service/MeetingOptionService.dart';

import 'package:pidilite/features/meetingDashboard/controller/MeetingOptionController.dart';


class MeetingOptionBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<MeetingOptionController>(() => MeetingOptionController());
    Get.lazyPut<MeetingOptionService>(() => MeetingOptionService());

  }

}