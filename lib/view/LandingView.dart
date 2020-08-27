import 'dart:async';

import 'package:flutter/material.dart';

class LandingView extends StatelessWidget {
  @override
  Widget build(Object context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text('Go to login'),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ),
    );
  }
}
