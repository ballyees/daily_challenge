import 'package:daily_challenge/src/custom_icons/counter.dart';
import 'package:daily_challenge/src/setting/setting.dart';
import 'package:ff_navigation_bar/ff_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ConfigureHomePage {
  static bool isDark = false;
  static const appName = 'Daily Challenge';
  /// App screens
  static final List<Widget> screens  = <Widget>[
    ChangeNotifierProvider.value(child: CounterPage(), value: CounterProvider(),),
    Scaffold(backgroundColor: Colors.red),
    Scaffold(backgroundColor: Colors.blue),
    Scaffold(backgroundColor: Colors.black),
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
