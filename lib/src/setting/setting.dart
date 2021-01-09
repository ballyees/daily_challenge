import 'package:daily_challenge/src/Logger.dart';
import 'package:daily_challenge/src/setting/configure.dart';
import 'package:daily_challenge/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width / 1.25;
    double _paddingTop = MediaQuery.of(context).size.height / 10;
    AppThemeProvider appThemeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: ConfigureSettingPage.appBarTitle,
      ),
      body: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.fromLTRB(0, _paddingTop, 0, 0),
          child: Column(
            children: [
              SizedBox(
                width: _width,
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
              SizedBox(
                width: _width,
                child: RaisedButton(
                  child: Text('BUG REPORT'),
                  onPressed: () {
                    appThemeProvider.toggleTheme();
                    CustomLogger.log('press bug report');
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(color: Colors.black38),
                  ),
                ),
              ),
              SizedBox(
                width: _width,
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
          )),
    );
  }
}
