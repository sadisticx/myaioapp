import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myaioapp/homepage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'auth_gate.dart';
import 'auth_service.dart';
import 'firebase_options.dart';

import 'forgotpasswordpage.dart';
import 'registerpage.dart';
import 'loginpage.dart';
import 'welcomepage.dart';
import 'emailsentpage.dart';
import 'newdiaryentry.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthGate(),
      routes: [
        GoRoute(path: 'home', builder: (context, state) => const HomePage()),
      ],
    ),
    GoRoute(
      path: '/login_page',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register_page',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(path: '/forgot_password'),
  ],
);

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
        NewDiaryEntryPage.id: (context) => const NewDiaryEntryPage(),
      },
    );
  }
}
