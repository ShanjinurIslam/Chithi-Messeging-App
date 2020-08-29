import 'package:Chithi/model/Message.dart';
import 'package:flutter/material.dart';

class ChatThread {
  String threadID;
  List<Message> messages;

  ChatThread() {
    messages = new List<Message>();
  }

  factory ChatThread.fromJSON(Map<String, dynamic> json) {
    List<Message> messages = new List<Message>();

    for (int i = 0; i < json['messages'].length; i++) {
      messages.insert(0, Message.fromJSON(json['messages'][i]));
    }

    ChatThread thread = new ChatThread();
    thread.threadID = json['threadID'];
    thread.messages = messages;

    return thread;
  }
}
