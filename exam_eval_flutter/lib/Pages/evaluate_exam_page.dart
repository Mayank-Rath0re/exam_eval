import 'dart:io' if (dart.library.html) 'dart:html' as html;
import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:math' as math;
import 'file_reader.dart';

class Question {
  String question;
  String idealAnswer;
  String carriedMarks;

  Question({
    this.question = '',
    this.idealAnswer = '',
    this.carriedMarks = '',
  });
}

class QuestionInputPage extends StatefulWidget {
  const QuestionInputPage({super.key});

  @override
  State<QuestionInputPage> createState() => _QuestionInputPageState();
}

class _QuestionInputPageState extends State<QuestionInputPage>
    with SingleTickerProviderStateMixin {
  final List<Question> questions = [Question()];
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _addQuestion() {
    setState(() {
      questions.add(Question());
    });
  }

  Widget _buildQuestionCard(int index) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question Id: ${(index + 1).toString().padLeft(3, '0')}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Question',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
              maxLines: 3,
              onChanged: (value) => questions[index].question = value,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Ideal Answer',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
              maxLines: 3,
              onChanged: (value) => questions[index].idealAnswer = value,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Carried Marks',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => questions[index].carriedMarks = value,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Questions'),
        backgroundColor: const Color(0xFF2D5A27),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
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
        child: Column(
          children: [
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: ListView.builder(
                    itemCount: questions.length,
                    itemBuilder: (context, index) => _buildQuestionCard(index),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addQuestion,
        backgroundColor: const Color(0xFF2D5A27),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class EvaluateExamPage extends StatefulWidget {
  const EvaluateExamPage({super.key});

  @override
  State<EvaluateExamPage> createState() => _EvaluateExamPageState();
}

class _EvaluateExamPageState extends State<EvaluateExamPage> {
  bool csvUploaded = false;
  List<List<dynamic>>? csvData;

  Future<void> pickCsvFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
      withData: true, // ensure bytes are available for web
    );
    if (result != null) {
      String content = '';
      if (kIsWeb) {
        // On web, use bytes
        final bytes = result.files.single.bytes;
        if (bytes != null) {
          content = utf8.decode(bytes);
        }
      } else {
        // On desktop/mobile, use file path
        final path = result.files.single.path;
        if (path != null) {
          content = await readFileAsString(path);
        }
      }
      if (content.isNotEmpty) {
        final rows = const CsvToListConverter().convert(content);
        setState(() {
          csvUploaded = true;
          csvData = rows;
        });
        print('CSV DATA:');
        print(rows);
      }
    }
  }

  int currentStep = 0;

  void goToNextStep() {
    setState(() {
      currentStep++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (currentStep == 0) ...[
              Container(
                width: 450,
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6DD5FA), Color(0xFF2980F2)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: const Color(0xFF624B8A),
                          width: 6,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      child: const Text(
                        'Choose an Exam',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Divider(
                      color: Colors.white,
                      thickness: 3,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: pickCsvFile,
                      icon: const Icon(Icons.upload_file, color: Color(0xFF624B8A)),
                      label: const Text(
                        'Upload CSV',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF624B8A),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF624B8A),
                        elevation: 2,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                    if (csvUploaded) ...[
                      const SizedBox(height: 16),
                      const Text(
                        'CSV uploaded',
                        style: TextStyle(
                          color: Color(0xFF624B8A),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                    if (csvUploaded) ...[
                      const SizedBox(height: 32),
                      SizedBox(
                        width: 180,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: goToNextStep,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF624B8A),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text(
                            'Next',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ] else if (currentStep == 1) ...[
              // Display CSV as a table
              if (csvData != null && csvData!.isNotEmpty && csvData!.any((row) => row.any((cell) => cell.toString().trim().isNotEmpty))) ...[
                Container(
                  width: 700,
                  constraints: const BoxConstraints(maxHeight: 500),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      child: Table(
                        border: TableBorder.all(color: Colors.black),
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: [
                          for (int i = 0; i < csvData!.length; i++)
                            TableRow(
                              decoration: i == 0
                                  ? const BoxDecoration(color: Color(0xFFE3E3F3))
                                  : null,
                              children: [
                                for (final cell in csvData![i])
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                    child: Text(
                                      cell.toString(),
                                      style: TextStyle(
                                        fontWeight: i == 0 ? FontWeight.bold : FontWeight.normal,
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ] else ...[
                const Text('No CSV data to display or all cells are empty.'),
              ],
            ],
            const SizedBox(height: 32),
            // Progress indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 32,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: currentStep == 0 ? Colors.black54 : Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 12,
                        height: 12,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: currentStep == 1 ? Colors.black54 : Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Responsive version that can be integrated with the responsive layout
class ResponsiveEvaluateExam extends StatelessWidget {
  const ResponsiveEvaluateExam({super.key});

  @override
  Widget build(BuildContext context) {
    return const EvaluateExamPage();
  }
}
