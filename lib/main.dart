import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appss/pages/login_page.dart';
import 'package:appss/pages/home_page.dart';
import 'package:appss/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Check if the user is already signed in on app launch
  User? currentUser = FirebaseAuth.instance.currentUser;
  runApp(MyApp(currentUser: currentUser));
}

class MyApp extends StatelessWidget {
  final User? currentUser;

  const MyApp({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthCheck(currentUser: currentUser), // Pass the currentUser to the AuthCheck widget
    );
  }
}

// Widget to check user authentication state
class AuthCheck extends StatelessWidget {
  final User? currentUser;

  const AuthCheck({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    // If the user is already signed in, navigate to the HomePage
    if (currentUser != null) {
      return const HomePage(); // Show home page if user is signed in
    }

    // Listen to authentication state changes and update UI accordingly
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return const HomePage(); // If user is logged in, show home page
        }
        return LoginPage(); // Otherwise, show login page
      },
    );
  }
}
