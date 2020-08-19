import 'package:Telegram/utils/colors.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomeState();
  }
}

class _HomeState extends State<HomeView> {
  List<String> categories = [
    'All',
    'Pinned',
    'Read',
    'Unread',
    'Muted',
  ];

  int current = 0;
  int unread = 100;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(27 * (414 / _width),
                      27 * (_height / 896.0), 15 * (414 / _width), 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Telegram",
                        style: TextStyle(
                            color: customBlue,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.add,
                                color: customBlue,
                                size: 30,
                              ),
                              onPressed: () => {}),
                          IconButton(
                              icon: Icon(
                                Icons.search,
                                color: customBlue,
                                size: 30,
                              ),
                              onPressed: () => {}),
                          IconButton(
                              icon: Icon(
                                Icons.menu,
                                color: customBlue,
                                size: 30,
                              ),
                              onPressed: () => {}),
                        ],
                      )
                    ],
                  ),
                ), // Header section ends here

                new Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  height: 40 * (_height / 896.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: index == 0
                            ? EdgeInsets.fromLTRB(20 * (414 / _width), 0, 0, 0)
                            : EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          color: current == index ? customBlue : null,
                          onPressed: () {
                            setState(() {
                              this.current = index;
                            });
                          },
                          child: Text(
                            categories[index],
                            style: TextStyle(
                                fontSize: 15,
                                color: current == index
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      );
                    },
                    itemCount: categories.length,
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.all(20 * (414 / _width)),
                        height: 82 * (_height / 896.0),
                        child: Row(
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  child: Image.asset('images/profile.png'),
                                  radius: 41,
                                ),
                                Container(
                                  //color: Colors.white,
                                  height: 23,
                                  width: 23,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                    border: new Border.all(
                                        color: Colors.white,
                                        width: 5,
                                        style: BorderStyle.solid),
                                  ),
                                )
                              ],
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Lisa Summer",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Why did you do that?",
                                  style: TextStyle(
                                      color: customBlue,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 17),
                                )
                              ],
                            ),
                            Spacer(
                              flex: 4,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "03:35PM",
                                  style: TextStyle(color: customGray),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: Center(
                                    child: Text(
                                      unread.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  width: unread > 10 ? 44 : 26,
                                  height: 26,
                                  decoration: new BoxDecoration(
                                    color: customBlue,
                                    borderRadius:
                                        new BorderRadius.circular(26.0),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
