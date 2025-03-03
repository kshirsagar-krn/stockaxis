
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  static String? getString(String key) => _prefs.getString(key);

  static Future<void> remove(String key) async {
    await _prefs.remove(key);
  }
}