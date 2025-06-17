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
import 'result.dart' as _i2;

abstract class ResultBatch implements _i1.TableRow, _i1.ProtocolSerialization {
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

  static final t = ResultBatchTable();

  static const db = ResultBatchRepository._();

  @override
  int? id;

  int uploadedBy;

  DateTime uploadedAt;

  bool isDraft;

  List<_i2.Result> contents;

  @override
  _i1.Table get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'uploadedBy': uploadedBy,
      'uploadedAt': uploadedAt.toJson(),
      'isDraft': isDraft,
      'contents': contents.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static ResultBatchInclude include() {
    return ResultBatchInclude._();
  }

  static ResultBatchIncludeList includeList({
    _i1.WhereExpressionBuilder<ResultBatchTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ResultBatchTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ResultBatchTable>? orderByList,
    ResultBatchInclude? include,
  }) {
    return ResultBatchIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ResultBatch.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ResultBatch.t),
      include: include,
    );
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

class ResultBatchTable extends _i1.Table {
  ResultBatchTable({super.tableRelation}) : super(tableName: 'result_batch') {
    uploadedBy = _i1.ColumnInt(
      'uploadedBy',
      this,
    );
    uploadedAt = _i1.ColumnDateTime(
      'uploadedAt',
      this,
    );
    isDraft = _i1.ColumnBool(
      'isDraft',
      this,
    );
    contents = _i1.ColumnSerializable(
      'contents',
      this,
    );
  }

  late final _i1.ColumnInt uploadedBy;

  late final _i1.ColumnDateTime uploadedAt;

  late final _i1.ColumnBool isDraft;

  late final _i1.ColumnSerializable contents;

  @override
  List<_i1.Column> get columns => [
        id,
        uploadedBy,
        uploadedAt,
        isDraft,
        contents,
      ];
}

class ResultBatchInclude extends _i1.IncludeObject {
  ResultBatchInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => ResultBatch.t;
}

class ResultBatchIncludeList extends _i1.IncludeList {
  ResultBatchIncludeList._({
    _i1.WhereExpressionBuilder<ResultBatchTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ResultBatch.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => ResultBatch.t;
}

class ResultBatchRepository {
  const ResultBatchRepository._();

  /// Returns a list of [ResultBatch]s matching the given query parameters.
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
  Future<List<ResultBatch>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ResultBatchTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ResultBatchTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ResultBatchTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ResultBatch>(
      where: where?.call(ResultBatch.t),
      orderBy: orderBy?.call(ResultBatch.t),
      orderByList: orderByList?.call(ResultBatch.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ResultBatch] matching the given query parameters.
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
  Future<ResultBatch?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ResultBatchTable>? where,
    int? offset,
    _i1.OrderByBuilder<ResultBatchTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ResultBatchTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ResultBatch>(
      where: where?.call(ResultBatch.t),
      orderBy: orderBy?.call(ResultBatch.t),
      orderByList: orderByList?.call(ResultBatch.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ResultBatch] by its [id] or null if no such row exists.
  Future<ResultBatch?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ResultBatch>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ResultBatch]s in the list and returns the inserted rows.
  ///
  /// The returned [ResultBatch]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ResultBatch>> insert(
    _i1.Session session,
    List<ResultBatch> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ResultBatch>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ResultBatch] and returns the inserted row.
  ///
  /// The returned [ResultBatch] will have its `id` field set.
  Future<ResultBatch> insertRow(
    _i1.Session session,
    ResultBatch row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ResultBatch>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ResultBatch]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ResultBatch>> update(
    _i1.Session session,
    List<ResultBatch> rows, {
    _i1.ColumnSelections<ResultBatchTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ResultBatch>(
      rows,
      columns: columns?.call(ResultBatch.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ResultBatch]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ResultBatch> updateRow(
    _i1.Session session,
    ResultBatch row, {
    _i1.ColumnSelections<ResultBatchTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ResultBatch>(
      row,
      columns: columns?.call(ResultBatch.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ResultBatch]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ResultBatch>> delete(
    _i1.Session session,
    List<ResultBatch> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ResultBatch>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ResultBatch].
  Future<ResultBatch> deleteRow(
    _i1.Session session,
    ResultBatch row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ResultBatch>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ResultBatch>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ResultBatchTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ResultBatch>(
      where: where(ResultBatch.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ResultBatchTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ResultBatch>(
      where: where?.call(ResultBatch.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
