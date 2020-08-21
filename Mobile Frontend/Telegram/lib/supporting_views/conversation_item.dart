import 'package:Telegram/utils/colors.dart';
import 'package:flutter/material.dart';

class ConversationItem extends StatelessWidget {
  final String userName;
  final String lastMessage;
  final String lastMessageTime;
  final int unseen;
  final String profileImageLink;

  ConversationItem(
      {this.userName,
      this.lastMessage,
      this.lastMessageTime,
      this.unseen,
      this.profileImageLink});

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10 * (_height / 896.0)),
      height: 82,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(this.profileImageLink),
                backgroundColor: Colors.transparent,
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
                this
                    .userName
                    .trim()
                    .substring(0, userName.length > 15 ? 15 : userName.length),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                lastMessage.substring(0, 20),
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
                lastMessageTime,
                style: TextStyle(color: customGray),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: Center(
                  child: Text(
                    unseen.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                width: unseen > 10 ? 44 : 26,
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
