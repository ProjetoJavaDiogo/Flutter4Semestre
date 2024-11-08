import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/residents_controller.dart';


class RegisterResidentPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController apartmentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Registrar Morador")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Senha')),
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Nome')),
            TextField(controller: apartmentController, decoration: InputDecoration(labelText: 'Apartamento')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final email = emailController.text.trim();
                final password = passwordController.text.trim();
                final name = nameController.text.trim();
                final apartment = apartmentController.text.trim();

                await authController.registerResident(email, password, {
                  'name': name,
                  'apartment': apartment,
                });


                // Limpa os campos após o registro
                emailController.clear();
                passwordController.clear();
                nameController.clear();
                apartmentController.clear();

                await Provider.of<ResidentsController>(context, listen: false).fetchResidents();

                Navigator.pushReplacementNamed(context, '/residents');
              },
              child: Text("Registrar Morador"),
            ),
          ],
        ),
      ),
    );
  }
}
