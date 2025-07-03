import 'package:exam_eval_flutter/Components/abs_button_primary.dart';
import 'package:exam_eval_flutter/Components/abs_minimal_box.dart';
import 'package:exam_eval_flutter/Components/abs_text.dart';
import 'package:exam_eval_flutter/Components/abs_textfield.dart';
import 'package:exam_eval_flutter/Pages/exam_create_edit.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ExamDefinePage extends StatefulWidget {
  const ExamDefinePage({super.key});

  @override
  State<ExamDefinePage> createState() => _ExamDefinePageState();
}

class _ExamDefinePageState extends State<ExamDefinePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _marksController = TextEditingController();
  int currentPage = 0;

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _durationController.dispose();
    _marksController.dispose();
  }

  Widget _buildFirstPage() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AbsText(
                    displayString: "Create New Exam", fontSize: 26, bold: true),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AbsText(displayString: "Title", fontSize: 16),
                    const SizedBox(height: 6),
                    AbsTextfield(
                        hintText: "title", controller: _titleController)
                  ],
                ),
                const SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AbsText(
                        displayString: "Duration (in minutes)", fontSize: 16),
                    const SizedBox(height: 6),
                    AbsTextfield(
                        hintText: "duration", controller: _durationController)
                  ],
                ),
                const SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AbsText(displayString: "Total Marks", fontSize: 16),
                    const SizedBox(height: 6),
                    AbsTextfield(
                        hintText: "marks", controller: _marksController)
                  ],
                ),
                const SizedBox(height: 15),
                AbsButtonPrimary(
                    onPressed: () {
                      setState(() {
                        currentPage = 1;
                      });
                    },
                    child: AbsText(displayString: "Create Exam", fontSize: 18))
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Icon(
                Icons.book_rounded,
                size: 60,
                color: Color(0xFF2D5A27),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView(
        children: [
          if (currentPage == 0) ...[
            _buildFirstPage()
          ] else ...[
            const SizedBox(height: 25),
            ExamCreateEdit(
              title: _titleController.text,
              duration: double.parse(_durationController.text),
              marks: int.parse(_marksController.text),
            )
          ]
        ],
      ),
    );
  }
}
