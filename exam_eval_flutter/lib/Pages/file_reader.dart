// file_reader.dart
// Platform-aware file reader

// ignore: uri_does_not_exist
import 'file_reader_io.dart' if (dart.library.html) 'file_reader_web.dart';

Future<String> readFileAsString(String path) => platformReadFileAsString(path); 