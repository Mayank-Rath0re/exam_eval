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

abstract class User implements _i1.SerializableModel {
  User._({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.dob,
    required this.gender,
    required this.education,
    required this.work,
  });

  factory User({
    int? id,
    required String name,
    required String email,
    required String password,
    required DateTime dob,
    required String gender,
    required List<String> education,
    required List<String> work,
  }) = _UserImpl;

  factory User.fromJson(Map<String, dynamic> jsonSerialization) {
    return User(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      email: jsonSerialization['email'] as String,
      password: jsonSerialization['password'] as String,
      dob: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dob']),
      gender: jsonSerialization['gender'] as String,
      education: (jsonSerialization['education'] as List)
          .map((e) => e as String)
          .toList(),
      work:
          (jsonSerialization['work'] as List).map((e) => e as String).toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String email;

  String password;

  DateTime dob;

  String gender;

  List<String> education;

  List<String> work;

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  User copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    DateTime? dob,
    String? gender,
    List<String>? education,
    List<String>? work,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'email': email,
      'password': password,
      'dob': dob.toJson(),
      'gender': gender,
      'education': education.toJson(),
      'work': work.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserImpl extends User {
  _UserImpl({
    int? id,
    required String name,
    required String email,
    required String password,
    required DateTime dob,
    required String gender,
    required List<String> education,
    required List<String> work,
  }) : super._(
          id: id,
          name: name,
          email: email,
          password: password,
          dob: dob,
          gender: gender,
          education: education,
          work: work,
        );

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  User copyWith({
    Object? id = _Undefined,
    String? name,
    String? email,
    String? password,
    DateTime? dob,
    String? gender,
    List<String>? education,
    List<String>? work,
  }) {
    return User(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      education: education ?? this.education.map((e0) => e0).toList(),
      work: work ?? this.work.map((e0) => e0).toList(),
    );
  }
}
