class meetingDetailResponse {
  final int status;
  final bool success;
  final String message;
  final List<MeetingDetailoData> data;

  meetingDetailResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory meetingDetailResponse.fromJson(Map<String, dynamic> json) {
    return meetingDetailResponse(
      status: json['status'] ?? 0,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List?)?.map((item) => MeetingDetailoData.fromJson(item)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'success': success,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class MeetingDetailoData {

  // final int? fldMdId;
  // final int? fldCustomerId;
  // final int? fldMeetingId;
  // final int? fldMtypeId;
  // final int? fldUserId;
  final String? fldActualAttendance;
  final String? fldTotalGiftsGiven;
  final String? fldNonParticipant;
  final String? fldOrderPlaced;
  final String? fldGiftPurchased;
  final String? fldGiftItemGiven;
  final String? fldRemark;
  final String? fldBillImg1Name;
  final String? fldBillImg1Path;
  final String? fldBillImg2Name;
  final String? fldBillImg2Path;


  MeetingDetailoData({
    // this.fldMdId,
    // this.fldCustomerId,
    // this.fldMeetingId,
    // this.fldMtypeId,
    // this.fldUserId,
    this.fldActualAttendance,
    this.fldTotalGiftsGiven,
    this.fldNonParticipant,
    this.fldOrderPlaced,
    this.fldGiftPurchased,
    this.fldGiftItemGiven,
    this.fldRemark,
    this.fldBillImg1Name,
    this.fldBillImg1Path,
    this.fldBillImg2Name,
    this.fldBillImg2Path,

  });

  factory MeetingDetailoData.fromJson(Map<String, dynamic> json) {

    return MeetingDetailoData(
      // fldMdId: json['fld_md_id'] as int?,
      // fldCustomerId: json['fld_customer_id'] as int?,
      // fldMeetingId: json['fld_meeting_id'] as int?,
      // fldMtypeId: json['fld_mtype_id'] as int?,
      // fldUserId: json['fld_user_id'] as int?,
      fldActualAttendance: json['fld_actual_attendence'].toString(),
      fldTotalGiftsGiven: json['fld_total_gifts_given'].toString(),
      fldNonParticipant: json['fld_non_participant'].toString()??"",
      fldOrderPlaced: json['fld_order_placed'].toString()??"",
      fldGiftPurchased: json['fld_gift_purchased'].toString(),
      fldGiftItemGiven: json['fld_gift_item_given'] as String?,
      fldRemark: json['fld_remark'] as String?,
      fldBillImg1Name: json['fld_bill_img_1_name'] as String?,
      fldBillImg1Path: json['fld_bill_img_1_path'] as String?,
      fldBillImg2Name: json['fld_bill_img_2_name'] as String?,
      fldBillImg2Path: json['fld_bill_img_2_path'] as String?,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'fld_md_id': fldMdId,
      // 'fld_customer_id': fldCustomerId,
      // 'fld_meeting_id': fldMeetingId,
      // 'fld_mtype_id': fldMtypeId,
      // 'fld_user_id': fldUserId,
      'fld_actual_attendence': fldActualAttendance,
      'fld_total_gifts_given': fldTotalGiftsGiven,
      'fld_non_participant': fldNonParticipant,
      'fld_order_placed': fldOrderPlaced,
      'fld_gift_purchased': fldGiftPurchased,
      'fld_gift_item_given': fldGiftItemGiven,
      'fld_remark': fldRemark,
      'fld_bill_img_1_name': fldBillImg1Name,
      'fld_bill_img_1_path': fldBillImg1Path,
      'fld_bill_img_2_name': fldBillImg2Name,
      'fld_bill_img_2_path': fldBillImg2Path,

    };
  }
}