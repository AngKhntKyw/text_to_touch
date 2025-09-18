import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_app/features/home/pages/bottom_navigation.dart';
import 'package:test_app/features/auth/presentation/pages/login_page.dart';

class AuthGate extends StatelessWidget {
  static const routeName = "/auth-gate";
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final fireAuth = FirebaseAuth.instance;

    return fireAuth.currentUser == null
        ? const LoginPage()
        : const BottomNavigation();
  }
}
