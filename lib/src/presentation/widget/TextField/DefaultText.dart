import 'package:flutter/material.dart';

class DefaultText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final String ?fontFamily;

  const DefaultText({
    super.key,
    required this.text,
    this.textAlign = TextAlign.start,
    this.color,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.maxLines,
    this.overflow,
    this.fontFamily = 'MontserratSemiBold'
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: fontSize,
        fontFamily: fontFamily
      ),
    );
  }
}
