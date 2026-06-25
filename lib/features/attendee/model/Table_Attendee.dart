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
  final String? fldRef1;
  final String? fldRef2;
  final String? fldRef3;
  final String? fldRemark1;
  final String? fldRemark2;
  final String? fldRemark3;
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
    this.fldRef1,
    this.fldRef2,
    this.fldRef3,
    this.fldRemark1,
    this.fldRemark2,
    this.fldRemark3,
    required this.fldInvites,
    required this.tollfree,
  });

  factory Table_Attendee.fromJson(Map<String, dynamic> json) {
    return Table_Attendee(
      fldAid: json['fld_aid'] is int ? json['fld_aid'] : int.tryParse(json['fld_aid']?.toString() ?? '0') ?? 0,
      fldCustomerId: json['fld_customer_id']?.toString() ?? '',
      fldUserId: json['fld_user_id']?.toString() ?? '',
      fldMtypeId: json['fld_mtype_id']?.toString() ?? '',
      fldMeetingId: json['fld_meeting_id']?.toString() ?? '',
      fldDealerId: json['fld_dealer_id']?.toString() ?? '',
      fldStateId: json['fld_state_id']?.toString() ?? '',
      fldDepoId: json['fld_depo_id']?.toString() ?? '',
      fldAttendeeName: json['fld_attendee_name']?.toString() ?? '',
      fldPancard: json['fld_pancard']?.toString(),
      fldDob: json['fld_dob']?.toString(),
      fldAge: json['fld_age']?.toString(),
      fldQualification: json['fld_qualification']?.toString(),
      fldMobile: json['fld_mobile']?.toString() ?? '',
      fldGiftGiven: json['fld_gift_given']?.toString() ?? '',
      fldContractor: json['fld_contractor']?.toString() ?? '',
      fldContractorSites: json['fld_contractor_sites']?.toString(),
      fldContractorTeamSize: json['fld_contractor_team_size']?.toString(),
      fldSmartphone: json['fld_smartphone']?.toString() ?? '',
      fldAppDownloadNebula: json['fld_app_download_nebula']?.toString() ?? '',
      fldAppDownloadAttendee: json['fld_app_download_attendee']?.toString() ?? '',
      fldNotDownloadReason: json['fld_not_download_reason']?.toString(),
      fldAdhesiveBrand: json['fld_adhesive_brand']?.toString() ?? '',
      fldAdhesiveConsumption: json['fld_adhesive_consumption']?.toString(),
      fldAttendance: json['fld_attendance'] is int ? json['fld_attendance'] : int.tryParse(json['fld_attendance']?.toString() ?? '0') ?? 0,
      fldOrderValue: json['fld_order_value']?.toString(),
      fldOrderPlaced: json['fld_order_placed']?.toString() ?? '',
      fldOrderDetails: json['fld_order_details']?.toString(),
      fldCompetitionPoints: json['fld_competition_points']?.toString(),
      fldRef1: json['fld_ref_1']?.toString(),
      fldRef2: json['fld_ref_2']?.toString(),
      fldRef3: json['fld_ref_3']?.toString(),
      fldRemark1: json['fld_remark_1']?.toString(),
      fldRemark2: json['fld_remark_2']?.toString(),
      fldRemark3: json['fld_remark_3']?.toString(),
      fldInvites: json['fld_invites'] is int ? json['fld_invites'] : int.tryParse(json['fld_invites']?.toString() ?? '0') ?? 0,
      tollfree: json['tollfree'] is int ? json['tollfree'] : int.tryParse(json['tollfree']?.toString() ?? '0') ?? 0,
    );
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
      "fld_adhesive_brand": fldAdhesiveBrand,
      "fld_adhesive_consumption": fldAdhesiveConsumption,
      "fld_attendance": fldAttendance,
      "fld_order_value": fldOrderValue,
      "fld_order_placed": fldOrderPlaced,
      "fld_order_details": fldOrderDetails,
      "fld_competition_points": fldCompetitionPoints,
      "fld_ref_1": fldRef1,
      "fld_ref_2": fldRef2,
      "fld_ref_3": fldRef3,
      "fld_remark_1": fldRemark1,
      "fld_remark_2": fldRemark2,
      "fld_remark_3": fldRemark3,
      "fld_invites": fldInvites,
      "tollfree": tollfree,
    };
  }
}
