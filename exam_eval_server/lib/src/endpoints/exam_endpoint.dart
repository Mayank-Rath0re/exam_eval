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

  Future<int> createResultBatch(Session session, String batchTitle, int userId,
      List<int> studentId, List<String> studentName, List<int> examId) async {
    try {
      List<int> resultData = [];
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
        resultData.add(resultInsert.id!);
      }
      var resultBatch = ResultBatch(
          title: batchTitle,
          uploadedBy: userId,
          uploadedAt: DateTime.now(),
          stage: "Draft",
          contents: resultData);
      // ignore: unused_local_variable
      var batchIns = await ResultBatch.db.insertRow(session, resultBatch);
      return batchIns.id!;
    } catch (err) {
      print(err);
      return -1;
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
      print(emptyFlag);
      if (!emptyFlag) {
        var resultObj = await Result.db.findById(session, resultId);
        print(resultObj!.status);
        resultObj.status = resultObj.status == "Not uploaded"
            ? "Not graded"
            : resultObj.status;
        print(resultObj.status);
        // ignore: unused_local_variable
        var resultUpd = await Result.db.updateRow(session, resultObj);
      }
    }
  }

  Future<void> evaluateExam(Session session, int resultBatchId) async {
    final url = Uri.parse('http://localhost:4000/evaluate');
    var resultBatch = await ResultBatch.db.findById(session, resultBatchId);
    resultBatch!.stage = "Evaluating";
    var resultBatchUpdate =
        await ResultBatch.db.updateRow(session, resultBatch);
    for (int i = 0; i < resultBatch.contents.length; i++) {
      var resultObj =
          await Result.db.findById(session, resultBatch.contents[i]);
      var answerObj = await Answer.db.findById(session, resultObj!.answers);

      // Update the state to processing for evaluation
      var examData = await Exam.db.findById(session, resultObj.examId);
      List<String> questions = [];
      List<String> idealAnswer = [];
      List<double> weightage = [];
      for (int j = 0; j < examData!.questions.length; j++) {
        questions.add(examData.questions[j].query);
        idealAnswer.add(examData.questions[j].idealAnswer!);
        weightage.add(examData.questions[j].weightage);
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
          final decodedOnce = json.decode(response.body);
          final responseBody = json.decode(decodedOnce);
          double totalScore = 0;
          answerObj.evaluatedScore = List.filled(responseBody.length, 0.0);

          for (int responseIndex = 0;
              responseIndex < responseBody.length;
              responseIndex++) {
            var answerScore = responseBody[responseIndex]["marks"];
            answerObj.evaluatedScore[responseIndex] =
                double.parse(answerScore.toString());
            totalScore += answerScore;
          }
          resultObj.finalScore = totalScore.toDouble();
          await Answer.db.updateRow(session, answerObj);
          resultObj.status = "graded";
          await Result.db.updateRow(session, resultObj);
          // Notify the user
        } else {
          print('Response body: ${response.body}');
        }
      } catch (e) {
        resultBatchUpdate.stage = "Error";
        print('Failed to connect to Evaluation server: $e');
      }
    }
    resultBatchUpdate.stage =
        resultBatchUpdate.stage != "Error" ? "Completed" : "Error";
    if (resultBatchUpdate.stage == "Completed") {
      resultBatchUpdate.completedAt = DateTime.now();
    }
    // ignore: unused_local_variable
    var resultBatchFinalize =
        await ResultBatch.db.updateRow(session, resultBatchUpdate);
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

  Future<List<Result>> fetchResultBatchById(
      Session session, int batchId) async {
    var resultBatchObj = await ResultBatch.db.findById(session, batchId);
    List<Result> resultData = [];
    for (int i = 0; i < resultBatchObj!.contents.length; i++) {
      var resultObj =
          await Result.db.findById(session, resultBatchObj.contents[i]);
      resultData.add(resultObj!);
    }
    return resultData;
  }

  Future<List<ResultBatch>> fetchCompletedResults(
      Session session, int userId) async {
    var resultBatchObj = await ResultBatch.db.find(session,
        where: (t) =>
            t.uploadedBy.equals(userId) & t.stage.equals("Completed"));
    return resultBatchObj;
  }
}
