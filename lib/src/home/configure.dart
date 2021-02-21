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
    GameHome(),
    ProfilePage(),
    RankPage(),
    HistoryQuestionPage(),
    SettingPage()
  ];
  static final List<FFNavigationBarItem> items = <FFNavigationBarItem>[
    FFNavigationBarItem(
      iconData: Icons.home,
      label: 'Home',
    ),
    FFNavigationBarItem(
      iconData: Icons.account_circle,
      label: 'Profile',
    ),
    FFNavigationBarItem(
      iconData: Icons.star,
      label: 'Ranking',
    ),
    FFNavigationBarItem(
      iconData: Icons.history,
      label: 'History',
    ),
    FFNavigationBarItem(
      iconData: Icons.settings,
      label: 'Setting',
    ),
  ];
}
