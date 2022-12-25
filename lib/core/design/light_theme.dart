import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './colors.dart';

ThemeData lightTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: GoogleFonts.poppins().fontFamily,
    textTheme: textTheme(),
    colorScheme: colorScheme(),
    appBarTheme: appBarTheme(),
    snackBarTheme: snackBarTheme(),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    centerTitle: true,
    backgroundColor: Colors.white,
    elevation: 0,
    actionsIconTheme: const IconThemeData(
      color: Color.fromRGBO(158, 158, 158, 1),
    ),
    foregroundColor: colorPrimary500,
    titleTextStyle: TextStyle(
      fontSize: 16,
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontWeight: FontWeight.w600,
      color: const Color.fromRGBO(158, 158, 158, 1),
    ),
  );
}

SnackBarThemeData snackBarTheme() {
  return const SnackBarThemeData(
    backgroundColor: colorPrimary500,
    contentTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    actionTextColor: Colors.white,
  );
}

ColorScheme colorScheme() {
  return const ColorScheme(
      brightness: Brightness.light,
      primary: colorPrimary500,
      onPrimary: colorbackgroundPrimary500,
      secondary: colorSecondary500,
      onSecondary: colorbackgroundSecondary500,
      error: colorError500,
      onError: colorBackgroundError500,
      background: Colors.white,
      onBackground: Colors.black,
      surface: colorPrimary500,
      onSurface: colorbackgroundPrimary500,
      tertiary: Color.fromARGB(255, 244, 243, 243),
      onTertiary: Colors.orange);
}

TextTheme textTheme() {
  return const TextTheme(
    headline1: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 60,
    ),
    headline2: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 50,
    ),
    headline3: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    headline4: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    headline5: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    headline6: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 10,
    ),
    bodyText1: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      height: 1.75,
      fontSize: 12,
    ),
    bodyText2: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 10,
    ),
    button: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 13,
    ),
    caption: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 10,
    ),
    headlineLarge: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 10,
    ),
    overline: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 10,
    ),
    subtitle1: TextStyle(
      color: Color.fromARGB(255, 152, 152, 152),
      fontWeight: FontWeight.normal,
      fontSize: 16,
    ), // used in form field
    subtitle2: TextStyle(
      color: Color.fromARGB(255, 152, 152, 152),
      fontWeight: FontWeight.normal,
      fontSize: 13,
    ), // used in forms hint text
  );
}
