import 'package:flutter/material.dart';

class LandingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      bottom: false,
      child: Center(
        child: Text("Welcome"),
      ),
    ));
  }
}
