import 'dart:convert';
import 'package:Telegram/model/conversation_item_model.dart';
import 'package:flutter/material.dart';

class ConversationItemController {
  static Future<List<ConversationItemModel>> generateItems(
          BuildContext context) async =>
      await DefaultAssetBundle.of(context)
          .loadString("assets/data.json")
          .then((value) {
        List<dynamic> jsonResult = jsonDecode(value);
        List<ConversationItemModel> items = new List<ConversationItemModel>();
        for (var each in jsonResult) {
          Map<String, dynamic> json = each;
          items.add(ConversationItemModel.from(json));
        }
        return items;
      });
}
