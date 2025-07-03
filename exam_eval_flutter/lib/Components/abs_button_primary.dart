import 'package:flutter/material.dart';

class AbsButtonPrimary extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;
  const AbsButtonPrimary(
      {super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Color(0xFF2D5A27)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)))),
        onPressed: onPressed,
        child: child);
  }
}
