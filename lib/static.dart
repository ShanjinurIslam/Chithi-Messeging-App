//final BASE_URL = 'https://chithiapp.herokuapp.com';
import 'package:intl/intl.dart';

final socketUrl = 'http://192.168.0.101:3000/';
final baseUrl = 'http://192.168.0.101:3000/api';
final createUserUrl = baseUrl + '/user/create';

// all of these will require auth token
final readUserUrl = baseUrl + '/user/read';
final updateUserUrl = baseUrl + '/user/update';
final uploadAvatarUrl = baseUrl + '/user/upload';
final getAvatar = baseUrl + '/user/avatar/';
final deleteUser = '/user/delete';

final logInUrl = baseUrl + '/login';

// this will require auth token
final logOutUrl = baseUrl + '/logout';

final accessThreads = baseUrl + '/threads';
final storeMessageUrl = baseUrl + '/store_message';
final singleThread = baseUrl + '/threads/';

String getTime(DateTime time) {
  return new DateFormat.jm().format(time).toString();
}

String getDayDiff(DateTime time) {
  int days = DateTime.now().difference(time).inDays;

  if (days == 0) {
    if (time.day != DateTime.now().day) {
      return 'Yesterday';
    } else {
      return 'Today';
    }
  } else {
    return days.toString() + ' days before';
  }
}
