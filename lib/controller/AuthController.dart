import 'package:Chithi/model/User.dart';
import 'package:Chithi/static.dart';
import 'package:dio/dio.dart';

class AuthController {
  static Future<User> signUp(String username, String password) async {
    Response response;
    Dio dio = new Dio();
    try {
      response = await dio.post(createUserUrl,
          data: {"username": username, "password": password});
      Map<String, dynamic> json = response.data;
      User user = User.fromJson(json);
      return user;
    } catch (error) {
      throw new Exception(error);
    }
  }

  static Future<User> logIn(String username, String password) async {
    Response response;
    Dio dio = new Dio();
    try {
      response = await dio
          .post(logInUrl, data: {"username": username, "password": password});
      Map<String, dynamic> json = response.data;
      User user = User.fromJson(json);
      return user;
    } catch (error) {
      throw new Exception(error);
    }
  }
}
