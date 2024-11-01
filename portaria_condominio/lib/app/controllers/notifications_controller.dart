// notifications_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationsController {
  final CollectionReference notificationsCollection = FirebaseFirestore.instance.collection('notifications');

  Future<void> addNotification(String title, String description, BuildContext context) async {
    if (title.isNotEmpty && description.isNotEmpty) {
      try {
        await notificationsCollection.add({
          'title': title,
          'description': description,
          'timestamp': FieldValue.serverTimestamp(),
        });
        Navigator.pop(context);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao adicionar notificação: $error")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Todos os campos devem ser preenchidos")),
      );
    }
  }

  Stream<List<Map<String, dynamic>>> getNotifications() {
    return notificationsCollection.orderBy('timestamp', descending: true).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    });
  }
}
