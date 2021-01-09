import 'package:daily_challenge/src/Logger.dart';
import 'package:daily_challenge/src/custom_icons/counter.dart';
import 'package:daily_challenge/src/preference_utils.dart';
import 'package:daily_challenge/src/theme/theme.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:morpheus/morpheus.dart';
import 'package:daily_challenge/src/home/configure.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatelessWidget {
  Future<SharedPreferences> _getPrefs() async {
    return await PreferenceUtils.init();
  }

  @override
  Widget build(BuildContext context) {
    AppThemeProvider appThemeProvider = Provider.of<AppThemeProvider>(context);
    return FutureBuilder(
        future: _getPrefs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('app created');
            bool isDarkMode =
                snapshot.data.getBool(AppThemeProvider.darkModeKey) ??
                    (SchedulerBinding.instance.window.platformBrightness ==
                        Brightness.dark);
            return MultiProvider(
                providers: [
                  ChangeNotifierProvider.value(value: CounterProvider()),
                ],
                child: Consumer<AppThemeProvider>(
                  builder: (context, data, child) => MaterialApp(
                    title: 'Daily Challenge',
                    theme: appThemeProvider.getTheme(isDarkMode: isDarkMode),
                    darkTheme:
                        appThemeProvider.getTheme(isDarkMode: isDarkMode),
                    home: HomePage(),
                  ),
                ));
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final _HomePageState _instance = _HomePageState._internal();
  factory _HomePageState() {
    CustomLogger.log('home page: singleton factory');
    return _instance;
  }
  int _currentIndex;
  _HomePageState._internal() {
    CustomLogger.log('home page: singleton created');
    _currentIndex = 2;
  }

  @override
  Widget build(BuildContext context) {
    print('home page: created !!!');
    return Scaffold(
      body: MorpheusTabView(
          child: ConfigureHomePage.screens.elementAt(_currentIndex)),
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
            barBackgroundColor: Colors.black12,
            selectedItemBackgroundColor: AppThemeProvider()
                .getTheme()
                .bottomNavigationBarTheme
                .backgroundColor),
        selectedIndex: _currentIndex, // center
        onSelectTab: _onItemTapped,
        items: ConfigureHomePage.items,
      ),
    );
  }

  void _onItemTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
        CustomLogger.log('change pages!!!');
      });
    }
  }
}
