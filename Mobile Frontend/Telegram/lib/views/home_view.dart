import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:Telegram/supporting_views/conversation_item.dart';
import 'package:Telegram/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomeState();
  }
}

class _HomeState extends State<HomeView> {
  List<DisplayMode> modes = <DisplayMode>[];
  DisplayMode selected;
  List<String> categories = [
    'All',
    'Pinned',
    'Read',
    'Unread',
  ];

  List<String> names = [
    "John",
    "Elita",
    "Max",
    "Frank",
    "Ronaldo",
    "Liam",
    "Emma",
    "Noah",
    "Olivia",
    "William",
    "Ava",
    "James",
    "Isabella"
        "Oliver",
    "Sophia",
    "Benjamin",
    "Charlotte"
        "Elijah",
    "Mia",
    "Lucas",
    "Amelia",
    "Mason",
    "Harper"
        "Logan",
    "Evelyn"
  ];

  bool isScrolling = false;

  String current = "All";

  Future<void> fetchModes() async {
    try {
      modes = await FlutterDisplayMode.supported;
      modes.forEach(print);

      /// On OnePlus 7 Pro:
      /// #1 1080x2340 @ 60Hz
      /// #2 1080x2340 @ 90Hz
      /// #3 1440x3120 @ 90Hz
      /// #4 1440x3120 @ 60Hz
      /// On OnePlus 8 Pro:
      /// #1 1080x2376 @ 60Hz
      /// #2 1440x3168 @ 120Hz
      /// #3 1440x3168 @ 60Hz
      /// #4 1080x2376 @ 120Hz
    } on PlatformException catch (e) {
      print(e);

      /// e.code =>
      /// noAPI - No API support. Only Marshmallow and above.
      /// noActivity - Activity is not available. Probably app is in background
    }
    selected =
        modes.firstWhere((DisplayMode m) => m.selected, orElse: () => null);
    if (mounted) {
      setState(() {});
    }
  }

  Future<DisplayMode> getCurrentMode() async {
    return await FlutterDisplayMode.current;
  }

  void set90HzMode() async {
    modes = await FlutterDisplayMode.supported;
    if (modes.length > 0) {
      await FlutterDisplayMode.setMode(modes[1]);
    }
  }

  @override
  void initState() {
    super.initState();
    set90HzMode();
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

                Container(
                  //key: UniqueKey(),
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  height: 40 * (_height / 896.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: categories
                        .map((e) => InkWell(
                              borderRadius: BorderRadius.circular(26.0),
                              onTap: () {
                                setState(() {
                                  current = e;
                                });
                              },
                              child: AnimatedSwitcher(
                                  duration: Duration(milliseconds: 300),
                                  switchInCurve: Curves.easeIn,
                                  switchOutCurve: Curves.easeOut,
                                  child: current == e
                                      ? Container(
                                          margin:
                                              EdgeInsets.fromLTRB(5, 0, 5, 0),
                                          width: 80,
                                          height: 44,
                                          key: UniqueKey(),
                                          decoration: BoxDecoration(
                                            color: customBlue,
                                            borderRadius:
                                                new BorderRadius.circular(26.0),
                                          ),
                                          child: Center(
                                            child: Text(
                                              e,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          margin:
                                              EdgeInsets.fromLTRB(5, 0, 5, 0),
                                          width: 80,
                                          height: 50,
                                          key: UniqueKey(),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                new BorderRadius.circular(26.0),
                                          ),
                                          child: Center(
                                            child: Text(
                                              e,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        )),
                            ))
                        .toList(),
                  ),
                  /*
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                borderRadius: BorderRadius.circular(26.0),
                                onTap: () {
                                  setState(() {
                                    current = index;
                                  });
                                },
                                child: AnimatedSwitcher(
                                    duration: Duration(milliseconds: 300),
                                    switchInCurve: Curves.easeIn,
                                    switchOutCurve: Curves.easeOut,
                                    child: current == index
                                        ? Container(
                                            margin: index == 0
                                                ? EdgeInsets.fromLTRB(
                                                    27 * (414 / _width),
                                                    0,
                                                    5,
                                                    0)
                                                : EdgeInsets.fromLTRB(
                                                    5, 0, 5, 0),
                                            width: 80,
                                            height: 45,
                                            key: UniqueKey(),
                                            decoration: BoxDecoration(
                                              color: customBlue,
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      26.0),
                                            ),
                                            child: Center(
                                              child: Text(
                                                categories[index],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            margin: index == 0
                                                ? EdgeInsets.fromLTRB(
                                                    27 * (414 / _width),
                                                    0,
                                                    5,
                                                    0)
                                                : EdgeInsets.fromLTRB(
                                                    5, 0, 5, 0),
                                            width: 80,
                                            height: 50,
                                            key: UniqueKey(),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      26.0),
                                            ),
                                            child: Center(
                                              child: Text(
                                                categories[index],
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          )),
                              );
                            },
                            itemCount: categories.length,
                          ),*/
                ),

                Expanded(
                  child: NotificationListener<ScrollUpdateNotification>(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: names.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                          key: Key(UniqueKey().toString()),
                          dismissal: SlidableDismissal(
                            child: SlidableDrawerDismissal(),
                            onDismissed: (actionType) {
                              setState(() {
                                names.removeAt(index);
                              });
                            },
                            dismissThresholds: <SlideActionType, double>{
                              SlideActionType.primary: 1.0
                            },
                          ),
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.25,
                          actions: <Widget>[
                            IconSlideAction(
                              caption: 'Archive',
                              color: Colors.blue,
                              icon: Icons.archive,
                              onTap: () => {},
                            ),
                          ],
                          secondaryActions: <Widget>[
                            IconSlideAction(
                              caption: 'More',
                              color: Colors.black45,
                              icon: Icons.more_horiz,
                              onTap: () {},
                            ),
                            IconSlideAction(
                              caption: 'Delete',
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () {
                                //names.removeAt(index);
                              },
                            ),
                          ],
                          child: FlatButton(
                            onPressed: () => {},
                            child: ConversationItem(
                              name: names[index],
                            ),
                          ),
                        );
                      },
                    ),
                    onNotification: (notification) {
                      /*
                      if (notification.metrics.pixels >
                              notification.metrics.minScrollExtent &&
                          isScrolling == false) {
                        isScrolling = true;
                        setState(() {});
                      }

                      if (notification.metrics.pixels ==
                              notification.metrics.minScrollExtent &&
                          isScrolling == true) {
                        isScrolling = false;
                        setState(() {});
                      }*/

                      return true;
                    },
                  ),
                ),
              ],
            )));
  }
}
