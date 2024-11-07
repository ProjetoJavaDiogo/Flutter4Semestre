import 'package:flutter/material.dart';

class HomeGrid extends StatelessWidget {
<<<<<<< Tabnine <<<<<<<
  final List<Map<String, dynamic>> options = [//-
    {"icon": Icons.people, "title": "Moradores", "route": "/residents"},//-
    {"icon": Icons.schedule, "title": "Visitas", "route": "/visits"},//-
    {"icon": Icons.car_rental, "title": "Veículos", "route": "/vehicles"},//-
    {"icon": Icons.notification_important, "title": "Notificações", "route": "/notifications"},//-
    {"icon": Icons.person, "title": "Prestadores de Serviço", "route": "/serviceProviders"},//-
  ];//-
  class HomeGrid extends StatelessWidget {//+
    final List<Map<String, dynamic>> options = const [//+
      {"icon": Icons.people, "title": "Moradores", "route": "/residents"},//+
      {"icon": Icons.schedule, "title": "Visitas", "route": "/visits"},//+
      {"icon": Icons.car_rental, "title": "Veículos", "route": "/vehicles"},//+
      {"icon": Icons.notification_important, "title": "Notificações", "route": "/notifications"},//+
      {"icon": Icons.person, "title": "Prestadores de Serviço", "route": "/serviceProviders"},//+
    ];//+
//+
    const HomeGrid({super.key});//+
//+
    // ... the rest of the component//+
  }//+
>>>>>>> Tabnine >>>>>>>// {"conversationId":"d85570d5-0fe3-4536-98ca-428a888440db","source":"instruct"}

  const HomeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                  const SizedBox(height: 10),
                  Text(options[index]["title"],
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
