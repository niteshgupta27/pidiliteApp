
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

import '../../../Utill/Apputills.dart';
import '../../../Utill/app_required.dart';
import '../../../Utill/app_storage.dart';
import '../../meeting/model/TableMeetingsModel.dart';
import '../model/AdhesiveModel.dart';
import '../model/RoleModel.dart';
import '../model/Table_Attendee.dart';
import '../service/AttendeeService.dart';

class AddAttendee2Controller extends GetxController {
  String TAG = "LoginController";
  var productServices = Get.find<AttendeeService>();
  RxBool isLoading = false.obs;
  var appStorage = Get.find<AppStorage>();
  RxString appName = "".obs;
  Rx<TextEditingController>  Painter_NameController = TextEditingController().obs;
  Rx<TextEditingController>  Phone_NumberController = TextEditingController().obs;
  Rx<TextEditingController>  Pan_CardController = TextEditingController().obs;
  Rx<TextEditingController>  DobController = TextEditingController().obs;
  Rx<TextEditingController>  AgeController = TextEditingController().obs;
  Rx<TextEditingController>  QualificationController = TextEditingController().obs;
  Rx<TextEditingController>  ReasonController = TextEditingController().obs;

  Rx<TextEditingController>  teamSizeController = TextEditingController().obs;
  Rx<TextEditingController>  DealerCodeController = TextEditingController().obs;
  Rx<TextEditingController>  orderValueController = TextEditingController().obs;
  Rx<TextEditingController>  orderDeailController = TextEditingController().obs;
  Rx<TextEditingController>  GiftGivenController = TextEditingController().obs;
  Rx<TextEditingController>  remark1Controller = TextEditingController().obs;
  Rx<TextEditingController>  remark2Controller = TextEditingController().obs;
  Rx<TextEditingController>  remark3Controller = TextEditingController().obs;
  Rx<TextEditingController>  ConsumptionController = TextEditingController().obs;

  Rx<TextEditingController>  Reference1Controller = TextEditingController().obs;
  Rx<TextEditingController>  Reference2Controller = TextEditingController().obs;
  Rx<TextEditingController>  Reference3Controller = TextEditingController().obs;
  List<String> radiooptions=["Yes","No"];
  RxString smartphoneOption="No".obs;

  RxString participantOption="Yes".obs;
  RxString DownloadApp="Yes".obs;
  RxString PolisherApp="Yes".obs;
 // RxString Contractoroption="No".obs;
  RxString orderoption="No".obs;
  Rx<TableMeetingsModel> meeting = TableMeetingsModel
      .fromJson({})
      .obs;
  Rx<Dealer> selectedDealer=Dealer.fromJson({}).obs;
  RxList<Dealer> dealers=<Dealer>[].obs;
  RxList<AdhesiveModel> Adhesive=<AdhesiveModel>[].obs;
  Rx<AdhesiveModel> selectedAdhesive=AdhesiveModel.fromJson({}).obs;

