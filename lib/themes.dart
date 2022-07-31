import 'package:flutter/material.dart';
import 'package:wedding_planner/main.dart';

class AppColours {
  static const Color primary = Color(0xFF69051D);
  static const Color pink = Color(0xFFAC1B3D);
  static const Color lightPink = Color(0xFFEDCDCD);
  static const Color secondary = Color(0xFFB2BCC1);
}

class Themes {
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColours.primary,
      appBarTheme: const AppBarTheme(backgroundColor: AppColours.primary),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColours.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: AppColours.primary,
          onPrimary: Colors.white,
        ),
      ),
      textTheme: const TextTheme(
        bodyText1: TextStyle(fontFamily: 'Gothic'),
        bodyText2: TextStyle(fontFamily: 'Gothic'),
        labelMedium: TextStyle(fontFamily: 'Gothic'),
        caption: TextStyle(fontFamily: 'Gothic'),
        button: TextStyle(fontFamily: 'Gothic'),
      ),
      tabBarTheme: const TabBarTheme(
          labelStyle: const TextStyle(color: AppColours.primary),
          unselectedLabelColor: AppColours.lightPink));

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColours.primary,
      appBarTheme: const AppBarTheme(backgroundColor: AppColours.primary),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColours.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: AppColours.primary,
          onPrimary: Colors.white,
        ),
      ),
      textTheme: const TextTheme(
        bodyText1: TextStyle(fontFamily: 'Gothic'),
        bodyText2: TextStyle(fontFamily: 'Gothic'),
        labelMedium: TextStyle(fontFamily: 'Gothic'),
        caption: TextStyle(fontFamily: 'Gothic'),
        button: TextStyle(fontFamily: 'Gothic'),
      ),
      tabBarTheme: const TabBarTheme(
          labelStyle: const TextStyle(color: AppColours.primary),
          unselectedLabelColor: AppColours.lightPink));
}