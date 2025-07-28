import 'package:flutter/material.dart';
import 'registerpage.dart';
import 'loginpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My AIO App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const WelcomePage(), // Set LoginPage as home
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key}); // Add constructor for consistency

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
              // Logo Section
              CircleAvatar(
                radius: 150.0, // 60 * 1.7
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  'assets/logo.png',
                ), // Replace with your logo path
              ),
              SizedBox(height: 10), // 20 * 1.4
              // App Title
              Text(
                'My AIO App',
                style: TextStyle(
                  fontSize: 55.6, // 32 * 1.4
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 7), // 10 * 1.4
              // Subtext
              Text(
                'Your personal app.',
                style: TextStyle(
                  fontSize: 22.4, // 16 * 1.4
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 30), // 40 * 1.4
              // Register Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ), // Navigate to RegisterPage
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple[700],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 112,
                    vertical: 21,
                  ), // 80 * 1.4 and 15 * 1.4
                  textStyle: TextStyle(fontSize: 22.4), // 16 * 1.4
                ),
                child: Text('Register'),
              ),
              SizedBox(height: 28), // 20 * 1.4
              // Login Button
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.blue),
                  padding: EdgeInsets.symmetric(
                    horizontal: 112,
                    vertical: 21,
                  ), // 80 * 1.4 and 15 * 1.4
                  textStyle: TextStyle(fontSize: 22.4), // 16 * 1.4
                ),
                child: Text('Login', style: TextStyle(color: Colors.blue)),
              ),
              SizedBox(height: 28), // 20 * 1.4
              // Forgot Password Text
              GestureDetector(
                onTap: () {
                  // Handle forgot password
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 19.6, // 14 * 1.4
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
