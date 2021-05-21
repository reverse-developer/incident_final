import 'package:flutter/material.dart';
import 'package:incident_report/styles/styles.dart';

final ThemeData themeData = ThemeData(
  fontFamily: 'Open Sans',
  primaryColor: kSecondaryColor,
  accentColor: kPrimaryColor,
  canvasColor: Colors.white,
  dividerColor: inactiveIconGrey,
  appBarTheme: AppBarTheme(
    elevation: 0,
    color: Colors.white,
    brightness: Brightness.light,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedLabelStyle: TextStyle(color: Colors.black),
    unselectedLabelStyle: TextStyle(color: inactiveIconGrey),
    selectedItemColor: kPrimaryColor,
    unselectedItemColor: inactiveIconGrey,
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: true,
    showUnselectedLabels: true,
  ),
  // buttonTheme: ButtonThemeData(
  //   buttonColor: PrimaryRed,
  //   shape: RoundedRectangleBorder(
  //     borderRadius: BorderRadius.circular(10),
  //   ),
  // ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateColor.resolveWith(
        (_) => PrimaryRed,
      ),
    ),
  ),
  buttonColor: kPrimaryColor,

  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.normal,
    minWidth: 88,
    height: 48,
    buttonColor: kPrimaryColor,
    padding: EdgeInsets.only(left: 20, right: 20),
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Color(0xff000000),
        width: 0,
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: InputFieldGrey,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: buttonBorderRadius,
      gapPadding: 16,
      borderSide: BorderSide.none,
    ),
  ),
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  }),
  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: buttonBorderRadius,
    ),
    backgroundColor: PrimaryRed,
    contentTextStyle: TextStyle(
      fontFamily: 'Open Sans',
      color: Colors.white,
    ),
  ),
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);
