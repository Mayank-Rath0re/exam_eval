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
import 'answer.dart' as _i2;
import 'exam.dart' as _i3;
import 'example.dart' as _i4;
import 'question.dart' as _i5;
import 'registrations.dart' as _i6;
import 'result.dart' as _i7;
import 'result_batch.dart' as _i8;
import 'user.dart' as _i9;
import 'userview.dart' as _i10;
import 'package:exam_eval_client/src/protocol/question.dart' as _i11;
import 'package:exam_eval_client/src/protocol/exam.dart' as _i12;
import 'package:exam_eval_client/src/protocol/result_batch.dart' as _i13;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i14;
export 'answer.dart';
export 'exam.dart';
export 'example.dart';
export 'question.dart';
export 'registrations.dart';
export 'result.dart';
export 'result_batch.dart';
export 'user.dart';
export 'userview.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.Answer) {
      return _i2.Answer.fromJson(data) as T;
    }
    if (t == _i3.Exam) {
      return _i3.Exam.fromJson(data) as T;
    }
    if (t == _i4.Example) {
      return _i4.Example.fromJson(data) as T;
    }
    if (t == _i5.Question) {
      return _i5.Question.fromJson(data) as T;
    }
    if (t == _i6.Registrations) {
      return _i6.Registrations.fromJson(data) as T;
    }
    if (t == _i7.Result) {
      return _i7.Result.fromJson(data) as T;
    }
    if (t == _i8.ResultBatch) {
      return _i8.ResultBatch.fromJson(data) as T;
    }
    if (t == _i9.User) {
      return _i9.User.fromJson(data) as T;
    }
    if (t == _i10.UserView) {
      return _i10.UserView.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Answer?>()) {
      return (data != null ? _i2.Answer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.Exam?>()) {
      return (data != null ? _i3.Exam.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Example?>()) {
      return (data != null ? _i4.Example.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.Question?>()) {
      return (data != null ? _i5.Question.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Registrations?>()) {
      return (data != null ? _i6.Registrations.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Result?>()) {
      return (data != null ? _i7.Result.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.ResultBatch?>()) {
      return (data != null ? _i8.ResultBatch.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.User?>()) {
      return (data != null ? _i9.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.UserView?>()) {
      return (data != null ? _i10.UserView.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<double>) {
      return (data as List).map((e) => deserialize<double>(e)).toList() as T;
    }
    if (t == List<_i5.Question>) {
      return (data as List).map((e) => deserialize<_i5.Question>(e)).toList()
          as T;
    }
    if (t == List<String?>) {
      return (data as List).map((e) => deserialize<String?>(e)).toList() as T;
    }
    if (t == List<_i7.Result>) {
      return (data as List).map((e) => deserialize<_i7.Result>(e)).toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i11.Question>) {
      return (data as List).map((e) => deserialize<_i11.Question>(e)).toList()
          as T;
    }
    if (t == List<dynamic>) {
      return (data as List).map((e) => deserialize<dynamic>(e)).toList() as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i12.Exam>) {
      return (data as List).map((e) => deserialize<_i12.Exam>(e)).toList() as T;
    }
    if (t == List<_i13.ResultBatch>) {
      return (data as List)
          .map((e) => deserialize<_i13.ResultBatch>(e))
          .toList() as T;
    }
    try {
      return _i14.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.Answer) {
      return 'Answer';
    }
    if (data is _i3.Exam) {
      return 'Exam';
    }
    if (data is _i4.Example) {
      return 'Example';
    }
    if (data is _i5.Question) {
      return 'Question';
    }
    if (data is _i6.Registrations) {
      return 'Registrations';
    }
    if (data is _i7.Result) {
      return 'Result';
    }
    if (data is _i8.ResultBatch) {
      return 'ResultBatch';
    }
    if (data is _i9.User) {
      return 'User';
    }
    if (data is _i10.UserView) {
      return 'UserView';
    }
    className = _i14.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Answer') {
      return deserialize<_i2.Answer>(data['data']);
    }
    if (dataClassName == 'Exam') {
      return deserialize<_i3.Exam>(data['data']);
    }
    if (dataClassName == 'Example') {
      return deserialize<_i4.Example>(data['data']);
    }
    if (dataClassName == 'Question') {
      return deserialize<_i5.Question>(data['data']);
    }
    if (dataClassName == 'Registrations') {
      return deserialize<_i6.Registrations>(data['data']);
    }
    if (dataClassName == 'Result') {
      return deserialize<_i7.Result>(data['data']);
    }
    if (dataClassName == 'ResultBatch') {
      return deserialize<_i8.ResultBatch>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i9.User>(data['data']);
    }
    if (dataClassName == 'UserView') {
      return deserialize<_i10.UserView>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i14.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
