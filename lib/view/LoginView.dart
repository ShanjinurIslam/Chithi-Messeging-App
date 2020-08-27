import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginViewState();
  }
}

class _LoginViewState extends State<LoginView> {
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
              'Chithi',
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
                    'Welcome Back,',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Sign In to Continue',
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
                        'Sign In',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                )),
          ),
          Padding(
            padding: EdgeInsets.all(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account? '),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/signUp');
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
