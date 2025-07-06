import 'package:flutter/material.dart';

class AbsMinimalBox extends StatefulWidget {
  final Widget child;
  final int layer;
  const AbsMinimalBox({super.key, required this.layer, required this.child});

  @override
  State<AbsMinimalBox> createState() => _AbsMinimalBoxState();
}

class _AbsMinimalBoxState extends State<AbsMinimalBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: widget.layer == 0 ? Colors.white : Colors.grey.shade200,
            // border: widget.layer == 0 ? Border.all(width: 1, color: Colors.black) : null,
            borderRadius: BorderRadius.circular(6),
            boxShadow: widget.layer == 0
                ? [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12,
                      spreadRadius: 4,
                      offset: Offset(0, 4),
                    )
                  ]
                : []),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: widget.child,
        ));
  }
}
