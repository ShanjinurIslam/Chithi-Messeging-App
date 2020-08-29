class User {
  final int id;
  final String username;
  String token;

  User({this.id, this.username, this.token});

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return new User(
        id: parsedJson['_id'] as int,
        username: parsedJson['username'] as String,
        token: parsedJson['token'] as String);
  }

  Map<String, dynamic> toJson() {
    return {"id": this.id, "username": this.username, "token": this.token};
  }
}
