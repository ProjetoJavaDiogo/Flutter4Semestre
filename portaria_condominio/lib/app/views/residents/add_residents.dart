import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portaria_condominio/app/controllers/residents_controller.dart';

class AddResidentPage extends StatefulWidget {
  @override
  _AddResidentPageState createState() => _AddResidentPageState();
}

class _AddResidentPageState extends State<AddResidentPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _addResident() {
    final String name = _nameController.text;
    final String cpf = _cpfController.text;
    final String address = _addressController.text;
    final String phone = _phoneController.text;

    if (name.isNotEmpty && cpf.isNotEmpty && address.isNotEmpty && phone.isNotEmpty) {
      final residentData = {
        'name': name,
        'cpf': cpf,
        'address': address,
        'phone': phone,
      };

      // Adiciona o morador usando o controlador
      Provider.of<ResidentsController>(context, listen: false).addResident(residentData);
      Navigator.pop(context); // Retorna para a tela anterior após o cadastro
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Morador"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Nome"),
            ),
            TextField(
              controller: _cpfController,
              decoration: InputDecoration(labelText: "CPF"),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: "Endereço"),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Telefone"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addResident,
              child: Text("Cadastrar"),
            ),
          ],
        ),
      ),
    );
  }
}
