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
    required this.submittedAnswer,
    required this.evaluatedScore,
  });

  factory Answer({
    int? id,
    required List<String> submittedAnswer,
    required List<double> evaluatedScore,
  }) = _AnswerImpl;

  factory Answer.fromJson(Map<String, dynamic> jsonSerialization) {
    return Answer(
      id: jsonSerialization['id'] as int?,
      submittedAnswer: (jsonSerialization['submittedAnswer'] as List)
          .map((e) => e as String)
          .toList(),
      evaluatedScore: (jsonSerialization['evaluatedScore'] as List)
          .map((e) => (e as num).toDouble())
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  List<String> submittedAnswer;

  List<double> evaluatedScore;

  /// Returns a shallow copy of this [Answer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Answer copyWith({
    int? id,
    List<String>? submittedAnswer,
    List<double>? evaluatedScore,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'submittedAnswer': submittedAnswer.toJson(),
      'evaluatedScore': evaluatedScore.toJson(),
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
    required List<String> submittedAnswer,
    required List<double> evaluatedScore,
  }) : super._(
          id: id,
          submittedAnswer: submittedAnswer,
          evaluatedScore: evaluatedScore,
        );

  /// Returns a shallow copy of this [Answer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Answer copyWith({
    Object? id = _Undefined,
    List<String>? submittedAnswer,
    List<double>? evaluatedScore,
  }) {
    return Answer(
      id: id is int? ? id : this.id,
      submittedAnswer:
          submittedAnswer ?? this.submittedAnswer.map((e0) => e0).toList(),
      evaluatedScore:
          evaluatedScore ?? this.evaluatedScore.map((e0) => e0).toList(),
    );
  }
}
