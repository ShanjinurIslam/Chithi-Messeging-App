import 'package:flutter/material.dart';

class Chats extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatState();
  }
}

class _ChatState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      bottom: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(33),
            child: Row(
              children: [
                Text(
                  'Chats',
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.w400),
                ),
                Spacer()
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(33, 0, 33, 0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Search', prefixIcon: Icon(Icons.search)),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 33, 0, 13),
            child: Container(
              height: 70,
              child: ListView.builder(
                padding: EdgeInsets.only(left: 33),
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
            padding: EdgeInsets.fromLTRB(33, 20, 33, 33),
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
                  padding: EdgeInsets.only(top: 20),
                  physics: BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.fromLTRB(33, 13.5, 33, 13.5),
                      height: 50,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey,
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'data',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text('data'),
                              ],
                            ),
                          ),
                          Spacer(
                            flex: 9,
                          ),
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
                    );
                  }))
        ],
      ),
    ));
  }
}
