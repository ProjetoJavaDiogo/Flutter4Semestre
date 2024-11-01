import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Registro de novo usuário
  Future<bool> register(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      print("Erro ao registrar usuário: $e");
      return false;
    }
  }

  // Login do usuário
  Future<bool> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      print("Erro ao fazer login: $e");
      return false;
    }
  }

  // Logout do usuário
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  // Verificar se o usuário está logado
  User? get currentUser => _firebaseAuth.currentUser;
}
