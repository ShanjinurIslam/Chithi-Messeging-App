import 'package:Telegram/utils/colors.dart';
import 'package:flutter/material.dart';

class ConversationItem extends StatelessWidget {
  int unread = 5;
  final String name;

  ConversationItem({this.name});

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10 * (_height / 896.0)),
      height: 82,
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
                      color: Colors.white, width: 5, style: BorderStyle.solid),
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
                this.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
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
            flex: 2,
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
                  borderRadius: new BorderRadius.circular(26.0),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
