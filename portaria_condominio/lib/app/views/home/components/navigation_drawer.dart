import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

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
        ],
      ),
    );
  }
}
