import 'package:shared_preferences/shared_preferences.dart';

class CachedHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> savePref({required String key, required dynamic value}) {
    if (value is String) {
      return sharedPreferences!.setString(key, value);
    } else if (value is bool) {
      return sharedPreferences!.setBool(key, value);
    } else if (value is int) {
      return sharedPreferences!.setInt(key, value);
    } else {
      return sharedPreferences!.setDouble(key, value);
    }
  }

  static dynamic getPref({required String key}) {
    return sharedPreferences!.get(key);
  }

  static Future<bool> removePref({required String key}) {
    return sharedPreferences!.remove(key);
  }
}
