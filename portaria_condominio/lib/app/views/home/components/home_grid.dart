import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portaria_condominio/app/controllers/auth_controller.dart';

class HomeGrid extends StatelessWidget {
  final List<Map<String, dynamic>> options = [
    {"icon": Icons.people, "title": "Moradores", "route": "/residents"},
    {"icon": Icons.schedule, "title": "Visitas", "route": "/visitsView"}, // Mude para /visitsView
    {"icon": Icons.car_rental, "title": "Veículos", "route": "/vehicles"},
    {"icon": Icons.notification_important, "title": "Notificações", "route": "/notifications"},
    {"icon": Icons.person, "title": "Prestadores de Serviço", "route": "/serviceProviders"},
  ];

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    // Filtra a lista de opções para mostrar "Moradores" apenas se o usuário for admin
    final filteredOptions = authController.isAdmin
        ? options
        : options.where((option) => option['title'] != 'Moradores').toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Dois ícones por linha
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: filteredOptions.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, filteredOptions[index]['route']);
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(filteredOptions[index]["icon"], size: 50, color: Colors.blue),
                  SizedBox(height: 10),
                  Text(filteredOptions[index]["title"],
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
