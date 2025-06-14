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
import '../endpoints/account_endpoint.dart' as _i2;
import '../endpoints/api_endpoint.dart' as _i3;
import '../endpoints/exam_endpoint.dart' as _i4;
import '../endpoints/example_endpoint.dart' as _i5;
import 'dart:typed_data' as _i6;
import 'package:exam_eval_server/src/generated/question.dart' as _i7;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i8;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'account': _i2.AccountEndpoint()
        ..initialize(
          server,
          'account',
          null,
        ),
      'api': _i3.ApiEndpoint()
        ..initialize(
          server,
          'api',
          null,
        ),
      'exam': _i4.ExamEndpoint()
        ..initialize(
          server,
          'exam',
          null,
        ),
      'example': _i5.ExampleEndpoint()
        ..initialize(
          server,
          'example',
          null,
        ),
    };
    connectors['account'] = _i1.EndpointConnector(
      name: 'account',
      endpoint: endpoints['account']!,
      methodConnectors: {
        'createAccount': _i1.MethodConnector(
          name: 'createAccount',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'dob': _i1.ParameterDescription(
              name: 'dob',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'gender': _i1.ParameterDescription(
              name: 'gender',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'education': _i1.ParameterDescription(
              name: 'education',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
            'work': _i1.ParameterDescription(
              name: 'work',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['account'] as _i2.AccountEndpoint).createAccount(
            session,
            params['id'],
            params['name'],
            params['email'],
            params['password'],
            params['dob'],
            params['gender'],
            params['education'],
            params['work'],
          ),
        )
      },
    );
    connectors['api'] = _i1.EndpointConnector(
      name: 'api',
      endpoint: endpoints['api']!,
      methodConnectors: {
        'generateIdealAnswer': _i1.MethodConnector(
          name: 'generateIdealAnswer',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['api'] as _i3.ApiEndpoint).generateIdealAnswer(
            session,
            params['query'],
          ),
        ),
        'uploadImage': _i1.MethodConnector(
          name: 'uploadImage',
          params: {
            'imageData': _i1.ParameterDescription(
              name: 'imageData',
              type: _i1.getType<_i6.ByteData>(),
              nullable: false,
            ),
            'filename': _i1.ParameterDescription(
              name: 'filename',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['api'] as _i3.ApiEndpoint).uploadImage(
            session,
            params['imageData'],
            params['filename'],
          ),
        ),
        'imageOcr': _i1.MethodConnector(
          name: 'imageOcr',
          params: {
            'imageData': _i1.ParameterDescription(
              name: 'imageData',
              type: _i1.getType<_i6.ByteData>(),
              nullable: false,
            ),
            'filename': _i1.ParameterDescription(
              name: 'filename',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['api'] as _i3.ApiEndpoint).imageOcr(
            session,
            params['imageData'],
            params['filename'],
          ),
        ),
      },
    );
    connectors['exam'] = _i1.EndpointConnector(
      name: 'exam',
      endpoint: endpoints['exam']!,
      methodConnectors: {
        'createExam': _i1.MethodConnector(
          name: 'createExam',
          params: {
            'creatorId': _i1.ParameterDescription(
              name: 'creatorId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'duration': _i1.ParameterDescription(
              name: 'duration',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'totalMarks': _i1.ParameterDescription(
              name: 'totalMarks',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'questions': _i1.ParameterDescription(
              name: 'questions',
              type: _i1.getType<List<_i7.Question>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['exam'] as _i4.ExamEndpoint).createExam(
            session,
            params['creatorId'],
            params['title'],
            params['duration'],
            params['totalMarks'],
            params['questions'],
          ),
        ),
        'editExam': _i1.MethodConnector(
          name: 'editExam',
          params: {
            'creatorId': _i1.ParameterDescription(
              name: 'creatorId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'examId': _i1.ParameterDescription(
              name: 'examId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'duration': _i1.ParameterDescription(
              name: 'duration',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'totalMarks': _i1.ParameterDescription(
              name: 'totalMarks',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'questions': _i1.ParameterDescription(
              name: 'questions',
              type: _i1.getType<List<_i7.Question>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['exam'] as _i4.ExamEndpoint).editExam(
            session,
            params['creatorId'],
            params['examId'],
            params['title'],
            params['duration'],
            params['totalMarks'],
            params['questions'],
          ),
        ),
        'deleteExam': _i1.MethodConnector(
          name: 'deleteExam',
          params: {
            'examId': _i1.ParameterDescription(
              name: 'examId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['exam'] as _i4.ExamEndpoint).deleteExam(
            session,
            params['examId'],
          ),
        ),
        'evaluateExam': _i1.MethodConnector(
          name: 'evaluateExam',
          params: {
            'examId': _i1.ParameterDescription(
              name: 'examId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'studentId': _i1.ParameterDescription(
              name: 'studentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'submittedAnswers': _i1.ParameterDescription(
              name: 'submittedAnswers',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['exam'] as _i4.ExamEndpoint).evaluateExam(
            session,
            params['examId'],
            params['studentId'],
            params['submittedAnswers'],
          ),
        ),
        'fetchUserExams': _i1.MethodConnector(
          name: 'fetchUserExams',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['exam'] as _i4.ExamEndpoint).fetchUserExams(
            session,
            params['userId'],
          ),
        ),
        'fetchExam': _i1.MethodConnector(
          name: 'fetchExam',
          params: {
            'examId': _i1.ParameterDescription(
              name: 'examId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['exam'] as _i4.ExamEndpoint).fetchExam(
            session,
            params['examId'],
          ),
        ),
      },
    );
    connectors['example'] = _i1.EndpointConnector(
      name: 'example',
      endpoint: endpoints['example']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['example'] as _i5.ExampleEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
    modules['serverpod_auth'] = _i8.Endpoints()..initializeEndpoints(server);
  }
}
