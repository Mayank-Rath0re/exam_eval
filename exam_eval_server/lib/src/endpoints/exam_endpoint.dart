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
