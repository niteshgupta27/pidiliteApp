class AppConstants {
  static const String appName = 'pidilite';
  static const double appVersion = 7.4;
  static const String fontFamily = 'InriaSans';
  static const String baseUrl = 'https://pidilite.nebula.in/api/';
  static const String configUri = '/api/v1/config';

  static var login='auth/login';
  static var MEETING_LIST='meeting/get-meeting-list';
  static var PROGRESS_CHECK = "meeting/progress-check";
  static var Info_LIST = "meeting/info-list";
 static var USER_CHECK = "auth/check";
  static var UPLOAD_MEETING_INFO = "meeting/add-info-new";
  static var MEETING_STATUS_UPDATE = "meeting/mstatus-update";
  static var  GET_PHOTO_TYPES = "master/get-photo-types";
  static var Get_all_photo_list = "meeting/all-photo-list";
  static var Delete_photo_list = "meeting/image/delete";
  static var UPLOAD_MEETING_IMAGE = "meeting/add-photo";
  static var Get_Meeting_Details = "meeting/details-list";
  static var UPLOAD_MEETING_DETAILS = "meeting/add-details";
  static var attendee_LIST = "meeting/attendee-list";
  static var  Meeting_History = "meeting/get-meeting-list/completed";
  static var UPLOAD_MEETING_ATTENDEE = "meeting/add-attendee";
  static var UPdate_MEETING_ATTENDEE = "meeting/update-attendees";
  static var GET_adhesives = "adhesives";
  static var MEETING_INVITES_LIST='meeting/invites-list';
  static var add_meeting_call='add-meeting-call';
  static var getstaff='get-staff-list';
  static var attendance="meeting/attendance";
  static var AttendeeRefresh = "misscalls/check?d=";
  static var phonenoExp = '^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}';
  static var emailExp = "^[a-zA-Z0-9.a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\$";
  static const loginUserInformation = 'loginUserInformation_storage';
  static const loginUserInformationToken = 'loginUserInformation_token';
  static const lastUpdate = 'lastUpdate';
  static const callLogList = 'callLogList';
  static const tollfree = 'TOLL FREE:- 90045 59396';
  static var otherApp ="Pragati App";
static var CarpenterApp="Super Carpenter App";

}
