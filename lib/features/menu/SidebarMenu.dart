import '../../Utill/app_required.dart';
import 'dottedDivider.dart';

class SidebarMenu extends StatelessWidget {
  var appStorage=Get.find<AppStorage>();
  void initState() {
    // TODO: implement initState
   // super.initState();
     appStorage = Get.find<AppStorage>();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.drawer_background,
            ),
            child:  Container(
              height: 160,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Container(
                        height: 120,
                        width:MediaQuery.of(context).size.width,
                        //margin: const EdgeInsets.only(top: 20.0),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(Images.arabicFlag),

                          ),
                        ),
                      ),
                      // Text(
                      //   'pidilite',
                      //   style: TextStyle(
                      //     color: AppColors.primaryColor,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // Text(
                      //   'Growth With Goodness',
                      //   style: TextStyle(
                      //     color: AppColors.black,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ]),
                  ]),
            ),
          ),
          Expanded(

            child: ListView(
              children: [
                _buildMenuItem(Images.dashboard, 'Dashboard', 'dashboard'),
                const DottedDivider(
                  width: 1,
                  color: Colors.grey,
                  thickness: 1,
                  gap: 4,
                ),
                _buildMenuItem(Images.history, 'Meeting History', 'History'),
                const DottedDivider(
                  width: 1,
                  color: Colors.grey,
                  thickness: 1,
                  gap: 4,
                ),
                // _buildMenuItem(Images.account, 'Sync', 'accounts'),
                // _buildMenuItem(Images.notes, 'Change password', 'notes'),
                _buildMenuItem(Images.logout, 'Logout', 'logout', logout: true),
                const DottedDivider(
                  width: 1,
                  color: Colors.grey,
                  thickness: 1,
                  gap: 4,
                ),
                Spacer(flex: 9,)
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Text(
          //     'Version 1.0.0',
          //     style: TextStyle(
          //       color: AppColors.primaryColor,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String icon, String title, String route, {bool logout = false}) {
    return ListTile(
      leading:  Container(width: 20,child:  Image.asset(icon,color: AppColors.primaryColor,),),
      title: Text(title, style: TextStyle(fontSize: 16)),
      onTap: () {
        if (logout) {
          // Perform logout action
          Get.defaultDialog(
            title: "Logout",
            middleText: "Are you sure you want to logout?",
            textConfirm: "Yes",
            textCancel: "No",
            confirmTextColor: Colors.white,
            onConfirm: () {
              appStorage.resetStorage();
              Get.offAllNamed(Routes.LOGINSCREEN); // Navigate to login after logout
            },
          );
        } else {
          handleAction(route);
           // Navigate to the respective route
        }
      },
    );
  }
  void handleAction(String action) {
    switch (action) {
      case 'dashboard':
        print('Navigating to Dashboard');
        Get.toNamed(Routes.ProductsDashboard);
        break;
      case 'History':
        print('Opening Estimates');
        Get.toNamed(Routes.Hidtory);
        break;
      case 'accounts':
        print('Accessing Accounts');
       // Get.toNamed(Routes.Accounts);
        break;
      case 'notes':
        print('Logging out');
       // Get.toNamed(Routes.Notes);
        break;
      case 'reminders':
        print('Logging out');
        //Get.toNamed(Routes.Reminders);
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