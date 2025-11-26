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
      id: json.containsKey('user_id')?json ['user_id']:"",
      depo_id: json.containsKey('depo_id')&& json['depo_id'] != null?json['depo_id']:"",
        username:json.containsKey('username')&& json['username'] != null?json['username']:""

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