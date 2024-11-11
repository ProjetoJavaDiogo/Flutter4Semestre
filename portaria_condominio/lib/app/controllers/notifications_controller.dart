import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationsController {
  final CollectionReference notificationsCollection = FirebaseFirestore.instance.collection('notifications');
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('residents');

  // Adiciona uma notificação para um usuário específico
  Future<void> addNotification(String title, String description, String? recipientId, BuildContext context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (title.isNotEmpty && description.isNotEmpty && recipientId != null && currentUser != null) {
      try {
        await notificationsCollection.add({
          'title': title,
          'description': description,
          'recipientId': recipientId, // Inclui o ID do destinatário
          'senderId': currentUser.uid, // Inclui o ID do remetente (admin)
          'timestamp': FieldValue.serverTimestamp(),
        });
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao adicionar notificação: $error")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Todos os campos devem ser preenchidos e um usuário deve ser selecionado")),
      );
    }
  }

  // Busca a lista de usuários cadastrados
  Future<List<Map<String, dynamic>>> getUsers() async {
    try {
      final snapshot = await usersCollection.get();
      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    } catch (e) {
      print("Erro ao buscar usuários: $e");
      return [];
    }
  }

  // Stream para buscar notificações, filtradas para o usuário logado
  Stream<List<Map<String, dynamic>>> getNotifications({String? userId, bool isAdmin = false}) {
    Query query = notificationsCollection;

    // Se o usuário for admin, ele deve ver todas as notificações que ele enviou
    if (isAdmin) {
      // Filtra as notificações enviadas pelo administrador (senderId)
      query = query.where('senderId', isEqualTo: userId);
    } else {
      // Se não for admin, ele verá apenas as notificações destinadas a ele (recipientId)
      if (userId != null) {
        query = query.where('recipientId', isEqualTo: userId);
      }
    }

    // Ordena apenas pelo 'id' do documento (sem precisar de índice composto)
    query = query.orderBy('__name__');  // Ordena pelos IDs dos documentos, sem usar timestamp

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    });
  }

}
