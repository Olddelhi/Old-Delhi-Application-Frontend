import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double fontSize;
  final int maxLine;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  const CustomText({
    required this.text,
    this.color,
    this.maxLine = 3,
    this.fontSize = 12,
    this.textStyle,
    this.textAlign, // Additional custom style
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
      ).merge(textStyle).copyWith(color: color),
    );
  }
}
