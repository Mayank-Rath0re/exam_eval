// ignore_for_file: camel_case_types

import 'package:exam_eval_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';

class loginpage extends StatelessWidget {
  const loginpage({super.key});

  void _navigateToDashboard(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final authController = EmailAuthController(client.modules.auth);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
        ),
        child: Row(
          children: [
            if (MediaQuery.of(context).size.width >= 500) _buildLeftPanel(),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (MediaQuery.of(context).size.width < 500)
                          const Text(
                            'Welcome to the AI based Exam\nEvaluation Software',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D5A27),
                            ),
                          ),
                        if (MediaQuery.of(context).size.width < 500)
                          const SizedBox(height: 32),
                        const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 32),
                        _buildTextField(
                            label: 'EMAIL',
                            hintText: 'Enter Your Email',
                            controller: emailController),
                        const SizedBox(height: 16),
                        _buildTextField(
                            label: 'PASSWORD',
                            hintText: '••••••••',
                            isPassword: true,
                            controller: passwordController),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () async {
                            if (emailController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              // do nothing
                            } else {
                              // Attempt sign in with the given credentials
                              var logCheck = await authController.signIn(
                                  emailController.text,
                                  passwordController.text);
                              // If attempts returns a value, then account exists
                              // redirect the user to home page
                              if (logCheck != null) {
                                // One way route to ensure user cannot come back to login page
                                // unless they log out
                                _navigateToDashboard(context);
                              } else {
                                // Need to create a better UI for this
                                showDialog(
                                    // ignore: use_build_context_synchronously
                                    context: context,
                                    builder: (context) => const AlertDialog(
                                        title: Text(
                                            "Incorrect password or e-mail")));
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2D5A27),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.black54),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Reset',
                                style: TextStyle(
                                  color: Color(0xFF2D5A27),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildLeftPanel() {
  return Expanded(
    child: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/mountains.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF2D5A27).withOpacity(0.8),
              const Color(0xFF2D5A27).withOpacity(0.6),
            ],
          ),
        ),
        child: const Center(
          child: Text(
            'Welcome to the AI based Exam\nEvaluation Software',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _buildTextField({
  required String label,
  required String hintText,
  required TextEditingController controller,
  bool isPassword = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
      ),
      const SizedBox(height: 8),
      TextField(
        obscureText: isPassword,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400]),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF2D5A27)),
          ),
        ),
      ),
    ],
  );
}
