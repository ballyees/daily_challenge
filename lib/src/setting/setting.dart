import 'package:daily_challenge/src/Logger.dart';
import 'package:daily_challenge/src/appbar/appbar.dart';
import 'package:daily_challenge/src/preference_utils.dart';
import 'package:daily_challenge/src/setting/bug_report.dart';
import 'package:daily_challenge/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width / 1.25;
    double _paddingTop = MediaQuery.of(context).size.height / 15;
    AppThemeProvider appThemeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBarPages.appBarSetting(context),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.fromLTRB(0, _paddingTop, 0, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        child: Text('ABOUT US'),
                        onPressed: () {
                          CustomLogger.log('press about us');
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: Colors.black38),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        child: Text('BUG REPORT'),
                        onPressed: () {
                          // appThemeProvider.toggleTheme();
                          CustomLogger.log('press bug report');
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => BugReportPage(),));
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: Colors.black38),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        child: Text('SWITCH USER'),
                        onPressed: () {
                          CustomLogger.log('press switch user');
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: Colors.black38),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        child: Text('REFRESH PREF'),
                        onPressed: () {
                          CustomLogger.log('press pref');
                          PreferenceUtils.clear();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: Colors.black38),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
