import 'dart:async';

import 'package:Chithi/model/User.dart';
import 'package:Chithi/view/Chats.dart';
import 'package:Chithi/view/LoginView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LandingViewState();
  }
}

class _LandingViewState extends State<LandingView> {
  bool _userExists = false;

  void checkForUser() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      int id = sharedPreferences.getInt('id');
      String username = sharedPreferences.getString('username');
      String token = sharedPreferences.getString('token');
      User user = new User(id: id, username: username, token: token);

      if (token != null) {
        Timer(
            Duration(milliseconds: 500),
            () => {
                  Navigator.of(context).pushReplacement(new PageRouteBuilder(
                      pageBuilder: (BuildContext context, _, __) {
                    return new Chats(user);
                  }, transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                    return new FadeTransition(opacity: animation, child: child);
                  }))
                });
      } else {
        Timer(
            Duration(milliseconds: 500),
            () => {
                  Navigator.of(context).pushReplacement(new PageRouteBuilder(
                      pageBuilder: (BuildContext context, _, __) {
                    return new LoginView();
                  }, transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                    return new FadeTransition(opacity: animation, child: child);
                  }))
                });
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    checkForUser();
  }

  @override
  Widget build(Object context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Center(
              child: Icon(
            Icons.message,
            size: 50,
          )),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ),
    );
  }
}
