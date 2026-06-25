class UserData {
  String? id;
  String? depo_id;
String? username;
  UserData({
    this.id,
    this.depo_id,
this.username,

  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['user_id']?.toString() ?? "",
      depo_id: json['depo_id']?.toString() ?? "",
      username: json['username']?.toString() ?? ""
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': id,
      'depo_id': depo_id,
      'username': username,
    };
  }
}