class User {
  String? avatar;
  String? username;
  String? name;

  User({
    this.avatar,
    this.username,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        avatar: json['avatar'] as String?,
        username: json['username'] as String?,
        name: json['first_name'] + ' ' + json['last_name'] as String?,
      );
}
