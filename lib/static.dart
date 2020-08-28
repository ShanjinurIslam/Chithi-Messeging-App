//final BASE_URL = 'https://chithiapp.herokuapp.com';
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
