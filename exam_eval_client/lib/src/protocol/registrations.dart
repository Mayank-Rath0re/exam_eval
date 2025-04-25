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

abstract class Registrations implements _i1.SerializableModel {
  Registrations._({
    this.id,
    required this.examId,
    required this.studentName,
    required this.rollNo,
    required this.schedule,
  });

  factory Registrations({
    int? id,
    required int examId,
    required String studentName,
    required int rollNo,
    required DateTime schedule,
  }) = _RegistrationsImpl;

  factory Registrations.fromJson(Map<String, dynamic> jsonSerialization) {
    return Registrations(
      id: jsonSerialization['id'] as int?,
      examId: jsonSerialization['examId'] as int,
      studentName: jsonSerialization['studentName'] as String,
      rollNo: jsonSerialization['rollNo'] as int,
      schedule:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['schedule']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int examId;

  String studentName;

  int rollNo;

  DateTime schedule;

  /// Returns a shallow copy of this [Registrations]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Registrations copyWith({
    int? id,
    int? examId,
    String? studentName,
    int? rollNo,
    DateTime? schedule,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'examId': examId,
      'studentName': studentName,
      'rollNo': rollNo,
      'schedule': schedule.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RegistrationsImpl extends Registrations {
  _RegistrationsImpl({
    int? id,
    required int examId,
    required String studentName,
    required int rollNo,
    required DateTime schedule,
  }) : super._(
          id: id,
          examId: examId,
          studentName: studentName,
          rollNo: rollNo,
          schedule: schedule,
        );

  /// Returns a shallow copy of this [Registrations]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Registrations copyWith({
    Object? id = _Undefined,
    int? examId,
    String? studentName,
    int? rollNo,
    DateTime? schedule,
  }) {
    return Registrations(
      id: id is int? ? id : this.id,
      examId: examId ?? this.examId,
      studentName: studentName ?? this.studentName,
      rollNo: rollNo ?? this.rollNo,
      schedule: schedule ?? this.schedule,
    );
  }
}
