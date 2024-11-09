import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  // Atributo
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Método login usuario
  Future<User?> loginUsuario(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  // Método registrar usuario
  Future<void> registerUsuario(String email, String password) async {
    try {
        await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // Verifique o código de erro e trate-o adequadamente
      switch (e.code) {
        case 'email-already-in-use':
          if (kDebugMode) {
            print('O email já está em uso.');
          }
          break;
        case 'weak-password':
          if (kDebugMode) {
            print('Senha fraca. Use uma senha mais forte.');
          }
          break;
        default:
          if (kDebugMode) {
            print('Erro desconhecido: $e.code');
          }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro desconhecido: $e');
      }
    }
  }

  // Método logout usuario
  Future<void> logoutUsuario() async {
    try {
      await _auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
