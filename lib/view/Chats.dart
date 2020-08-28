import 'package:Chithi/model/Friend.dart';
import 'package:Chithi/model/User.dart';
import 'package:Chithi/view/ProfileView.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

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
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  Socket _socket;
  List<Friend> friends = new List<Friend>();

  @override
  void initState() {
    _socket = io('http://192.168.0.101:3000/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    _socket.io.options['query'] = {'id': widget.user.id.toString()};
    _socket.connect();

    _socket.on(
        'connect',
        (_) => {
              _key.currentState.showSnackBar(SnackBar(
                content: Text('Connected'),
                duration: Duration(milliseconds: 500),
              ))
            });

    _socket.on('active_list', (activeList) {
      if (activeList != 0) {
        for (var active in activeList) {
          Friend friend = new Friend();
          friend.id = active['_id'];
          friend.username = active['username'];
          friend.socketID = active['socketId'];
          friends.add(friend);
        }

        setState(() {});
      }
    });

    _socket.on('new_user', (user) {
      Friend friend = new Friend();
      friend.id = user['_id'];
      friend.username = user['username'];
      friend.socketID = user['socketId'];
      friends.add(friend);
      setState(() {});
    });
    _socket.on('remove_user', (user) {
      friends = friends.where((element) => element.id != user['_id']).toList();
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
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
                      style:
                          TextStyle(fontSize: 48, fontWeight: FontWeight.w400),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(new PageRouteBuilder(
                            pageBuilder: (BuildContext context, _, __) {
                          return new ProfileView(
                            user: widget.user,
                            socket: _socket,
                          );
                        }, transitionsBuilder: (_, Animation<double> animation,
                                __, Widget child) {
                          return new FadeTransition(
                              opacity: animation, child: child);
                        }));
                      },
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(getAvatar + widget.user.id.toString()),
                      ),
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
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                child: friends.length > 0
                    ? Padding(
                        key: UniqueKey(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 21.5,
                                        backgroundImage: NetworkImage(
                                            getAvatar +
                                                friends[index].id.toString()),
                                      ),
                                      Text(friends[index].username)
                                    ],
                                  ));
                            },
                            itemCount: friends.length,
                          ),
                        ),
                      )
                    : Container(
                        key: UniqueKey(),
                      ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
                child: Row(
                  children: [
                    Text(
                      'Recent',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
