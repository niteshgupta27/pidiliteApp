

import 'package:pidilite/features/attendee/binding/AttendeeBinding.dart';
import 'package:pidilite/features/attendee/view/AddAttendee2View.dart';
import 'package:pidilite/features/attendee/view/AddAttendeeView.dart';
import 'package:pidilite/features/attendee/view/AttendeeView.dart';
import 'package:pidilite/features/history/bindings/MeetingHistoryBindings.dart';
import 'package:pidilite/features/history/view/Meeting_HistoryView.dart';

import '../Utill/app_required.dart';

import '../features/Detail/binding/MeetingDetailBinding.dart';
import '../features/Detail/view/MeetingDetailView.dart';
import '../features/Photos/binding/MeetingPhotosBinding.dart';
import '../features/Photos/view/AddMeetingPhotosView.dart';
import '../features/Photos/view/MeetingPhotosList.dart';
import '../features/Start/binding/MeetingStartBinding.dart';
import '../features/Start/view/MeetingStartView.dart';
import '../features/attendee/view/AddAttendee3View.dart';
import '../features/auth/Login/view/login_view.dart';
import '../features/auth/bindings/auth_bindings.dart';
import '../features/invite/binding/InviteBinding.dart';
import '../features/invite/view/InviteView.dart';
import '../features/meeting/bindings/MeetingBindings.dart';
import '../features/meeting/view/Meeting_DashboardView.dart';
import '../features/meetingDashboard/binding/MeetingOptionBinding.dart';
import '../features/meetingDashboard/view/MeetingOptionView.dart';
import '../features/permission/binding/PermissionBindings.dart';
import '../features/permission/view/PermissionDeniedPage.dart';
import '../features/splash/bindings/SplashBindings.dart';
import '../features/splash/view/SplashView.dart';
part 'package:pidilite/routes/app_routes.dart';





class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [


    GetPage(
        name: _Paths.SPLASH,
        page: () =>  SplashView(),
        binding: SplashBindings()
    ),

    GetPage(
        name: _Paths.LOGINSCREEN,
        page: () => const LoginView(),
        binding: AuthBindings()
    ),
    GetPage(
        name: _Paths.MeetingPhotos,
        page: () =>  MeetingPhotosList(),
        binding: MeetingPhotosBinding()
    ),
    GetPage(
        name: _Paths.MeetingStart,
        page: () =>  MeetingStartView(),
        binding: MeetingStartBinding()
    ),
    GetPage(
      name: _Paths.Meetingoption,
      page: () => MeetingOptionView(),
      binding: MeetingOptionBinding(),
    ),
    GetPage(
      name: _Paths.ProductsDashboard,
      page: () =>  Meeting_DashboardView(),
      binding: MeetingBindings(),
    ),
    GetPage(
      name: _Paths.Permission,
      page: () =>  PermissionDeniedPage(),
      binding: PermissionBindings(),
    ),
    GetPage(
      name: _Paths.AddmeetingPhotos,
      page: () => AddMeetingPhotosView(),
      binding: MeetingPhotosBinding(),
    ),
    GetPage(
      name: _Paths.MeetingDetail,
      page: () =>  MeetingDetailView(),
      binding: MeetingDetailBinding(),
    ),
    GetPage(
      name: _Paths.Attendee,
      page: () =>  AttendeeView(),
      binding: AttendeeBinding(),
    ),
    GetPage(
      name: _Paths.AddAttendee,
      page: () =>  AddAttendeeView(),
      binding: AttendeeBinding(),
    ),
    GetPage(
      name: _Paths.AddAttendee2,
      page: () =>  AddAttendee2View(),
      binding: AttendeeBinding(),
    ),
    GetPage(
      name: _Paths.AddAttendee3,
      page: () =>  AddAttendee3View(),
      binding: AttendeeBinding(),
    ),
    GetPage(
      name: _Paths.Hidtory,
      page: () =>  Meeting_HistoryView(),
      binding: MeetingHistoryBindings(),
    ),
    GetPage(
        name: _Paths.inviteSCREEN,
        page: () =>  InviteView(),
        binding: InviteBindings()
    ),
    // // GetPage(
    // //   name: _Paths.Profile,
    // //   page: () => ProfileView(),
    // //   binding: AuthBindings(),
    // // ),
    // GetPage(
    //   name: _Paths.Address,
    //   page: () => AddressView(),
    //   binding: AuthBindings(),
    // ),
    // GetPage(
    //
    //   name: _Paths.Wallet,
    //   page: () => WalletView(),
    //   binding: AuthBindings(),
    // ),
    // GetPage(
    //   name: _Paths.Profile,
    //   page: () => const ProfileView(),
    //   binding: ProfileBindings(),
    // ),
  ];

}