import 'package:flutter/material.dart';

class AbsText extends StatelessWidget {
  final String displayString;
  final double fontSize;
  final bool bold;
  const AbsText(
      {super.key,
      required this.displayString,
      required this.fontSize,
      this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      displayString,
      style: TextStyle(
          fontSize: fontSize,
          fontFamily: "Axiforma",
          fontWeight: bold ? FontWeight.bold : FontWeight.normal),
    );
  }
}
