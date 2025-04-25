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
import 'answer.dart' as _i2;

abstract class Result implements _i1.SerializableModel {
  Result._({
    this.id,
    required this.examId,
    required this.rollNo,
    required this.finalScore,
    required this.answers,
  });

  factory Result({
    int? id,
    required int examId,
    required int rollNo,
    required double finalScore,
    required List<_i2.Answer> answers,
  }) = _ResultImpl;

  factory Result.fromJson(Map<String, dynamic> jsonSerialization) {
    return Result(
      id: jsonSerialization['id'] as int?,
      examId: jsonSerialization['examId'] as int,
      rollNo: jsonSerialization['rollNo'] as int,
      finalScore: (jsonSerialization['finalScore'] as num).toDouble(),
      answers: (jsonSerialization['answers'] as List)
          .map((e) => _i2.Answer.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int examId;

  int rollNo;

  double finalScore;

  List<_i2.Answer> answers;

  /// Returns a shallow copy of this [Result]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Result copyWith({
    int? id,
    int? examId,
    int? rollNo,
    double? finalScore,
    List<_i2.Answer>? answers,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'examId': examId,
      'rollNo': rollNo,
      'finalScore': finalScore,
      'answers': answers.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ResultImpl extends Result {
  _ResultImpl({
    int? id,
    required int examId,
    required int rollNo,
    required double finalScore,
    required List<_i2.Answer> answers,
  }) : super._(
          id: id,
          examId: examId,
          rollNo: rollNo,
          finalScore: finalScore,
          answers: answers,
        );

  /// Returns a shallow copy of this [Result]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Result copyWith({
    Object? id = _Undefined,
    int? examId,
    int? rollNo,
    double? finalScore,
    List<_i2.Answer>? answers,
  }) {
    return Result(
      id: id is int? ? id : this.id,
      examId: examId ?? this.examId,
      rollNo: rollNo ?? this.rollNo,
      finalScore: finalScore ?? this.finalScore,
      answers: answers ?? this.answers.map((e0) => e0.copyWith()).toList(),
    );
  }
}
