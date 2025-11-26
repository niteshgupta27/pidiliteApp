import 'package:pidilite/Utill/app_required.dart';
import 'package:pidilite/features/meetingDashboard/service/MeetingOptionService.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../Utill/Apputills.dart';
import '../../meeting/model/TableMeetingsModel.dart';
import '../model/progressModel.dart';

class MeetingOptionController extends GetxController {
  RxString appName="".obs;

  String TAG = "MeetingOptionController";
  final appStorage = Get.find<AppStorage>();
  RxBool isLoading = true.obs;
  var productServices = Get.find<MeetingOptionService>();
Rx<TableMeetingsModel> meeting=TableMeetingsModel.fromJson({}).obs;
Rx<progressModel>data=progressModel.fromJson({}).obs;
  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    print(arguments);
    if(arguments!= null){
     meeting.value= TableMeetingsModel.fromJson(arguments['data']);
      CallGetdata();
    }
    //CallGetdata();
    getversion();

  }
  void finshbutton(){
    if(data.value.meetingInfo==1){
    if(data.value.meetingPhoto==1) {
      if (data.value.meetingDetails == 1) {
        if (data.value.meetingAttendees == 1) {
          changeMeetingStatus();
        }
        else {
          AppUtils.showSnackbar("Please Check the Meeting Attendee data.", "Info");
        }
      } else {
        AppUtils.showSnackbar("Please Check the Meeting Detail data.", "Info");
      }
    }else {
      AppUtils.showSnackbar("Please Check the Meeting Photos data.", "Info");
    }
  }
    else {
      AppUtils.showSnackbar("Please Check the Meeting Info data.", "Info");
    }
  }
  Future<void> getversion() async {

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName.value = packageInfo.version;
  }
  Future<void> CallGetdata() async {
    if (await AppUtils.checkInternetConnectivity()) {
      progressCheckApi();

    }else {
      AppUtils.showSnackbar("Please check Internet Connection", "Info");
    }
  }
  void progressCheckApi() {
    // AppUtils.alertWithProgressBar();
    isLoading.value= true;

    var requestBody = {
      'user_id': appStorage.loggedInUser.id,
'meeting_id':meeting.value.fldMId
    };
    print(requestBody);
    productServices.gethomedata(body: requestBody).then((value) async {
      isLoading.value = false;
      if (value.success == true) {
        // tages.value =value.data.arrayData.tages;
data.value=value.data!;
        // productSlider.value=value.data.arrayData.productSlider;
        // cartSection.value = value.data.arrayData.cartSection;
        // boxSection.value = value.data.arrayData.boxSection;

        // appStorage.loggedInUser.data?.token = value.data;
        // appStorage.loggedInUserToken = value.data!;
        // appStorage.write(AppConstants.loginUserInformationToken, value.data!);
        // fetchUserInformation(token: value.data);
        // Get.toNamed(Routes.OTPSCREEN,arguments: {
        //   'phoneNumber': phonenumber,
        //   'Registration': value.Registration,
        // });

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
  Future<void> changeMeetingStatus() async {
    // AppUtils.alertWithProgressBar();

    isLoading.value= true;
    var requestBody = {
      'user_id': appStorage.loggedInUser.id,
      'meeting_id':meeting.value.fldMId,
      "mstatus": "3",

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