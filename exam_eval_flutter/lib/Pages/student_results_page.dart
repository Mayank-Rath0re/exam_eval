import 'package:flutter/material.dart';

class StudentResult {
  final String studentName;
  final String subject;
  final String date;
  final int marks;

  StudentResult({
    required this.studentName,
    required this.subject,
    required this.date,
    required this.marks,
  });
}

class StudentResultsPage extends StatelessWidget {
  StudentResultsPage({super.key});

  // Sample data - in a real app this would come from a database
  final List<StudentResult> results = [
    StudentResult(
      studentName: "Sushant",
      subject: "22053570014",
      date: "2025-16-04",
      marks: 85,
    ),
    StudentResult(
      studentName: "Rishabh",
      subject: "22053570015",
      date: "2025-16-04",
      marks: 52,
    ),
    StudentResult(
      studentName: "Gaurav",
      subject: "22053570016",
      date: "2025-16-04",
      marks: 78,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Results'),
        backgroundColor: const Color(0xFF2D5A27),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade50,
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Column(
                    children: [
                      Text(
                        'Science Exam',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D5A27),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Duration: 60 minutes',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 800),
                        child: Column(
                          children: results.map((result) => Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: _buildResultCard(result),
                          )).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard(StudentResult result) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  '${result.marks}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D5A27),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.studentName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    result.subject,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              result.date,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 