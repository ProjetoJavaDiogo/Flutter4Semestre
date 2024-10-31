import 'package:flutter/material.dart';

class HomeGrid extends StatelessWidget {
  final List<Map<String, dynamic>> options = [
    {"icon": Icons.people, "title": "Moradores", "route": "/residents"},
    {"icon": Icons.schedule, "title": "Visitas", "route": "/visits"},
    {"icon": Icons.car_rental, "title": "Veículos", "route": "/vehicles"},
    {"icon": Icons.notification_important, "title": "Notificações", "route": "/notifications"},
    {"icon": Icons.person, "title": "Prestadores de Serviço", "route": "/serviceProviders"},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Dois ícones por linha
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: options.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, options[index]['route']);
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(options[index]["icon"], size: 50, color: Colors.blue),
                  SizedBox(height: 10),
                  Text(options[index]["title"],
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
