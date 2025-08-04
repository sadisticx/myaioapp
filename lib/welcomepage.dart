import 'package:flutter/material.dart';
import 'registerpage.dart';
import 'loginpage.dart';
import 'forgotpasswordpage.dart';

class WelcomePage extends StatelessWidget {
  static const String id = 'WelcomePage';
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 150.0,
                backgroundColor: Colors.transparent,
                child: Image.asset('assets/logo.png'),
              ),
              const SizedBox(height: 10),
              const Text(
                'My AIO App',
                style: TextStyle(
                  fontFamily: 'ComicRelief-Bold',
                  fontSize: 55.6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'Your personal app.',
                style: TextStyle(fontSize: 22.4, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegisterPage.id);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 112,
                    vertical: 21,
                  ),
                  textStyle: const TextStyle(fontSize: 22.4),
                ),
                child: const Text('Register'),
              ),
              const SizedBox(height: 28),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginPage.id);
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.blue),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 112,
                    vertical: 21,
                  ),
                  textStyle: const TextStyle(fontSize: 22.4),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 28),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ForgotPasswordPage.id);
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.blue, fontSize: 19.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
