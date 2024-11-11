// notifications_page.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:portaria_condominio/app/controllers/notifications_controller.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final NotificationsController _notificationsController = NotificationsController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedUserId; // ID do usuário selecionado
  bool _isAdmin = false; // Flag para verificar se o usuário é admin

  @override
  void initState() {
    super.initState();
    _checkIfAdmin();
  }

  // Verifica se o usuário é administrador
  Future<void> _checkIfAdmin() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('residents').doc(currentUser.uid).get();
      setState(() {
        _isAdmin = userDoc['isAdmin'] ?? false;
      });
    }
  }

  Future<void> _showAddNotificationDialog() async {
    List<Map<String, dynamic>> users = await _notificationsController.getUsers();
    print(users); // Adicione este print para verificar se os dados dos usuários estão carregando corretamente

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Adicionar Notificação"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: "Título"),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: "Descrição"),
              ),
              DropdownButton<String>(
                value: _selectedUserId,
                hint: Text("Selecionar Usuário"),
                items: users.map((user) {
                  return DropdownMenuItem<String>(
                    value: user['id'],
                    child: Text(user['name'] ?? 'Usuário Sem Nome'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedUserId = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_selectedUserId != null) {
                  _notificationsController.addNotification(
                    _titleController.text,
                    _descriptionController.text,
                    _selectedUserId,
                    context,
                  );
                  _titleController.clear();
                  _descriptionController.clear();
                  setState(() {
                    _selectedUserId = null;
                  });
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Selecione um usuário")),
                  );
                }
              },
              child: Text("Adicionar"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text("Notificações"),
        actions: [
          if (_isAdmin) // Exibe o botão apenas para administradores
            IconButton(
              icon: Icon(Icons.add),
              onPressed: _showAddNotificationDialog,
            ),
        ],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>( 
        stream: _notificationsController.getNotifications(
          userId: currentUser?.uid,
          isAdmin: _isAdmin,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Erro ao carregar notificações"));
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
