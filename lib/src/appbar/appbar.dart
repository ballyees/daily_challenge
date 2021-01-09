import 'dart:math';

import 'package:daily_challenge/src/Logger.dart';
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
    double _appBarHeight = AppBar().preferredSize.height;
    double _itemSize = _appBarHeight * 0.75;
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
