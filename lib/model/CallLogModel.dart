class CallLogModel {
  int fldMid;
  String? fldUid;
  String? fldNumber;
  String fldStatus;
  String fldCalltime;
  String fldDuration;

  CallLogModel( {

    required this.fldMid,
    required this.fldUid,
    required this.fldNumber,
    required this.fldStatus,
    required this.fldCalltime,
    required this.fldDuration,
  });

  // Factory method to create an instance from a JSON map
  factory CallLogModel.fromJson(Map<String, dynamic> json) {
    return CallLogModel(
      fldMid: json['fld_mid'],
      fldUid: json['fld_uid'],
      fldNumber: json['fld_number'],
      fldStatus: json['fld_status'],
      fldCalltime: json['fld_calltime'],
      fldDuration: json['fld_duration'],
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'fld_mid': fldMid,
      'fld_uid': fldUid,
      'fld_number': fldNumber,
      'fld_status': fldStatus,
      'fld_calltime': fldCalltime,
      'fld_duration': fldDuration,
    };
  }

  @override
  String toString() {
    return 'CallLogModel(fldMid: $fldMid, fldUid: $fldUid, fldNumber: $fldNumber, fldStatus: $fldStatus, fldCalltime: $fldCalltime, fldDuration: $fldDuration)';
  }
}