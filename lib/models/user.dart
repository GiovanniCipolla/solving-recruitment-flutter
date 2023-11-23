class User {
  User({this.id, this.username, this.email, this.sub, this.enabled});
  
  int? id;
  String? username;
  String? email;
  String? sub;
  bool? enabled;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] != null ? json['id'] as int : null,
      username: json['username'] != null ? json['username'] as String : null,
      email: json['email'] != null ? json['email'] as String : null,
      sub: json['sub'] != null ? json['sub'] as String : null,
      enabled: json['enabled'] != null ? json['enabled'] as bool : null,
    );
  }
}
