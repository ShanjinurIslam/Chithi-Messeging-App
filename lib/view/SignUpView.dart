import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SignUpViewState();
  }
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(25),
            child: Text(
              'Sign Up',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.w500),
            ),
          ),
          Spacer(),
          Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Just Username and Password, You are good to go!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                  ),
                ],
              )),
          Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  autocorrect: false,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 0, bottom: 11, top: 11, right: 15),
                      hintText: 'Username'),
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 0, bottom: 11, top: 11, right: 15),
                      hintText: 'Password'),
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 0, bottom: 11, top: 11, right: 15),
                      hintText: 'Confirm Password'),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(25),
            child: FlatButton(
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                onPressed: () {},
                child: Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                )),
          ),
          //Spacer(),
        ],
      ),
    ));
  }
}
