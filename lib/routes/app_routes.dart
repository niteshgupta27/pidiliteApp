part of 'app_pages.dart';


abstract class Routes {
  Routes._();

  static const SPLASH = _Paths.SPLASH;
  static const HOMESCREEN = _Paths.HOMESCREEN;
  static const LOGINSCREEN = _Paths.LOGINSCREEN;

 // static const BOTTOM_NAVIGATION = _Paths.BOTTOM_NAVIGATION;
  //static const ProductDetail = _Paths.ProductDetail;
  static const ProductsDashboard = _Paths.ProductsDashboard;
  static const AddAttendee2 = _Paths.AddAttendee2;
  static const AddAttendee3 = _Paths.AddAttendee3;
  static const Hidtory = _Paths.Hidtory;
  static const AddAttendee = _Paths.AddAttendee;
  static const Attendee = _Paths.Attendee;
  static const MeetingDetail = _Paths.MeetingDetail;
  static const AddmeetingPhotos = _Paths.AddmeetingPhotos;
  static const MeetingPhotos = _Paths.MeetingPhotos;
  static const MeetingStart = _Paths.MeetingStart;
  static const Meetingoption = _Paths.Meetingoption;
  static const Permission = _Paths.Permission;
  static const inviteSCREEN = _Paths.inviteSCREEN;

}

abstract class _Paths {
  _Paths._();

  static const SPLASH = "/splash";
  static const HOMESCREEN = "/home";
  static const LOGINSCREEN = "/login";
  static const Permission = "/permission";

  static const MeetingStart = '/meeting-start';
  static const ProductDetail = '/productDetail';
  static const ProductsDashboard = '/productsDashboard';
  static const ServiceDashboard = '/serviceDashboard';
  static const CategoryProducts = '/categoryProducts';
  static const SubCategoryProducts = '/subcategoryProducts';
  static const Hidtory = '/history';
  static const AddAttendee2 = '/addattendee2';
  static const AddAttendee3 = '/addattendee3';

  static const AddAttendee = '/addattendee';
  static const Attendee = '/attendee';
  static const MeetingDetail = '/detail';
  static const AddmeetingPhotos = "/addphotos";
  static const MeetingPhotos = "/photos";
  static const Meetingoption = "/option";
  static const inviteSCREEN = "/invite";

}