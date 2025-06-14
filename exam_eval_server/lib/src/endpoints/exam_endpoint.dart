import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:exam_eval_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class ExamEndpoint extends Endpoint {
  Future<void> createExam(Session session, int creatorId, String title,
      double duration, int totalMarks, List<Question> questions) async {
    var examObj = Exam(
        creatorId: creatorId,
        title: title,
        duration: duration,
        totalMarks: totalMarks,
        questions: questions);
    // ignore: unused_local_variable
    var examInsert = Exam.db.insertRow(session, examObj);
  }

  Future<int> editExam(Session session, int creatorId, int examId, String title,
      double duration, int totalMarks, List<Question> questions) async {
    var examObj = await Exam.db.findById(session, examId);
    if (examObj != null && examObj.creatorId == creatorId) {
      var examUpdated = Exam(
          id: examId,
          creatorId: creatorId,
          title: title,
          duration: duration,
          totalMarks: totalMarks,
          questions: questions);
      // ignore: unused_local_variable
      var examIns = await Exam.db.updateRow(session, examUpdated);
      return 0;
    }
    return 1;
  }

  Future<void> deleteExam(Session session, int examId) async {
    // ignore: unused_local_variable
    var examDel =
        await Exam.db.deleteWhere(session, where: (t) => t.id.equals(examId));
    // Result Objects could be linked to this, need to figure out and code accordingly
  }

  Future<void> evaluateExam(Session session, int examId,int studentId, List<String> submittedAnswers) async {
    final url = Uri.parse('http://locahost:4000/evaluate');
    // Update the state to processing for evaluation
    var examData = await Exam.db.findById(session, examId);
    List<String> questions = [];
    List<String> idealAnswer = [];
    List<double> weightage = [];
    for( int i=0;i<examData!.questions.length;i++){
      questions.add(examData.questions[i].query);
      idealAnswer.add(examData.questions[i].idealAnswer!);
      weightage.add(examData.questions[i].weightage);
    }
    Map<String, dynamic> commandInput = {"question": questions, "ideal_answer":idealAnswer,"subjective_answer": submittedAnswers,"weightage":weightage};
    
    try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(commandInput),
    );
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      // For debugging only
      print('Output: ${responseBody['output']}');
      // Update the status to completed evaluation
      // Notify the user
    } else {
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Failed to connect to Evaluation server: $e');
  }
  }

  Future<List<Exam>> fetchUserExams(Session session, int userId) async {
    var exams =
        await Exam.db.find(session, where: (t) => t.creatorId.equals(userId));
    return exams;
  }

  Future<Exam> fetchExam(Session session, int examId) async {
    var examObj = await Exam.db.findById(session, examId);
    return examObj!;
  }
}
