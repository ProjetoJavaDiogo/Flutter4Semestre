import 'package:flutter/material.dart';
import 'package:portaria_condominio/app/views/home/components/home_grid.dart';
import 'package:portaria_condominio/app/views/home/components/navigation_drawer.dart' as custom;


class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: HomeGrid(), // Conteúdo principal
    );
  }
}
