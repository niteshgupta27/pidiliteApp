import 'package:pidilite/Utill/app_required.dart';
import 'package:pidilite/features/Photos/controller/AddMeetingPhotosController.dart';
import 'package:pidilite/features/Photos/controller/MeetingPhotosListController.dart';
import 'package:pidilite/features/Photos/service/MeetingPhotosService.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class MeetingPhotosBinding extends Bindings {


  @override
  void dependencies() {
    Get.lazyPut<MeetingPhotosListController>(() => MeetingPhotosListController());
    Get.lazyPut<MeetingPhotosService>(
          () => MeetingPhotosService(),
    );
    Get.lazyPut<AddMeetingPhotosController>(() => AddMeetingPhotosController());

  }


}