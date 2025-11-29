import 'dart:io';

import 'package:pidilite/Utill/ImageHelper.dart';
import 'package:pidilite/Utill/app_required.dart';
import 'package:pidilite/features/Photos/service/MeetingPhotosService.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../../Utill/Apputills.dart';
import '../../../Utill/DialogHelper.dart';
import '../../camera/camera_page.dart';
import '../../meeting/model/TableMeetingsModel.dart';
import '../model/MeetingPhotoTypesResponse.dart';

class AddMeetingPhotosController extends GetxController {
  RxBool isLoading = true.obs;
  var productServices = Get.find<MeetingPhotosService>();
  var appStorage = Get.find<AppStorage>();

  RxString fld_p_image_path="".obs;

  Rx<TableMeetingsModel> meeting=TableMeetingsModel.fromJson({}).obs;
  var data=<MeetingPhotoTypesData>[].obs;
  Rx<MeetingPhotoTypesData?> selectedOption = Rx<MeetingPhotoTypesData?>(null);

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    print(arguments);
    if(arguments!= null){
      meeting.value= TableMeetingsModel.fromJson(arguments['data']);
      data.value=arguments['cat'];
      isLoading.value=false;
      //CallGetdata();
    }
  }
  //final ImagePicker _picker = ImagePicker();

  Future<void> takePhoto(String imagetype,BuildContext context) async {
    if(selectedOption.value != null) {
      var result = await Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return CameraPage(needSelfyMode: false,);
        },
      ));

        // final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
        if (result["result"] != null) {
          try {
          File file = File(result["result"]);
          File processedFile = await ImageHelper.processImage(file, meeting.value, selectedOption.value != null ? selectedOption.value!.fldPurpose : "");

          fld_p_image_path.value = processedFile.path;
        } catch (e) {
        AppUtils.showSnackbar(e.toString(), "Info");
        print("Error during image selection: $e"); //Proper logging for debugging and reporting
        // Handle errors appropriately, e.g., display an error message to the user.
      }
        }

    }else{
      AppUtils.showSnackbar("Select Photo Type First.", "Info");
    }
  }

  Future<void> CallGetdata() async {
    if (await AppUtils.checkInternetConnectivity()) {
     // HomeApi();

    }else {
      AppUtils.showSnackbar("Please check Internet Connection", "Info");
    }
  }

  validateAndProcess() async {

    if (selectedOption.value != null ) {

          if (fld_p_image_path.value.toString() != "" ) {

                if (await AppUtils.checkInternetConnectivity()) {
                  // Get.offNamed(Routes.HOMESCREEN);
                  CallNoteAdd_update();
                } else {
                  AppUtils.showSnackbar("Please check Internet Connection", "Info");
                }

          } else {
            AppUtils.showSnackbar("Please take a picture First", "Info");
            //Show N
          }
        }else{
          AppUtils.showSnackbar("Please Select a Photo Type.", "Info");
        }

  }
  Future<void> CallNoteAdd_update() async {
    // AppUtils.alertWithProgressBar();

    isLoading.value= true;
    var requestBody = {
      'user_id': appStorage.loggedInUser.id,
      'meeting_id':meeting.value.fldMId,

      "type_id": selectedOption.value?.fldPtId,
      "fld_lat": appStorage.lat.value,
      "fld_long": appStorage.long.value,
      "image":await AppUtils.editImage(fld_p_image_path.value),

    };
    print(requestBody);
    productServices.UPLOAD_MEETING_IMAGE(body: requestBody).then((value) async {
      isLoading.value = false;
      if(value.success==true) {
        Get.back(result: {"status": "success",});
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
  // Future<void> changeMeetingStatus() async {
  //   // AppUtils.alertWithProgressBar();
  //
  //   isLoading.value= true;
  //   var requestBody = {
  //     'user_id': appStorage.loggedInUser.id,
  //     'meeting_id':meeting.value.fldMId,
  //     "mstatus": "2",
  //
  //   };
  //   print(requestBody);
  //   productServices.UpdateStatus(body: requestBody).then((value) async {
  //     isLoading.value = false;
  //     if(value.success==true) {
  //       Get.back(result: {"status": "success",});
  //       AppUtils.showSnackbar(value.message.toString(),"success");
  //     }else{
  //       AppUtils.showSnackbar(value.message.toString(),"Error");
  //     }
  //   }).catchError((err) {
  //     isLoading.value = false;
  //     AppUtils.showSnackbar(err.toString(),"server Error");
  //     //AppUtils.alert("Something went wrong", title: "Oops");
  //   });
  // }
  void deleteNoteAt(String Imagetype) {
    DialogHelper.showDeleteDialog(
      title: "Are you sure you want to delete?",
      content: "This action cannot be undone.",
      onConfirm: () {
        if(Imagetype=="p") {
          fld_p_image_path.value = "";
        }
      },
    );

  }
}