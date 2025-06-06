import 'package:flutter/material.dart';

class QuestionAnalysis {
  final String question;
  final String idealAnswer;
  final String studentAnswer;
  final int score;
  final int maxScore;

  QuestionAnalysis({
    required this.question,
    required this.idealAnswer,
    required this.studentAnswer,
    required this.score,
    required this.maxScore,
  });
}

class StudentExamAnalysisPage extends StatefulWidget {
  final String studentName;
  final String subject;
  final String date;
  final int totalMarks;

  const StudentExamAnalysisPage({
    super.key,
    required this.studentName,
    required this.subject,
    required this.date,
    required this.totalMarks,
  });

  @override
  State<StudentExamAnalysisPage> createState() => _StudentExamAnalysisPageState();
}

class _StudentExamAnalysisPageState extends State<StudentExamAnalysisPage> {
  // Sample data - in a real app this would come from a database
  final List<QuestionAnalysis> questions = [
    QuestionAnalysis(
      question: "Explain the process of photosynthesis.",
      idealAnswer: "Photosynthesis is the process by which plants convert light energy into chemical energy. It involves the absorption of light by chlorophyll, conversion of CO2 and H2O into glucose and O2.",
      studentAnswer: "Photosynthesis is when plants make food using sunlight. They take in CO2 and water to make glucose and oxygen.",
      score: 8,
      maxScore: 10,
    ),
    QuestionAnalysis(
      question: "What are the main components of a cell?",
      idealAnswer: "The main components of a cell include the nucleus, cytoplasm, cell membrane, mitochondria, endoplasmic reticulum, Golgi apparatus, and ribosomes.",
      studentAnswer: "Cells have a nucleus, cell membrane, and cytoplasm. They also have mitochondria for energy.",
      score: 6,
      maxScore: 10,
    ),
    // Add more questions as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.studentName}\'s Analysis'),
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
                _buildSummaryCard(),
                const SizedBox(height: 20),
                ...questions.map((q) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: _buildQuestionCard(q),
                )).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
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
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade50,
              Colors.blue.shade100,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Exam Summary',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            const SizedBox(height: 15),
            _buildSummaryRow('Subject', widget.subject),
            _buildSummaryRow('Date', widget.date),
            _buildSummaryRow('Total Score', '${widget.totalMarks}%'),
            _buildSummaryRow('Questions Attempted', '${questions.length}'),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue.shade800,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(QuestionAnalysis question) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Question',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${question.score}/${question.maxScore}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              question.question,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            _buildAnswerSection('Ideal Answer', question.idealAnswer, Colors.blue.shade50),
            const SizedBox(height: 15),
            _buildAnswerSection('Student\'s Answer', question.studentAnswer, Colors.green.shade50),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerSection(String title, String answer, Color backgroundColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            answer,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
} 