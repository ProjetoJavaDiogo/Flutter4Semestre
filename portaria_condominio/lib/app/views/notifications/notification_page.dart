// notifications_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portaria_condominio/app/controllers/notifications_controller.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final NotificationsController _notificationsController = NotificationsController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _showAddNotificationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Adicionar Notificação"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Título"),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Descrição"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _notificationsController.addNotification(
                  _titleController.text,
                  _descriptionController.text,
                  context,
                );
                _titleController.clear();
                _descriptionController.clear();
                Navigator.of(context).pop();
              },
              child: const Text("Adicionar"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notificações"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddNotificationDialog,
          ),
        ],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _notificationsController.getNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Erro ao carregar notificações"));
          }
          final notifications = snapshot.data ?? [];
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return ListTile(
                title: Text(notification['title']),
                subtitle: Text(notification['description']),
                trailing: Text(notification['timestamp']?.toDate().toString() ?? ''),
              );
            },
          );
        },
      ),
    );
  }
}
