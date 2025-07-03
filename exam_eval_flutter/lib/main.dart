import 'package:exam_eval_client/exam_eval_client.dart';
import 'package:exam_eval_flutter/Pages/evaluation_page.dart';
import 'package:exam_eval_flutter/Pages/registerpage.dart';
import 'package:exam_eval_flutter/Pages/result_page.dart';
import 'package:exam_eval_flutter/Responsive/my_desktopscaffold.dart';
import 'package:exam_eval_flutter/Responsive/my_mobilscaffold.dart';
import 'package:exam_eval_flutter/Responsive/my_responsive_layout.dart';
import 'package:exam_eval_flutter/Responsive/my_tabletscaffold.dart';
import 'package:flutter/material.dart';

import 'package:exam_eval_flutter/Pages/profile_page.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

// Sets up a singleton client object that can be used to talk to the server from
// anywhere in our app. The client is generated from your server code.
// The client is set up to connect to a Serverpod running on a local server on
// the default port. You will need to modify this to connect to staging or
// production servers.

late SessionManager sessionManager;
late Client client;

Future<void> main() async {
  // The android emulator does not have access to the localhost of the machine.
  //const ipAddress = '10.0.2.2'; // Android emulator ip for the host
  const ipAddress = 'localhost';
  // On a real device replace the ipAddress with the IP address of your computer.
  //const ipAddress = 'localhost';
  client = Client(
    'http://$ipAddress:8080/',
    authenticationKeyManager: FlutterAuthenticationKeyManager(),
  )..connectivityMonitor = FlutterConnectivityMonitor();
  // The session manager keeps track of the signed-in state of the user. You
  // can query it to see if the user is currently signed in and get information
  // about the user.
  sessionManager = SessionManager(
    caller: client.modules.auth,
  );
  await sessionManager.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exam Evaluation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(6, 48, 43, 1),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2D5A27),
          primary: const Color(0xFF2D5A27),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF2D5A27)),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF2D5A27),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2D5A27),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      routes: {
        '/': (context) => const RegisterPage(),
        '/dashboard': (context) => ResponsiveLayout(
              mobileScaffold: const MobileScaffold(),
              tabletScffold: const TabletScaffold(),
              desktopScaffold: const DesktopScaffold(),
              //desktopScaffold: const DesktopScaffold(),
            ),
        '/evaluate_exam': (context) => const EvaluationPage(),
        '/results': (context) =>
            ResultPage(userId: sessionManager.signedInUser!.id!),
        '/profile': (context) => const ProfilePage(),
      },
      initialRoute: '/',
    );
  }
}
