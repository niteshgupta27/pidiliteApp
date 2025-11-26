class Timemodel {
  int fldMid;
  int? lastTime;


  Timemodel( {

    required this.fldMid,
    required this.lastTime,

  });

  // Factory method to create an instance from a JSON map
  factory Timemodel.fromJson(Map<String, dynamic> json) {
    return Timemodel(
      fldMid: json['fld_mid'],
      lastTime: json['lastTime'],

    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'fld_mid': fldMid,
      'lastTime': lastTime,

    };
  }

  @override
  String toString() {
    return 'Timemodel(fldMid: $fldMid, lastTime: $lastTime)';
  }
}