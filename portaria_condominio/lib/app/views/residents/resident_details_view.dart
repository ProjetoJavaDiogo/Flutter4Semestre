import 'package:flutter/material.dart';

class ResidentDetailsView extends StatelessWidget {
  final Map<String, dynamic> resident;

  ResidentDetailsView({required this.resident});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do Morador"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nome: ${resident['name']}"),
            SizedBox(height: 8),
            Text("CPF: ${resident['cpf']}"),
            SizedBox(height: 8),
            Text("Endereço: ${resident['address']}"),
            SizedBox(height: 8),
            Text("Telefone: ${resident['phone']}"),
          ],
        ),
      ),
    );
  }
}
