import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portaria_condominio/app/controllers/auth_controller.dart';
import 'package:portaria_condominio/app/views/home/components/home_grid.dart';
import 'package:portaria_condominio/app/views/home/components/navigation_drawer.dart' as custom;

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Acessa o AuthController do Provider
    final authController = Provider.of<AuthController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Condomínio"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Redireciona para a página de notificações
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ],
      ),
      drawer: custom.NavigationDrawer(), // Menu lateral
      body: HomeGrid(
        resident: {
          'name': authController.name ?? 'Nome não disponível',
          'apartment': authController.apartment ?? 'Não informado',
          'email': authController.email ?? 'Não informado',
        },
      ), // Conteúdo principal
    );
  }
}
