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

abstract class UserView implements _i1.TableRow, _i1.ProtocolSerialization {
  UserView._({
    this.id,
    required this.accountId,
    required this.name,
    required this.avatar,
  });

  factory UserView({
    int? id,
    required int accountId,
    required String name,
    required String avatar,
  }) = _UserViewImpl;

  factory UserView.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserView(
      id: jsonSerialization['id'] as int?,
      accountId: jsonSerialization['accountId'] as int,
      name: jsonSerialization['name'] as String,
      avatar: jsonSerialization['avatar'] as String,
    );
  }

  static final t = UserViewTable();

  static const db = UserViewRepository._();

  @override
  int? id;

  int accountId;

  String name;

  String avatar;

  @override
  _i1.Table get table => t;

  /// Returns a shallow copy of this [UserView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserView copyWith({
    int? id,
    int? accountId,
    String? name,
    String? avatar,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'accountId': accountId,
      'name': name,
      'avatar': avatar,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'accountId': accountId,
      'name': name,
      'avatar': avatar,
    };
  }

  static UserViewInclude include() {
    return UserViewInclude._();
  }

  static UserViewIncludeList includeList({
    _i1.WhereExpressionBuilder<UserViewTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserViewTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserViewTable>? orderByList,
    UserViewInclude? include,
  }) {
    return UserViewIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserView.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserView.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserViewImpl extends UserView {
  _UserViewImpl({
    int? id,
    required int accountId,
    required String name,
    required String avatar,
  }) : super._(
          id: id,
          accountId: accountId,
          name: name,
          avatar: avatar,
        );

  /// Returns a shallow copy of this [UserView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserView copyWith({
    Object? id = _Undefined,
    int? accountId,
    String? name,
    String? avatar,
  }) {
    return UserView(
      id: id is int? ? id : this.id,
      accountId: accountId ?? this.accountId,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }
}

class UserViewTable extends _i1.Table {
  UserViewTable({super.tableRelation}) : super(tableName: 'userview') {
    accountId = _i1.ColumnInt(
      'accountId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    avatar = _i1.ColumnString(
      'avatar',
      this,
    );
  }

  late final _i1.ColumnInt accountId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString avatar;

  @override
  List<_i1.Column> get columns => [
        id,
        accountId,
        name,
        avatar,
      ];
}

class UserViewInclude extends _i1.IncludeObject {
  UserViewInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => UserView.t;
}

class UserViewIncludeList extends _i1.IncludeList {
  UserViewIncludeList._({
    _i1.WhereExpressionBuilder<UserViewTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserView.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => UserView.t;
}

class UserViewRepository {
  const UserViewRepository._();

  /// Returns a list of [UserView]s matching the given query parameters.
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
  Future<List<UserView>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserViewTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserViewTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserViewTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<UserView>(
      where: where?.call(UserView.t),
      orderBy: orderBy?.call(UserView.t),
      orderByList: orderByList?.call(UserView.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [UserView] matching the given query parameters.
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
  Future<UserView?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserViewTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserViewTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserViewTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<UserView>(
      where: where?.call(UserView.t),
      orderBy: orderBy?.call(UserView.t),
      orderByList: orderByList?.call(UserView.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [UserView] by its [id] or null if no such row exists.
  Future<UserView?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<UserView>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [UserView]s in the list and returns the inserted rows.
  ///
  /// The returned [UserView]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<UserView>> insert(
    _i1.Session session,
    List<UserView> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<UserView>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [UserView] and returns the inserted row.
  ///
  /// The returned [UserView] will have its `id` field set.
  Future<UserView> insertRow(
    _i1.Session session,
    UserView row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserView>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserView]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserView>> update(
    _i1.Session session,
    List<UserView> rows, {
    _i1.ColumnSelections<UserViewTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserView>(
      rows,
      columns: columns?.call(UserView.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserView]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserView> updateRow(
    _i1.Session session,
    UserView row, {
    _i1.ColumnSelections<UserViewTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserView>(
      row,
      columns: columns?.call(UserView.t),
      transaction: transaction,
    );
  }

  /// Deletes all [UserView]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserView>> delete(
    _i1.Session session,
    List<UserView> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserView>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserView].
  Future<UserView> deleteRow(
    _i1.Session session,
    UserView row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserView>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserView>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserViewTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserView>(
      where: where(UserView.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserViewTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserView>(
      where: where?.call(UserView.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
