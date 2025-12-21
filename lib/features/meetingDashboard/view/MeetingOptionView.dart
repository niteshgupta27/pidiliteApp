import 'package:permission_handler/permission_handler.dart';

import '../../../Utill/app_required.dart';
import '../../qr/QrCodeScanner.dart';
import '../controller/MeetingOptionController.dart';

class MeetingOptionView extends GetView<MeetingOptionController> {
  const MeetingOptionView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.transparent, // Make AppBar transparent
          elevation: 5,
          // leading: IconButton(
          //   icon: Icon(Icons.menu, color: Colors.white),
          //   onPressed: () {
          //     // Open drawer or add functionality
          //   },
          // ),
          title: Text(
            "${controller.meeting.value.fldMTypeName!} ${controller.appStorage.loggedInUser.username}",
            style: Styles.PageTitle,
          ),
          centerTitle: false,
          iconTheme: IconThemeData(size: 37, color: AppColors.whites),
          actions: [
            IconButton(
              icon: Icon(Icons.qr_code, color: AppColors.whites),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => QrCodeScannerPage(
                      meetingId: controller.meeting.value.fldMId!,
                      Userid: controller.appStorage.loggedInUser.id!,
                    ),
                  ),
                );
                // Handle notifications action
              },
            ),
          ],
        ),

        body: controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  // Carousel
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      controller.meeting.value.fldLocation!,
                      style: Styles.headerTitel,
                    ),
                  ),

                  SizedBox(height: 10),
                  // GridView for options
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      padding: const EdgeInsets.all(10),
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1.2,
                      children: [
                        // _buildGridItem(Images.estimates, "Estimates", Colors.pink.shade50),
                        // _buildGridItem(Images.account, "Accounts", Colors.blue.shade50),
                        _buildGridItem(
                          Images.Meeting_Start,
                          "Meeting Start",
                          Colors.yellow.shade50,
                        ),
                        if (controller.data.value.meetingInfo == 1 ||
                            controller.data.value.meetingPhoto == 1 ||
                            controller.data.value.meetingDetails == 1 ||
                            controller.data.value.meetingAttendees == 1)
                          _buildGridItem(
                            Images.Meeting_Details,
                            "Meeting Details",
                            Colors.green.shade50,
                          ),
                        if (controller.data.value.meetingInfo == 1 ||
                            controller.data.value.meetingPhoto == 1 ||
                            controller.data.value.meetingDetails == 1 ||
                            controller.data.value.meetingAttendees == 1)
                          _buildGridItem(
                            Images.Meeting_Photos,
                            "Meeting Photos",
                            Colors.purple.shade50,
                          ),
                        if (controller.data.value.meetingInfo == 1 ||
                            controller.data.value.meetingPhoto == 1 ||
                            controller.data.value.meetingDetails == 1 ||
                            controller.data.value.meetingAttendees == 1)
                          _buildGridItem(
                            Images.Attendee,
                            "Attendee List",
                            Colors.orange.shade50,
                          ),
                      ],
                    ),
                  ),
                  if (controller.data.value.meetingFinish == 1)
                   Center(child:  SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ), // Set the radius here
                          ),
                        ),
                        onPressed: () {
                          controller.finshbutton();
                        },
                        child: Text(
                          "Finish Meeting".tr,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: AppColors.whites),
                        ),
                      ),
                    ),),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '${controller.data.value.messageTextDetail.isNotEmpty ? "---${controller.data.value.messageTextDetail}--" : ""}\n${controller.data.value.messageTextAttendees.isNotEmpty ? "---${controller.data.value.messageTextAttendees}---\n" : ""}${controller.data.value.messageTextPhoto.isNotEmpty ? "---${controller.data.value.messageTextPhoto}---" : ""}',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  // Footer
                  const SizedBox(height: Dimensions.x16),

                  // Center(child: Text(
                  //       "${AppConstants.tollfree}",
                  //       textAlign: TextAlign.center,
                  //       style: Styles.inriaSansBold.copyWith(
                  //         fontSize: Dimensions.fontSizeLarge,
                  //         color: AppColors.primaryColor,
                  //         fontWeight: FontWeight.w500,
                  //       ),),),
                  //     const SizedBox(height: Dimensions.x16),

                  // Terms & Conditions
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Image.asset(Images.poweredby),
                    ),
                  ),
                  const SizedBox(height: Dimensions.x0_8),

                  Center(
                    child: Text(
                      "App Version ${controller.appName.value}",
                      textAlign: TextAlign.center,
                      style: Styles.inriaSansBold.copyWith(
                        fontSize: Dimensions.fontSizeLarge,
                        color: const Color(0xFF626262),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
      );
    });
  }

  // Method to build each grid item
  Widget _buildGridItem(String icon, String label, Color color) {
    return InkWell(
      onTap: () {
        handlePermission(Permission.camera, label.trim().toLowerCase());
        //handleAction(label.trim().toLowerCase());
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(child: Image.asset(icon), width: 40),
            //Icon(Images.account, color: AppColors.primaryColor, size: 40),
            SizedBox(height: 8),
            Text(
              label.tr,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> handlePermission(Permission permission, event) async {
    final status = await permission.status;

    if (status.isGranted) {
      debugPrint("✅ Permission granted");
      handleAction(event);
      // You can now perform the functionality requiring the permission.
    } else if (status.isDenied) {
      final result = await permission.request();
      if (result.isGranted) {
        handlePermission(Permission.camera, event.trim().toLowerCase());
        debugPrint("✅ Permission granted after request");
      } else if (result.isPermanentlyDenied) {
        Get.offNamed(Routes.Permission);
      }
    }
  }

  Future<void> handleAction(String action) async {
    switch (action) {
      case 'meeting start':
        print('Navigating to Dashboard');
        final result = await Get.toNamed(
          Routes.MeetingStart,
          arguments: {"data": controller.meeting.value.toJson()},
        );
        print("Result received from AddNotes: $result");
        if (result != null) {
          controller.CallGetdata();
        }
        break;
      case 'meeting photos':
        final result = await Get.toNamed(
          Routes.MeetingPhotos,
          arguments: {"data": controller.meeting.value.toJson()},
        );
        print("Result received from AddNotes: $result");
        if (result != null) {
          controller.CallGetdata();
        }
        print('Opening Estimates');
        // Get.toNamed(Routes.Estimates);
        break;
      case 'meeting details':
        print('meeting details');
        final result = await Get.toNamed(
          Routes.MeetingDetail,
          arguments: {
            "data": controller.meeting.value.toJson(),
            "meetingAttendeesCount":
                controller.data.value.meetingAttendeesCount,
            "meeting_nonparticipants_count":
                controller.data.value.meeting_nonparticipants_count,
          },
        );
        print("Result received from AddNotes: $result");
        if (result != null) {
          controller.CallGetdata();
        }
        break;
      case 'attendee list':
        print('Logging out');
        Get.toNamed(
          Routes.Attendee,
          arguments: {
            "data": controller.meeting.value.toJson(),
            "ShowAttendeesnote":
                controller.data.value.messageTextAttendees.isNotEmpty,
          },
        );
        break;
      case 'reminders':
        print('Logging out');
        // Get.toNamed(Routes.Reminders);
        break;
      case 'history':
        print('Logging out');
        // Get.toNamed(Routes.History);
        break;
      case 'projects':
        print('Logging out');
        // Get.toNamed(Routes.Projects);
        break;
      case 'services':
        print('Logging out');
        // Get.toNamed(Routes.Services);
        break;
      case 'password':
        print('Logging out');
        // Get.toNamed(Routes.Password);
        break;
      default:
        print('Unknown action: $action');
    }
  }
}
