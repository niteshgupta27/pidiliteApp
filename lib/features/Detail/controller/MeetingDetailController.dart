import 'dart:io';

import 'package:pidilite/Utill/ImageHelper.dart';
import 'package:pidilite/Utill/app_required.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../../Utill/Apputills.dart';
import '../../../Utill/DialogHelper.dart';
import '../../camera/camera_page.dart';
import '../../meeting/model/TableMeetingsModel.dart';
import '../../meeting/services/Meeting_services.dart';
import '../model/meetingDetailResponse.dart';
import '../service/MeetingDetailService.dart';

class MeetingDetailController extends GetxController {
  RxBool isLoading = false.obs;
  var productServices = Get.find<MeetingDetailService>();
  var appStorage = Get.find<AppStorage>();
  Rx<TextEditingController>  Actual_AttendanceController = TextEditingController().obs;
  Rx<TextEditingController>  Total_Gift_GivenController = TextEditingController().obs;
  Rx<TextEditingController>  nonParticipantsController = TextEditingController().obs;
  Rx<TextEditingController>  Number_of_Orders_PlacedController = TextEditingController().obs;
  Rx<TextEditingController>  giftitemController = TextEditingController().obs;
  Rx<TextEditingController>  remarkController = TextEditingController().obs;

  RxString fld_p_image_path="".obs;
  RxString fld_t_image_path="".obs;
  Rx<TableMeetingsModel> meeting=TableMeetingsModel.fromJson({}).obs;
  Rx<meetingDetailResponse>data=meetingDetailResponse.fromJson({}).obs;
  List<String> giftOptions = [
    "Gift Purchased",
    "Purchased Locally",
    "Provided by Company"
  ];

  String selectedGift = "Gift Purchased"; // Default selection
  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    print(arguments);
    if(arguments!= null){
      meeting.value= TableMeetingsModel.fromJson(arguments['data']);
      Actual_AttendanceController.value.text=arguments['meetingAttendeesCount'].toString();
      nonParticipantsController.value.text=arguments["meeting_nonparticipants_count"].toString();
      CallGetdata();
    }
  }
  //final ImagePicker _picker = ImagePicker();

  Future<void> takePhoto(String imagetype ,BuildContext context) async {
    var result = await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return CameraPage(needSelfyMode: false,);
      },
    ));

      // final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (result["result"] != null) {
        try {
        File file = File(result["result"]);
        // final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

       // File file = File(photo.path);
        File processedFile = await ImageHelper.processImage(file, meeting.value, "Hotel Bill");
        if (imagetype == "p") {
          fld_p_image_path.value = processedFile.path;
        } else if (imagetype == "t") {
          fld_t_image_path.value = processedFile.path;
        }
      } catch (e) {
      AppUtils.showSnackbar(e.toString(), "Info");
      print("Error during image selection: $e"); //Proper logging for debugging and reporting
      // Handle errors appropriately, e.g., display an error message to the user.
    }
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
        if(value.data.length>0) {
          data.value = value;
          giftitemController.value.text = value.data.first.fldGiftItemGiven!;
          Total_Gift_GivenController.value.text = value.data.first.fldTotalGiftsGiven!.toString();
          nonParticipantsController.value.text = value.data.first.fldNonParticipant!.toString();
          Number_of_Orders_PlacedController.value.text = value.data.first.fldOrderPlaced.toString();
          selectedGift = value.data.first.fldGiftPurchased!;
          remarkController.value.text = value.data.first.fldRemark!.toString();
          fld_p_image_path.value = value.data.first.fldBillImg1Path!;
          fld_t_image_path.value = value.data.first.fldBillImg2Path!;
          Actual_AttendanceController.value.text=value.data.first.fldActualAttendance!;
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

      },
    );

  }
  validateAndProcess() async {

    if (Actual_AttendanceController.value.text != "" ) {
      if (nonParticipantsController.value.text != "" ) {
        if (selectedGift !="") {
          //if (giftitemController.value.toString() != "" ) {
            if (fld_p_image_path.value.toString() != "" ) {

          if (await AppUtils.checkInternetConnectivity()) {
            // Get.offNamed(Routes.HOMESCREEN);
            CallNoteAdd_update();
          } else {
            AppUtils.showSnackbar("Please check Internet Connection", "Info");
          }

      } else {
        AppUtils.showSnackbar("Please take a Bill Photo.", "Info");
        //Show error
      }
    } else {
      AppUtils.showSnackbar("Please enter gift option", "Info");
      //Show N
    }
        // }else{
        //   AppUtils.showSnackbar("Please enter a Gift item.", "Info");
        // }
      } else {
        AppUtils.showSnackbar("Please enter a Non Participant.", "Info");
        //Show error
      }
    } else {
      AppUtils.showSnackbar("Please enter a Attendee.", "Info");
      //Show N
    }
  }
  Future<void> CallNoteAdd_update() async {
    // AppUtils.alertWithProgressBar();

    isLoading.value= true;
    var requestBody = {
      'user_id': appStorage.loggedInUser.id,
      'meeting_id':meeting.value.fldMId,
      "fld_actual_attendence": Actual_AttendanceController.value.text.toString(),
      "fld_gift_item_given": giftitemController.value.text.toString().isNotEmpty?giftitemController.value.text.toString():"",
      "fld_total_gifts_given": Total_Gift_GivenController.value.text.toString(),
      "fld_non_participant":nonParticipantsController.value.text.toString(),
      "fld_order_placed":Number_of_Orders_PlacedController.value.text.toString().isNotEmpty?Number_of_Orders_PlacedController.value.text.toString():0,
      "fld_gift_purchased":selectedGift,
      "fld_remark":remarkController.value.text.toString(),
      "fld_lat": appStorage.lat.value,
      "fld_long": appStorage.long.value,
      "hotel_bill_image_1":await AppUtils.editImage(fld_p_image_path.value),
      "hotel_bill_image_2":fld_t_image_path.isNotEmpty?await AppUtils.editImage(fld_t_image_path.value):"",
      //"business_card_image":await AppUtils.editImage(fld_c_image_path.value),
    };
    print(requestBody);
    productServices.Add_meeting_info(body: requestBody).then((value) async {
      isLoading.value = false;
      if(value.success==true) {

       // changeMeetingStatus();
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