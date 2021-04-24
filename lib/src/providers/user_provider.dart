import 'dart:convert';
import 'package:agroxpress/src/models/purchase_model.dart';
import 'package:agroxpress/src/models/user_model.dart';
import 'package:agroxpress/src/utils/user_prefs.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  final _url = "https://agroxpress.herokuapp.com";
  static UserPref _prefs = UserPref();

  final headerOptions = new Options(
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

  /// Obtiene la información completa de un usuario
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
  }

  /// Obtiene las compras realizadas por el usuario logueado
  Future<List<PurchaseModel>> getMyPurchases() async {
    try {
      final resp = await Dio()
          .get("$_url/api/user/get_purchases", options: headerOptions);

      final purchases = Purchases.fromJson(resp.data["purchases"]);

      return purchases.items;
    } catch (e) {
      print("Error al obtener mis compras: ${e.toString()}");
    }
  }
}
