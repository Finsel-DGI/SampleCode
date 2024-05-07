import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static late SharedPreferences _prefs;
  // Hidden Constructor
  // i.e : Constructor cannot be called upon this class
  // Initialization should be done using [init()]
  Prefs._();

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveString(String key, String value) =>
      _prefs.setString(key, value);

  static Future<bool> saveBool(String key, bool value) =>
      _prefs.setBool(key, value);

  static String? getString(String key) => _prefs.getString(key);
  static bool getBool(String key) => _prefs.getBool(key) ?? false;

  static deleteString(String key) async {
    _prefs.remove(key);
  }
}
