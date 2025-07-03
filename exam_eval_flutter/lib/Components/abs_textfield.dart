import 'package:flutter/material.dart';

class AbsTextfield extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final Function()? onTap;

  const AbsTextfield({
    super.key,
    required this.hintText,
    required this.controller,
    this.onTap,
  });

  @override
  State<AbsTextfield> createState() => _AbsTextfieldState();
}

class _AbsTextfieldState extends State<AbsTextfield> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      controller: widget.controller,
      onTap: () {
        setState(() {
          isActive = true;
        });
        widget.onTap;
      },
      style: TextStyle(color: theme.colorScheme.onSurface),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade200,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey.shade800),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
