import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User?> signWithEmailAndPassword(String email, String password) async{

  }

  Future<User?> registerWithEmailAndPassword(String email, String password) async{
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
  }