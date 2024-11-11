// notifications_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationsController {
  final CollectionReference notificationsCollection = FirebaseFirestore.instance.collection('notifications');
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('residents');

  // Adiciona uma notificação para um usuário específico
  Future<void> addNotification(String title, String description, String? recipientId, BuildContext context) async {
    if (title.isNotEmpty && description.isNotEmpty && recipientId != null) {
      try {
        await notificationsCollection.add({
          'title': title,
          'description': description,
          'recipientId': recipientId, // Inclui o ID do destinatário
          'timestamp': FieldValue.serverTimestamp(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Notificação enviada com sucesso!")),
        );
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
          'id': doc.id, // O UID do usuário
          ...doc.data() as Map<String, dynamic>, // Adiciona os dados do usuário
        };
      }).toList();
    } catch (e) {
      print("Erro ao buscar usuários: $e");
      return [];
    }
  }

  // Stream para buscar notificações, filtradas para o usuário logado
  Stream<List<Map<String, dynamic>>> getNotifications({String? userId}) {
    Query query = notificationsCollection.orderBy('timestamp', descending: true);
    
    // Se um userId for passado, adiciona o filtro para notificações destinadas ao usuário
    if (userId != null) {
      query = query.where('recipientId', isEqualTo: userId);
    }

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
