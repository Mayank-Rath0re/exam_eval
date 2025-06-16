import 'package:flutter/material.dart';

class ProfileOptionTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ProfileOptionTile({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: Color.fromARGB(255, 0, 0, 0),
          thickness: 0.5,
          height: 0,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 4),
            child: Row(
              children: [
                const Icon(Icons.content_cut, color: Color.fromARGB(255, 0, 0, 0), size: 22),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right, color: Color.fromARGB(155, 0, 0, 0), size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}