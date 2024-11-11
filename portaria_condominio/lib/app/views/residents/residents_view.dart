import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portaria_condominio/app/controllers/residents_controller.dart';

import 'add_residents.dart';
import 'resident_details_view.dart';

import 'add_residents.dart';
import 'resident_details_view.dart';

class ResidentsView extends StatefulWidget {
  const ResidentsView({super.key});

  @override
  _ResidentsViewState createState() => _ResidentsViewState();
}

class _ResidentsViewState extends State<ResidentsView> {
  @override
  void initState() {
    super.initState();
    Provider.of<ResidentsController>(context, listen: false).fetchResidents();
  }

  @override
  Widget build(BuildContext context) {
    final residentsController = Provider.of<ResidentsController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Moradores"),
      ),
      body: residentsController.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: residentsController.residents.length,
              itemBuilder: (context, index) {
                final resident = residentsController.residents[index];

                return ListTile(
                  title: Text(resident['name'] ?? 'Nome não disponível'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Apartamento: ${resident['apartment'] ?? 'Não informado'}'),
                      Text('Email: ${resident['email'] ?? 'Não informado'}'),
                    ],
                  ),
                  onTap: () {
                    // Navegar para a tela de detalhes do morador
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResidentDetailsView(resident: resident),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterResidentPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
