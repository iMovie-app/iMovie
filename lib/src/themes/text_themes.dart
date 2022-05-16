import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peliculas_app/src/themes/app_colors.dart';

class TextThemes {
  const TextThemes();

  static getTextTheme() {
    return TextTheme(
      headline6: _whiteHeadLine6,
      headline5: _whiteHeadline5,
      subtitle1: _whiteSubtitle1,
      button: _whiteButtonText,
      bodyText2: _whiteBodyText2,
      caption: _captionText,
    );
  }

  static TextTheme get _poppinsTextTheme => GoogleFonts.poppinsTextTheme();

  static TextStyle get _whiteButtonText => _poppinsTextTheme.button!.copyWith(
        fontSize: 14.0,
        color: Colors.white,
      );

  static TextStyle get _captionText => _poppinsTextTheme.button!.copyWith(
        fontSize: 12.0,
        color: Colors.white,
      );

  static TextStyle get _whiteSubtitle1 => _poppinsTextTheme.subtitle1!.copyWith(
        color: Colors.white,
        fontSize: 16.0,
      );

  static TextStyle get _whiteBodyText2 => _poppinsTextTheme.bodyText2!.copyWith(
        color: Colors.white,
        fontSize: 14.0,
        wordSpacing: 0.25,
        letterSpacing: 0.25,
        height: 1.5,
      );

  static TextStyle get _whiteHeadline5 => _poppinsTextTheme.headline5!.copyWith(
        fontSize: 20.0,
        color: Colors.white,
      );

  static TextStyle get _whiteHeadLine6 {
    return _poppinsTextTheme.headline6!.copyWith(
      fontSize: 20.0,
      color: Colors.white,
    );
  }
}

extension TextThemeExtension on TextTheme {
  TextStyle get royalBlueSubtitle1 => subtitle1!.copyWith(
        color: AppColors.royalBlue,
        fontWeight: FontWeight.w600,
      );
}
