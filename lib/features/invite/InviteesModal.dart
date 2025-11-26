class InviteesModal {
  int? status;
  bool? success;
  String? message;
  List<Datum>? data;

  InviteesModal({
    this.status,
    this.success,
    this.message,
    this.data,
  });

  // Factory constructor to create an InviteesModal instance from JSON
  factory InviteesModal.fromJson(Map<String, dynamic> json) {
    return InviteesModal(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List).map((item) => Datum.fromJson(item)).toList()
          : null,
    );
  }

  // Convert InviteesModal instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'success': success,
      'message': message,
      'data': data?.map((datum) => datum.toJson()).toList(),
    };
  }
}
class Datum {

  String? fldName;
  String? fldNumber;
  String? fldAttending;
  String? fld_dialed;
  Datum({

    this.fldName,
    this.fldNumber,
    this.fldAttending,
    this.fld_dialed
  });

  // Factory constructor to create a Datum instance from JSON
  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(

      fldName: json['fld_attendee_name'],
      fldNumber: json['fld_mobile'],
      fldAttending: json['fld_aid'],
        fld_dialed: json['fld_dialed']
    );
  }

  // Convert Datum instance to JSON
  Map<String, dynamic> toJson() {
    return {

      'fld_name': fldName,
      'fld_number': fldNumber,
      'fld_attending': fldAttending,
      'fld_dialed': fld_dialed,
    };
  }
}