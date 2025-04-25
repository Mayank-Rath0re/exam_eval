import 'package:exam_eval_flutter/Pages/loginpage.dart';
import 'package:exam_eval_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  void _navigateToDashboard(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController verifyController = TextEditingController();
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
                          'Register',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 32),
                        _buildTextField(
                          label: 'FULL NAME',
                          hintText: 'Enter Your Full Name',
                          controller: nameController,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          label: 'EMAIL',
                          hintText: 'Enter Your Email',
                          controller: emailController,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          label: 'PASSWORD',
                          hintText: '••••••••',
                          controller: passwordController,
                          isPassword: true,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () async {
                            if (nameController.text.isNotEmpty &&
                                emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty) {
                              var check =
                                  await authController.createAccountRequest(
                                      nameController.text,
                                      emailController.text,
                                      passwordController.text);

                              if (check) {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          content: SizedBox(
                                            height: 150,
                                            width: 150,
                                            child: _buildTextField(
                                                label: "Verification Code",
                                                hintText: "code",
                                                controller: verifyController)
                                            //
                                            ,
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () async {
                                                  if (verifyController
                                                      .text.isNotEmpty) {
                                                    var check =
                                                        await authController
                                                            .validateAccount(
                                                                emailController
                                                                    .text,
                                                                verifyController
                                                                    .text);
                                                    if (check != null) {
                                                      await authController
                                                          .signIn(
                                                              emailController
                                                                  .text,
                                                              passwordController
                                                                  .text);
                                                      var createdAccount =
                                                          client.account.createAccount(
                                                              sessionManager
                                                                  .signedInUser!
                                                                  .id,
                                                              nameController
                                                                  .text,
                                                              emailController
                                                                  .text,
                                                              passwordController
                                                                  .text,
                                                              DateTime.now(),
                                                              "Male",
                                                              [],
                                                              []);
                                                      if (createdAccount ==
                                                          -1) {
                                                        showDialog(
                                                            // ignore: use_build_context_synchronously
                                                            context: context,
                                                            builder: (context) =>
                                                                const AlertDialog(
                                                                    content: Text(
                                                                        "Error Creating Account")));
                                                      } else {
                                                        _navigateToDashboard(
                                                            context);
                                                      }
                                                    }
                                                  }
                                                },
                                                child: Text("Submit"))
                                          ],
                                        ));
                              }
                            } else {
                              // Show dialog for empty fields
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
                            'Sign Up',
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
                              'Already have an account? ',
                              style: TextStyle(color: Colors.black54),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => loginpage(),
                                    ));
                              },
                              child: const Text(
                                'Sign In',
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
}
