import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AuthController with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isAdmin = false;

  String? name;
  String? apartment;
  String? email;


  // Registro de novo morador (apenas para o administrador)
  Future<User?> registerResident(String email, String password, Map<String, dynamic> residentData) async {
    if (!isAdmin) {
      if (kDebugMode) {
        print("Apenas administradores podem registrar novos moradores.");
      }
      return null;
    }

    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Salva dados do morador no Firestore na coleção 'residents'
      await _firestore
          .collection('residents')
          .doc(userCredential.user!.uid)
          .set({
        'email': email,
        ...residentData, // Inclui outros dados do morador (nome, apartamento, etc.)
        'isAdmin': false, // Morador não é administrador
      });

      notifyListeners(); // Notifica widgets sobre a mudança de estado
      return userCredential.user; // Retorna o usuário registrado
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao registrar morador: $e");
      }
      return null; // Retorna null em caso de erro
    }
  }

  // Método para apagar a própria conta
  Future<void> deleteAccount() async {
    try {
      User? currentUser = _firebaseAuth.currentUser;

      if (currentUser != null) {
        // Apagar dados do usuário no Firestore
        await _firestore.collection('residents').doc(currentUser.uid).delete();

        // Apagar usuário do Firebase Authentication
        await currentUser.delete();

        // Redefine o status de administrador e notifica o estado
        isAdmin = false;
        notifyListeners();
      }
    } catch (e) {
      print("Erro ao apagar a conta: $e");
      // Exibir uma mensagem apropriada em caso de erro (ex: se o usuário precisar fazer login novamente)
    }
  }

  // Login do usuário e verificação de status de administrador
  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Verifica se o usuário é administrador ou morador e carrega dados adicionais
      final doc = await _firestore.collection('residents').doc(userCredential.user!.uid).get();
      if (doc.exists) {
        isAdmin = doc['isAdmin'] ?? false;  // Define o status de admin
        name = doc['name'] ?? 'Nome não disponível';
        this.apartment = doc['apartment'] ?? 'Apartamento não disponível';
        this.email = doc['email'] ?? 'Email não disponível';
      } else {
        isAdmin = false;
        this.name = null;
        this.apartment = null;
        this.email = null;
      }
      
      notifyListeners();  // Notifica widgets sobre a mudança de estado
      return userCredential.user;  // Retorna o usuário autenticado
    } catch (e) {
      print("Erro ao fazer login: $e");
      return null; // Retorna null em caso de erro
    }
  }

  // Logout do usuário e redefinição do status de administrador e redefinição do status de administrador
  Future<void> logout() async {
    await _firebaseAuth.signOut();
    isAdmin = false;  // Reseta o status de administrador após logout
    notifyListeners();  // Notifica widgets sobre a mudança de estado
  }

  // Função para verificar status de administrador de um usuário já logado
  Future<void> checkAdminStatus() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('residents').doc(user.uid).get();
      if (doc.exists) {
        isAdmin = doc['isAdmin'] ?? false;
        name = doc['name'] ?? 'Nome não disponível';
        apartment = doc['apartment'] ?? 'Apartamento não disponível';
        email = doc['email'] ?? 'Email não disponível';
      }
      notifyListeners();
    }
  }
}