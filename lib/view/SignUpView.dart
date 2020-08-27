import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SignUpViewState();
  }
}

class _SignUpViewState extends State<SignUpView> {
  bool _isLoading = false;
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  TextEditingController _confirmpwdController = new TextEditingController();

  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Padding(
                padding: EdgeInsets.all(25),
                child: Text(
                  'Just Username and Password, You are good to go!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter username';
                          }
                          return null;
                        },
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
                      TextFormField(
                        controller: _pwdController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter username';
                          }
                          return null;
                        },
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
                      TextFormField(
                        controller: _confirmpwdController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter username';
                          } else if (value != _pwdController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
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
              ),
              Padding(
                padding: EdgeInsets.all(25),
                child: FlatButton(
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    onPressed: () {
                      _formKey.currentState.validate();
                    },
                    child: Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
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
