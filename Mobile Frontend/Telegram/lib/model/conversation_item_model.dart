import 'dart:core';

class ConversationItemModel {
  final String userName;
  final String lastMessage;
  final String lastMessageTime;
  final int unseen;
  final String profileImageLink;
  bool pinned = false;
  bool read = false;

  ConversationItemModel(
      {this.userName,
      this.lastMessage,
      this.lastMessageTime,
      this.unseen,
      this.profileImageLink});

  factory ConversationItemModel.from(Map<String, dynamic> json) {
    //print(json);
    return ConversationItemModel(
        userName: json['user_name'],
        lastMessage: json['last_message'],
        lastMessageTime: json['last_message_time'],
        unseen: json['unseen'],
        profileImageLink: json['profile_image_link']);
  }
}
