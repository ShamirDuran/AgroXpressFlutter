import 'dart:convert';
import 'package:agroxpress/src/utils/user_prefs.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  final _url = "https://agroxpress.herokuapp.com";
  final _prefs = UserPref();

  // User login, save token in shared preferences
  Future<bool> loginUser(String email, String password) async {
    final authData = {
      "email": email,
      "password": password,
    };

    final resp = await http.post("$_url/api/login", body: authData);

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp["ok"] == true) {
      print(decodedResp);
      _prefs.token = decodedResp["token"];
      return true;
    } else {
      print(decodedResp);
      return false;
    }
  }

  // User register
  Future<dynamic> registerUser(String email, String password) async {
    final authData = {
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
}
