// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:exam_eval_flutter/Constants.dart';
import 'package:flutter/material.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: DefaultBackground,
      appBar: DefaultAppbar,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildDrawer(context),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Hi, User",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Welcome back to your dashboard",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // 🎯 FIXED Responsive Container
                    Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 1000),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Class Performance Overview",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "View all",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          // Metrics Wrap
                          Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: [
                              _buildInfoCard("Average Score", "85",Colors.grey.shade200),
                              _buildInfoCard("Class Participation", "70%", Colors.grey.shade200),
                            ],
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            "Performance Distribution",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 25),
                          Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: [
                              _buildInfoCard("Excellent", "5",Colors.green.shade200),
                              _buildInfoCard("Good", "10",Colors.blue.shade200),
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

              ),
            ),
          ),

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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, final Color) {
    return SizedBox(
      width: 200,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Color,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
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
          const Text(
            "History",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
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
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
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
