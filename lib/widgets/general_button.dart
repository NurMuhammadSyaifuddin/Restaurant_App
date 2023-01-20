import 'package:flutter/material.dart';
import 'package:submission_3/theme.dart';

class GeneralButton extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final String text;
  final double fontSize;
  final double margin;
  final Color backgroundColor;
  final Color textColor;

  const GeneralButton({super.key,
    this.width = 80,
    this.height = 32,
    this.borderRadius = 24,
    required this.text,
    this.fontSize = 10,
    required this.textColor, this.margin = 24,
    required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(top: margin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
        color: backgroundColor,
      ),
      child: Center(
        child: Text(
          text,
          style: whiteTextStyle.copyWith(
            fontSize: fontSize,
            fontWeight: semiBold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
