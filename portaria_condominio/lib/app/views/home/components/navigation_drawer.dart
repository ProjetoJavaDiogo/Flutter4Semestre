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
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Moradores'),
            onTap: () {
              Navigator.pushNamed(context, '/residents');
            },
          ),
          ListTile(
            leading: Icon(Icons.car_rental),
            title: Text('Veículos'),
            onTap: () {
              Navigator.pushNamed(context, '/vehicles');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Prestadores de Serviço'),
            onTap: () {
              Navigator.pushNamed(context, '/serviceProviders');
            },
          ),
          ListTile(
            leading: Icon(Icons.schedule),
            title: Text('Visitas'),
            onTap: () {
              Navigator.pushNamed(context, '/visits');
            },
          ),
          Divider(), // Adiciona uma linha separadora
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async {
              // Chama o método de logout do AuthController
              await Provider.of<AuthController>(context, listen: false).logout();
              
              // Após o logout, redireciona para a tela de login (ou onde você preferir)
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
