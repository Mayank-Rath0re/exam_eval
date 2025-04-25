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

abstract class Answer implements _i1.TableRow, _i1.ProtocolSerialization {
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

  static final t = AnswerTable();

  static const db = AnswerRepository._();

  @override
  int? id;

  int questionIndex;

  String submittedAnswer;

  double evaluatedScore;

  @override
  _i1.Table get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'questionIndex': questionIndex,
      'submittedAnswer': submittedAnswer,
      'evaluatedScore': evaluatedScore,
    };
  }

  static AnswerInclude include() {
    return AnswerInclude._();
  }

  static AnswerIncludeList includeList({
    _i1.WhereExpressionBuilder<AnswerTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AnswerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AnswerTable>? orderByList,
    AnswerInclude? include,
  }) {
    return AnswerIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Answer.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Answer.t),
      include: include,
    );
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

class AnswerTable extends _i1.Table {
  AnswerTable({super.tableRelation}) : super(tableName: 'answer') {
    questionIndex = _i1.ColumnInt(
      'questionIndex',
      this,
    );
    submittedAnswer = _i1.ColumnString(
      'submittedAnswer',
      this,
    );
    evaluatedScore = _i1.ColumnDouble(
      'evaluatedScore',
      this,
    );
  }

  late final _i1.ColumnInt questionIndex;

  late final _i1.ColumnString submittedAnswer;

  late final _i1.ColumnDouble evaluatedScore;

  @override
  List<_i1.Column> get columns => [
        id,
        questionIndex,
        submittedAnswer,
        evaluatedScore,
      ];
}

class AnswerInclude extends _i1.IncludeObject {
  AnswerInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Answer.t;
}

class AnswerIncludeList extends _i1.IncludeList {
  AnswerIncludeList._({
    _i1.WhereExpressionBuilder<AnswerTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Answer.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Answer.t;
}

class AnswerRepository {
  const AnswerRepository._();

  /// Returns a list of [Answer]s matching the given query parameters.
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
  Future<List<Answer>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AnswerTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AnswerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AnswerTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Answer>(
      where: where?.call(Answer.t),
      orderBy: orderBy?.call(Answer.t),
      orderByList: orderByList?.call(Answer.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Answer] matching the given query parameters.
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
  Future<Answer?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AnswerTable>? where,
    int? offset,
    _i1.OrderByBuilder<AnswerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AnswerTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Answer>(
      where: where?.call(Answer.t),
      orderBy: orderBy?.call(Answer.t),
      orderByList: orderByList?.call(Answer.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Answer] by its [id] or null if no such row exists.
  Future<Answer?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Answer>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Answer]s in the list and returns the inserted rows.
  ///
  /// The returned [Answer]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Answer>> insert(
    _i1.Session session,
    List<Answer> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Answer>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Answer] and returns the inserted row.
  ///
  /// The returned [Answer] will have its `id` field set.
  Future<Answer> insertRow(
    _i1.Session session,
    Answer row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Answer>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Answer]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Answer>> update(
    _i1.Session session,
    List<Answer> rows, {
    _i1.ColumnSelections<AnswerTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Answer>(
      rows,
      columns: columns?.call(Answer.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Answer]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Answer> updateRow(
    _i1.Session session,
    Answer row, {
    _i1.ColumnSelections<AnswerTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Answer>(
      row,
      columns: columns?.call(Answer.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Answer]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Answer>> delete(
    _i1.Session session,
    List<Answer> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Answer>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Answer].
  Future<Answer> deleteRow(
    _i1.Session session,
    Answer row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Answer>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Answer>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AnswerTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Answer>(
      where: where(Answer.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AnswerTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Answer>(
      where: where?.call(Answer.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
