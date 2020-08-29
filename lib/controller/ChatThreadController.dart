import 'package:Chithi/model/ChatThread.dart';
import 'package:Chithi/model/ThreadItem.dart';
import 'package:Chithi/static.dart';
import 'package:dio/dio.dart';

class ChatThreadController {
  static Future<List<ThreadItem>> generateThreads(String token) async {
    Response response;
    Dio dio = new Dio();
    dio.options.headers["authorization"] = "Bearer $token";
    try {
      response = await dio.get(accessThreads);

      List<dynamic> jsons = response.data;
      List<ThreadItem> items = new List<ThreadItem>();
      for (int i = 0; i < jsons.length; i++) {
        Map<String, dynamic> json = jsons[i];
        items.add(ThreadItem.fromJSON(json));
      }
      return items;
    } on DioError catch (error) {
      throw new Exception(error.response.data);
    }
  }

  static Future<ChatThread> accessChatThread(
      String token, String threadID) async {
    Response response;
    Dio dio = new Dio();
    dio.options.headers["authorization"] = "Bearer $token";
    try {
      response = await dio.get(singleThread + threadID);
      ChatThread thread = ChatThread.fromJSON(response.data);
      return thread;
    } on DioError catch (error) {
      throw new Exception(error.response.data);
    }
  }

  static void storeMessage(String token, int sender, int receiver,
      String threadID, String content) async {
    Response response;
    Dio dio = new Dio();
    dio.options.headers["authorization"] = "Bearer $token";
    try {
      response = await dio.post(storeMessageUrl, data: {
        "sender": sender,
        "receiver": receiver,
        "threadID": threadID,
        "content": content
      });
      print(response.statusCode);
    } on DioError catch (error) {
      throw new Exception(error.response.data);
    }
  }
}
