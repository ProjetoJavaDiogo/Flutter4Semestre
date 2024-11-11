import 'package:flutter/material.dart';

class ResidentDetailsView extends StatelessWidget {
  final Map<String, dynamic> resident;

  const ResidentDetailsView({super.key, required this.resident});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes do Morador"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nome: ${resident['name'] ?? 'Não informado'}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Apartamento: ${resident['apartment'] ?? 'Não informado'}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text("Email: ${resident['email'] ?? 'Não informado'}",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
