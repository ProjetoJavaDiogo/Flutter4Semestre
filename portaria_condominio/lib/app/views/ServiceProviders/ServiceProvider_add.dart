import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/ServicesProvider_controller.dart';

class AddServiceProviderPage extends StatefulWidget {
  const AddServiceProviderPage({super.key});

  @override
  _AddServiceProviderPageState createState() => _AddServiceProviderPageState();
}

class _AddServiceProviderPageState extends State<AddServiceProviderPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _serviceController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _addServiceProvider() {
    final String name = _nameController.text;
    final String service = _serviceController.text;
    final String phone = _phoneController.text;

    final providerData = {
      "name": name,
      "service": service,
      "phone": phone,
    };

    Provider.of<ServiceProvidersController>(context, listen: false).addServiceProvider(providerData);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Prestador de Serviço"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addServiceProvider,
              child: const Text("Cadastrar"),
            ),
          ],
        ),
      ),
    );
  }
}
