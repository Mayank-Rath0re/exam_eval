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
import 'answer.dart' as _i2;

abstract class Result implements _i1.TableRow, _i1.ProtocolSerialization {
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

  static final t = ResultTable();

  static const db = ResultRepository._();

  @override
  int? id;

  int examId;

  int rollNo;

  double finalScore;

  List<_i2.Answer> answers;

  @override
  _i1.Table get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'examId': examId,
      'rollNo': rollNo,
      'finalScore': finalScore,
      'answers': answers.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static ResultInclude include() {
    return ResultInclude._();
  }

  static ResultIncludeList includeList({
    _i1.WhereExpressionBuilder<ResultTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ResultTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ResultTable>? orderByList,
    ResultInclude? include,
  }) {
    return ResultIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Result.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Result.t),
      include: include,
    );
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

class ResultTable extends _i1.Table {
  ResultTable({super.tableRelation}) : super(tableName: 'result') {
    examId = _i1.ColumnInt(
      'examId',
      this,
    );
    rollNo = _i1.ColumnInt(
      'rollNo',
      this,
    );
    finalScore = _i1.ColumnDouble(
      'finalScore',
      this,
    );
    answers = _i1.ColumnSerializable(
      'answers',
      this,
    );
  }

  late final _i1.ColumnInt examId;

  late final _i1.ColumnInt rollNo;

  late final _i1.ColumnDouble finalScore;

  late final _i1.ColumnSerializable answers;

  @override
  List<_i1.Column> get columns => [
        id,
        examId,
        rollNo,
        finalScore,
        answers,
      ];
}

class ResultInclude extends _i1.IncludeObject {
  ResultInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Result.t;
}

class ResultIncludeList extends _i1.IncludeList {
  ResultIncludeList._({
    _i1.WhereExpressionBuilder<ResultTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Result.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Result.t;
}

class ResultRepository {
  const ResultRepository._();

  /// Returns a list of [Result]s matching the given query parameters.
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
  Future<List<Result>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ResultTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ResultTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ResultTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Result>(
      where: where?.call(Result.t),
      orderBy: orderBy?.call(Result.t),
      orderByList: orderByList?.call(Result.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Result] matching the given query parameters.
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
  Future<Result?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ResultTable>? where,
    int? offset,
    _i1.OrderByBuilder<ResultTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ResultTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Result>(
      where: where?.call(Result.t),
      orderBy: orderBy?.call(Result.t),
      orderByList: orderByList?.call(Result.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Result] by its [id] or null if no such row exists.
  Future<Result?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Result>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Result]s in the list and returns the inserted rows.
  ///
  /// The returned [Result]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Result>> insert(
    _i1.Session session,
    List<Result> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Result>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Result] and returns the inserted row.
  ///
  /// The returned [Result] will have its `id` field set.
  Future<Result> insertRow(
    _i1.Session session,
    Result row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Result>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Result]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Result>> update(
    _i1.Session session,
    List<Result> rows, {
    _i1.ColumnSelections<ResultTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Result>(
      rows,
      columns: columns?.call(Result.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Result]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Result> updateRow(
    _i1.Session session,
    Result row, {
    _i1.ColumnSelections<ResultTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Result>(
      row,
      columns: columns?.call(Result.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Result]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Result>> delete(
    _i1.Session session,
    List<Result> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Result>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Result].
  Future<Result> deleteRow(
    _i1.Session session,
    Result row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Result>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Result>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ResultTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Result>(
      where: where(Result.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ResultTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Result>(
      where: where?.call(Result.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
