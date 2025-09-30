import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
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
                  context.go('/register');
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
                  context.go('/login');
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
                  context.go('/forgot-password');
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
