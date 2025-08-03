import 'package:flutter/material.dart';
import 'loginpage.dart';

class EmailSentPage extends StatelessWidget {
  const EmailSentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100), // Push content down from top
              Container(
                padding: const EdgeInsets.all(24),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: const [
                    Icon(Icons.check_circle, size: 48, color: Colors.teal),
                    SizedBox(height: 16),
                    Text(
                      'Email Sent!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "We've sent a password reset link to your email address. Please check your inbox and follow the instructions to reset your password.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.arrow_back, color: Colors.deepPurple),
                    SizedBox(width: 6),
                    Text(
                      'Back to Login',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
