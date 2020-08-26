import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Message {
  String text;
  bool senderType;
  Message(this.text, this.senderType);
}

class ChatThread extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ChatThreadState();
  }
}

class _ChatThreadState extends State<ChatThread> {
  IO.Socket socket;

  final _scrollController = new ScrollController();
  List<Message> messages = [];

  final _textEditingController = new TextEditingController();

  @override
  void initState() {
    socket = IO.io('https://chithiapp.herokuapp.com/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.on('connect', (_) {
      print('connected');
      socket.emit('join', 0);
    });

    socket.on('newUser', (data) => print(data));

    socket.on('receive_message', (data) {
      String message = data.toString();
      setState(() {
        messages.insert(0, new Message(message, false));
        _scrollController.animateTo(_scrollController.position.minScrollExtent,
            duration: Duration(milliseconds: 600), curve: Curves.easeIn);
      });
    });
    socket.on('disconnect', (_) => print('disconnect'));
    super.initState();
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
                    backgroundColor: Colors.grey,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Avatar Name',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        Text('Online Now',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w300)),
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
                          Navigator.pop(context);
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
                  if (messages[index].senderType) {
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
                                  child: Text(messages[index].text),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.all(6),
                              child: Text(
                                '3 minutes ago',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w300),
                              ),
                            )
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
                                child: Text(messages[index].text,
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Spacer()
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.all(6),
                            child: Text(
                              '3 minutes ago',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w300),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                },
                itemCount: messages.length,
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
                        socket.emit('send_message', message);
                        setState(() {
                          _textEditingController.clear();
                          messages.insert(0, new Message(message, true));
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
