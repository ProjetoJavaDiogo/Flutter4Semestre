import 'package:flutter/material.dart';
import 'package:portaria_condominio/app/views/home/components/home_grid.dart';
import 'package:portaria_condominio/app/views/home/components/navigation_drawer.dart' as custom;


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Condomínio"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Redireciona para a página de notificações
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ],
      ),
      drawer: const custom.NavigationDrawer(), // Menu lateral
      body: HomeGrid(), // Conteúdo principal
    );
  }
}
