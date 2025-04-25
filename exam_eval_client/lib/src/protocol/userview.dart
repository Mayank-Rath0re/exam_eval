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

abstract class UserView implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int accountId;

  String name;

  String avatar;

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
