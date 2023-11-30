class UserAccount {
  final String username;
  final String password;

  const UserAccount({required this.username, required this.password});

  UserAccount.fromJson(Map<String, dynamic> json)
      : username = json["username"],
        password = json["password"];

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  UserAccount.fromMap(Map<String, dynamic> map)
      : username = map['username'],
        password = map['password'];
}
