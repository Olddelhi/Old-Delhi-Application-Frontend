import 'package:flutter/material.dart';


class FontFamily {
  static String bold = "Sen-Bold";
  static String extraBold = "Sen-extraBold";
  static String medium = "Sen-Medium";
  static String regular = "Sen-Regular";
  static String semiBold = "Sen-SemiBold";
}

class TextStyles {
  static TextStyle get mediumText => TextStyle(
    fontFamily: FontFamily.medium,
    color: Colors.black,
  );

  static TextStyle get mediumHomeText => TextStyle(
    fontFamily: FontFamily.medium,
    color: Colors.black,
    overflow: TextOverflow.ellipsis
  );

  static TextStyle get boldText => TextStyle(
    fontFamily: FontFamily.bold,
    color: Colors.black
  );
  static TextStyle get boldOrderText => TextStyle(
    fontFamily: FontFamily.bold,
    color: Colors.black,overflow: TextOverflow.ellipsis
  );

  static TextStyle get regularText => TextStyle(
    fontFamily: FontFamily.regular,
    color: Colors.black,
  );

  static TextStyle get semiBoldText => TextStyle(
    fontFamily: FontFamily.regular,
    color: Colors.black,
  );
  static TextStyle get semiBoldTextStyle => TextStyle(
    fontFamily: FontFamily.regular,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle get extraBoldText => TextStyle(
    fontFamily: FontFamily.extraBold,
    color: Colors.black,
  );

}