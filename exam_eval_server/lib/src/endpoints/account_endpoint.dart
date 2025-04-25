import 'package:exam_eval_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class AccountEndpoint extends Endpoint {
  // Create Account
  Future<int> createAccount(
      Session session,
      int? id,
      String name,
      String email,
      String password,
      DateTime dob,
      String gender,
      List<String> education,
      List<String> work) async {
    // create User object
    User userObj = User(
        name: name,
        password: password,
        email: email,
        dob: dob,
        gender: gender,
        education: education,
        work: work);

    // Insert Object
    // ignore: unused_local_variable
    try {
      var userInsert = await User.db.insertRow(session, userObj);
      // ignore: unused_local_variable
      return userInsert.id!;
    } catch (e) {
      print("Error inserting user: $e");
      return -1;
    }
  }
}
