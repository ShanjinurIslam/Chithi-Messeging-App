//final BASE_URL = 'https://chithiapp.herokuapp.com';
import 'package:intl/intl.dart';

final socketUrl = 'https://chithiapp.herokuapp.com/';
final baseUrl = 'https://chithiapp.herokuapp.com/api';
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
final checkThread = baseUrl + '/checkThreadExists';

String getTime(DateTime time) {
  return new DateFormat.jm().format(time).toString();
}

String getDayDiff(DateTime time) {
  int days = DateTime.now().toUtc().difference(time).inDays;

  if (days == 0) {
    if (time.day != DateTime.now().toUtc().day) {
      return 'Yesterday';
    } else {
      return 'Today';
    }
  } else {
    return days.toString() + ' days before';
  }
}
