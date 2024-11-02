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
            Text("Nome: ${resident['name']}"),
            const SizedBox(height: 8),
            Text("CPF: ${resident['cpf']}"),
            const SizedBox(height: 8),
            Text("Endereço: ${resident['address']}"),
            const SizedBox(height: 8),
            Text("Telefone: ${resident['phone']}"),
          ],
        ),
      ),
    );
  }
}
