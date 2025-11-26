
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';


import '../../../../Utill/AppConstants.dart';
import '../../../../Utill/Apputills.dart';
import '../../../../Utill/app_storage.dart';
import '../../../../routes/app_pages.dart';
import '../../services/auth_services.dart';

class LoginController extends GetxController {
  String TAG = "LoginController";
  var loginServices = Get.find<AuthServices>();
  RxBool isLoading = false.obs;
  var appStorage = Get.find<AppStorage>();
  RxString appName="".obs;
  @override
  void onInit() {
    super.onInit();
    getversion();
  }
  Future<void> getversion() async {

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName.value = packageInfo.version;

  }
  validateAndProcess(username,password) async {
    print(username);
    if (username != "" ) {
      if (password != "" ) {
      if (await AppUtils.checkInternetConnectivity()) {
      login(username,password);
    }else {
        AppUtils.showSnackbar("Please check Internet Connection", "Info");
      }
      } else {
        AppUtils.showSnackbar("Please enter a valid password.", "Info");
        //Show error
      }
    } else {
      AppUtils.showSnackbar("Please enter a valid username.", "Info");
      //Show error
    }
  }
  void login(username,password) {
   // AppUtils.alertWithProgressBar();
    isLoading.value= true;
    var requestBody = {
      'username': username,
      'password': password,
    };

    loginServices.authenticate(body: requestBody).then((value) async {
      isLoading.value = false;
      if(value.success==true){
      appStorage.loggedInUser = value.data;
      appStorage.loggedInUserToken =value.token;
      await appStorage.write(AppConstants.loginUserInformationToken, value.token);
      await appStorage.write(
          AppConstants.loginUserInformation, appStorage.loggedInUser);

      Get.offNamed(Routes.ProductsDashboard);
      } else {
        // Get.back();

        AppUtils.showSnackbar(value.message.toString(),  "Info");
      }
        }).catchError((err) {
      isLoading.value = false;
      AppUtils.showSnackbar(err.toString(),"Oops");
      //AppUtils.alert("Something went wrong", title: "Oops");
    });
  }

}