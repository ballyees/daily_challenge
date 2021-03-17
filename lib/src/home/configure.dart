import 'package:daily_challenge/src/game/home/game_home.dart';
import 'package:daily_challenge/src/history/history_question.dart';
import 'package:daily_challenge/src/profile/profile.dart';
import 'package:daily_challenge/src/rank/rank.dart';
import 'package:daily_challenge/src/setting/setting.dart';
import 'package:ff_navigation_bar/ff_navigation_bar_item.dart';
import 'package:flutter/material.dart';


class ConfigureHomePage {
  static bool isDark = false;
  static int currentPage = 2;
  static const appName = 'Daily Challenge';
  /// App screens
  static final List<dynamic> screens  = <dynamic>[
    ProfilePage(),
    RankPage(),
    GameHome(),
    HistoryQuestionPage(),
    SettingPage()
  ];
  static final List<FFNavigationBarItem> items = <FFNavigationBarItem>[
    FFNavigationBarItem(
      iconData: Icons.account_circle,
      label: 'Profile',
      selectedLabelColor: Colors.white,
      selectedForegroundColor: Colors.white,
    ),
    FFNavigationBarItem(
      iconData: Icons.star,
      label: 'Ranking',
      selectedLabelColor: Colors.white,
      selectedForegroundColor: Colors.white,
    ),
    FFNavigationBarItem(
      iconData: Icons.home,
      label: 'Home',
      selectedLabelColor: Colors.white,
      selectedForegroundColor: Colors.white,
    ),
    FFNavigationBarItem(
      iconData: Icons.history,
      label: 'History',
      selectedLabelColor: Colors.white,
      selectedForegroundColor: Colors.white,
    ),
    FFNavigationBarItem(
      iconData: Icons.settings,
      label: 'Setting',
      selectedLabelColor: Colors.white,
      selectedForegroundColor: Colors.white,
    ),
  ];
}
