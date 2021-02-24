import 'package:shared_preferences/shared_preferences.dart';

class UserPref {
  static final UserPref _instancia = UserPref._();

  factory UserPref() => _instancia;
  UserPref._();

  SharedPreferences _prefs;

  initPref() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // Getters
  get token => _prefs.getString("token") ?? "";
  get id => _prefs.getString("id") ?? "";
  get name => _prefs.getString("name") ?? "";
  get surname => _prefs.getString("surname") ?? "";
  get image => _prefs.getString("image") ?? "";

  // Setters
  set token(String value) => _prefs.setString("token", value);
  set id(String value) => _prefs.setString("id", value);
  set name(String value) => _prefs.setString("name", value);
  set surname(String value) => _prefs.setString("surname", value);
  set image(String value) => _prefs.setString("image", value);
}
