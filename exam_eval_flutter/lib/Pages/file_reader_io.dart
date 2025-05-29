import 'dart:io';

Future<String> platformReadFileAsString(String path) async {
  return File(path).readAsString();
} 