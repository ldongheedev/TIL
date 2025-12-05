import 'package:flutter/material.dart';

class AppFont extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double? size;
  final TextAlign? align;
  final Color? color;

  const AppFont(
    this.text, {
    super.key,
    this.fontWeight,
    this.size,
    this.align,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: size,
        color: color,
      ),
    );
  }
}
