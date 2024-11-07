import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Registro de novo usuário
  Future<User?> register(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;  // Retorna o usuário registrado
    } catch (e) {
      print("Erro ao registrar usuário: $e");
      return null;  // Retorna null em caso de erro
    }
  }

  // Login do usuário
  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;  // Retorna o usuário autenticado
    } catch (e) {
      print("Erro ao fazer login: $e");
      return null;  // Retorna null em caso de erro
    }
  }

  // Logout do usuário
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  // Verificar se o usuário está logado
  User? get currentUser => _firebaseAuth.currentUser;
}
