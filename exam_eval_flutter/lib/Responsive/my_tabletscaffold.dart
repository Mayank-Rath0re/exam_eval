import 'package:exam_eval_flutter/Constants.dart';
import 'package:flutter/material.dart';

class TabletScaffold extends StatefulWidget {
  const TabletScaffold({Key? key}) : super(key: key);

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
  int _selectedIndex = 0;

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.of(context).pop(); // Close the drawer after selection
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D5A27),
        titleSpacing: 0,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            'EXAM EVAL',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
      drawer: SideBar(onTabChange: _onTabChange),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const Center(child: Text('Dashboard'));
      case 1:
        return const Center(child: Text('Task'));
      case 2:
        return const Center(child: Text('Report'));
      case 3:
        return const Center(child: Text('Evaluate Exam'));
      case 4:
        return const Center(child: Text('Results'));
      case 5:
        return const Center(child: Text('Settings'));
      case 6:
        return const Center(child: Text('Support'));
      case 7:
        return const Center(child: Text('Create Exam'));
      default:
        return const Center(child: Text('Dashboard'));
    }
  }
}
