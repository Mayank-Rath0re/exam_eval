import 'package:exam_eval_server/src/web/routes/root.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;
import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';

// This is the starting point of your Serverpod server. In most cases, you will
// only need to make additions to this file if you add future calls,  are
// configuring Relic (Serverpod's web-server), or need custom setup work.

void run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.
  var pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
    authenticationHandler: auth.authenticationHandler,
  );

  auth.AuthConfig.set(auth.AuthConfig(
      sendValidationEmail: (session, emailID, validationCode) async {
    // Send the validation email to the user.
    print(validationCode);
    // Return `true` if the email was successfully sent, otherwise `false`.
    return true;
  }, sendPasswordResetEmail: (session, userInfo, validationCode) async {
    // Send the password reset email to the user.
    print(validationCode);
    // Return `true` if the email was successfully sent, otherwise `false`.
    return true;
  }, onUserCreated: (session, userInfo) async {
    if (userInfo.id != null) {}
  }));

  // If you are using any future calls, they need to be registered here.
  // pod.registerFutureCall(ExampleFutureCall(), 'exampleFutureCall');

  // Setup a default page at the web root.
  pod.webServer.addRoute(RouteRoot(), '/');
  pod.webServer.addRoute(RouteRoot(), '/index.html');
  // Serve all files in the /static directory.
  pod.webServer.addRoute(
    RouteStaticDirectory(serverDirectory: 'static', basePath: '/'),
    '/*',
  );

  // Start the server.
  await pod.start();
}
