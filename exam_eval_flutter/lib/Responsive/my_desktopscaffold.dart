import 'package:exam_eval_flutter/Components/mega_menu.dart';
import 'package:exam_eval_flutter/Components/profile_listTile.dart';
import 'package:exam_eval_flutter/Components/upcoming_exam_tile.dart';
import 'package:exam_eval_flutter/Pages/my_exams_page.dart';
import 'package:flutter/material.dart';
import 'package:exam_eval_flutter/Pages/evaluate_exam_page.dart';
import 'package:exam_eval_flutter/Pages/results_page.dart';
import 'package:exam_eval_flutter/Pages/exam_define_page.dart';
import 'package:exam_eval_flutter/Pages/settings_page.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  int _selectedIndex = 0;

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.8, 0.8),
                radius: 2.3,
                colors: [
                  Color.fromRGBO(247, 245, 243, 1),
                  Color.fromRGBO(227, 221, 211, 1),
                  Color.fromRGBO(212, 199, 130, 1),
                  Color.fromRGBO(54, 87, 78, 1),
                ],
                stops: [0.0, 0.1, 0.52, 0.81],
              ),
            ),
          ),
          Column(
            children: [
              _buildAppBar(),
              Expanded(child: _buildBody()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleSpacing: 0,
      title: Row(
        children: [
          const Padding(
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
          const Spacer(),
          MegaMenu(
            onTabChange: _onTabChange,
            isMobile: false,
          ),
        ],
      ),
      toolbarHeight: 70,
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboard();
      case 1:
        return const MyExamsPage();
      case 2:
        return const Center(child: Text('Report'));
      case 3:
        return const ResponsiveEvaluateExam();
      case 4:
        return const ResponsiveResultsPage();
      case 5:
        return const SettingsPage();
      case 6:
        return const Center(child: Text('Support'));
      case 7:
        return const ExamDefinePage();
      default:
        return _buildDashboard();
    }
  }

  Widget _buildDashboard() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: 350,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(227, 221, 211, 1),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 12,
                  spreadRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    const Icon(Icons.person_outline_sharp,
                        color: Colors.black, size: 130),
                    const SizedBox(height: 20),
                    const Text(
                      "Sushant Jaiswal",
                      style: TextStyle(
                        fontFamily: 'Axiforma',
                        color: Color.fromRGBO(54, 87, 78, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 30),
                    buildProfileMenu()
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 280,
                      width: 350,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(227, 221, 211, 1),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 12,
                            spreadRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          "Metric to be Planned",
                          style: TextStyle(
                            fontFamily: 'Axiforma',
                            color: Color.fromRGBO(54, 87, 78, 1),
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 280,
                      width: 350,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(227, 221, 211, 1),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 12,
                            spreadRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListView(
                        children: [Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Upcoming Exam",
                              style: TextStyle(
                                fontFamily: 'Axiforma',
                                color: Color.fromRGBO(54, 87, 78, 1),
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 16),
                            UpcomingExamTile(
                              subject: "Software Engineering",
                              examType: "Final",
                              date: "12th June 2025",
                              onTap: null,
                            ),
                            UpcomingExamTile(
                              subject: "AI",
                              examType: "Final",
                              date: "17th June 2025",
                              onTap: null,
                            ),
                            UpcomingExamTile(
                              subject: "Machine Learning",
                              examType: "Final",
                              date: "20th June 2025",
                              onTap: null,
                            ),
                          ],
                        ),
                ]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildProfileMenu() {
    return Column(
      children: [
        ProfileOptionTile(
          title: 'Edit Profile',
          onTap: () {},
        ),
        ProfileOptionTile(
          title: 'Analyze Performance',
          onTap: () {},
        ),
        ProfileOptionTile(
          title: 'Activity Log',
          onTap: () {},
        ),
        ProfileOptionTile(
          title: 'Uploaded Documents',
          onTap: () {},
        ),
        ProfileOptionTile(
          title: 'Preferences',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildInfoCard(String title, String value, Color color) {
    return SizedBox(
      width: 200,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text(value,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent)),
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
          const Text("History",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Column(
            children: List.generate(3, (index) {
              return InkWell(
                onTap: () => print("Tapped on Unit \${index + 1}"),
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.person, color: Colors.blue),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Unit \${index + 1}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          const Text("Artificial Intelligence",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios,
                          size: 16, color: Colors.grey),
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
