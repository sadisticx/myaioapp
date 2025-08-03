import 'package:flutter/material.dart';
import 'forgotpasswordpage.dart';
import 'registerpage.dart';
import 'loginpage.dart';
import 'forgotpasswordpage.dart'; // Import the forgot password page

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
      home: const WelcomePage(),
    );
  }
}

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
              SizedBox(height: 10),
              Text(
                'My AIO App',
                style: TextStyle(
                  fontSize: 55.6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 7),
              Text(
                'Your personal app.',
                style: TextStyle(
                  fontSize: 22.4,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple[700],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 112,
                    vertical: 21,
                  ),
                  textStyle: TextStyle(fontSize: 22.4),
                ),
                child: Text('Register'),
              ),
              SizedBox(height: 28),
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
                  ),
                  textStyle: TextStyle(fontSize: 22.4),
                ),
                child: Text('Login', style: TextStyle(color: Colors.blue)),
              ),
              SizedBox(height: 28),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ForgotPasswordPage()), // Navigate to the ForgotPasswordPage
                  );
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 19.6,
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