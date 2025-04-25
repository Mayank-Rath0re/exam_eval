/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'question.dart' as _i2;

abstract class Exam implements _i1.SerializableModel {
  Exam._({
    this.id,
    required this.creatorId,
    required this.title,
    required this.duration,
    required this.totalMarks,
    required this.questions,
  });

  factory Exam({
    int? id,
    required int creatorId,
    required String title,
    required double duration,
    required int totalMarks,
    required List<_i2.Question> questions,
  }) = _ExamImpl;

  factory Exam.fromJson(Map<String, dynamic> jsonSerialization) {
    return Exam(
      id: jsonSerialization['id'] as int?,
      creatorId: jsonSerialization['creatorId'] as int,
      title: jsonSerialization['title'] as String,
      duration: (jsonSerialization['duration'] as num).toDouble(),
      totalMarks: jsonSerialization['totalMarks'] as int,
      questions: (jsonSerialization['questions'] as List)
          .map((e) => _i2.Question.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int creatorId;

  String title;

  double duration;

  int totalMarks;

  List<_i2.Question> questions;

  /// Returns a shallow copy of this [Exam]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Exam copyWith({
    int? id,
    int? creatorId,
    String? title,
    double? duration,
    int? totalMarks,
    List<_i2.Question>? questions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'creatorId': creatorId,
      'title': title,
      'duration': duration,
      'totalMarks': totalMarks,
      'questions': questions.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExamImpl extends Exam {
  _ExamImpl({
    int? id,
    required int creatorId,
    required String title,
    required double duration,
    required int totalMarks,
    required List<_i2.Question> questions,
  }) : super._(
          id: id,
          creatorId: creatorId,
          title: title,
          duration: duration,
          totalMarks: totalMarks,
          questions: questions,
        );

  /// Returns a shallow copy of this [Exam]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Exam copyWith({
    Object? id = _Undefined,
    int? creatorId,
    String? title,
    double? duration,
    int? totalMarks,
    List<_i2.Question>? questions,
  }) {
    return Exam(
      id: id is int? ? id : this.id,
      creatorId: creatorId ?? this.creatorId,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      totalMarks: totalMarks ?? this.totalMarks,
      questions:
          questions ?? this.questions.map((e0) => e0.copyWith()).toList(),
    );
  }
}
