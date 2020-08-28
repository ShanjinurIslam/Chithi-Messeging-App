import 'package:Chithi/controller/AuthController.dart';
import 'package:Chithi/model/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Chats.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginViewState();
  }
}

class _LoginViewState extends State<LoginView> {
  bool _isLoading = false;
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Back',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'Sign In to Continue',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w300),
                      ),
                    ],
                  )),
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter username';
                          }
                          return null;
                        },
                        controller: _usernameController,
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
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        controller: _passwordController,
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
              ),
              Padding(
                padding: EdgeInsets.all(25),
                child: FlatButton(
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    onPressed: _isLoading
                        ? null
                        : () async {
                            String username = _usernameController.text;
                            String password = _passwordController.text;

                            if (_formKey.currentState.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              setState(() {
                                _isLoading = true;
                              });

                              print(_isLoading);
                              try {
                                User user = await AuthController.logIn(
                                    username, password);
                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                await sharedPreferences.setInt('id', user.id);
                                await sharedPreferences.setString(
                                    'username', user.username);
                                await sharedPreferences.setString(
                                    'token', user.token);

                                Navigator.of(context).push(new PageRouteBuilder(
                                    pageBuilder: (BuildContext context, _, __) {
                                  return new Chats(user);
                                }, transitionsBuilder: (_,
                                        Animation<double> animation,
                                        __,
                                        Widget child) {
                                  return new FadeTransition(
                                      opacity: animation, child: child);
                                }));
                              } catch (error) {
                                print(error);
                                _key.currentState.showSnackBar(SnackBar(
                                    content: Text(error.message.toString())));
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            }
                          },
                    child: Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _isLoading
                              ? CupertinoActivityIndicator()
                              : Text(
                                  'Sign In',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
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
              //Spacer(),
            ],
          ),
        ));
  }
}
