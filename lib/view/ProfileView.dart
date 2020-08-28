import 'package:Chithi/controller/AuthController.dart';
import 'package:Chithi/model/User.dart';
import 'package:Chithi/static.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:socket_io_client/socket_io_client.dart';

class ProfileView extends StatefulWidget {
  final User user;
  final Socket socket;

  ProfileView({this.user, this.socket});

  @override
  State<StatefulWidget> createState() {
    return new _ProfileViewState();
  }
}

class _ProfileViewState extends State<ProfileView> {
  bool _isLoading = false;
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    widget.socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Center(
          child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(25),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 4,
                    backgroundImage:
                        NetworkImage(getAvatar + widget.user.id.toString()),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: Text(
                      '@' + widget.user.username,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    //Spacer(),
                  ),
                ],
              )),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(25),
              child: FlatButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  onPressed: () async {
                    widget.socket.disconnect();
                    setState(() {
                      _isLoading = true;
                    });
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    String token = sharedPreferences.getString('token');
                    try {
                      int statusCode = await AuthController.logOut(token);
                      if (statusCode == 200) {
                        sharedPreferences.clear();
                        Navigator.pushReplacementNamed(context, '/login');
                      }
                    } catch (error) {
                      setState(() {
                        _isLoading = false;
                      });
                      _key.currentState.showSnackBar(SnackBar(
                        content: Text(error.message.toString()),
                      ));
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
                                'Log Out',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              )
                      ],
                    ),
                  )),
            ),
          ],
        ),
      )),
    );
  }
}
