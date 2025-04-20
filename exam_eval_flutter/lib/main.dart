import 'package:exam_eval_client/exam_eval_client.dart';
import 'package:exam_eval_flutter/Pages/registerpage.dart';
import 'package:exam_eval_flutter/Responsive/my_desktopscaffold.dart';
import 'package:exam_eval_flutter/Responsive/my_mobilscaffold.dart';
import 'package:exam_eval_flutter/Responsive/my_responsive_layout.dart';
import 'package:exam_eval_flutter/Responsive/my_tabletscaffold.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

// Sets up a singleton client object that can be used to talk to the server from
// anywhere in our app. The client is generated from your server code.
// The client is set up to connect to a Serverpod running on a local server on
// the default port. You will need to modify this to connect to staging or
// production servers.
var client = Client('http://$localhost:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

void main() {
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
        primaryColor: const Color(0xFF2D5A27),
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
        ),
      },
      initialRoute: '/',
    );
  }
}

