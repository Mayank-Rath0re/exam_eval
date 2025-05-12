import 'dart:io';
import 'package:serverpod/serverpod.dart';

class ApiEndpoint extends Endpoint {
  Future<String> generateIdealAnswer(Session session, String query) async {
    String generatedResponse = "";
    try {
      var process = await Process.run(
          "python", ["api_methods/ideal_answer_generation.py", query]);
      generatedResponse += process.stdout.toString();
      return generatedResponse;
    } catch (err) {
      print(err);
      return err.toString();
    }
  }

  Future<String> imageOcr(Session session, String filepath) async {
    try {
      String extractedText = "";
      var process =
          await Process.run("python", ["api_methods/gemini_ocr.py", filepath]);
      extractedText += process.stdout.toString();
      return extractedText;
    } catch (err) {
      print(err);
      return err.toString();
    }
  }
}
