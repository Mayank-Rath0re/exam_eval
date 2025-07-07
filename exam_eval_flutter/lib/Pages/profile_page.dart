import 'dart:math';
import 'package:flutter/material.dart';
import 'package:exam_eval_flutter/main.dart';
import 'package:exam_eval_flutter/Components/mega_menu.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Controllers for personal info
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController institutionController = TextEditingController();

  // Controllers for password change
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String selectedTab = "personal"; // active section

  @override
  void initState() {
    super.initState();
    nameController.text = sessionManager.signedInUser?.userName ?? "User";
    emailController.text = sessionManager.signedInUser?.email ?? "email@example.com";
  }

  void _onTabChange(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/evaluate_exam');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/results');
        break;
      case 5:
        Navigator.pushReplacementNamed(context, '/settings');
        break;
      default:
        Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(height: 150),
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 380),
                  Column(
                    children: [
                      ClipOval(
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(227, 221, 211, 1),
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 12,
                                spreadRadius: 4,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Image.asset("assets/images/mayank_pfp.jpeg", fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 400),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 12,
                              spreadRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _buildProfileItem(
                              icon: Icons.person_outline,
                              title: "Personal Information",
                              onTap: () {
                                setState(() {
                                  selectedTab = "personal";
                                });
                              },
                            ),
                            const Divider(height: 1),
                            _buildProfileItem(
                              icon: Icons.lock_outline,
                              title: "Change Password",
                              onTap: () {
                                setState(() {
                                  selectedTab = "password";
                                });
                              },
                            ),
                            const Divider(height: 1),
                            _buildProfileItem(
                              icon: Icons.notifications_outlined,
                              title: "Notification Settings",
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Container(height: 350, width: 2, color: Colors.black),
                  const SizedBox(width: 20),
                  selectedTab == "personal"
                      ? Column(
                          children: [
                            _buildTextField(controller: nameController, label: 'Name'),
                            _buildTextField(controller: emailController, label: 'Email'),
                            _buildTextField(controller: passwordController, label: 'Password', obscure: true),
                            _buildTextField(controller: dobController, label: 'Date of Birth'),
                            _buildTextField(controller: genderController, label: 'Gender'),
                            _buildTextField(controller: educationController, label: 'Education'),
                            _buildTextField(controller: institutionController, label: 'Institution'),
                          ],
                        )
                      : Column(
                          children: [
                            _buildTextField(controller: currentPasswordController, label: 'Current Password', obscure: true),
                            _buildTextField(controller: newPasswordController, label: 'New Password', obscure: true),
                            _buildTextField(controller: confirmPasswordController, label: 'Confirm Password', obscure: true),
                          ],
                        ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color.fromRGBO(54, 87, 78, 1)),
      title: Text(
        title,
        style: const TextStyle(
          color: Color.fromRGBO(54, 87, 78, 1),
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color.fromRGBO(54, 87, 78, 1)),
      onTap: onTap,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: 300,
        child: TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              color: Color.fromRGBO(54, 87, 78, 1),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color.fromRGBO(54, 87, 78, 1),
              ),
            ),
            isDense: true,
          ),
        ),
      ),
    );
  }
}


