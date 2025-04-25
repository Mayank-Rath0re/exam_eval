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

abstract class Answer implements _i1.SerializableModel {
  Answer._({
    this.id,
    required this.questionIndex,
    required this.submittedAnswer,
    required this.evaluatedScore,
  });

  factory Answer({
    int? id,
    required int questionIndex,
    required String submittedAnswer,
    required double evaluatedScore,
  }) = _AnswerImpl;

  factory Answer.fromJson(Map<String, dynamic> jsonSerialization) {
    return Answer(
      id: jsonSerialization['id'] as int?,
      questionIndex: jsonSerialization['questionIndex'] as int,
      submittedAnswer: jsonSerialization['submittedAnswer'] as String,
      evaluatedScore: (jsonSerialization['evaluatedScore'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int questionIndex;

  String submittedAnswer;

  double evaluatedScore;

  /// Returns a shallow copy of this [Answer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Answer copyWith({
    int? id,
    int? questionIndex,
    String? submittedAnswer,
    double? evaluatedScore,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'questionIndex': questionIndex,
      'submittedAnswer': submittedAnswer,
      'evaluatedScore': evaluatedScore,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AnswerImpl extends Answer {
  _AnswerImpl({
    int? id,
    required int questionIndex,
    required String submittedAnswer,
    required double evaluatedScore,
  }) : super._(
          id: id,
          questionIndex: questionIndex,
          submittedAnswer: submittedAnswer,
          evaluatedScore: evaluatedScore,
        );

  /// Returns a shallow copy of this [Answer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Answer copyWith({
    Object? id = _Undefined,
    int? questionIndex,
    String? submittedAnswer,
    double? evaluatedScore,
  }) {
    return Answer(
      id: id is int? ? id : this.id,
      questionIndex: questionIndex ?? this.questionIndex,
      submittedAnswer: submittedAnswer ?? this.submittedAnswer,
      evaluatedScore: evaluatedScore ?? this.evaluatedScore,
    );
  }
}
