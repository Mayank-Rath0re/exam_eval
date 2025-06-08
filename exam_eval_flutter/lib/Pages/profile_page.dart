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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF2D5A27),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Profile",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
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
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 80,
                      color: Color(0xFF2D5A27),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Editable Name TextField
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
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
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
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
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
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
                      decoration: const InputDecoration(
                        labelText: 'Date of Birth',
                        border: OutlineInputBorder(),
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
                      decoration: const InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(),
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
                      decoration: const InputDecoration(
                        labelText: 'Education',
                        border: OutlineInputBorder(),
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
                      decoration: const InputDecoration(
                        labelText: 'Institution',
                        border: OutlineInputBorder(),
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
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
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF2D5A27)),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
