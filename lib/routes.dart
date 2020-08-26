import 'package:Chithi/view/ChatThread.dart';
import 'package:Chithi/view/Chats.dart';
import 'package:Chithi/view/LandingView.dart';
import 'package:flutter/material.dart';

final routes = {
  '/': (BuildContext context) => Chats(),
  '/thread': (BuildContext context) => ChatThread()
};