  int  Attendee_id=0;
  String fld_attendance="0";
  RxList<RoleModel> rolluser=<RoleModel>[].obs;
  Rx<RoleModel> selectedRoll=RoleModel.fromJson({}).obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    print(arguments);
    Calladhesives();
    if (arguments != null) {
      meeting.value = TableMeetingsModel.fromJson(arguments['data']);
      dealers.value=meeting.value.dealers;
      //debugPrint(arguments['Attendees']);
      if (arguments['Attendees'] != null) {
        Table_Attendee data = arguments['Attendees'];
        Phone_NumberController.value.text = data.fldMobile;
        Painter_NameController.value.text=data.fldAttendeeName;
        Pan_CardController.value.text = data.fldPancard!;
        QualificationController.value.text = data.fldQualification!;
        ReasonController.value.text = data.fldNotDownloadReason!;
        teamSizeController.value.text = data.fldContractorTeamSize!;
        ConsumptionController.value.text = data.fldCompetitionPoints!;
        DobController.value.text = data.fldDob!;
        orderValueController.value.text = data.fldOrderPlaced;
        orderDeailController.value.text = data.fldOrderDetails!;
        GiftGivenController.value.text = data.fldGiftGiven;
        remark1Controller.value.text = data.fldRemark1!;
        remark2Controller.value.text = data.fldRemark2!;
        remark3Controller.value.text = data.fldRemark3!;
        Reference1Controller.value.text=data.fldRef1!;
        Reference2Controller.value.text=data.fldRef2!;
        Reference3Controller.value.text=data.fldRef3!;

        smartphoneOption.value=data.fldSmartphone=="1"?"Yes":"No";
        DownloadApp.value=data.fldAppDownloadNebula=="1"?"Yes":"No";
        PolisherApp.value=data.fldAppDownloadAttendee=="1"?"Yes":"No";
       // Contractoroption.value=data.fldContractor=="1"?"Yes":"No";
        orderoption.value=data.fldOrderPlaced=="1"?"Yes":"No";

        Attendee_id=data.fldAid;
        fld_attendance=data.fldAttendance.toString();
        print("jjjjjjjjjjj${meeting.value.toJson()}");
        print("jjjjjjjjjjj${data.fldDealerId}");

        if(data.fldDealerId.isNotEmpty) {
          selectedDealer.value = dealers.firstWhere((dealer) => dealer.fldDrid == int.parse(data.fldDealerId));
          DealerCodeController.value.text = selectedDealer.value.fldRcode!;
        }else{
          selectedDealer.value=dealers.first;
          DealerCodeController.value.text = selectedDealer.value.fldRcode!;

        }
        //CallGetdata();
      }
      else{
        selectedDealer.value=dealers.first;
        DealerCodeController.value.text = selectedDealer.value.fldRcode!;

      }
    }
    CallGetdata();
  }
  void calculateAge(String dob) {
    try {
      final date = DateFormat('dd/MM/yyyy').parse(dob);
      var age = DateTime.now().year - date.year;
      if (DateTime.now().month < date.month || (DateTime.now().month == date.month && DateTime.now().day < date.day)) {
        age--;
      }
      AgeController.value.text = age.toString();
    } catch (e) {
      print('Invalid date format');
    }
  }
  validateAndProcess() async {
    String regex = r'^[6-9]\d{9}$';


    if (Painter_NameController.value.text.trim().isEmpty) {
      AppUtils.showSnackbar("Please enter your name", "Info");
    } else if (Phone_NumberController.value.text.trim().isEmpty) {
      AppUtils.showSnackbar("Please enter mobile number", "Info");
    } else if (!RegExp(regex).hasMatch(Phone_NumberController.value.text)) {
      AppUtils.showSnackbar("Please enter valid mobile number", "Info");
    } else if (participantOption == "Yes" && DobController.value.text.toString().trim().isEmpty) {
      AppUtils.showSnackbar("Please enter Dob", "Info");
    }else if (participantOption == "Yes" && !isValidDate(DobController.value.text)) {
      AppUtils.showSnackbar("Invalid date or not before current date", "Info");
    }
    else if (smartphoneOption == "Yes" && DownloadApp == "No" && PolisherApp == "No" && ReasonController.value.text.isEmpty) {
      AppUtils.showSnackbar("Please enter Reason", "Info");
    } else if (participantOption == "Yes" && orderoption == "Yes" && orderValueController.value.text.isEmpty && orderDeailController.value.text.isEmpty) {
      AppUtils.showSnackbar("Please enter valid order details", "Info");
    }
    // else if (GiftGivenController.value.text.isEmpty) {
    //   AppUtils.showSnackbar("Please enter gift Given", "Info");
    // }
    else if (participantOption == "Yes" && teamSizeController.value.text.isEmpty) {
      AppUtils.showSnackbar("Please enter Team Size", "Info");
     } else if (participantOption == "Yes" && ConsumptionController.value.text.isEmpty) {
      AppUtils.showSnackbar("Please enter Consumption", "Info");
    }
    else if (selectedDealer.value.fldDrid==0) {
      AppUtils.showSnackbar("Please select dealer name", "Info");
    } else {
      if (await AppUtils.checkInternetConnectivity()) {
        // Get.offNamed(Routes.HOMESCREEN);
        CallNoteAdd_update();
      } else {
        AppUtils.showSnackbar("Please check Internet Connection", "Info");
      }
    }

  }
  bool isValidDate(String dateString) {
    // Define the date format
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    // Try to parse the date string
    try {
      final date = formatter.parse(dateString);

      // Get the current date without time
      final currentDate = DateTime.now().toLocal();
      final currentDateTime = DateTime(currentDate.year, currentDate.month, currentDate.day);

      // Check if the parsed date is before the current date
      return date.isBefore(currentDateTime);
    } catch (e) {
      // If parsing fails, the date is invalid
      return false;
    }
  }

  Future<void> Calladhesives() async {
    // AppUtils.alertWithProgressBar();

    isLoading.value= true;

    productServices.getadhesives(fld_uid:appStorage.loggedInUser.id).then((value) async {
      isLoading.value = false;
      if(value.success==true) {
        Adhesive.value=value.data;
      }else{
        AppUtils.showSnackbar(value.message.toString(),"Error");
      }
    }).catchError((err) {
      isLoading.value = false;
      AppUtils.showSnackbar(err.toString(),"server Error");
      //AppUtils.alert("Something went wrong", title: "Oops");
    });
  }
  Future<void> CallNoteAdd_update() async {
    // AppUtils.alertWithProgressBar();

    isLoading.value= true;
    var requestBody = {
      'user_id': appStorage.loggedInUser.id,
      'fld_meeting_id':meeting.value.fldMId,
      'fld_customer_id': meeting.value.fldCustomerId,
      'fld_dealer_id': selectedDealer.value.fldDrid,
      "fld_attendee_name": Painter_NameController.value.text,
      "fld_pancard":Pan_CardController.value.text,
      "fld_mobile":Phone_NumberController.value.text,
      "fld_dob":participantOption.value=="Yes"?DobController.value.text:"",
      "fld_age":participantOption.value=="Yes"?AgeController.value.text:"",
      "fld_qualification": participantOption.value=="Yes"?QualificationController.value.text:"",
      "fld_gift_given": GiftGivenController.value.text,
      "fld_contractor": 0,
      "fld_contractor_team_size":participantOption.value=="Yes"? teamSizeController.value.text:"",
      "fld_contractor_sites": "",
      "fld_smartphone":participantOption.value=="Yes"&& smartphoneOption.value=="Yes"?1:0,
      "fld_app_download_nebula":participantOption.value=="Yes"&&smartphoneOption.value=="Yes" && DownloadApp.value=="Yes"?1:0,
      "fld_app_download_attendee":participantOption.value=="Yes"&&smartphoneOption.value=="Yes" && DownloadApp.value=="No"&& PolisherApp.value=="Yes"?1:0,
      "fld_not_download_reason": participantOption.value=="Yes"&&smartphoneOption.value=="Yes" && DownloadApp.value=="No"&& PolisherApp.value=="No"?ReasonController.value.text:"",
      "fld_adhesive_consumption": participantOption.value=="Yes"?ConsumptionController.value.text:"",
      "fld_attendance":Attendee_id != 0?"1":fld_attendance,
      "fld_participant":participantOption.value=="Yes"?1:0,
      "fld_adhesive_brand":participantOption.value=="Yes"?selectedAdhesive.value.fldAdid:0,
      "fld_order_value":participantOption.value=="Yes"&& orderoption.value=="Yes" ? orderValueController.value.text:"",
      "fld_order_details": participantOption.value=="Yes"&&orderoption.value=="Yes"? orderDeailController.value.text:"",
      "fld_order_placed": participantOption.value=="Yes"&&orderoption.value=="Yes"?1:0,
      "fld_ref_1": Reference1Controller.value.text,
      "fld_ref_2":Reference2Controller.value.text,
      "fld_ref_3": Reference3Controller.value.text,
      "fld_remark_1":remark1Controller.value.text,
      "fld_remark_2": remark2Controller.value.text,
      "fld_remark_3":remark3Controller.value.text,
      "fld_competition_points": "",
      "image": "",
      "fld_lat": appStorage.lat.value,
      "fld_long": appStorage.long.value,
      if (Attendee_id != 0)
        'attendee_id':Attendee_id,
      "fld_staff_id":participantOption.value=="No"?selectedRoll.value.fldSid:0
    };

    print(requestBody);
    productServices.Addattendee(body: requestBody,modify:Attendee_id != 0).then((value) async {
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
  void getstaffvalue() {
    // AppUtils.alertWithProgressBar();
    isLoading.value= true;

    productServices.getstaff().then((value) async {
      isLoading.value = false;
      if (value.success == true) {
        rolluser.value=value.data;
        selectedRoll.value=rolluser.first;
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
  Future<void> CallGetdata() async {
    if (await AppUtils.checkInternetConnectivity()) {
      getstaffvalue();

    }else {
      AppUtils.showSnackbar("Please check Internet Connection", "Info");
    }
  }
}