import 'package:Chithi/model/User.dart';
import 'package:Chithi/static.dart';
import 'package:dio/dio.dart';
import 'dart:io';

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
    } on DioError catch (error) {
      throw new Exception(error.response.data);
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
    } on DioError catch (error) {
      throw new Exception(error.response.data);
    }
  }

  // ignore: missing_return
  static Future<int> uploadAvatar(File _image, String token) async {
    Response response;
    Dio dio = new Dio();
    dio.options.headers["authorization"] = "Bearer $token";

    FormData formData = FormData.fromMap({
      "avatar":
          await MultipartFile.fromFile(_image.path, filename: "avatar.jpg"),
    });

    try {
      response = await dio.post(uploadAvatarUrl, data: formData);
      if (response.statusCode == 200) {
        return 200;
      }
    } on DioError catch (error) {
      throw new Exception(error.response.data);
    }
  }

  // ignore: missing_return
  static Future<int> logOut(String token) async {
    Response response;
    Dio dio = new Dio();
    dio.options.headers["authorization"] = "Bearer $token";
    try {
      response = await dio.post(logOutUrl);
      if (response.statusCode == 200) {
        return 200;
      }
    } on DioError catch (error) {
      throw new Exception(error.response.data);
    }
  }
}
