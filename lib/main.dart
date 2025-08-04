import 'package:flutter/material.dart';
import 'package:myaioapp/homepage.dart';
import 'forgotpasswordpage.dart';
import 'registerpage.dart';
import 'loginpage.dart';
import 'welcomepage.dart';
import 'emailsentpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomePage(),
      title: 'My AIO App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: WelcomePage.id, // Set the initial route
      routes: {
        WelcomePage.id: (context) => const WelcomePage(),
        RegisterPage.id: (context) => const RegisterPage(),
        LoginPage.id: (context) => LoginPage(),
        ForgotPasswordPage.id: (context) => const ForgotPasswordPage(),
        HomePage.id: (context) => const HomePage(),
        EmailSentPage.id: (context) => const EmailSentPage(),
      },
    );
  }
}
