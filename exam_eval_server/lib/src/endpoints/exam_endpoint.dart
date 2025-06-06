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

  Future<Exam> fetchExam(Session session, int examId) async {
    var examObj = await Exam.db.findById(session, examId);
    return examObj!;
  }
}
