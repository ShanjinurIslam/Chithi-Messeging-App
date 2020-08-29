import 'package:Chithi/controller/ChatThreadController.dart';
import 'package:Chithi/model/Message.dart';
import 'package:Chithi/model/User.dart';
import 'package:Chithi/model/ChatThread.dart';
import 'package:Chithi/model/UserData.dart';
import 'package:Chithi/view/Chats.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../static.dart';

// ignore: must_be_immutable
class ChatThreadView extends StatefulWidget {
  final User user;
  final User receiver;
  final Socket socket;
  String threadID;
  final UserData userData;

  ChatThreadView({
    this.userData,
    this.user,
    this.receiver,
    this.threadID,
    this.socket,
  });

  @override
  State<StatefulWidget> createState() {
    return new _ChatThreadState();
  }
}

class _ChatThreadState extends State<ChatThreadView> {
  ChatThread chatThread = new ChatThread();

  final _scrollController = new ScrollController();

  final _textEditingController = new TextEditingController();

  void getChat() async {
    if (widget.threadID != null) {
      chatThread = await ChatThreadController.accessChatThread(
          widget.user.token, widget.threadID);
      setState(() {});
    } else {
      try {
        widget.threadID = await ChatThreadController.getChatThread(
            widget.user.token, widget.receiver.id);
        chatThread = await ChatThreadController.accessChatThread(
            widget.user.token, widget.threadID);
        setState(() {});
      } catch (error) {
        widget.threadID = Uuid().v4().toString();
        print(widget.threadID);
        setState(() {});
      }
      // find common chat thread id, have to write an api
    }
  }

  @override
  void initState() {
    super.initState();
    getChat();
    widget.socket.on('receive_message', (map) {
      print(map);

      if (map['sender']['_id'].toString() == widget.receiver.id.toString()) {
        Message message = new Message(
            sender: widget.receiver,
            receiver: widget.user,
            content: map['content'],
            createdAt: DateTime.now().toUtc());
        chatThread.messages.insert(0, message);
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    widget.socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(25, 26, 25, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        NetworkImage(getAvatar + widget.receiver.id.toString()),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.receiver.username,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        /*
                        Text('Online Now',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w300)),*/
                      ],
                    ),
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.socket.disconnect();
                          Navigator.of(context).pushReplacement(
                              new PageRouteBuilder(
                                  pageBuilder: (BuildContext context, _, __) {
                            return new Chats(widget.user);
                          }, transitionsBuilder: (_,
                                      Animation<double> animation,
                                      __,
                                      Widget child) {
                            return new FadeTransition(
                                opacity: animation, child: child);
                          }));
                        },
                        child: Icon(
                          CupertinoIcons.clear,
                          size: 45,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                reverse: true,
                controller: _scrollController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  if (chatThread.messages[index].sender.id == widget.user.id) {
                    return Padding(
                        padding: EdgeInsets.only(
                            left: 30, right: 30, top: 7.5, bottom: 7.5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: 270,
                                  padding: EdgeInsets.all(15),
                                  child:
                                      Text(chatThread.messages[index].content),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.all(6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    getDayDiff(
                                        chatThread.messages[index].createdAt),
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Text(
                                    ' ',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Text(
                                    getTime(
                                        chatThread.messages[index].createdAt),
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ));
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: 30, right: 30, top: 7.5, bottom: 7.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(10)),
                                width: 270,
                                padding: EdgeInsets.all(15),
                                child: Text(chatThread.messages[index].content,
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Spacer()
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.all(6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getDayDiff(
                                      chatThread.messages[index].createdAt),
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  ' ',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  getTime(chatThread.messages[index].createdAt),
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                },
                itemCount: chatThread.messages.length,
              ),
            ),
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.withOpacity(.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50,
                    width: 270,
                    child: TextField(
                      controller: _textEditingController,
                      cursorColor: Colors.black,
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white70,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: 'Type your message'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      if (_textEditingController.text.isNotEmpty) {
                        String message = _textEditingController.text;
                        /*
                        socket.emit('send_message', message);*/
                        setState(() {
                          _textEditingController.clear();
                          chatThread.messages.insert(
                              0,
                              new Message(
                                  sender: widget.user,
                                  receiver: widget.receiver,
                                  content: message,
                                  createdAt: DateTime.now().toUtc()));

                          var object = {
                            'sender': {
                              '_id': widget.user.id,
                              'username': widget.user.username
                            },
                            'receiver': {
                              '_id': widget.receiver.id,
                              'username': widget.receiver.username
                            },
                            'content': message,
                            'threadID': widget.threadID,
                            'createdAt': DateTime.now().toUtc().toString()
                          };

                          widget.socket.emit('send_message', object);

                          int index =
                              widget.userData.findIndex(widget.threadID);
                          if (index != -1) {
                            widget.userData.updateActiveThread(index, message);
                          } else {
                            widget.userData.addActiveThread(object);
                          }

                          ChatThreadController.storeMessage(
                              widget.user.token,
                              widget.user.id,
                              widget.receiver.id,
                              widget.threadID,
                              message);
                          _scrollController.animateTo(
                              _scrollController.position.minScrollExtent,
                              duration: Duration(milliseconds: 600),
                              curve: Curves.easeIn);
                        });
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
