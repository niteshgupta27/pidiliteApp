import 'package:permission_handler/permission_handler.dart';

import '../../../Utill/AppConstants.dart';
import '../../../Utill/Images.dart';
import '../../../Utill/app_colors.dart';
import '../../../Utill/app_required.dart' hide AppColors;
import '../controller/PermissionController.dart';

class PermissionDeniedPage extends GetView<PermissionController> {
  //final PermissionController controller = Get.find<PermissionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Logo Container
              Container(
                width: double.infinity,
                height: 190,
              //  color: Colors.blue.shade800,
                alignment: Alignment.center,
                child: Image.asset(
                  Images.arabicFlag, // Ensure the image is in your assets directory
                  fit: BoxFit.contain,
                ),
              ),
               Text(
                controller.appStorage.loggedInUser.username!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.sblue,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Permissions Required\nFor ${AppConstants.appName} App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Permission Heading

              const SizedBox(height: 20),
              Obx(() => _buildPermissionsCard(controller)),
              const SizedBox(height: 30),
              _buildAllowButton(controller),
              const SizedBox(height: 20),

              // Logout Button
              SizedBox(
                width: 120,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    controller.appStorage.resetStorage();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildPermissionsCard(PermissionController controller) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Column(
        children: [
          // _buildPermissionTile(
          //   controller: controller,
          //   permission: Permission.contacts,
          //   icon: Icons.notifications_none,
          //   title: 'Contact',
          //   subtitle: "",
          // ),
         // const Divider(height: 1, color: Colors.black12),
          _buildPermissionTile(
            controller: controller,
            permission: Permission.microphone,
            icon: Icons.mic_none,
            title: 'Microphone',
            subtitle: "",
           // statusText: 'Required',
          ),
          const Divider(height: 1, color: Colors.black12),
          _buildPermissionTile(
            controller: controller,
            permission: Permission.location,
            icon: Icons.location_on,
            title: 'Location',
            subtitle: "",
          ),
          const Divider(height: 1, color: Colors.black12),
          _buildPermissionTile(
            controller: controller,
            permission: Permission.phone,
            icon: Icons.call,
            title: 'Phone State',
            subtitle: "",
          ),
          const Divider(height: 1, color: Colors.black12),
          _buildPermissionTile(
            controller: controller,
            permission: Permission.camera,
            icon: Icons.camera,
            title: 'Camera',
            subtitle: "",
          ),
          const Divider(height: 1, color: Colors.black12),
          _buildPermissionTile(
            controller: controller,
            permission: Permission.photos,
            icon: Icons.photo,
            title: 'Photos',
            subtitle: "",
          ),
          // if(!controller.isFetchingCallLogs)
          //   Column(children: [
          //     const Divider(height: 1, color: Colors.black12),
          //     _buildCalllogPermissionTile(
          //       controller: controller,
          //       icon: Icons.photo,
          //       title: 'Call Log',
          //       subtitle: "",
          //     ),
          //   ],)
        ],
      ),
    );
  }

  Widget _buildPermissionTile({
    required PermissionController controller,
    required Permission permission,
    required IconData icon,
    required String title,
    required String subtitle,
    String? statusText,
  }) {
    final bool isAllowed = controller.isPermissionAllowed(permission);
    final String buttonText = controller.getButtonText(permission);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.black54),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    if (statusText != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: Colors.red[100], borderRadius: BorderRadius.circular(12)),
                          child: Text(statusText, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red[700])),
                        ),
                      ),
                  ],
                ),
                //const SizedBox(height: 5),
               // Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.black54)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: isAllowed ? null : () => controller.requestPermission(permission),
              style: ElevatedButton.styleFrom(
                backgroundColor: isAllowed ? Colors.blue[700] : Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                side: isAllowed ? BorderSide.none : const BorderSide(color: Colors.black12),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  color: isAllowed ? Colors.white : Colors.blue[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildCalllogPermissionTile({
    required PermissionController controller,

    required IconData icon,
    required String title,
    required String subtitle,
    String? statusText,
  }) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.black54),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    if (statusText != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: Colors.red[100], borderRadius: BorderRadius.circular(12)),
                          child: Text(statusText, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red[700])),
                        ),
                      ),
                  ],
                ),
                //const SizedBox(height: 5),
                // Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.black54)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: controller.isFetchingCallLogs ? null : () => controller.openSettingspage(),
              style: ElevatedButton.styleFrom(
                backgroundColor: controller.isFetchingCallLogs ? Colors.blue[700] : Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                side: controller.isFetchingCallLogs ? BorderSide.none : const BorderSide(color: Colors.black12),
              ),
              child: Text(
                controller.isFetchingCallLogs?"Allowed":"Allow",
                style: TextStyle(
                  color: controller.isFetchingCallLogs ? Colors.white : Colors.blue[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllowButton(PermissionController controller) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: controller.requestAllPermissions,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.sblue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: const Text('Allow All and Continue', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
  // Observe app lifecycle
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.) {
  //     Get.offNamed(Routes.ProductsDashboard); // Recheck permission when returning to the app
  //   }
  // }
}