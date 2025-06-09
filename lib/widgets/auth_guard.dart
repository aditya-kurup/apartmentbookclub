import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../screens/login_screen.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;

  const AuthGuard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService.authStateChanges,
      builder: (context, snapshot) {
        // Show loading while checking auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // If user is signed in, show the protected content
        if (AuthService.isSignedIn) {
          return child;
        }

        // If not signed in, show login screen
        return const LoginScreen();
      },
    );
  }
}

class PublicRoute extends StatelessWidget {
  final Widget child;

  const PublicRoute({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Public routes don't need authentication
    return child;
  }
}
