import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
      color: Colors.red[900],
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.white,
  );

   // Dark Theme
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(
      color: Colors.grey[850],
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: Colors.grey[900],
  );

  

}