class TableMeetingsModel {
  int? fldMId;
  String? fldCustomerId;
  String? fldUserId;
  String? fldExecutiveId;
  String? fldDepoId;
  String? fldDepoCode;
  String? fldDepoName;
  String? fldStateId;
  String? fldDealerId;
  String? fldMeetingType;
  String? fldAsmId;
  String? fldId;
  String? fldIdPrefix;
  String? fldIdCode;
  String? fldMDate;
  String? fldMTypeName;
  String? fldEstiAttendee;
  String? fldRemark;
  String? fldStatus;
  String? fldIsDelete;
  String? fldCreatedAt;
  String? fldUpdatedAt;
  String? fldLocation;
  String? fldCsr;
  String? fldBranch;
  String? localStatus;
  List<Dealer> dealers;

  bool showFinish = false;

  TableMeetingsModel({
    this.fldMId,
    this.fldCustomerId,
    this.fldUserId,
    this.fldExecutiveId,
    this.fldDepoId,
    this.fldDepoCode,
    this.fldDepoName,
    this.fldStateId,
    this.fldDealerId,
    required this.dealers,
    this.fldMeetingType,
    this.fldAsmId,
    this.fldId,
    this.fldIdPrefix,
    this.fldIdCode,
    this.fldMDate,
    this.fldMTypeName,
    this.fldEstiAttendee,
    this.fldRemark,
    this.fldStatus,
    this.fldIsDelete,
    this.fldCreatedAt,
    this.fldUpdatedAt,
    this.fldLocation,
    this.fldCsr,
    this.fldBranch,
    this.localStatus,
    this.showFinish = false,
  });

  // Factory method to create an instance from JSON
  factory TableMeetingsModel.fromJson(Map<String, dynamic> json) {
    return TableMeetingsModel(
      fldMId: json['fld_mid'],
      fldCustomerId: json['fld_customer_id'],
      fldUserId: json['fld_user_id'],
      fldExecutiveId: json['fld_executive_id'],
      fldDepoId: json['fld_depo_id'],
      fldDepoCode: json['fld_depo_code'],
      fldDepoName: json['fld_depo_name'],
      fldStateId: json['fld_state_id'],
      fldDealerId: json['fld_dealer_id'],
      dealers: json.containsKey('dealers')&& json['dealers'] != null
          ? (json['dealers'] as List).map((e) => Dealer.fromJson(e)).toList()
          : [],
      fldMeetingType: json['fld_meeting_type'],
      fldAsmId: json['fld_asm_id'],
      fldId: json['fld_id'],
      fldIdPrefix: json['fld_id_prefix'],
      fldIdCode: json['fld_id_code'],
      fldMDate: json['fld_mdate'],
      fldMTypeName: json['fld_mtype_name'],
      fldEstiAttendee: json['fld_esti_attendee'],
      fldRemark: json['fld_remark'],
      fldStatus: json['fld_status'],
      fldIsDelete: json['fld_is_delete'],
      fldCreatedAt: json['fld_created_at'],
      fldUpdatedAt: json['fld_updated_at'],
      fldLocation: json['fld_location'],
      fldCsr:json['fld_csr'] != null? json['fld_csr']:"",
      fldBranch: json['fld_branch'],
      localStatus: json['local_status'],
      showFinish: json['show_finish'] ?? false,
    );
  }

  // Method to convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'fld_mid': fldMId,
      'fld_customer_id': fldCustomerId,
      'fld_user_id': fldUserId,
      'fld_executive_id': fldExecutiveId,
      'fld_depo_id': fldDepoId,
      'fld_depo_code': fldDepoCode,
      'fld_depo_name': fldDepoName,
      'fld_state_id': fldStateId,
      'fld_dealer_id': fldDealerId,
      'dealers': dealers?.map((e) => e.toJson()).toList(),
      'fld_meeting_type': fldMeetingType,
      'fld_asm_id': fldAsmId,
      'fld_id': fldId,
      'fld_id_prefix': fldIdPrefix,
      'fld_id_code': fldIdCode,
      'fld_mdate': fldMDate,
      'fld_mtype_name': fldMTypeName,
      'fld_esti_attendee': fldEstiAttendee,
      'fld_remark': fldRemark,
      'fld_status': fldStatus,
      'fld_is_delete': fldIsDelete,
      'fld_created_at': fldCreatedAt,
      'fld_updated_at': fldUpdatedAt,
      'fld_location': fldLocation,
      'fld_csr': fldCsr,
      'fld_branch': fldBranch,
      'local_status': localStatus,
      'show_finish': showFinish,
    };
  }
}
class Dealer {
  int? fldDrid;
  String? fldRname;
  String? fldRcode;

  Dealer({
    this.fldDrid,
    this.fldRname,
    this.fldRcode,
  });

  factory Dealer.fromJson(Map<String, dynamic> json) {
    return Dealer(
      fldDrid: json['fld_drid']??0,
      fldRname: json['fld_rname']??"",
      fldRcode: json['fld_rcode']??"",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'fld_drid':fldDrid,
      'fld_rname':fldRname,
      'fld_rcode':fldRcode
    };}
}