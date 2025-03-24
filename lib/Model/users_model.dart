class User {
  final int uid;
  final String fristname;
  final String lastname;
  final String username;
  final String password;

  User(
      {required this.uid,
      required this.fristname,
      required this.lastname,
      required this.username,
      required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        uid: json['uid'],
        fristname: json['fristname'],
        lastname: json['lastname'],
        username: json['username'],
        password: json['password']);
  }
}
