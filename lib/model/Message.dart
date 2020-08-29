import 'package:Chithi/model/User.dart';

class Message {
  final User sender;
  final User receiver;
  String content;
  DateTime createdAt;

  Message({this.sender, this.receiver, this.content, this.createdAt});

  factory Message.fromJSON(Map<String, dynamic> json) {
    return Message(
        sender: User.fromJson(json['sender']),
        receiver: User.fromJson(json['receiver']),
        content: json['content'] as String,
        createdAt: DateTime.parse(json['createdAt']));
  }
}
