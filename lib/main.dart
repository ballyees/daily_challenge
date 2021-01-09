import 'package:daily_challenge/src/home/home.dart';
import 'package:daily_challenge/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;

  runApp(ChangeNotifierProvider<AppThemeProvider>(
    create: (context) => AppThemeProvider(),
    child: MyApp(),
  ));
}

