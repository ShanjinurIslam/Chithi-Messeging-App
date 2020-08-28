import 'dart:io';

import 'package:Chithi/controller/AuthController.dart';
import 'package:Chithi/model/User.dart';
import 'package:Chithi/static.dart';
import 'package:Chithi/view/Chats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadAvatarView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _UploadAvatarViewState();
  }
}

class _UploadAvatarViewState extends State<UploadAvatarView> {
  bool _fileSelected = false;
  bool _isUploading = false;
  final picker = ImagePicker();
  File _image;

  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    _fileSelected = true;
    _image = File(pickedFile.path);

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;

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
                    'Upload Avatar',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  GestureDetector(
                    child: _isUploading ? Text('') : Text('Skip'),
                    onTap: () {
                      Navigator.of(context).push(new PageRouteBuilder(
                          pageBuilder: (BuildContext context, _, __) {
                        return new Chats(user);
                      }, transitionsBuilder: (_, Animation<double> animation,
                              __, Widget child) {
                        return new FadeTransition(
                            opacity: animation, child: child);
                      }));
                    },
                  )
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Center(
                  child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: _fileSelected
                          ? CircleAvatar(
                              key: UniqueKey(),
                              backgroundImage: FileImage(_image),
                              radius: MediaQuery.of(context).size.width / 2.5,
                            )
                          : CircleAvatar(
                              key: UniqueKey(),
                              backgroundImage:
                                  NetworkImage(getAvatar + user.id.toString()),
                              radius: MediaQuery.of(context).size.width / 2.5,
                            )),
                  Positioned(
                    child: RawMaterialButton(
                      onPressed: () {
                        getImage();
                      },
                      elevation: 2.0,
                      fillColor: Colors.white,
                      child: Icon(
                        Icons.image,
                        size: 25.0,
                        color: Colors.black,
                      ),
                      padding: EdgeInsets.all(10.0),
                      shape: CircleBorder(),
                    ),
                    right: 15,
                    bottom: 15,
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
                  onPressed: _isUploading
                      ? null
                      : () async {
                          if (_fileSelected) {
                            setState(() {
                              _isUploading = true;
                            });
                            try {
                              int statusCode =
                                  await AuthController.uploadAvatar(
                                      _image, user.token);
                              print(statusCode);
                              Navigator.of(context).pushReplacement(
                                  new PageRouteBuilder(pageBuilder:
                                      (BuildContext context, _, __) {
                                return new Chats(user);
                              }, transitionsBuilder: (_,
                                      Animation<double> animation,
                                      __,
                                      Widget child) {
                                return new FadeTransition(
                                    opacity: animation, child: child);
                              }));
                            } catch (error) {
                              setState(() {
                                _isUploading = false;
                              });
                              _key.currentState.showSnackBar(
                                  SnackBar(content: Text(error.toString())));
                            }
                          } else {
                            Navigator.of(context).pushReplacement(
                                new PageRouteBuilder(
                                    pageBuilder: (BuildContext context, _, __) {
                              return new Chats(user);
                            }, transitionsBuilder: (_,
                                        Animation<double> animation,
                                        __,
                                        Widget child) {
                              return new FadeTransition(
                                  opacity: animation, child: child);
                            }));
                          }
                        },
                  child: Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _isUploading
                            ? CupertinoActivityIndicator()
                            : Text(
                                _fileSelected ? 'Upload' : 'Next',
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
