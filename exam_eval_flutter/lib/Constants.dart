import 'package:flutter/material.dart';

var DefaultBackground = Colors.grey.shade300;

var DefaultAppbar = AppBar(
  backgroundColor: Colors.teal,
  actions: [
    Padding(padding: EdgeInsets.all(15),
    child: GestureDetector(onTap: () {},
    child: Icon(Icons.person,size: 25,),),)
  ],
);

class SideBar extends StatelessWidget {
  final void Function(int) onTabChange;
  const SideBar({Key? key, required this.onTabChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.tealAccent,
      child: Column(
        children: [
          const SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.dashboard_outlined),
            title: Text("D A S H B O A R D"),
            onTap: () => onTabChange(0),
          ),
          ListTile(
            leading: Icon(Icons.task),
            title: Text("T A S K"),
            onTap: () => onTabChange(1),
          ),
          ListTile(
            leading: Icon(Icons.receipt_outlined),
            title: Text("R E P O R T"),
            onTap: () => onTabChange(2),
          ),
          ListTile(
            leading: Icon(Icons.assessment),
            title: Text("E V A L U A T E  E X A M"),
            onTap: () => onTabChange(3),
          ),
          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text("R E S U L T S"),
            onTap: () => onTabChange(4),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("S E T T I N G S"),
            onTap: () => onTabChange(5),
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text("S U P P O R T"),
            onTap: () => onTabChange(6),
          ),
        ],
      ),
    );
  }
}




// For backward compatibility
var DefaultDrawer = Drawer(
  backgroundColor: Colors.teal,
  child: Column(
    children: [
      const SizedBox(height: 20,),
      ListTile(
        leading: Icon(Icons.dashboard_outlined),
        title: Text("D A S H B O A R D"),
      ),
      ListTile(
        leading: Icon(Icons.task),
        title: Text("T A S K"),
      ),
      ListTile(
        leading: Icon(Icons.receipt_outlined),
        title: Text("R E P O R T"),
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text("S E T T I N G S"),
      ),
      ListTile(
        leading: Icon(Icons.help),
        title: Text("S U P P O R T"),
      ),
    ],
  ),
);

