import 'package:exam_eval_flutter/Components/mega_menu.dart';
import 'package:exam_eval_flutter/Components/profile_listTile.dart';
import 'package:exam_eval_flutter/Components/upcoming_exam_tile.dart';
import 'package:exam_eval_flutter/Pages/evaluation_page.dart';
import 'package:exam_eval_flutter/Pages/exam_define_page.dart';
import 'package:exam_eval_flutter/Pages/my_exams_page.dart';
import 'package:exam_eval_flutter/Pages/results_page.dart';
import 'package:exam_eval_flutter/Pages/settings_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PageBuild extends StatefulWidget {
  final int index;
  const PageBuild({super.key, required this.index});

  @override
  State<PageBuild> createState() => _PageBuildState();
}

class _PageBuildState extends State<PageBuild> {
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
            onTabChange: (index) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PageBuild(index: index)));
            },
            isMobile: false,
          ),
        ],
      ),
      toolbarHeight: 70,
    );
  }

  Widget _buildBody() {
    switch (widget.index) {
      case 0:
        return _buildDashboard();
      case 1:
        return const MyExamsPage();
      case 2:
        return const Center(child: Text('Report'));
      case 3:
        return const EvaluationPage();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _buildAppBar()),
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
              Expanded(child: _buildBody()),
            ],
          ),
        ],
      ),
    );
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
                children: [
                  Column(
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
                              child: ListView(children: [
                                Column(
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
                                      subject: "Computer Networks",
                                      examType: "Final",
                                      date: "12th June 2025",
                                      onTap: null,
                                    ),
                                    UpcomingExamTile(
                                      subject: "Discrete Mathc",
                                      examType: "Final",
                                      date: "17th June 2025",
                                      onTap: null,
                                    ),
                                    UpcomingExamTile(
                                      subject: "DBMS",
                                      examType: "Final",
                                      date: "20th June 2025",
                                      onTap: null,
                                    ),
                                    UpcomingExamTile(
                                      subject: "AADS",
                                      examType: "Final",
                                      date: "23th June 2025",
                                      onTap: null,
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 400,
                        width: 700,
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
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Half yearly sales analysis',
                              style: TextStyle(
                                fontFamily: 'Axiforma',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(54, 87, 78, 1),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: LineChart(
                                LineChartData(
                                  gridData: FlGridData(show: true),
                                  titlesData: FlTitlesData(
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: true),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: (value, meta) {
                                          const months = [
                                            'Jan',
                                            'Feb',
                                            'Mar',
                                            'Apr',
                                            'May'
                                          ];
                                          return Text(months[value.toInt()],
                                              style: const TextStyle(
                                                  fontSize: 12));
                                        },
                                        interval: 1,
                                      ),
                                    ),
                                  ),
                                  borderData: FlBorderData(show: true),
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: [
                                        FlSpot(0, 35),
                                        FlSpot(1, 28),
                                        FlSpot(2, 34),
                                        FlSpot(3, 32),
                                        FlSpot(4, 40),
                                      ],
                                      isCurved: true,
                                      barWidth: 4,
                                      belowBarData: BarAreaData(show: true),
                                      dotData: FlDotData(show: true),
                                      color:
                                          const Color.fromRGBO(54, 87, 78, 1),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              )
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
}
