import 'package:flutter/material.dart';
import 'package:social_app/core/utils/app_constants.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: AppBarTheme(color: Colors.white, scrolledUnderElevation: 0.0),
  scaffoldBackgroundColor: Colors.white,

  primaryColor: AppConstants.primaryColor,
  iconTheme: IconThemeData(color: AppConstants.primaryColor),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      side: BorderSide(color: Colors.grey, width: 1),
      foregroundColor: AppConstants.primaryColor,
    ),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppConstants.primaryColor,
  ),
  fontFamily: "Jannah",
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppConstants.primaryColor,
    selectionColor: AppConstants.primaryColor.withOpacity(0.5),
    selectionHandleColor: AppConstants.primaryColor.withOpacity(0.5),
  ),
  textTheme: TextTheme(
    headlineSmall: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      height: 1.4,
    ),

    bodyMedium: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      height: 1.4,
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: Colors.black45,
    ),
    titleSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.black45,
    ),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppConstants.primaryColor,

    elevation: 20,
  ),
);
ThemeData darkTheme = ThemeData(
  //HexColor('333739')
  appBarTheme: AppBarTheme(color: Color(0XFF333739), scrolledUnderElevation: 0.0),
  scaffoldBackgroundColor: Color(0XFF333739),
  primaryColor: AppConstants.primaryColor,
  iconTheme: IconThemeData(color: AppConstants.primaryColor),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      side: BorderSide(color: Colors.grey, width: 1),
      foregroundColor: AppConstants.primaryColor,
    ),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppConstants.primaryColor,
  ),
  fontFamily: "Jannah",
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppConstants.primaryColor,
    selectionColor: AppConstants.primaryColor.withOpacity(0.5),
    selectionHandleColor: AppConstants.primaryColor.withOpacity(0.5),
  ),
  textTheme: TextTheme(
    headlineSmall: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      height: 1.4,
    ),

    bodyMedium: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      height: 1.4,
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor:Color(0XFF333739),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppConstants.primaryColor,

    elevation: 20,
  ),
);
