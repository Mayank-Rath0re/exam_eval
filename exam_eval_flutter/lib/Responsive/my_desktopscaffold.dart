import 'package:exam_eval_flutter/Components/abs_minimal_box.dart';
import 'package:exam_eval_flutter/Components/abs_text.dart';
import 'package:exam_eval_flutter/Components/mega_menu.dart';
import 'package:exam_eval_flutter/Components/profile_listTile.dart';
import 'package:exam_eval_flutter/Components/upcoming_exam_tile.dart';
import 'package:exam_eval_flutter/Pages/evaluation_page.dart';
import 'package:exam_eval_flutter/Pages/my_exams_page.dart';
import 'package:exam_eval_flutter/Pages/profile_page.dart';
import 'package:exam_eval_flutter/Pages/result_page.dart';
import 'package:exam_eval_flutter/main.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 0,
      title: Row(
        children: [
          SizedBox(width: 10,),
          if (_selectedIndex != 0)
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
          if (_selectedIndex == 0)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfilePage()),
              );
            },
            child: const CircleAvatar(
              foregroundImage: AssetImage("assets/images/mayank_pfp.jpeg"),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'EXAM EVAL',
              style: TextStyle(
                color: Color(0xFF2D5A27),
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
      toolbarHeight: 70,),
      body: Column(
        children: [
          //_buildAppBar(),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

 Widget _buildAppBar() {
  return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 0,
      title: Row(
        children: [
          if (_selectedIndex != 0)
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfilePage()),
              );
            },
            child: const CircleAvatar(
              foregroundImage: AssetImage("assets/images/mayank_pfp.jpeg"),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'EXAM EVAL',
              style: TextStyle(
                color: Color(0xFF2D5A27),
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
        return const EvaluationPage();
      case 4:
        return ResultPage(userId: sessionManager.signedInUser!.id!);
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
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AbsText(displayString: "Dashboard", fontSize: 26, bold: true),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                  child: AbsMinimalBox(
                      layer: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AbsText(displayString: "Average Score", fontSize: 16),
                          const SizedBox(height: 8),
                          AbsText(
                              displayString: "78%", fontSize: 18, bold: true)
                        ],
                      ))),
              const SizedBox(width: 12),
              Expanded(
                  child: AbsMinimalBox(
                      layer: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AbsText(
                              displayString: "Exams Evaluated", fontSize: 16),
                          const SizedBox(height: 8),
                          AbsText(
                              displayString: "150", fontSize: 18, bold: true)
                        ],
                      ))),
              const SizedBox(width: 12),
              Expanded(
                  child: AbsMinimalBox(
                      layer: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AbsText(
                              displayString: "Students Assessed", fontSize: 16),
                          const SizedBox(height: 8),
                          AbsText(
                              displayString: "120", fontSize: 18, bold: true)
                        ],
                      ))),
            ],
          ),
          const SizedBox(height: 15),
          AbsText(
              displayString: "Performance Overview", fontSize: 18, bold: true),
          const SizedBox(height: 20),
          AbsMinimalBox(
              layer: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AbsText(displayString: "Overall Performance", fontSize: 16),
                  const SizedBox(height: 5),
                  AbsText(displayString: "75%", fontSize: 20, bold: true),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 320,
                    child: AbsMinimalBox(
                        layer: 1,
                        child: Center(
                            child: AbsText(
                                displayString: "Graph Metric Area",
                                fontSize: 18,
                                bold: true))),
                  )
                ],
              ))
        ],
      ),
    ));
  }

  /*
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
  */

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

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
