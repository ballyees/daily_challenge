import 'package:logger/logger.dart';
import 'dart:developer' as developer;

class CustomLogger {
  static Logger _logger =
      Logger(printer: PrettyPrinter(printTime: true, colors: true));
  static final CustomLogger _instance = CustomLogger._internal();
  factory CustomLogger() {
    return _instance;
  }

  CustomLogger._internal();

  static void log(message){
    DateTime now = DateTime.now();
    developer.log(message, name: '$now');
  }

  static void i(message) {
    _logger.i(message);
  }

  static void v(message) {
    _logger.v(message);
  }

  static void e(message) {
    _logger.e(message);
  }

  static void w(message) {
    _logger.w(message);
  }

  static void d(message) {
    _logger.d(message);
  }

  static void wtf(message) {
    _logger.wtf(message);
  }
}
