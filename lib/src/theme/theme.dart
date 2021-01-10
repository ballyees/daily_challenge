import 'package:daily_challenge/src/Logger.dart';
import 'package:daily_challenge/src/preference_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrimaryTheme {
  static final PrimaryTheme _instance = PrimaryTheme._internal();
  ThemeData _data;
  get theme => _data;

  factory PrimaryTheme() {
    CustomLogger.log('PrimaryTheme: singleton factory');
    return _instance;
  }
  PrimaryTheme._internal() {
    _data = ThemeData(
      brightness: Brightness.light,
      bannerTheme: MaterialBannerThemeData(backgroundColor: Colors.black38),
    );
    CustomLogger.log('PrimaryTheme: singleton created');
  }
}

class DarkTheme {
  static final DarkTheme _instance = DarkTheme._internal();
  ThemeData _data;
  get theme => _data;

  factory DarkTheme() {
    CustomLogger.log('DarkTheme: singleton factory');
    return _instance;
  }
  DarkTheme._internal() {
    _data = ThemeData(
      brightness: Brightness.dark,
      appBarTheme:
          AppBarTheme(brightness: Brightness.dark, color: Colors.amber),
      bannerTheme: MaterialBannerThemeData(backgroundColor: Colors.white),
      backgroundColor: Colors.amber,
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.amber,
        hoverColor: Colors.black,
      ),
    );
    CustomLogger.log('DarkTheme: singleton created');
  }
}

class AppThemeProvider with ChangeNotifier {
  static bool _isDarkTheme;

  static bool get isDarkThemeStatic => _isDarkTheme;
  bool get isDarkTheme => _isDarkTheme;
  static final String darkModeKey = 'darkMode';

  static final AppThemeProvider _instance = AppThemeProvider._internal();
  factory AppThemeProvider() {
    CustomLogger.log('AppTheme: singleton factory');
    return _instance;
  }

  AppThemeProvider._internal() {
    CustomLogger.log('AppTheme: singleton created');
  }

  void _sharedPrefs(isDarkMode) async {
    SharedPreferences prefs = await PreferenceUtils.init();
    prefs.setBool(darkModeKey, isDarkMode);
  }

  ThemeData getTheme({bool isDarkMode}) {
    _isDarkTheme ??= isDarkMode;
    _sharedPrefs(_isDarkTheme);
    return _isDarkTheme ? DarkTheme().theme : PrimaryTheme().theme;
  }

  ThemeData get darkTheme => DarkTheme().theme;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    PreferenceUtils.init()
        .then((prefs) => prefs.setBool(darkModeKey, _isDarkTheme));
    notifyListeners();
  }
}
