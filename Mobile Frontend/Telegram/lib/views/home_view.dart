import 'package:Telegram/controller/ConversationItemController.dart';
import 'package:Telegram/model/conversation_item_model.dart';
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
  List<ConversationItemModel> items = new List<ConversationItemModel>();
  List<ConversationItemModel> all = new List<ConversationItemModel>();
  List<String> categories = [
    'All',
    'Pinned',
    'Read',
    'Unread',
  ];

  String current = "All";

  void generate() async {
    this.items = await ConversationItemController.generateItems(context);
    this.all = List.of(items);
    this.setState(() {});
  }

  @override
  void initState() {
    super.initState();
    generate();
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
                        .map((e) => GestureDetector(
                              onTap: () {
                                current = e;
                                if (e == "All") {
                                  this.items = List.of(all);
                                } else if (e == "Pinned") {
                                  this.items = all
                                      .where(
                                          (element) => element.pinned == true)
                                      .toList();
                                } else if (e == "Read") {
                                  this.items = all
                                      .where((element) => element.read == true)
                                      .toList();
                                } else {
                                  this.items = all
                                      .where((element) => element.read == false)
                                      .toList();
                                }
                                setState(() {});
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
                ),

                Expanded(
                  child: NotificationListener<ScrollUpdateNotification>(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                          key: Key(UniqueKey().toString()),
                          dismissal: SlidableDismissal(
                            child: SlidableDrawerDismissal(),
                            onDismissed: (actionType) {
                              setState(() {
                                items.removeAt(index);
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
                              caption:
                                  this.items[index].pinned ? 'Unpin' : 'Pin',
                              color: Colors.blue,
                              icon: Icons.star,
                              onTap: () {
                                this.all[index].pinned =
                                    !this.all[index].pinned;
                                this.items = List.of(this.all);
                                setState(() {});
                              },
                            ),
                          ],
                          secondaryActions: <Widget>[
                            IconSlideAction(
                              caption:
                                  this.items[index].read ? 'Read' : 'Unread',
                              color: Colors.black45,
                              icon: Icons.markunread,
                              onTap: () {
                                this.all[index].read = !this.all[index].read;
                                this.items = List.of(this.all);
                                setState(() {});
                              },
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
                              userName: items[index].userName,
                              lastMessage: items[index].lastMessage,
                              lastMessageTime: items[index].lastMessageTime,
                              profileImageLink: items[index].profileImageLink,
                              unseen: items[index].unseen,
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
