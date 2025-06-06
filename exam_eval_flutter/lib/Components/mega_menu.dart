import 'package:flutter/material.dart';

class MegaMenu extends StatelessWidget {
  final void Function(int) onTabChange;
  final bool isMobile;

  const MegaMenu({
    Key? key,
    required this.onTabChange,
    this.isMobile = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return _buildMobileMenu(context);
    }
    return _buildDesktopMenu(context);
  }

  Widget _buildMobileMenu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu, color: Colors.white),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder: (context) => [
        _buildMenuItem('Dashboard', Icons.dashboard_outlined, 0),
        _buildMenuItem('My Exams', Icons.task, 1),
        _buildMenuItem('Report', Icons.receipt_outlined, 2),
        _buildMenuItem('Evaluate Exam', Icons.assessment, 3),
        _buildMenuItem('Results', Icons.bar_chart, 4),
        _buildMenuItem('Settings', Icons.settings, 5),
        _buildMenuItem('Support', Icons.help, 6),
        _buildMenuItem('Create Exam', Icons.task, 7),
      ],
      onSelected: (value) {
        // Handle menu item selection
        final index = int.parse(value);
        onTabChange(index);
      },
    );
  }

  Widget _buildDesktopMenu(BuildContext context) {
    return Container(
      color: const Color(0xFF2D5A27),
      child: Row(
        children: [
          _buildMenuButton('Dashboard', Icons.dashboard_outlined, 0),
          _buildMenuButton('Task', Icons.task, 1),
          _buildMenuButton('Report', Icons.receipt_outlined, 2),
          _buildMenuButton('Evaluate Exam', Icons.assessment, 3),
          _buildMenuButton('Results', Icons.bar_chart, 4),
          _buildMenuButton('Settings', Icons.settings, 5),
          _buildMenuButton('Support', Icons.help, 6),
          _buildMenuButton('Create Exam', Icons.task, 7),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildMenuItem(String title, IconData icon, int index) {
    return PopupMenuItem<String>(
      value: index.toString(),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF2D5A27)),
          const SizedBox(width: 10),
          Text(title),
        ],
      ),
    );
  }

  Widget _buildMenuButton(String title, IconData icon, int index) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: () => onTabChange(index),
        hoverColor: Colors.white.withOpacity(0.1),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
