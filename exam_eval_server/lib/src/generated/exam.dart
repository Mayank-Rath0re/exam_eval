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
import 'question.dart' as _i2;

abstract class Exam implements _i1.TableRow, _i1.ProtocolSerialization {
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

  static final t = ExamTable();

  static const db = ExamRepository._();

  @override
  int? id;

  int creatorId;

  String title;

  double duration;

  int totalMarks;

  List<_i2.Question> questions;

  @override
  _i1.Table get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'creatorId': creatorId,
      'title': title,
      'duration': duration,
      'totalMarks': totalMarks,
      'questions': questions.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static ExamInclude include() {
    return ExamInclude._();
  }

  static ExamIncludeList includeList({
    _i1.WhereExpressionBuilder<ExamTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExamTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExamTable>? orderByList,
    ExamInclude? include,
  }) {
    return ExamIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Exam.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Exam.t),
      include: include,
    );
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

class ExamTable extends _i1.Table {
  ExamTable({super.tableRelation}) : super(tableName: 'exam') {
    creatorId = _i1.ColumnInt(
      'creatorId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    duration = _i1.ColumnDouble(
      'duration',
      this,
    );
    totalMarks = _i1.ColumnInt(
      'totalMarks',
      this,
    );
    questions = _i1.ColumnSerializable(
      'questions',
      this,
    );
  }

  late final _i1.ColumnInt creatorId;

  late final _i1.ColumnString title;

  late final _i1.ColumnDouble duration;

  late final _i1.ColumnInt totalMarks;

  late final _i1.ColumnSerializable questions;

  @override
  List<_i1.Column> get columns => [
        id,
        creatorId,
        title,
        duration,
        totalMarks,
        questions,
      ];
}

class ExamInclude extends _i1.IncludeObject {
  ExamInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Exam.t;
}

class ExamIncludeList extends _i1.IncludeList {
  ExamIncludeList._({
    _i1.WhereExpressionBuilder<ExamTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Exam.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Exam.t;
}

class ExamRepository {
  const ExamRepository._();

  /// Returns a list of [Exam]s matching the given query parameters.
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
  Future<List<Exam>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExamTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExamTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExamTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Exam>(
      where: where?.call(Exam.t),
      orderBy: orderBy?.call(Exam.t),
      orderByList: orderByList?.call(Exam.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Exam] matching the given query parameters.
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
  Future<Exam?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExamTable>? where,
    int? offset,
    _i1.OrderByBuilder<ExamTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExamTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Exam>(
      where: where?.call(Exam.t),
      orderBy: orderBy?.call(Exam.t),
      orderByList: orderByList?.call(Exam.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Exam] by its [id] or null if no such row exists.
  Future<Exam?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Exam>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Exam]s in the list and returns the inserted rows.
  ///
  /// The returned [Exam]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Exam>> insert(
    _i1.Session session,
    List<Exam> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Exam>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Exam] and returns the inserted row.
  ///
  /// The returned [Exam] will have its `id` field set.
  Future<Exam> insertRow(
    _i1.Session session,
    Exam row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Exam>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Exam]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Exam>> update(
    _i1.Session session,
    List<Exam> rows, {
    _i1.ColumnSelections<ExamTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Exam>(
      rows,
      columns: columns?.call(Exam.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Exam]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Exam> updateRow(
    _i1.Session session,
    Exam row, {
    _i1.ColumnSelections<ExamTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Exam>(
      row,
      columns: columns?.call(Exam.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Exam]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Exam>> delete(
    _i1.Session session,
    List<Exam> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Exam>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Exam].
  Future<Exam> deleteRow(
    _i1.Session session,
    Exam row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Exam>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Exam>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ExamTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Exam>(
      where: where(Exam.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExamTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Exam>(
      where: where?.call(Exam.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
