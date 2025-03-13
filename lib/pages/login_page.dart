import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/auth_service.dart';

class LoginPage extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50, // Light purple background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 📜✅ To-Do Icon
            Icon(
              FontAwesomeIcons.listCheck, // Cool to-do list icon
              size: 80,
              color: Colors.deepPurple, 
            ),

            const SizedBox(height: 20),

            // ✨ Catchy Slogan
            Text(
              "Never Miss Your Task",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade700,
              ),
            ),

            const SizedBox(height: 40),

            // 🔹 Sign-In Button with styling
            ElevatedButton.icon(
              onPressed: () async {
                await _authService.signInWithGoogle();
              },
              icon: const FaIcon(FontAwesomeIcons.google, color: Colors.white),
              label: Text(
                "Sign in with Google",
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                backgroundColor: Colors.deepPurple.shade600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
