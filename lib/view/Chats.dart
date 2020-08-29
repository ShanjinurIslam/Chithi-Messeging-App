import 'package:Chithi/controller/ChatThreadController.dart';
import 'package:Chithi/model/User.dart';
import 'package:Chithi/model/UserData.dart';
import 'package:Chithi/view/ChatThread.dart';
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
  List<User> friends = new List<User>();
  UserData userData = new UserData();

  void generateThreads() async {
    userData.activeThreads =
        await ChatThreadController.generateThreads(widget.user.token);
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _socket = io(socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    _socket.io.options['query'] = {'id': widget.user.id.toString()};
    _socket.connect();

    _socket.on(
        'connect',
        (_) => {
              /*
              _key.currentState.showSnackBar(SnackBar(
                content: Text('Connected'),
                duration: Duration(milliseconds: 500),
              ))*/
            });
    generateThreads();

    _socket.on('active_list', (activeList) {
      if (activeList != 0) {
        for (var active in activeList) {
          friends.add(User.fromJson(active));
        }

        if (this.mounted) {
          setState(() {});
        }
      }
    });

    _socket.on('new_user', (user) {
      friends.add(User.fromJson(user));
      if (this.mounted) {
        setState(() {});
      }
    });
    _socket.on('remove_user', (user) {
      friends = friends.where((element) => element.id != user['_id']).toList();
      if (this.mounted) {
        setState(() {});
      }
    });

    _socket.on('thread_update', (data) {
      print(data);
      int index = userData.findIndex(data['threadID']);

      if (index != -1) {
        userData.updateActiveThread(index, data['content']);
      } else {
        userData.addActiveThread(data);
      }
      if (this.mounted) {
        setState(() {});
      }
    });
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
                    GestureDetector(
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
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      new PageRouteBuilder(pageBuilder:
                                          (BuildContext context, _, __) {
                                    return new ChatThreadView(
                                        userData: userData,
                                        user: widget.user,
                                        socket: _socket,
                                        receiver: friends[index]);
                                  }, transitionsBuilder: (_,
                                          Animation<double> animation,
                                          __,
                                          Widget child) {
                                    return new FadeTransition(
                                        opacity: animation, child: child);
                                  }));
                                },
                                child: Container(
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
                                  ),
                                ),
                              );
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
                      itemCount: userData.activeThreads.length,
                      itemBuilder: (BuildContext context, int index) {
                        User receiver;
                        if (userData
                                .activeThreads[index].lastMessage.sender.id ==
                            widget.user.id) {
                          receiver = userData
                              .activeThreads[index].lastMessage.receiver;
                        } else {
                          receiver =
                              userData.activeThreads[index].lastMessage.sender;
                        }

                        return FlatButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  new PageRouteBuilder(pageBuilder:
                                      (BuildContext context, _, __) {
                                return new ChatThreadView(
                                    userData: userData,
                                    user: widget.user,
                                    socket: _socket,
                                    receiver: receiver,
                                    threadID:
                                        userData.activeThreads[index].threadID);
                              }, transitionsBuilder: (_,
                                      Animation<double> animation,
                                      __,
                                      Widget child) {
                                return new FadeTransition(
                                    opacity: animation, child: child);
                              }));
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(13, 13.5, 13, 13.5),
                              height: 50,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage: NetworkImage(
                                        getAvatar + receiver.id.toString()),
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
                                            userData
                                                        .activeThreads[index]
                                                        .lastMessage
                                                        .sender
                                                        .id ==
                                                    widget.user.id
                                                ? userData
                                                    .activeThreads[index]
                                                    .lastMessage
                                                    .receiver
                                                    .username
                                                : userData
                                                    .activeThreads[index]
                                                    .lastMessage
                                                    .sender
                                                    .username,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(userData.activeThreads[index]
                                              .lastMessage.content),
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
                                          getDayDiff(userData
                                              .activeThreads[index]
                                              .lastMessage
                                              .createdAt),
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Text(
                                          getTime(userData.activeThreads[index]
                                              .lastMessage.createdAt),
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
