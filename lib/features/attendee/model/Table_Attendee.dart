import '../../../Utill/app_required.dart';

class Table_Attendee {
  final int fldAid;
  final String fldCustomerId;
  final String fldUserId;
  final String fldMtypeId;
  final String fldMeetingId;
  final String fldDealerId;
  final String fldStateId;
  final String fldDepoId;
  final String fldAttendeeName;
  final String? fldPancard;
  final String? fldDob;
  final String? fldAge;
  final String? fldQualification;
  final String fldMobile;
  final String fldGiftGiven;
  final String fldContractor;
  final String? fldContractorSites;
  final String? fldContractorTeamSize;
  final String fldSmartphone;
  final String fldAppDownloadNebula;
  final String fldAppDownloadAttendee;
  final String? fldNotDownloadReason;
  final String fldAdhesiveBrand;
  final String? fldAdhesiveConsumption;
  final int fldAttendance;
  final String? fldOrderValue;
  final String fldOrderPlaced;
  final String? fldOrderDetails;
  final String? fldCompetitionPoints;
  // final String? fldQrValue;
  // final String? fldQrImage;
  // final String? fldQrImagePath;
  // final String? fldImageName;
  // final String? fldImagePath;
  // final String? fldInvitationImage;
  // final String? fldInvitationPath;
  // final String? fldMisscallTime;
  // final String? fldMisscallCode;
  final String? fldRef1;
  final String? fldRef2;
  final String? fldRef3;
  final String? fldRemark1;
  final String? fldRemark2;
  final String? fldRemark3;
  // final String fldLat;
  // final String fldLong;
  // final String fldCreatedAt;
  // final String fldUpdatedAt;
  final int fldInvites;
  final int tollfree;

  Table_Attendee({
    required this.fldAid,
    required this.fldCustomerId,
    required this.fldUserId,
    required this.fldMtypeId,
    required this.fldMeetingId,
    required this.fldDealerId,
    required this.fldStateId,
    required this.fldDepoId,
    required this.fldAttendeeName,
    this.fldPancard,
    this.fldDob,
    this.fldAge,
    this.fldQualification,
    required this.fldMobile,
    required this.fldGiftGiven,
    required this.fldContractor,
    this.fldContractorSites,
    this.fldContractorTeamSize,
    required this.fldSmartphone,
    required this.fldAppDownloadNebula,
    required this.fldAppDownloadAttendee,
    this.fldNotDownloadReason,
    required this.fldAdhesiveBrand,
    this.fldAdhesiveConsumption,
    required this.fldAttendance,
    this.fldOrderValue,
    required this.fldOrderPlaced,
    this.fldOrderDetails,
    this.fldCompetitionPoints,
    // this.fldQrValue,
    // this.fldQrImage,
    // this.fldQrImagePath,
    // this.fldImageName,
    // this.fldImagePath,
    // this.fldInvitationImage,
    // this.fldInvitationPath,
    // this.fldMisscallTime,
    // this.fldMisscallCode,
    this.fldRef1,
    this.fldRef2,
    this.fldRef3,
    this.fldRemark1,
    this.fldRemark2,
    this.fldRemark3,
    // required this.fldLat,
    // required this.fldLong,
    // required this.fldCreatedAt,
    // required this.fldUpdatedAt,
    required this.fldInvites,
    required this.tollfree,
  });

