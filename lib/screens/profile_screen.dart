import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'auth_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Show logged-in user email
            Text(
              "Email: ${auth.currentUser?.email}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            // Logout button
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

            const SizedBox(height: 10),

            // Change password button
            ElevatedButton(
              onPressed: () async {
                await auth.changePassword("newpassword123");

                if (!context.mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Password Updated")),
                );
              },
              child: const Text("Change Password"),
            ),
          ],
        ),
      ),
    );
  }
}