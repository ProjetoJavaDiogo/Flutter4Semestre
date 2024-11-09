import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portaria_condominio/app/controllers/auth_controller.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Condomínio App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Moradores'),
            onTap: () {
              Navigator.pushNamed(context, '/residents');
            },
          ),
          ListTile(
            leading: const Icon(Icons.car_rental),
            title: const Text('Veículos'),
            onTap: () {
              Navigator.pushNamed(context, '/vehicles');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Prestadores de Serviço'),
            onTap: () {
              Navigator.pushNamed(context, '/serviceProviders');
            },
          ),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text('Visitas'),
            onTap: () {
              Navigator.pushNamed(context, '/visits');
            },
          ),
          const Divider(), // Adiciona uma linha separadora
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () {
              Navigator.pushNamed(context, '/settingsView');
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () async {
              // Chama o método de logout do AuthController
              await Provider.of<AuthController>(context, listen: false)
                  .logout();

              // Após o logout, redireciona para a tela de login (ou onde você preferir)
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
