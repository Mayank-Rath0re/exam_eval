/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class Registrations
    implements _i1.TableRow, _i1.ProtocolSerialization {
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

  static final t = RegistrationsTable();

  static const db = RegistrationsRepository._();

  @override
  int? id;

  int examId;

  String studentName;

  int rollNo;

  DateTime schedule;

  @override
  _i1.Table get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'examId': examId,
      'studentName': studentName,
      'rollNo': rollNo,
      'schedule': schedule.toJson(),
    };
  }

  static RegistrationsInclude include() {
    return RegistrationsInclude._();
  }

  static RegistrationsIncludeList includeList({
    _i1.WhereExpressionBuilder<RegistrationsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RegistrationsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RegistrationsTable>? orderByList,
    RegistrationsInclude? include,
  }) {
    return RegistrationsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Registrations.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Registrations.t),
      include: include,
    );
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

class RegistrationsTable extends _i1.Table {
  RegistrationsTable({super.tableRelation})
      : super(tableName: 'registrations') {
    examId = _i1.ColumnInt(
      'examId',
      this,
    );
    studentName = _i1.ColumnString(
      'studentName',
      this,
    );
    rollNo = _i1.ColumnInt(
      'rollNo',
      this,
    );
    schedule = _i1.ColumnDateTime(
      'schedule',
      this,
    );
  }

  late final _i1.ColumnInt examId;

  late final _i1.ColumnString studentName;

  late final _i1.ColumnInt rollNo;

  late final _i1.ColumnDateTime schedule;

  @override
  List<_i1.Column> get columns => [
        id,
        examId,
        studentName,
        rollNo,
        schedule,
      ];
}

class RegistrationsInclude extends _i1.IncludeObject {
  RegistrationsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Registrations.t;
}

class RegistrationsIncludeList extends _i1.IncludeList {
  RegistrationsIncludeList._({
    _i1.WhereExpressionBuilder<RegistrationsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Registrations.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Registrations.t;
}

class RegistrationsRepository {
  const RegistrationsRepository._();

  /// Returns a list of [Registrations]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Registrations>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RegistrationsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RegistrationsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RegistrationsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Registrations>(
      where: where?.call(Registrations.t),
      orderBy: orderBy?.call(Registrations.t),
      orderByList: orderByList?.call(Registrations.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Registrations] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Registrations?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RegistrationsTable>? where,
    int? offset,
    _i1.OrderByBuilder<RegistrationsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RegistrationsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Registrations>(
      where: where?.call(Registrations.t),
      orderBy: orderBy?.call(Registrations.t),
      orderByList: orderByList?.call(Registrations.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Registrations] by its [id] or null if no such row exists.
  Future<Registrations?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Registrations>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Registrations]s in the list and returns the inserted rows.
  ///
  /// The returned [Registrations]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Registrations>> insert(
    _i1.Session session,
    List<Registrations> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Registrations>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Registrations] and returns the inserted row.
  ///
  /// The returned [Registrations] will have its `id` field set.
  Future<Registrations> insertRow(
    _i1.Session session,
    Registrations row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Registrations>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Registrations]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Registrations>> update(
    _i1.Session session,
    List<Registrations> rows, {
    _i1.ColumnSelections<RegistrationsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Registrations>(
      rows,
      columns: columns?.call(Registrations.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Registrations]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Registrations> updateRow(
    _i1.Session session,
    Registrations row, {
    _i1.ColumnSelections<RegistrationsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Registrations>(
      row,
      columns: columns?.call(Registrations.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Registrations]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Registrations>> delete(
    _i1.Session session,
    List<Registrations> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Registrations>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Registrations].
  Future<Registrations> deleteRow(
    _i1.Session session,
    Registrations row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Registrations>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Registrations>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RegistrationsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Registrations>(
      where: where(Registrations.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RegistrationsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Registrations>(
      where: where?.call(Registrations.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
