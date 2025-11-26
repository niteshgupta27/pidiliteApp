import '../../../Utill/Apputills.dart';
import '../../../Utill/app_dateformatters.dart';
import '../../../Utill/app_required.dart';
import '../../meeting/model/TableMeetingsModel.dart';
import '../model/Table_Attendee.dart';
import '../service/AttendeeService.dart';
import '../widgets/LiveView.dart';
import '../widgets/PendingView.dart';

class AttendeeController extends GetxController {
  String TAG = "AttendeeController";
  var productServices = Get.find<AttendeeService>();
  RxBool isLoading = false.obs;
  var appStorage = Get.find<AppStorage>();
  RxString appName = "".obs;
  PageController pageController = PageController(initialPage: 1);
  List<Widget> pages = [PendingView(), LiveView()];
  var selectedIndex = 0.obs;
  Rx<TableMeetingsModel> meeting = TableMeetingsModel.fromJson({}).obs;
  RxList<Table_Attendee> live = <Table_Attendee>[].obs;
  RxList<Table_Attendee> panddingList = <Table_Attendee>[].obs;
  RxBool ShowAttendeesnote = false.obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    print(arguments);
    if (arguments != null) {
      meeting.value = TableMeetingsModel.fromJson(arguments['data']);
      CallGetdata();
      ShowAttendeesnote.value = arguments['ShowAttendeesnote'];
      print(arguments['ShowAttendeesnote']);
    }
  }

  Future<void> CallGetdata() async {
    if (await AppUtils.checkInternetConnectivity()) {
      HomeApi();
    } else {
      AppUtils.showSnackbar("Please check Internet Connection", "Info");
    }
  }

  void HomeApi() {
    // AppUtils.alertWithProgressBar();
    isLoading.value = true;

    var requestBody = {
      'user_id': appStorage.loggedInUser.id,
      'meeting_id': meeting.value.fldMId,
    };
    productServices
        .gethomedata(body: requestBody)
        .then((value) async {
          isLoading.value = false;
          if (value.success == true) {
            // data.value=value;
            panddingList.value = value.data
                .where(
                  (data) => data.fldAttendance == 1 && data.fldInvites == 1,
                )
                .toList();
            print("panddingList${panddingList.value.length}");
            live.value = value.data
                .where(
                  (data) => data.fldAttendance != 1 || data.fldInvites != 1,
                )
                .toList();
            print("live${live.value.length}");
          } else {
            // Get.back();

            AppUtils.showSnackbar(value.message.toString(), "Info");
          }
        })
        .catchError((err) {
          // Get.back();
          isLoading.value = false;
          AppUtils.showSnackbar("Something went wrong", "Oops");
          //AppUtils.alert("Something went wrong", title: "Oops");
        });
  }

  void attendeeRefesh() {
    // AppUtils.alertWithProgressBar();
    isLoading.value = true;
    String current = DateConverterHelper.estimatedDate(DateTime.now());
    productServices
        .getmisscall(cureentDate: current)
        .then((value) async {
          isLoading.value = false;
          if (value.success == true) {
            // data.value=value;
            HomeApi();
          } else {
            // Get.back();

            AppUtils.showSnackbar(value.message.toString(), "Info");
          }
        })
        .catchError((err) {
          // Get.back();
          isLoading.value = false;
          AppUtils.showSnackbar("Something went wrong", "Oops");
          //AppUtils.alert("Something went wrong", title: "Oops");
        });
  }

  Future<void> addAttendee() async {
    //if(meeting.value.fldCustomerId=="2") {
    final result = await Get.toNamed(
      Routes.AddAttendee,
      arguments: {"data": meeting.value.toJson()},
    );
    if (result != null) {
      CallGetdata();
    }
    //}
    //     else if(meeting.value.fldCustomerId=="2") {
    //   final result = await Get.toNamed(Routes.AddAttendee2, arguments: {"data": meeting.value.toJson(),});
    //   if (result != null) {
    //     CallGetdata();
    //   }}
    // else if(meeting.value.fldCustomerId=="3") {
    //   final result = await Get.toNamed(Routes.AddAttendee3, arguments: {"data": meeting.value.toJson(),});
    //   if (result != null) {
    //     CallGetdata();
    //   }}
  }

  Future<void> editAttendee(Table_Attendee data) async {
    // if(meeting.value.fldCustomerId=="1") {
    final result = await Get.toNamed(
      Routes.AddAttendee,
      arguments: {"data": meeting.value.toJson(), "Attendees": data},
    );
    if (result != null) {
      CallGetdata();
    }
    //  }
    // else if(meeting.value.fldCustomerId=="2") {
    //   final result = await Get.toNamed(Routes.AddAttendee2, arguments: {"data": meeting.value.toJson(), "Attendees": data});
    //   if (result != null) {
    //     CallGetdata();
    //   }
    // }
    // else if(meeting.value.fldCustomerId=="3") {
    //   final result = await Get.toNamed(Routes.AddAttendee3, arguments: {"data": meeting.value.toJson(), "Attendees": data});
    //   if (result != null) {
    //     CallGetdata();
    //   }
    // }
  }

  void onButtonPressed(int index) {
    selectedIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
