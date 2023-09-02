import 'package:flutter/material.dart';

import '../src_constants.dart';
import 'app_colors.dart';
import 'app_styles.dart';

normalTheme(BuildContext context) {
  return ThemeData(
    fontFamily: fontFamilyMontserrat,
    primaryColor: secondaryColor,
    secondaryHeaderColor: accentColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor
    ),
    disabledColor: Colors.grey,
    cardColor: Colors.white,
    canvasColor: Colors.white,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: Colors.white,
      selectionHandleColor: Colors.black,
    ),
    brightness: Brightness.light,
    buttonTheme: Theme.of(context).buttonTheme.copyWith(
        colorScheme: const ColorScheme.light(),
        buttonColor: Colors.black,
        splashColor: Colors.white),
    appBarTheme: const AppBarTheme(
      elevation: 2.0,
    ),
  );
}

lightTheme(BuildContext context) {
  return ThemeData(
    fontFamily: fontFamilyMontserrat,
    primarySwatch: Colors.blue,
    primaryColor: Colors.white,
    hintColor: Colors.blue,
    disabledColor: Colors.grey,
    cardColor: Colors.white,
    canvasColor: Colors.white,
    brightness: Brightness.light,
    buttonTheme: Theme.of(context).buttonTheme.copyWith(
        colorScheme: const ColorScheme.light(),
        buttonColor: Colors.blue,
        splashColor: Colors.white),
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
    ),
  );
}

darkTheme(BuildContext context) {
  return ThemeData(
    fontFamily: fontFamilyMontserrat,
    primarySwatch: Colors.blue,
    primaryColor: accentColor,
    hintColor: accentColor,
    disabledColor: Colors.grey,
    cardColor: Color(0xff1f2124),
    scaffoldBackgroundColor: accentColor,
    canvasColor: accentColor,
    brightness: Brightness.dark,
    buttonTheme: Theme.of(context).buttonTheme.copyWith(
        colorScheme: const ColorScheme.dark(),
        buttonColor: Colors.blue,
        splashColor: Colors.black),
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      backgroundColor: accentColor
    ),
  );
}