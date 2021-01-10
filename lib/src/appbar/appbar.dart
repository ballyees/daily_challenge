import 'dart:math';

import 'package:daily_challenge/src/Logger.dart';
import 'package:daily_challenge/src/home/home.dart';
import 'package:daily_challenge/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarPages {
  static AppBar appBarSetting(context) {
    AppThemeProvider appThemeProvider = Provider.of<AppThemeProvider>(context);
    return AppBar(
      actions: [
        IconButton(
          icon: Transform.rotate(
              angle: appThemeProvider.isDarkTheme ? 0 : pi * 2.5 / 3,
              child: Icon(
                appThemeProvider.isDarkTheme
                    ? Icons.lightbulb_outline
                    : Icons.brightness_3,
              )),
          onPressed: () {
            appThemeProvider.toggleTheme();
            CustomLogger.log('appbar theme');
          },
        ),
      ],
    );
  }

  static AppBar appBarGameHome(context) {
    AppThemeProvider appThemeProvider = Provider.of<AppThemeProvider>(context);
    PageIndexProvider pageIndexProvider = Provider.of<PageIndexProvider>(context);
    double _appBarHeight = AppBar().preferredSize.height;
    double _itemSize = _appBarHeight * 0.7;
    double _spaceSize = _appBarHeight / 4;
    return AppBar(
      actions: [
        SizedBox(
            height: _itemSize,
            width: _itemSize,
            child: RawMaterialButton(
              child: Transform.rotate(
                  angle: appThemeProvider.isDarkTheme ? 0 : pi * 2.5 / 3,
                  child: Icon(
                    appThemeProvider.isDarkTheme
                        ? Icons.lightbulb_outline
                        : Icons.brightness_3,
                    size: _itemSize,
                  )),
              onPressed: () {
                appThemeProvider.toggleTheme();
                CustomLogger.log('appbar theme');
              },
              shape: CircleBorder(),
            )),
        SizedBox(
          height: _spaceSize,
          width: _spaceSize,
        ),
        SizedBox(
          height: _itemSize,
          width: _itemSize,
          child: RawMaterialButton(
            onPressed: () {
              pageIndexProvider.setCurrentIndex(1);
              CustomLogger.log('to user profile');
            },
            elevation: 2.0,
            child: Icon(
              Icons.account_circle,
              size: _itemSize,
            ),
            shape: CircleBorder(),
          ),
        ),
        SizedBox(
          height: _spaceSize,
          width: _spaceSize,
        ),
      ],
    );
  }

  static AppBar appBarAskQuestion(context, formKey){
    AppThemeProvider appThemeProvider = Provider.of<AppThemeProvider>(context);
    PageIndexProvider pageIndexProvider = Provider.of<PageIndexProvider>(context);
    double _appBarHeight = AppBar().preferredSize.height;
    double _itemSize = _appBarHeight * 0.7;
    double _spaceSize = _appBarHeight / 4;
    return AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            formKey.currentState.save();
            Navigator.of(context).pop();
          },
        ),
      actions: [
        SizedBox(
            height: _itemSize,
            width: _itemSize,
            child: RawMaterialButton(
              child: Transform.rotate(
                  angle: appThemeProvider.isDarkTheme ? 0 : pi * 2.5 / 3,
                  child: Icon(
                    appThemeProvider.isDarkTheme
                        ? Icons.lightbulb_outline
                        : Icons.brightness_3,
                    size: _itemSize,
                  )),
              onPressed: () {
                appThemeProvider.toggleTheme();
                CustomLogger.log('appbar theme');
              },
              shape: CircleBorder(),
            )),
        SizedBox(
          height: _spaceSize,
          width: _spaceSize,
        ),
        SizedBox(
          height: _itemSize,
          width: _itemSize,
          child: RawMaterialButton(
            onPressed: () {
              pageIndexProvider.setCurrentIndex(1);
              Navigator.of(context).pop();
              CustomLogger.log('to user profile');
            },
            elevation: 2.0,
            child: Icon(
              Icons.account_circle,
              size: _itemSize,
            ),
            shape: CircleBorder(),
          ),
        ),
        SizedBox(
          height: _spaceSize,
          width: _spaceSize,
        ),
      ],
    );
  }
}
