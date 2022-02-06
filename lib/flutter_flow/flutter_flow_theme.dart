import 'package:flutter/material.dart';

class FlutterFlowTheme {
  static const Color primaryColor = Color(0xFF000000);
  static const Color secondaryColor = Color(0xFFBA0C2F);
  static const Color tertiaryColor = Color(0xFFFFFFFF);

  static TextStyle get title1 => TextStyle().copyWith(
        fontFamily: 'Open Sans',
        color: primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 30,
      );
  static TextStyle get title2 => TextStyle().copyWith(
        fontFamily: 'Open Sans',
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      );
  static TextStyle get title3 => TextStyle().copyWith(
        fontFamily: 'Open Sans',
        color: primaryColor,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      );
  static TextStyle get title3Red => TextStyle().copyWith(
        fontFamily: 'Open Sans',
        color: secondaryColor,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      );
  static TextStyle get subtitle1 => TextStyle().copyWith(
        fontFamily: 'Open Sans',
        color: primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      );
  static TextStyle get subtitle2 => TextStyle().copyWith(
        fontFamily: 'Open Sans',
        color: primaryColor,
        fontWeight: FontWeight.w600,
        fontSize: 22,
      );
  static TextStyle get subtitle3 => TextStyle().copyWith(
        fontFamily: 'Open Sans',
        color: FlutterFlowTheme.primaryColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );
  static TextStyle get bodyText1 => TextStyle().copyWith(
        fontFamily: 'Open Sans',
        color: primaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );
  static TextStyle get bodyText2 => TextStyle().copyWith(
        fontFamily: 'Open Sans',
        color: primaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
}
