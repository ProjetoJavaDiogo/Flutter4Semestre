import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/services_provider_controller.dart';

class ServiceProvidersView extends StatefulWidget {
  @override
  _ServiceProvidersViewState createState() => _ServiceProvidersViewState();
}

class _ServiceProvidersViewState extends State<ServiceProvidersView> {
  @override
  void initState() {
    super.initState();
    Provider.of<ServicesproviderController>(context, listen: false)
        .fetchServiceProviders();
  }

  @override
  Widget build(BuildContext context) {
    final serviceProvidersController =
        Provider.of<ServicesproviderController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Prestadores de Serviço"),
      ),
      body: serviceProvidersController.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: serviceProvidersController.serviceProviders.length,
              itemBuilder: (context, index) {
                final provider =
                    serviceProvidersController.serviceProviders[index];
                return ListTile(
                  title: Text(provider['name']),
                  subtitle: Text(provider['service']),
                  trailing: Text(provider['phone']),
                  onTap: () => _editServiceProvider(
                      context, provider), // Ação para editar
                  onLongPress: () => _confirmDeleteServiceProvider(
                      context, provider['id']), // Ação para excluir
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addServiceProvider');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Função para editar prestador de serviço
  void _editServiceProvider(BuildContext context, dynamic provider) {
    final TextEditingController _nameController =
        TextEditingController(text: provider['name']);
    final TextEditingController _serviceController =
        TextEditingController(text: provider['service']);
    final TextEditingController _phoneController =
        TextEditingController(text: provider['phone']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Editar Prestador de Serviço"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Nome do Prestador"),
              ),
              TextField(
                controller: _serviceController,
                decoration: const InputDecoration(labelText: "Serviço Oferecido"),
              ),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: "Telefone"),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedData = {
                  "name": _nameController.text,
                  "service": _serviceController.text,
                  "phone": _phoneController.text,
                };

                // Passa o ID do prestador de serviço para a função de atualização
                Provider.of<ServicesproviderController>(context, listen: false)
                    .updateServiceProvider(provider['id'], updatedData);

                Navigator.pop(context);
              },
              child: const Text("Salvar"),
            )
          ],
        );
      },
    );
  }

  // Função para mostrar mensagem de confirmação de exclusão
  void _confirmDeleteServiceProvider(BuildContext context, String providerId) {
    final TextEditingController _confirmationController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Excluir Prestador de Serviço"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Digite '",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: "excluir",
                      style: TextStyle(
                        color: Colors.red, // Cor para destacar
                        fontWeight: FontWeight.bold, // Negrito para destaque
                      ),
                    ),
                    TextSpan(
                      text: "' para confirmar a exclusão.",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              TextField(
                controller: _confirmationController,
                decoration: const InputDecoration(labelText: "Confirmar Exclusão"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                // Verifica se a palavra digitada é "excluir"
                if (_confirmationController.text.toLowerCase() == 'excluir') {
                  Provider.of<ServicesproviderController>(context,
                          listen: false)
                      .deleteServiceProvider(providerId);
                  Navigator.pop(context);
                } else {
                  // Exibe uma mensagem de erro caso a palavra não seja 'excluir'
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("A palavra digitada não é 'excluir'."),
                    ),
                  );
                }
              },
              child: const Text("Excluir"),
            ),
          ],
        );
      },
    );
  }
}
