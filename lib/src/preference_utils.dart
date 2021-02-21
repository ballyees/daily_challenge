import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();

  static SharedPreferences _prefsInstance;

  static void remove(String key) {
    _prefsInstance.remove(key);
  }

  static void clear() {
    _prefsInstance.clear();
  }

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static int getInt(String key, [int defValue]) {
    return _prefsInstance.getInt(key) ?? defValue ?? 0;
  }

  static Future<bool> setInt(String key, int value) async {
    return _prefsInstance?.setInt(key, value) ?? Future.value(false);
  }

  bool getBool(String key, [bool defValue]) {
    return _prefsInstance.getBool(key) ?? defValue ?? true;
  }

  Future<bool> setBool(String key, bool value) async {
    return _prefsInstance?.setBool(key, value) ?? Future.value(false);
  }

  static String getString(String key, [String defValue]) {
    return _prefsInstance.getString(key) ?? defValue ?? "";
  }

  static Future<bool> setString(String key, String value) async {
    return _prefsInstance?.setString(key, value) ?? Future.value(false);
  }

  static double getDouble(String key, [double defValue]) {
    return _prefsInstance.getDouble(key) ?? defValue ?? 0.0;
  }

  static Future<bool> setDouble(String key, double value) async {
    return _prefsInstance?.setDouble(key, value) ?? Future.value(false);
  }
}
