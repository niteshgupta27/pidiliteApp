import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../controller/AddAttendee2Controller.dart';
import '../controller/AddAttendee3Controller.dart';
import '../controller/AddAttendeeController.dart';
import '../controller/AttendeeController.dart';
import '../service/AttendeeService.dart';

class AttendeeBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<AttendeeController>(
          () => AttendeeController(),
    );

    Get.lazyPut<AttendeeService>(
          () => AttendeeService(),
    );
    Get.lazyPut<AddAttendeeController>(
          () => AddAttendeeController(),
    );
    Get.lazyPut<AddAttendee2Controller>(
          () => AddAttendee2Controller(),
    );
    Get.lazyPut<AddAttendee3Controller>(
          () => AddAttendee3Controller(),
    );
  }
}