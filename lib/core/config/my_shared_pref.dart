import 'package:shared_preferences/shared_preferences.dart';

class MySharedPref {
  static const accessToken = "access_token";
  static const userId = "user_id";

  final SharedPreferences _pref;

  MySharedPref(this._pref);

  void saveAccessToken(String token) {
    _pref.setString(accessToken, token);
  }

  String getAccessToken() {
    return _pref.getString(accessToken) ?? "";
  }
}
