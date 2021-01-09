import 'package:daily_challenge/src/Logger.dart';
import 'package:daily_challenge/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class AppBarPages{
  static AppBar appBarSetting(context){
    AppThemeProvider appThemeProvider = Provider.of<AppThemeProvider>(context);
    return AppBar(actions: [
      IconButton(
        icon: Icon(
            appThemeProvider.isDarkTheme?Icons.brightness_high:Icons.brightness_2
        ),
        onPressed: (){
          appThemeProvider.toggleTheme();
          CustomLogger.log('appbar theme');
        },
      ),
    ],);
  }

}