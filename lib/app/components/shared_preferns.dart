import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPrefs._();
  static SharedPreferences? pref;
  static var keys = _Keys();
}

class _Keys {
  String authToken = "authToken";
  String userId = "userId";
  String fcmToken = "fcmToken";
  String? userData = "userData";
}
