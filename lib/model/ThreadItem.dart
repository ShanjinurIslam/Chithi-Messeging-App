import 'package:Chithi/model/Message.dart';

class ThreadItem {
  final String threadID;
  Message lastMessage;

  ThreadItem({this.threadID, this.lastMessage});

  factory ThreadItem.fromJSON(Map<String, dynamic> json) {
    return ThreadItem(
      threadID: json['threadID'],
      lastMessage: Message.fromJSON(json['lastMessage']),
    );
  }
}
