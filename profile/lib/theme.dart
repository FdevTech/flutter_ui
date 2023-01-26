
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme{

  AppTheme._();
  static final Color _iconColor = Colors.redAccent.shade200;

  static const Color _lightPrimaryColor = Colors.white;
  static const Color _lightPrimaryVariantColor = Color(0xFFE1E1E1);
  static const Color _lightSecondaryColor = Colors.green;
  static const Color _lightOnPrimaryColor = Colors.black;
  static const Color _lightTransparentColor = Colors.transparent;

  static final myFont = GoogleFonts.openSans();
  static final ThemeData lightTheme = ThemeData(
      iconTheme: const IconThemeData(
          color: _lightOnPrimaryColor,

      ),
    scaffoldBackgroundColor:_lightPrimaryColor ,
    appBarTheme: const AppBarTheme(
      backgroundColor: _lightTransparentColor,
      elevation: 0
    ),
    textTheme: TextTheme(
      headline4: myFont.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600
      ),
        headline3: myFont.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600
        ),
        bodyText1: myFont.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400
        ),
    ),
    colorScheme: const ColorScheme.light().copyWith(
      onPrimary: _lightOnPrimaryColor
    )

  );
  static const Color _darkPrimaryColor = Colors.black;
  static const Color _darkSecondaryColor = Colors.white;
  static const Color _darkOnPrimaryColor = Colors.white;
  static final ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor:_darkPrimaryColor ,
      iconTheme: const IconThemeData(
        color: _darkOnPrimaryColor
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: _lightTransparentColor,
          elevation: 0
      ),
      colorScheme: ColorScheme.dark().copyWith(
        secondary: _darkPrimaryColor
      ),
      textTheme: TextTheme(
          headline4: myFont.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: _darkOnPrimaryColor
          ),
          headline3: myFont.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: _darkOnPrimaryColor
          ),
          bodyText1: myFont.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: _darkOnPrimaryColor
          )
      )
  );

}