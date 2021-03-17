import 'package:daily_challenge/src/global_configure.dart';
import 'package:daily_challenge/src/preference_utils.dart';
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {

  String _userId;
  String _username;
  String get userId => _userId;
  String get username => _username;
  static final ProfileProvider _instance = ProfileProvider._internal();

  factory ProfileProvider() {
    print('ProfileProvider: singleton factory');
    return _instance;
  }

  ProfileProvider._internal() {
    setFields();
    print('ProfileProvider: singleton created');
  }

  /// create fields in class
  void setFields() {
    PreferenceUtils.init().then((pref){
      _userId = pref.getString(GlobalConfigure.userIdPrefKey);
      _username = pref.getString(GlobalConfigure.usernamePrefKey);
      print('call set fields');
    });

  }
}
