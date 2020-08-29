import 'package:Chithi/model/ThreadItem.dart';
import 'package:Chithi/model/Message.dart';
import 'package:Chithi/model/User.dart';

class UserData {
  List<ThreadItem> activeThreads = new List<ThreadItem>();

  int findIndex(String threadID) {
    return activeThreads.indexWhere((element) => element.threadID == threadID);
  }

  void addActiveThread(Map<String, dynamic> data) {
    ThreadItem item = ThreadItem(
        threadID: data['threadID'],
        lastMessage: new Message(
            createdAt: DateTime.now().toUtc(),
            content: data['content'],
            receiver: new User(
                id: data['receiver']['_id'],
                username: data['receiver']['username']),
            sender: new User(
                id: data['sender']['_id'],
                username: data['sender']['username'])));
    activeThreads.insert(0, item);
  }

  void updateActiveThread(int index, String content) {
    activeThreads[index].lastMessage.content = content;
    activeThreads[index].lastMessage.createdAt = DateTime.now().toUtc();

    var temp = activeThreads[index];
    activeThreads.removeAt(index);
    activeThreads.insert(0, temp);
  }
}
