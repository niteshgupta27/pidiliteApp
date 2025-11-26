
import 'package:call_e_log/call_log.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../Utill/Apputills.dart';
import '../../../Utill/app_dateformatters.dart';
import '../../../Utill/app_required.dart';
import '../../../Utill/app_storage.dart';
import '../../../model/CallLogModel.dart';
import '../InviteesModal.dart';
import '../service/InviteService.dart';
import '../widgets/CallView.dart';
import '../widgets/Follow.dart';

class InviteController extends GetxController {

  static const platform = MethodChannel('com.nebula.pidilite/call');
  RxBool isLoading = true.obs;
  var appStorage = Get.find<AppStorage>();
  var productServices = Get.find<InviteServices>();

  String TAG = "InviteController";
  RxString callState = 'Unknown'.obs;
  RxString phoneNumber = ''.obs;
  RxInt callDuration = 0.obs;
  PageController pageController = PageController(initialPage: 1);
  var selectedIndex = 0.obs;
  var followlist = <Datum>[].obs;
  RxList<Datum> panddingList = <Datum>[].obs;
  List<Widget> pages = [
     CallView(),
    const FollowView(),
  ];
  late List<Datum> childes=[];

  var arguments = Get.arguments;
  var section_id = 0;

  @override
  void onInit() {
    super.onInit();
    if (arguments["meeting_id"] != null) {

      section_id = arguments["meeting_id"];
     // BrandName= RxString(arguments['brand_name']);
      print(arguments);
    }
    CallGetdata();
  }
  void onButtonPressed(int index) {
    selectedIndex.value = index;
    pageController.animateToPage(index, duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut
    );
  }
  Future startAnimation() async {
    startListeningForCallState();
  }
  Future<void> CallGetdata() async {
    if (await AppUtils.checkInternetConnectivity()) {
      HomeApi();

    }else {
      AppUtils.showSnackbar("Please check Internet connection", "Info");
    }
  }
  void HomeApi() {
    // AppUtils.alertWithProgressBar();
    isLoading.value= true;

    var requestBody = {
      'user_id': appStorage.loggedInUser.id,
'meeting_id':section_id
    };
    print(requestBody);
    productServices.getinvite(body: requestBody).then((value) async {

      isLoading.value = false;
      if (value.success == true) {

        childes=value.data!;
        print(childes);
       // for (int i = 0; i < 20; i++) {
          panddingList.value=childes.where((data) => data.fld_dialed == "0").toList();

          followlist.value = childes.where((data) => data.fld_dialed == "1").toList();
       // }
        print(panddingList);
        print(followlist);
        saveCallLogHistory();
      } else {
        // Get.back();

        AppUtils.showSnackbar(value.message.toString(),  "Info");
      }
    }).catchError((err) {
      // Get.back();
      print(err);
      isLoading.value = false;
      AppUtils.showSnackbar("Something went wrong","Oops");
      //AppUtils.alert("Something went wrong", title: "Oops");
    });
  }
  String getCallTypeString(String type) {
    print("call type $type");
    switch (type) {
      case "1":
        return "Incoming";
      case "2":
        return "Outgoing";
      case "3":
        return "Missed";
      case "4":
        return "Voicemail";
      case "5":
        return "Rejected";
      case "6":
        return "Blocked";
      case "7":
        return "Answered Externally";
      default:
        return "Unknown";
    }
  }
  void updatecallDetailApi(fld_number,fld_status,fld_calltime,fld_duration) {
    // AppUtils.alertWithProgressBar();
    isLoading.value= true;
    print("updatecallDetailApi");
    print(getCallTypeString(fld_status));
    print(DateConverterHelper.formatMilliseconds(int.parse(fld_calltime)));

    var requestBody = {

      "fld_mid" :section_id,
      "fld_uid": appStorage.loggedInUser.id,
      "fld_number": fld_number,
      "fld_status": getCallTypeString(fld_status),
      "fld_calltime": DateConverterHelper.formatMilliseconds(int.parse(fld_calltime)),
      "fld_duration": AppUtils.formatDuration(int.parse(fld_duration))
    };
    print(requestBody);
    productServices.SendcallDetail(body: requestBody).then((value) async {

      isLoading.value = false;
      if (value.success == true) {
        appStorage.updateLastTime(section_id,int.parse(fld_calltime));
await appStorage.write(
    AppConstants.lastUpdate, appStorage.lastTimeArray);
        HomeApi();
      } else {
        // Get.back();

        AppUtils.showSnackbar(value.message.toString(),  "Info");
      }
    }).catchError((err) {
      // Get.back();
      print(err);
      isLoading.value = false;
      AppUtils.showSnackbar("Something went wrong","Oops");
      //AppUtils.alert("Something went wrong", title: "Oops");
    });
  }

