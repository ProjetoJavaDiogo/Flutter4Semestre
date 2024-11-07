import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthController with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isAdmin = false;

  User? _user;



  User? get user => _user;

  // Registro de novo morador (apenas para o administrador)
  Future<User?> registerResident(String email, String password, Map<String, dynamic> residentData) async {
    if (!isAdmin) {
      print("Apenas administradores podem registrar novos moradores.");
      return null;
    }

    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Salva dados do morador no Firestore na coleção 'residents'
      await _firestore.collection('residents').doc(userCredential.user!.uid).set({
        'email': email,
        ...residentData, // Inclui outros dados do morador (nome, apartamento, etc.)
        'isAdmin': false,  // Morador não é administrador
      });

      notifyListeners();  // Notifica widgets sobre a mudança de estado
      return userCredential.user;  // Retorna o usuário registrado
    } catch (e) {
      print("Erro ao registrar morador: $e");
      return null;  // Retorna null em caso de erro
    }
  }

  // Login do usuário e verificação de status de administrador
  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Verifica se o usuário é administrador ou morador
      final doc = await _firestore.collection('residents').doc(userCredential.user!.uid).get();
      if (doc.exists) {
        isAdmin = doc['isAdmin'] ?? false;  // Define o status de admin
      } else {
        isAdmin = false;
      }
      notifyListeners();  // Notifica widgets sobre a mudança de estado

      return userCredential.user;  // Retorna o usuário autenticado
    } catch (e) {
      print("Erro ao fazer login: $e");
      return null;  // Retorna null em caso de erro
    }
  }

  // Logout do usuário e redefinição do status de administrador
  Future<void> logout() async {
    await _firebaseAuth.signOut();
    isAdmin = false;  // Reseta o status de administrador após logout
    notifyListeners();  // Notifica widgets sobre a mudança de estado
  }

  // Verificar se o usuário está logado
  User? get currentUser => _firebaseAuth.currentUser;

  // Função para verificar status de administrador de um usuário já logado
  Future<void> checkAdminStatus() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('residents').doc(user.uid).get();
      if (doc.exists) {
        isAdmin = doc['isAdmin'] ?? false;
      }
      notifyListeners();
    }
  }
}
