import 'dart:convert';
import 'package:agroxpress/src/models/user_model.dart';
import 'package:agroxpress/src/utils/user_prefs.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  final _url = "https://agroxpress.herokuapp.com";
  static UserPref _prefs = UserPref();

  final _headerOptions = new Options(
    contentType: "application/json",
    headers: {"authorization": _prefs.token},
  );

  // User login, save token in shared preferences
  Future<bool> loginUser(String email, String password) async {
    final authData = {
      "email": email,
      "password": password,
    };

    final resp = await http.post("$_url/api/login", body: authData);

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp["ok"] == true) {
      _prefs.token = decodedResp["token"];
      _prefs.id = decodedResp["user"]["_id"];
      _prefs.name = decodedResp["user"]["name"];
      _prefs.surname = decodedResp["user"]["surname"];
      _prefs.image = decodedResp["user"]["img"] ?? "";
      return true;
    } else {
      print(decodedResp);
      return false;
    }
  }

  // User register
  Future<dynamic> registerUser(
      String name, String surname, String email, String password) async {
    final authData = {
      "name": name,
      "surname": surname,
      "email": email,
      "password": password,
    };

    final resp = await http.post("$_url/api/signup", body: authData);

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp["ok"] == true) {
      return true;
    } else {
      print(decodedResp);
      return decodedResp["errors"]["email"];
    }
  }

  Future<UserModel> getUserData(String id) async {
    final uri =
        Uri.https("agroxpress.herokuapp.com", "/api/user/get_information", {
      'id_user': id,
    });

    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "authorization": _prefs.token,
    });

    final decodedData = json.decode(response.body);
    if (decodedData["ok"]) {
      return UserModel.fromJson(decodedData["user"]);
    } else {
      print("Error obteniendo data user, ${decodedData["message"]}");
      return null;
    }

    // try {
    //   print("{$_url/api/user/get_information}");

    //   final resp = await Dio().post(
    //     "$_url/api/user/get_information",
    //     queryParameters: {"id_user": id,},
    //     options: _headerOptions,
    //   );

    //   return UserModel.fromJson(resp.data["user"]);
    // } catch (e) {
    //   print("Error al tratar de obtener data del usuario: ${e.toString()}");
    //   return null;
    // }
  }
}
