import 'package:shared_preferences/shared_preferences.dart';

class UserPref {
  static final UserPref _instancia = UserPref._();

  factory UserPref() => _instancia;
  UserPref._();

  SharedPreferences _prefs;

  initPref() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get token => _prefs.getString("token") ?? "";
  set token(String value) => _prefs.setString("token", value);
}
