import 'package:flutter/material.dart';
import 'package:exam_eval_flutter/main.dart';
import 'package:exam_eval_flutter/Components/mega_menu.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Controllers for the text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController institutionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = sessionManager.signedInUser?.userName ?? "User";
    emailController.text = sessionManager.signedInUser?.email ?? "email@example.com";
  }

  void _onTabChange(int index) {
    // Navigate to the corresponding page using named routes
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
      // Add more cases as needed
      default:
        Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.8, 0.8),
                radius: 2.3,
                colors: [
                  Color.fromRGBO(247, 245, 243, 1),
                  Color.fromRGBO(227, 221, 211, 1),
                  Color.fromRGBO(212, 199, 130, 1),
                  Color.fromRGBO(54, 87, 78, 1),
                ],
                stops: [0.0, 0.1, 0.52, 0.81],
              ),
            ),
          ),
          Column(
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                titleSpacing: 0,
                title: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        'EXAM EVAL',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const Spacer(),
                    MegaMenu(
                      onTabChange: _onTabChange,
                      isMobile: false,
                    ),
                  ],
                ),
                toolbarHeight: 70,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Your Profile",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(54, 87, 78, 1),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: Column(
                          children: [
                            Container(
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
                              child: const Icon(
                                Icons.person,
                                size: 80,
                                color: Color.fromRGBO(54, 87, 78, 1),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Editable Name TextField
                            SizedBox(
                              width: 300,
                              child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  labelText: 'Name',
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
                            const SizedBox(height: 10),
                            // Editable Email TextField
                            SizedBox(
                              width: 300,
                              child: TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: 'Email',
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
                            const SizedBox(height: 10),
                            // Editable Password TextField
                            SizedBox(
                              width: 300,
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Password',
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
                            const SizedBox(height: 10),
                            // Editable Date of Birth TextField
                            SizedBox(
                              width: 300,
                              child: TextField(
                                controller: dobController,
                                decoration: InputDecoration(
                                  labelText: 'Date of Birth',
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
                            const SizedBox(height: 10),
                            // Editable Gender TextField
                            SizedBox(
                              width: 300,
                              child: TextField(
                                controller: genderController,
                                decoration: InputDecoration(
                                  labelText: 'Gender',
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
                            const SizedBox(height: 10),
                            // Editable Education TextField
                            SizedBox(
                              width: 300,
                              child: TextField(
                                controller: educationController,
                                decoration: InputDecoration(
                                  labelText: 'Education',
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
                            const SizedBox(height: 10),
                            // Editable Institution TextField
                            SizedBox(
                              width: 300,
                              child: TextField(
                                controller: institutionController,
                                decoration: InputDecoration(
                                  labelText: 'Institution',
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
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Center(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 500),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(227, 221, 211, 1),
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
                                  // TODO: Implement personal information edit
                                },
                              ),
                              const Divider(height: 1),
                              _buildProfileItem(
                                icon: Icons.lock_outline,
                                title: "Change Password",
                                onTap: () {
                                  // TODO: Implement password change
                                },
                              ),
                              const Divider(height: 1),
                              _buildProfileItem(
                                icon: Icons.notifications_outlined,
                                title: "Notification Settings",
                                onTap: () {
                                  // TODO: Implement notification settings
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color.fromRGBO(54, 87, 78, 1),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Color.fromRGBO(54, 87, 78, 1),
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Color.fromRGBO(54, 87, 78, 1),
      ),
      onTap: onTap,
    );
  }
}
