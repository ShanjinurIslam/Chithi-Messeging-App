import 'package:Chithi/model/User.dart';
import 'package:Chithi/view/ChatThread.dart';
import 'package:Chithi/view/Chats.dart';
import 'package:Chithi/view/LandingView.dart';
import 'package:Chithi/view/LoginView.dart';
import 'package:Chithi/view/ProfileView.dart';
import 'package:Chithi/view/SignUpView.dart';
import 'package:Chithi/view/UploadAvatar.dart';
import 'package:flutter/material.dart';

final routes = {
  '/': (BuildContext context) => LandingView(),
  '/login': (BuildContext context) => LoginView(),
  '/signUp': (BuildContext context) => SignUpView(),
  '/chats': (BuildContext context) => Chats(new User()),
  '/thread': (BuildContext context) => ChatThread(),
  '/uploadAvatar': (BuildContext context) => UploadAvatarView(),
  '/profile': (BuildContext context) => ProfileView()
};
