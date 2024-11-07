import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portaria_condominio/app/controllers/residents_controller.dart';

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
                  title: Text(resident['name']),
                  subtitle: Text(resident['cpf']),
                  onTap: () {

                    // Navegar para a tela de detalhes do morador
                    Navigator.pushNamed(
                      context,
                      '/residentDetails',
                      arguments: resident,
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.pushNamed(context, '/addResident');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