  factory Table_Attendee.fromJson(Map<String, dynamic> json) {
    debugPrint(json.toString());

    // Helper function to safely extract values and print their types
    dynamic safeExtract(String key, dynamic defaultValue) {
      final value = json[key] ?? defaultValue;
      debugPrint('Key: $key, Value: $value, Type: ${value.runtimeType}');
      return value;
    }

    return Table_Attendee(
      fldAid: safeExtract('fld_aid', 0) is int ? safeExtract('fld_aid', 0) : int.tryParse(safeExtract('fld_aid', '0').toString()) ?? 0,
      fldCustomerId: safeExtract('fld_customer_id', ''),
      fldUserId: safeExtract('fld_user_id', ''),
      fldMtypeId: safeExtract('fld_mtype_id', ''),
      fldMeetingId: safeExtract('fld_meeting_id', ''),
      fldDealerId: safeExtract('fld_dealer_id', ''),
      fldStateId: safeExtract('fld_state_id', ''),
      fldDepoId: safeExtract('fld_depo_id', ''),
      fldAttendeeName: safeExtract('fld_attendee_name', ''),
      fldPancard: safeExtract('fld_pancard', ''),
      fldDob: safeExtract('fld_dob', ''),
      fldAge: safeExtract('fld_age', ''),
      fldQualification: safeExtract('fld_qualification', ''),
      fldMobile: safeExtract('fld_mobile', ''),
      fldGiftGiven: safeExtract('fld_gift_given', ''),
      fldContractor: safeExtract('fld_contractor', ''),
      fldContractorSites: safeExtract('fld_contractor_sites', ''),
      fldContractorTeamSize: safeExtract('fld_contractor_team_size', ''),
      fldSmartphone: safeExtract('fld_smartphone', ''),
      fldAppDownloadNebula: safeExtract('fld_app_download_nebula', ''),
      fldAppDownloadAttendee: safeExtract('fld_app_download_attendee', ''),
      fldNotDownloadReason: safeExtract('fld_not_download_reason', ''),
      fldAdhesiveBrand: safeExtract('fld_adhesive_brand', ''),
      fldAdhesiveConsumption: safeExtract('fld_adhesive_consumption', ''),
      fldAttendance: safeExtract('fld_attendance', 0) is int ? safeExtract('fld_attendance', 0) : int.tryParse(safeExtract('fld_attendance', '0').toString()) ?? 0,
      fldOrderValue: safeExtract('fld_order_value', ''),
      fldOrderPlaced: safeExtract('fld_order_placed', ''),
      fldOrderDetails: safeExtract('fld_order_details', ''),
      fldCompetitionPoints: safeExtract('fld_competition_points', ''),
      fldRef1: safeExtract('fld_ref_1', ''),
      fldRef2: safeExtract('fld_ref_2', ''),
      fldRef3: safeExtract('fld_ref_3', ''),
      fldRemark1: safeExtract('fld_remark_1', ''),
      fldRemark2: safeExtract('fld_remark_2', ''),
      fldRemark3: safeExtract('fld_remark_3', ''),
      fldInvites: safeExtract('fld_invites', 0) is int ? safeExtract('fld_invites', 0) : int.tryParse(safeExtract('fld_invites', '0').toString()) ?? 0,
      tollfree: safeExtract('tollfree', 0) is int ? safeExtract('tollfree', 0) : int.tryParse(safeExtract('tollfree', '0').toString()) ?? 0,
    );
    // return Table_Attendee(
    //   fldAid: json['fld_aid'] ??0,
    //   fldCustomerId: json['fld_customer_id'] ??"",
    //   fldUserId: json['fld_user_id'] ??"",
    //   fldMtypeId: json['fld_mtype_id'] ??"",
    //   fldMeetingId: json['fld_meeting_id'] ??"",
    //   fldDealerId: json['fld_dealer_id']??"",
    //   fldStateId: json['fld_state_id'] ??"",
    //   fldDepoId: json['fld_depo_id'] ??"",
    //   fldAttendeeName: json['fld_attendee_name'] ??"",
    //   fldPancard: json['fld_pancard'] ?? "",
    //   fldDob: json['fld_dob'] ?? "",
    //   fldAge: json['fld_age'] ?? "",
    //   fldQualification:json['fld_qualification'] ?? "",
    //   fldMobile: json['fld_mobile'] ??"",
    //   fldGiftGiven: json['fld_gift_given'] ?? "",
    //   fldContractor: json['fld_contractor'] ??"",
    //   fldContractorSites:json['fld_contractor_sites'] ?? "",
    //   fldContractorTeamSize: json['fld_contractor_team_size'] ?? "",
    //   fldSmartphone: json['fld_smartphone'] ??"",
    //   fldAppDownloadNebula: json['fld_app_download_nebula'] ??"",
    //   fldAppDownloadAttendee: json['fld_app_download_attendee'] ??"",
    //   fldNotDownloadReason:json['fld_not_download_reason'] ?? "",
    //   fldAdhesiveBrand: json['fld_adhesive_brand'] ?? "",
    //   fldAdhesiveConsumption:json['fld_adhesive_consumption'] ?? "",
    //   fldAttendance: json['fld_attendance'] ??0,
    //   fldOrderValue: json['fld_order_value'] ?? "",
    //   fldOrderPlaced:json['fld_order_placed'] ?? "",
    //   fldOrderDetails: json['fld_order_details'] ?? "",
    //   fldCompetitionPoints: json['fld_competition_points'] ?? "",
    //
    //   fldRef1: json['fld_ref_1'] ??"",
    //   fldRef2: json['fld_ref_2'] ??"",
    //   fldRef3: json['fld_ref_3'] ??"",
    //   fldRemark1: json['fld_remark_1'] ??"",
    //   fldRemark2: json['fld_remark_2'] ??"",
    //   fldRemark3: json['fld_remark_3'] ??"",
    //
    //   fldInvites: json['fld_invites'] ??0,
    //   tollfree: json['tollfree'] ??0,
    // );
  }

  Map<String, dynamic> toJson() {
    return {
      "fld_aid": fldAid,
      "fld_customer_id": fldCustomerId,
      "fld_user_id": fldUserId,
      "fld_mtype_id": fldMtypeId,
      "fld_meeting_id": fldMeetingId,
      "fld_dealer_id": fldDealerId,
      "fld_state_id": fldStateId,
      "fld_depo_id": fldDepoId,
      "fld_attendee_name": fldAttendeeName,
      "fld_pancard": fldPancard,
      "fld_dob": fldDob,
      "fld_age": fldAge,
      "fld_qualification": fldQualification,
      "fld_mobile": fldMobile,
      "fld_gift_given": fldGiftGiven,
      "fld_contractor": fldContractor,
      "fld_contractor_sites": fldContractorSites,
      "fld_contractor_team_size": fldContractorTeamSize,
      "fld_smartphone": fldSmartphone,
      "fld_app_download_nebula": fldAppDownloadNebula,
      "fld_app_download_attendee": fldAppDownloadAttendee,
      "fld_not_download_reason": fldNotDownloadReason,
      // "fld_lat": fldLat,
      // "fld_long": fldLong,
      // "fld_created_at": fldCreatedAt,
      // "fld_updated_at": fldUpdatedAt,
      "fld_invites": fldInvites,
      "tollfree": tollfree,
    };
  }
}
