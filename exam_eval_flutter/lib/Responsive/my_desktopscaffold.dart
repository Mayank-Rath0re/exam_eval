import 'package:flutter/material.dart';
import 'package:exam_eval_flutter/Constants.dart';
import 'package:exam_eval_flutter/Pages/evaluate_exam_page.dart';
import 'package:exam_eval_flutter/Pages/results_page.dart';


class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  int selectedTabIndex = 0;

  void handleTabChange(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultBackground,
      appBar: DefaultAppbar,
      drawer: SideBar(onTabChange: handleTabChange),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar
          
          // Main content area
          Expanded(
            flex: 3,
            child: _getSelectedPage(),
          ),
          // Sidebar content (e.g., Timetable)
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 20),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 4),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "🕒 Timetable",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Return the correct page for selected tab
  Widget _getSelectedPage() {
    switch (selectedTabIndex) {
      case 0:
        return _buildDashboard(); // Your current content
      case 1:
        return Center(child: Text("Tasks Page")); // placeholder
      case 2:
        return Center(child: Text("Reports Page")); // placeholder
      case 3:
        return const ResponsiveEvaluateExam(); // Import this
      case 4:
        return const ResponsiveResultsPage(); // Import this
      case 5:
        return Center(child: Text("Settings Page")); // placeholder
      case 6:
        return Center(child: Text("Support Page")); // placeholder
      default:
        return _buildDashboard();
    }
  }

  Widget _buildDashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hi, User", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Text("Welcome back to your dashboard", style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Performance container
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 1000),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Class Performance Overview", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                    Text("View all", style: TextStyle(color: Colors.blue, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 25),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    _buildInfoCard("Average Score", "85", Colors.grey.shade200),
                    _buildInfoCard("Class Participation", "70%", Colors.grey.shade200),
                  ],
                ),
                const SizedBox(height: 30),
                const Text("Performance Distribution", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 25),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    _buildInfoCard("Excellent", "5", Colors.green.shade200),
                    _buildInfoCard("Good", "10", Colors.blue.shade200),
                    _buildInfoCard("Average", "6", Colors.yellow.shade200),
                    _buildInfoCard("Needs Improvement", "7", Colors.red.shade200),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          _buildHistorySection(),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, Color color) {
    return SizedBox(
      width: 200,
      child: Container(
        height: 100,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
          ],
        ),
      ),
    );
  }

  Widget _buildHistorySection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("History", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Column(
            children: List.generate(3, (index) {
              return InkWell(
                onTap: () => print("Tapped on Unit ${index + 1}"),
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.person, color: Colors.blue),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Unit ${index + 1}", style: const TextStyle(fontWeight: FontWeight.bold)),
                          const Text("Artificial Intelligence", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}


