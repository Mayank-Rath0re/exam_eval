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
import 'dart:async' as _i2;
import 'dart:typed_data' as _i3;
import 'package:exam_eval_client/src/protocol/question.dart' as _i4;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i5;
import 'protocol.dart' as _i6;

/// {@category Endpoint}
class EndpointAccount extends _i1.EndpointRef {
  EndpointAccount(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'account';

  _i2.Future<int> createAccount(
    int? id,
    String name,
    String email,
    String password,
    DateTime dob,
    String gender,
    List<String> education,
    List<String> work,
  ) =>
      caller.callServerEndpoint<int>(
        'account',
        'createAccount',
        {
          'id': id,
          'name': name,
          'email': email,
          'password': password,
          'dob': dob,
          'gender': gender,
          'education': education,
          'work': work,
        },
      );
}

/// {@category Endpoint}
class EndpointApi extends _i1.EndpointRef {
  EndpointApi(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'api';

  _i2.Future<String> generateIdealAnswer(String query) =>
      caller.callServerEndpoint<String>(
        'api',
        'generateIdealAnswer',
        {'query': query},
      );

  _i2.Future<String> uploadImage(
    _i3.ByteData imageData,
    String filename,
  ) =>
      caller.callServerEndpoint<String>(
        'api',
        'uploadImage',
        {
          'imageData': imageData,
          'filename': filename,
        },
      );

  _i2.Future<String> imageOcr(
    _i3.ByteData imageData,
    String filename,
  ) =>
      caller.callServerEndpoint<String>(
        'api',
        'imageOcr',
        {
          'imageData': imageData,
          'filename': filename,
        },
      );
}

/// {@category Endpoint}
class EndpointExam extends _i1.EndpointRef {
  EndpointExam(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'exam';

  _i2.Future<void> createExam(
    int creatorId,
    String title,
    double duration,
    int totalMarks,
    List<_i4.Question> questions,
  ) =>
      caller.callServerEndpoint<void>(
        'exam',
        'createExam',
        {
          'creatorId': creatorId,
          'title': title,
          'duration': duration,
          'totalMarks': totalMarks,
          'questions': questions,
        },
      );
}

/// {@category Endpoint}
class EndpointExample extends _i1.EndpointRef {
  EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  _i2.Future<String> hello(String name) => caller.callServerEndpoint<String>(
        'example',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    auth = _i5.Caller(client);
  }

  late final _i5.Caller auth;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i6.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    account = EndpointAccount(this);
    api = EndpointApi(this);
    exam = EndpointExam(this);
    example = EndpointExample(this);
    modules = Modules(this);
  }

  late final EndpointAccount account;

  late final EndpointApi api;

  late final EndpointExam exam;

  late final EndpointExample example;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'account': account,
        'api': api,
        'exam': exam,
        'example': example,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
