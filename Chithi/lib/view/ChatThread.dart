import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatThread extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ChatThreadState();
  }
}

class _ChatThreadState extends State<ChatThread> {
  final _controller = new ScrollController();

  List<String> chat = [
    'Just reached my new location mate',
    'Please come more closer, I can see you standing near the bar. Come 10 steps forward mate',
    'Cool, I am standing in front of local bar. See',
    'Still can’t see you anywhere. Minding sharing your location to me',
    'Here you go mate.'
  ].reversed.toList();

  final _textEditingController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
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
              padding: EdgeInsets.fromLTRB(33, 26, 25, 20),
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
                controller: _controller,
                reverse: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  if (index % 2 == 0) {
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
                                  child: Text(chat[index]),
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
                                child: Text(chat[index]),
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
                itemCount: chat.length,
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
                      setState(() {
                        chat.insert(0, _textEditingController.text);
                        _textEditingController.clear();
                      });
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