  Future<void> startListeningForCallState() async {
    try {
      platform.setMethodCallHandler((call) async {
        if (call.method == 'callStateChanged') {
          final String state = call.arguments['state'];
          final String number = call.arguments['number'] ?? '';
          final int duration = call.arguments['duration'] ?? 0;
print("callState.value = $state");
          print("phoneNumber.value = $number");
          print("callDuration.value = $duration");
          callState.value = state;
          phoneNumber.value = number;
          callDuration.value = 0;

          if (state == 'Connected') {
            print('Call connected to: $number');
          } else if (state == 'Ended') {
            print('Call ended. Duration: $duration seconds');

          }else if (state == 'Calllog') {
            print(state);
            callState.value = state;
            phoneNumber.value = number;
            callDuration.value = duration;
            if(duration!=0)
              for (var child in childes) {
                if(child.fldNumber==number)
                updatecallDetailApi(number, call.arguments['type'] ?? 0, call.arguments['Date'] ?? "", duration.toString());
              }
          }
        }
      });
      await platform.invokeMethod('startListening');
    } on PlatformException catch (e) {
      print("Failed to listen for call state: '${e.message}'.");
    }
  }
Future<void> saveCallLogHistory() async {
  // GET WHOLE CALL LOG
 // Iterable<CallLogEntry> entries = await CallLog.get();
  var now = DateTime.now();
  int to = now.millisecondsSinceEpoch;

  for (var child in childes) {
    Iterable<CallLogEntry> entries = await CallLog.query(
      dateFrom: appStorage.getLastTime(section_id),
      dateTo: to,
      durationFrom: 1,
      //durationTo: 60,
      //name: 'John Doe',
      number: child.fldNumber,
      //type: CallType.incoming,
    );

    for (var child in entries) {
      //print("child ${child.callType}");
      CallLogModel temp= CallLogModel( fldMid: section_id, fldUid: appStorage.loggedInUser.id, fldNumber: child.number, fldStatus: child.callType.toString(), fldCalltime: DateConverterHelper.formatMilliseconds(child.timestamp!), fldDuration: AppUtils.formatDuration(child.duration!),);
      appStorage.CalllogArray.add(temp);

    }
print(appStorage.CalllogArray.length);

    }
  appStorage.updateLastTime(section_id,to);
  await appStorage.write(
      AppConstants.callLogList, appStorage.CalllogArray);
  await appStorage.write(
      AppConstants.lastUpdate, appStorage.lastTimeArray);
  }
}

class CallService {

  static const platform = MethodChannel('com.nebula.pidilite/call');

   static makeDirectCall(String phoneNumber) async {
      try {
        await platform.invokeMethod('makeCall', {"number": phoneNumber});
      } on PlatformException catch (e) {
        print("Failed to make call: '${e.message}'.");
      }
    }
    // final Uri launchUri = Uri(
    //   scheme: 'tel',
    //   path: phoneNumber,
    // );
    // await launchUrl(launchUri);

}
// class CallStateListener {
//   static const platform = MethodChannel('com.nebula.pidilite/call');
//
//   static Future<String?> listenForCallState() async {
//     try {
//       final String result = await platform.invokeMethod('startListening');
//       print("===$result");
//       return result;
//     } on PlatformException catch (e) {
//       print("Failed to get call state: '${e.message}'.");
//       return null;
//     }
//   }
// }