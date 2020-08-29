import 'package:Chithi/controller/ChatThreadController.dart';
import 'package:Chithi/model/Message.dart';
import 'package:Chithi/model/ThreadItem.dart';
import 'package:Chithi/model/User.dart';
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
  List<ThreadItem> activeThreads = new List<ThreadItem>();

  void generateThreads() async {
    activeThreads =
        await ChatThreadController.generateThreads(widget.user.token);
    setState(() {});
  }

  @override
  void initState() {
    _socket = io(socketUrl, <String, dynamic>{
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
    generateThreads();

    _socket.on('active_list', (activeList) {
      if (activeList != 0) {
        for (var active in activeList) {
          friends.add(User.fromJson(active));
        }

        setState(() {});
      }
    });

    _socket.on('new_user', (user) {
      friends.add(User.fromJson(user));
      setState(() {});
    });
    _socket.on('remove_user', (user) {
      friends = friends.where((element) => element.id != user['_id']).toList();
      setState(() {});
    });

    _socket.on('thread_update', (data) {
      print(data);
      int index = activeThreads
          .indexWhere((element) => element.threadID == data['threadID']);

      if (index != -1) {
        activeThreads[index].lastMessage.content = data['content'];
        activeThreads[index].lastMessage.createdAt = DateTime.now();

        var temp = activeThreads[index];
        activeThreads.removeAt(index);
        activeThreads.insert(0, temp);
      } else {
        print('I am here' + data.toString());
        ThreadItem item = ThreadItem(
            threadID: data['threadID'],
            lastMessage: new Message(
                createdAt: DateTime.now(),
                content: data['content'],
                receiver: new User(
                    id: data['receiver']['_id'],
                    username: data['receiver']['username']),
                sender: new User(
                    id: data['sender']['_id'],
                    username: data['sender']['username'])));
        activeThreads.insert(0, item);
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
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
                                  Navigator.of(context).push(
                                      new PageRouteBuilder(pageBuilder:
                                          (BuildContext context, _, __) {
                                    return new ChatThreadView(
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
                      itemCount: activeThreads.length,
                      itemBuilder: (BuildContext context, int index) {
                        User receiver;
                        if (activeThreads[index].lastMessage.sender.id ==
                            widget.user.id) {
                          receiver = activeThreads[index].lastMessage.receiver;
                        } else {
                          receiver = activeThreads[index].lastMessage.sender;
                        }

                        return FlatButton(
                            onPressed: () {
                              Navigator.of(context).push(new PageRouteBuilder(
                                  pageBuilder: (BuildContext context, _, __) {
                                return new ChatThreadView(
                                    user: widget.user,
                                    socket: _socket,
                                    receiver: receiver,
                                    threadID: activeThreads[index].threadID);
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
                                            activeThreads[index]
                                                        .lastMessage
                                                        .sender
                                                        .id ==
                                                    widget.user.id
                                                ? activeThreads[index]
                                                    .lastMessage
                                                    .receiver
                                                    .username
                                                : activeThreads[index]
                                                    .lastMessage
                                                    .sender
                                                    .username,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(activeThreads[index]
                                              .lastMessage
                                              .content),
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
                                          getDayDiff(activeThreads[index]
                                              .lastMessage
                                              .createdAt),
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Text(
                                          getTime(activeThreads[index]
                                              .lastMessage
                                              .createdAt),
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
