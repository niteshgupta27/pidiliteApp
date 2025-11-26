import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../Utill/Apputills.dart';
import '../../../../Utill/app_storage.dart';
import '../../../Utill/app_required.dart';
import '../../../routes/app_pages.dart';
import '../../meeting/model/TableMeetingsModel.dart';
import '../services/Meeting_Historyservices.dart';


class Meeting_HistoryController extends GetxController {
  RxBool isLoading = true.obs;
  var productServices = Get.find<Meeting_Historyservices>();
  //var productSlider= <ProductSliderModel>[].obs ;
  //var cartSection= <CartSectionModel>[].obs ;
  //var bannerSlider= <BannerSliderModel>[].obs ;
 // var boxSection= <BoxSectionModel>[].obs ;
  var groupedMeetings = <String?, List<TableMeetingsModel>>{}.obs;

  var appStorage = Get.find<AppStorage>();
  late List<TableMeetingsModel> childes=[];
  final ScrollController scrollController = ScrollController();
  var sentCount = 0.obs;
  var remainingCount = 0.obs;
  String TAG = "ProductsDashboardController";

  RxBool isButtonPressed = false.obs;
  RxInt selected = 0.obs;
  RxString appName="".obs;
 // RxBool hasPermission = false.obs;
  @override
  void onInit() {
    super.onInit();
    CallGetdata();
    getversion();

  }
  Future<void> getversion() async {

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName.value = packageInfo.version;
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

    };
    productServices.gethomedata(body: requestBody).then((value) async {
      isLoading.value = false;
      if (value.status == true) {
        // tages.value =value.data.arrayData.tages;
        var grouped = groupBy(value.data, (TableMeetingsModel m) => m.fldMDate);

        // Update the RxMap
        groupedMeetings.value = grouped;
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

  String getOwnerName(TableMeetingsModel meetingModel) {
    try {


      if (meetingModel.dealers!.length > 1) {
        return "Multi Retailers";
      } else if (meetingModel.dealers!.length == 1) {
        // final jsonObject = meetingModel.dealers![0] as Map<String, dynamic>;
        return meetingModel.dealers![0].fldRname ?? "";
      } else {
        return "";
      }
    } catch (e) {
      print(e);
      return "";
    }
  }
}

