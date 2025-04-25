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

abstract class Question implements _i1.SerializableModel {
  Question._({
    this.id,
    required this.query,
    this.idealAnswer,
    required this.images,
    required this.weightage,
  });

  factory Question({
    int? id,
    required String query,
    String? idealAnswer,
    required List<String?> images,
    required double weightage,
  }) = _QuestionImpl;

  factory Question.fromJson(Map<String, dynamic> jsonSerialization) {
    return Question(
      id: jsonSerialization['id'] as int?,
      query: jsonSerialization['query'] as String,
      idealAnswer: jsonSerialization['idealAnswer'] as String?,
      images: (jsonSerialization['images'] as List)
          .map((e) => e as String?)
          .toList(),
      weightage: (jsonSerialization['weightage'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String query;

  String? idealAnswer;

  List<String?> images;

  double weightage;

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Question copyWith({
    int? id,
    String? query,
    String? idealAnswer,
    List<String?>? images,
    double? weightage,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'query': query,
      if (idealAnswer != null) 'idealAnswer': idealAnswer,
      'images': images.toJson(),
      'weightage': weightage,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuestionImpl extends Question {
  _QuestionImpl({
    int? id,
    required String query,
    String? idealAnswer,
    required List<String?> images,
    required double weightage,
  }) : super._(
          id: id,
          query: query,
          idealAnswer: idealAnswer,
          images: images,
          weightage: weightage,
        );

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Question copyWith({
    Object? id = _Undefined,
    String? query,
    Object? idealAnswer = _Undefined,
    List<String?>? images,
    double? weightage,
  }) {
    return Question(
      id: id is int? ? id : this.id,
      query: query ?? this.query,
      idealAnswer: idealAnswer is String? ? idealAnswer : this.idealAnswer,
      images: images ?? this.images.map((e0) => e0).toList(),
      weightage: weightage ?? this.weightage,
    );
  }
}
