class User {
  final String username;
  final String token;

  User({this.username, this.token});

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return new User(
        username: parsedJson['username'] as String,
        token: parsedJson['token'] as String);
  }

  Map<String, dynamic> toJson() {
    return {"username": this.username, "token": this.token};
  }
}
