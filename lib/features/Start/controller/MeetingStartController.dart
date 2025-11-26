import 'dart:io';

import 'package:birla/Utill/ImageHelper.dart';
import 'package:birla/Utill/app_required.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Utill/Apputills.dart';
import '../../../Utill/DialogHelper.dart';
import '../../camera/camera_page.dart';
import '../../meeting/model/TableMeetingsModel.dart';
import '../../meeting/services/Meeting_services.dart';
import '../model/meetinginfoResponse.dart';
import '../service/MeetingStartService.dart';

class MeetingStartController extends GetxController {
  RxBool isLoading = false.obs;
  var productServices = Get.find<MeetingStartService>();
  var appStorage = Get.find<AppStorage>();
  Rx<TextEditingController>  Hotel_NameController = TextEditingController().obs;
  Rx<TextEditingController>  Hotel_manager_NameController = TextEditingController().obs;
  Rx<TextEditingController>  Hotel_manager_NumberController = TextEditingController().obs;
RxString fld_p_image_path="".obs;
  RxString fld_t_image_path="".obs;
  RxString fld_c_image_path="".obs;
  Rx<TableMeetingsModel> meeting=TableMeetingsModel.fromJson({}).obs;
  Rx<MeetingInfoResponse>data=MeetingInfoResponse.fromJson({}).obs;

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
  //final ImagePicker _picker = ImagePicker();

  Future<void> takePhoto(String imagetype,BuildContext context) async {
    if(Hotel_NameController.value .text.toString().isNotEmpty) {
    var result = await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return CameraPage(needSelfyMode: imagetype=="p"?true:false,);
      },
    ));

      // final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (result != null) {
        try {
      //fld_p_image_path.value =photo.path;
      print("object image");
      File file = File(result["result"]);
      File processedFile =  await ImageHelper.processImage(file,meeting.value,Hotel_NameController.value.text);
      print("object image ${processedFile.path}");
      if(imagetype=="p") {
        fld_p_image_path.value = processedFile.path;
      }else if(imagetype=="t") {
        fld_t_image_path.value = processedFile.path;
      }
      else if(imagetype=="c") {
        fld_c_image_path.value = processedFile.path;
      }
      } catch (e) {
      AppUtils.showSnackbar(e.toString(), "Info");
      print("Error during image selection: $e"); //Proper logging for debugging and reporting
      // Handle errors appropriately, e.g., display an error message to the user.
    }
    }

    }else{
      AppUtils.showSnackbar("Please enter Hotel Name First.", "Info");
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
    productServices.gethomedata(body: requestBody).then((value) async {
      isLoading.value = false;
      if (value.success == true) {
       // data.value=value;
        if(value.data.length>0) {
          Hotel_NameController.value.text = value.data.first.fldHotelName!;
          Hotel_manager_NameController.value.text = value.data.first.fldManagerName!;
          Hotel_manager_NumberController.value.text = value.data.first.fldMmobile!;
          fld_p_image_path.value = value.data.first.fldPImagePath1!;
          fld_t_image_path.value = value.data.first.fldTImagePath1!;
          fld_c_image_path.value = value.data.first.fldCImagePath1!;
        }
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
  void deleteNoteAt(String Imagetype) {
    DialogHelper.showDeleteDialog(
      title: "Are you sure you want to delete?",
      content: "This action cannot be undone.",
      onConfirm: () {
        if(Imagetype=="p") {
          fld_p_image_path.value = "";
        }else if(Imagetype=="t") {
          fld_t_image_path.value = "";
        }
        else if(Imagetype=="c") {
          fld_c_image_path.value = "";
        }
      },
    );

  }
  validateAndProcess() async {

    if (Hotel_NameController.value.text != "" ) {
      if (Hotel_manager_NameController.value.text != "" ) {
        if (AppUtils.isValidMobileNumber(Hotel_manager_NumberController.value.text) &&Hotel_manager_NumberController.value.text != "" ) {
          if (fld_p_image_path.value.toString() != "" ) {
            if (fld_t_image_path.value.toString() != "" ) {
              if (fld_c_image_path.value.toString() != "" ) {
          if (await AppUtils.checkInternetConnectivity()) {
            // Get.offNamed(Routes.HOMESCREEN);
            CallNoteAdd_update();
          } else {
            AppUtils.showSnackbar("Please check Internet Connection", "Info");
          }
        }else{
          AppUtils.showSnackbar("Please enter a c.", "Info");
        }
      } else {
        AppUtils.showSnackbar("Please enter a t.", "Info");
        //Show error
      }
    } else {
      AppUtils.showSnackbar("Please enter a p", "Info");
      //Show N
    }
        }else{
          AppUtils.showSnackbar("Please enter a Hotel Manger Number.", "Info");
        }
      } else {
        AppUtils.showSnackbar("Please enter a Hotel Manger Name.", "Info");
        //Show error
      }
    } else {
      AppUtils.showSnackbar("Please enter a Hotel Name.", "Info");
      //Show N
    }
  }
  Future<void> CallNoteAdd_update() async {
    // AppUtils.alertWithProgressBar();

    isLoading.value= true;
    var requestBody = {
      'user_id': appStorage.loggedInUser.id,
      'meeting_id':meeting.value.fldMId,
      "hotel_name": Hotel_NameController.value.text.toString(),
      "manager_name": Hotel_manager_NameController.value.text.toString(),
      "manager_mobile": Hotel_manager_NumberController.value.text.toString(),
      "fld_lat": appStorage.lat.value,
      "fld_long": appStorage.long.value,
      "promoter_image1":await AppUtils.editImage(fld_p_image_path.value),
      "training_image1":await AppUtils.editImage(fld_t_image_path.value),
      "business_card_image":await AppUtils.editImage(fld_c_image_path.value),
    };
    print(requestBody);
    productServices.Add_meeting_info(body: requestBody).then((value) async {
      isLoading.value = false;
      if(value.success==true) {
        changeMeetingStatus();
       // AppUtils.showSnackbar(value.message.toString(),"success");
      }else{
        AppUtils.showSnackbar(value.message.toString(),"Error");
      }
    }).catchError((err) {
      isLoading.value = false;
      AppUtils.showSnackbar(err.toString(),"server Error");
      //AppUtils.alert("Something went wrong", title: "Oops");
    });
  }
  Future<void> changeMeetingStatus() async {
    // AppUtils.alertWithProgressBar();

    isLoading.value= true;
    var requestBody = {
      'user_id': appStorage.loggedInUser.id,
      'meeting_id':meeting.value.fldMId,
      "mstatus": "2",

    };
    print(requestBody);
    productServices.UpdateStatus(body: requestBody).then((value) async {
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
}