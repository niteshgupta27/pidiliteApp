class AdhesiveModel {
  int? fldAdid;
  String? fldAdhesiveName;
  //int? fldStatus;

  AdhesiveModel({
    this.fldAdid,
    this.fldAdhesiveName,
   // this.fldStatus,

  });

  // Factory constructor to create an Adhesive object from a JSON map
  factory AdhesiveModel.fromJson(Map<String, dynamic> json) {
    return AdhesiveModel(
      fldAdid: json['fld_adid'],
      fldAdhesiveName: json['fld_adhesive_name'],
      //fldStatus: json['fld_status'],

    );
  }

  // Method to convert an Adhesive object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'fld_adid': fldAdid,
      'fld_adhesive_name': fldAdhesiveName,
      //'fld_status': fldStatus,

    };
  }
}