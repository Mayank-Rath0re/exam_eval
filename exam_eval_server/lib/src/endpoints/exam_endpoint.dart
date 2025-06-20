import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:exam_eval_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart' hide Result;

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

  Future<List<dynamic>> createResultBatch(Session session, int userId,
      List<int> studentId, List<String> studentName, List<int> examId) async {
    try {
      List<Result> resultData = [];
      for (int i = 0; i < studentId.length; i++) {
        var answerObj = Answer(submittedAnswer: [], evaluatedScore: []);
        var answerIns = await Answer.db.insertRow(session, answerObj);
        var resultObj = Result(
            examId: examId[i],
            rollNo: studentId[i],
            name: studentName[i],
            finalScore: -1,
            status: "Not uploaded",
            answers: answerIns.id!);
        var resultInsert = await Result.db.insertRow(session, resultObj);
        resultData.add(resultInsert);
      }
      var resultBatch = ResultBatch(
          uploadedBy: userId,
          uploadedAt: DateTime.now(),
          isDraft: true,
          contents: resultData);
      // ignore: unused_local_variable
      var batchIns = await ResultBatch.db.insertRow(session, resultBatch);
      return [batchIns.id!, resultData];
    } catch (err) {
      return [];
    }
  }

  Future<void> saveAnswers(
      Session session, int resultId, Answer answerObj) async {
    if (answerObj.submittedAnswer.isNotEmpty) {
      // ignore: unused_local_variable
      var answerUpdate = await Answer.db.updateRow(session, answerObj);
      bool emptyFlag = false;
      for (int i = 0; i < answerObj.submittedAnswer.length; i++) {
        if (answerObj.submittedAnswer[i].isEmpty) {
          emptyFlag = true;
          break;
        }
      }
      if (!emptyFlag) {
        var resultObj = await Result.db.findById(session, resultId);
        resultObj!.status = resultObj.status == "Not uploaded"
            ? "Not graded"
            : resultObj.status;
      }
    }
  }

  Future<void> evaluateExam(Session session, int resultBatchId) async {
    final url = Uri.parse('http://locahost:4000/evaluate');
    var resultBatch = await ResultBatch.db.findById(session, resultBatchId);

    for (int i = 0; i < resultBatch!.contents.length; i++) {
      var answerObj =
          await Answer.db.findById(session, resultBatch.contents[i].answers);

      // Update the state to processing for evaluation
      var examData =
          await Exam.db.findById(session, resultBatch.contents[i].examId);
      List<String> questions = [];
      List<String> idealAnswer = [];
      List<double> weightage = [];
      for (int i = 0; i < examData!.questions.length; i++) {
        questions.add(examData.questions[i].query);
        idealAnswer.add(examData.questions[i].idealAnswer!);
        weightage.add(examData.questions[i].weightage);
      }
      Map<String, dynamic> commandInput = {
        "question": questions,
        "ideal_answer": idealAnswer,
        "subjective_answer": answerObj!.submittedAnswer,
        "weightage": weightage
      };

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

  Future<Answer?> fetchAnswer(Session session, int answerId) async {
    var answerObj = await Answer.db.findById(session, answerId);
    return answerObj;
  }

  Future<List<ResultBatch>> fetchResultBatch(
      Session session, int userId) async {
    var resultBatchObj = await ResultBatch.db
        .find(session, where: (t) => t.uploadedBy.equals(userId));
    return resultBatchObj;
  }
}
