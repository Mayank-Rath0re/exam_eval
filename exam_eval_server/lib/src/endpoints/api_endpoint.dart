import 'dart:io';
import 'dart:typed_data';
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

  Future<String> uploadImage(
      Session session, ByteData imageData, String filename) async {
    String path = "/uploads/$filename";
    // ignore: unused_local_variable
    final file = await session.storage
        .storeFile(storageId: "public", path: path, byteData: imageData);
    final verify =
        await session.storage.fileExists(storageId: "public", path: path);
    if (verify) {
      print("Image Uploaded Successfully");
      var uri =
          await session.storage.getPublicUrl(storageId: "public", path: path);
      return uri.toString();
    }
    return "";
  }

  Future<String> imageOcr(
      Session session, ByteData imageData, String filename) async {
    try {
      final filePath = 'temp/$filename.png';

      // Convert ByteData to Uint8List and write to file
      final buffer = imageData.buffer;
      final bytes =
          buffer.asUint8List(imageData.offsetInBytes, imageData.lengthInBytes);
      final file = File(filePath);
      await file.writeAsBytes(bytes);

      // Call the Python OCR script
      final process = await Process.run(
        'python',
        ['api_methods/gemini_ocr.py', filePath],
      );

      if (process.exitCode != 0) {
        throw Exception('Python script error: ${process.stderr}');
      }

      return process.stdout.toString();
    } catch (err) {
      print(err);
      return err.toString();
    }
  }
}
