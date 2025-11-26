import 'dart:io';

import 'package:collection/collection.dart';
import 'package:birla/Utill/ImageHelper.dart';
import 'package:birla/Utill/app_required.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../../Utill/Apputills.dart';
import '../../../Utill/DialogHelper.dart';
import '../../meeting/model/TableMeetingsModel.dart';
import '../model/MeetingImagesResponce.dart';
import '../model/MeetingPhotoTypesResponse.dart';
import '../service/MeetingPhotosService.dart';


class MeetingPhotosListController extends GetxController {
  RxBool isLoading = false.obs;
  var productServices = Get.find<MeetingPhotosService>();
  var appStorage = Get.find<AppStorage>();

  RxString fld_p_image_path="".obs;
  RxString fld_t_image_path="".obs;
  RxString fld_c_image_path="".obs;
  Rx<TableMeetingsModel> meeting=TableMeetingsModel.fromJson({}).obs;
 var data=<MeetingPhotoTypesData>[].obs;
  var groupedMeetings = <String, List<MeetingPhotoTypesData>>{}.obs;
  var selectedCategory = ''.obs; // Stores the currently selected category
Rx<MeetingImagesResponce>meetingImagesResponce=MeetingImagesResponce.fromJson({}).obs;
  var tages = <String?>[].obs;
  RxInt selected = 0.obs;
  var groupedMeetingsimages = <String, List<Meetingimage>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    print(arguments);
    if(arguments!= null){
      meeting.value= TableMeetingsModel.fromJson(arguments['data']);
      CallGetdata();
    }
  }


  Future<void> CallGetdata() async {
    if (await AppUtils.checkInternetConnectivity()) {
      HomeApi();

    }else {
      AppUtils.showSnackbar("Please check Internet Connection", "Info");
    }
  }
  void HomeApi() {
    // AppUtils.alertWithProgressBar();
    isLoading.value= true;

    var requestBody = {
      'user_id': appStorage.loggedInUser.id,
      'meeting_id':meeting.value.fldMId
    };
    productServices.getPhotoTYpeata(body: requestBody).then((value) async {
      isLoading.value = false;
      if (value.success == true) {
         data.value=value.data;
         var grouped = groupBy(data, (MeetingPhotoTypesData m) => m.fldTypeName);

         // Update the RxMap
         groupedMeetings.value = grouped;
         if (grouped.isNotEmpty && selected==0) {
           selectedCategory.value = grouped.keys.first;
         }
        CallNoteAdd_update();
      } else {
        // Get.back();

        AppUtils.showSnackbar(value.message.toString(),  "Info");
      }
    }).catchError((err) {
      // Get.back();
      isLoading.value = false;
      AppUtils.showSnackbar("Something went wrong","Oops");
      //AppUtils.alert("Something went wrong", title: "Oops");
    });
  }

  void deleteNoteAt(int meeting_image_id) {
    DialogHelper.showDeleteDialog(
      title: "Are you sure you want to delete?",
      content: "This action cannot be undone.",
      onConfirm: () {
        Delete_image(meeting_image_id);
      },
    );

  }

  Future<void> CallNoteAdd_update() async {
    // AppUtils.alertWithProgressBar();

    isLoading.value= true;
    var requestBody = {
      'user_id': appStorage.loggedInUser.id,
      'meeting_id':meeting.value.fldMId,

    };
    print(requestBody);
    productServices.load_meeting_images(body: requestBody).then((value) async {
      isLoading.value = false;
      if(value.success==true) {
        if(value.data != null) {
          meetingImagesResponce.value = value;
          getimagedata();
        }
      }else{
        AppUtils.showSnackbar(value.message.toString(),"Error");
      }
    }).catchError((err) {
      isLoading.value = false;
      AppUtils.showSnackbar(err.toString(),"server Error");
      //AppUtils.alert("Something went wrong", title: "Oops");
    });
  }
  void getimagedata(){
   // if (meetingImagesResponce.value.data?.containsKey(selectedCategory.value) == true) {
      var data1 = meetingImagesResponce.value.data![selectedCategory.value] ?? [];
print(data1);
      // Group by purpose
      var grouped1 = groupBy(data1, (Meetingimage m) => m.purpose ?? 'Unknown');

      // Update the RxMap
      groupedMeetingsimages.value = grouped1;
   // }

  }
  Future<void> Delete_image(meeting_image_id) async {
    // AppUtils.alertWithProgressBar();

    isLoading.value= true;
    var requestBody = {
      'user_id': appStorage.loggedInUser.id,
      'meeting_id':meeting.value.fldMId,
      "meeting_image_id": meeting_image_id,

    };
    print(requestBody);
    productServices.Delete_image(body: requestBody).then((value) async {
      isLoading.value = false;
      if(value.success==true) {
        CallNoteAdd_update();
        AppUtils.showSnackbar(value.message.toString(),"success");
      }else{
        AppUtils.showSnackbar(value.message.toString(),"Error");
      }
    }).catchError((err) {
      isLoading.value = false;
      AppUtils.showSnackbar(err.toString(),"server Error");
      //AppUtils.alert("Something went wrong", title: "Oops");
    });
  }
}