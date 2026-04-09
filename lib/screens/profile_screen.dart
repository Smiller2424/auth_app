import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'auth_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = AuthService();
  final newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // EMAIL
            Text(
              "Email: ${auth.currentUser?.email}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            // PASSWORD FIELD (FIXED WIDTH)
            SizedBox(
              width: 250,
              child: TextField(
                controller: newPasswordController,
                decoration: const InputDecoration(
                  labelText: "New Password",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),

            const SizedBox(height: 15),

            // CHANGE PASSWORD
            ElevatedButton(
              onPressed: () async {
                String newPassword = newPasswordController.text;

                if (newPassword.length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Password must be 6+ chars")),
                  );
                  return;
                }

                await auth.changePassword(newPassword);

                if (!context.mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Password Updated")),
                );
              },
              child: const Text("Change Password"),
            ),

            const SizedBox(height: 10),

            // LOGOUT
            ElevatedButton(
              onPressed: () async {
                await auth.signOut();

                if (!context.mounted) return;

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthScreen(),
                  ),
                );
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}