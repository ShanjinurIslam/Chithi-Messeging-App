import 'package:Chithi/model/User.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../static.dart';

class Chats extends StatefulWidget {
  final User user;

  Chats(this.user);

  @override
  State<StatefulWidget> createState() {
    return _ChatState();
  }
}

class _ChatState extends State<Chats> {
  SharedPreferences preferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      bottom: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(25),
            child: Row(
              children: [
                Text(
                  'Chats',
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.w400),
                ),
                Spacer(),
                CircleAvatar(
                  key: UniqueKey(),
                  backgroundImage:
                      NetworkImage(getAvatar + widget.user.id.toString()),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Search', prefixIcon: Icon(Icons.search)),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 25, 0, 13),
            child: Container(
              height: 70,
              child: ListView.builder(
                padding: EdgeInsets.only(left: 25),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 21.5,
                            backgroundColor: Colors.grey,
                          ),
                          Text('Name')
                        ],
                      ));
                },
                itemCount: 10,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
            child: Row(
              children: [
                Text(
                  'Recent',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                Spacer()
              ],
            ),
          ),
          Divider(
            color: Colors.grey.withOpacity(.5),
            height: 1,
          ),
          Expanded(
              child: ListView.builder(
                  //padding: EdgeInsets.only(top: 20),
                  physics: BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/thread');
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(13, 13.5, 13, 13.5),
                          height: 50,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.grey,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Avatar Name',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text('Recent Text.....'),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '03:41 AM',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ));
                  }))
        ],
      ),
    ));
  }
}
