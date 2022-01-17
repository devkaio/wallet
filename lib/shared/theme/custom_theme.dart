import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = true;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.teal,
      appBarTheme: const AppBarTheme(
        color: Colors.teal,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      scaffoldBackgroundColor: Colors.white,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.teal,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.green[100],
        ),
        bodyText2: TextStyle(
          color: Colors.green[100],
        ),
        headline4: TextStyle(
          color: Colors.green[100],
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.green[100],
      ),
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.green[100],
        color: Colors.black,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.green[100],
        foregroundColor: Colors.black,
      ),
    );
  }
}
