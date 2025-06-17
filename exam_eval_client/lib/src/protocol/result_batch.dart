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
import 'result.dart' as _i2;

abstract class ResultBatch implements _i1.SerializableModel {
  ResultBatch._({
    this.id,
    required this.uploadedBy,
    required this.uploadedAt,
    required this.isDraft,
    required this.contents,
  });

  factory ResultBatch({
    int? id,
    required int uploadedBy,
    required DateTime uploadedAt,
    required bool isDraft,
    required List<_i2.Result> contents,
  }) = _ResultBatchImpl;

  factory ResultBatch.fromJson(Map<String, dynamic> jsonSerialization) {
    return ResultBatch(
      id: jsonSerialization['id'] as int?,
      uploadedBy: jsonSerialization['uploadedBy'] as int,
      uploadedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['uploadedAt']),
      isDraft: jsonSerialization['isDraft'] as bool,
      contents: (jsonSerialization['contents'] as List)
          .map((e) => _i2.Result.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int uploadedBy;

  DateTime uploadedAt;

  bool isDraft;

  List<_i2.Result> contents;

  /// Returns a shallow copy of this [ResultBatch]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ResultBatch copyWith({
    int? id,
    int? uploadedBy,
    DateTime? uploadedAt,
    bool? isDraft,
    List<_i2.Result>? contents,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'uploadedBy': uploadedBy,
      'uploadedAt': uploadedAt.toJson(),
      'isDraft': isDraft,
      'contents': contents.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ResultBatchImpl extends ResultBatch {
  _ResultBatchImpl({
    int? id,
    required int uploadedBy,
    required DateTime uploadedAt,
    required bool isDraft,
    required List<_i2.Result> contents,
  }) : super._(
          id: id,
          uploadedBy: uploadedBy,
          uploadedAt: uploadedAt,
          isDraft: isDraft,
          contents: contents,
        );

  /// Returns a shallow copy of this [ResultBatch]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ResultBatch copyWith({
    Object? id = _Undefined,
    int? uploadedBy,
    DateTime? uploadedAt,
    bool? isDraft,
    List<_i2.Result>? contents,
  }) {
    return ResultBatch(
      id: id is int? ? id : this.id,
      uploadedBy: uploadedBy ?? this.uploadedBy,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      isDraft: isDraft ?? this.isDraft,
      contents: contents ?? this.contents.map((e0) => e0.copyWith()).toList(),
    );
  }
}
