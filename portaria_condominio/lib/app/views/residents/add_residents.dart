import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/auth_controller.dart';


class RegisterResidentPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController apartmentController = TextEditingController();

  RegisterResidentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Registrar Morador")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, decoration: const InputDecoration(labelText: 'Senha')),
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Nome')),
            TextField(controller: apartmentController, decoration: const InputDecoration(labelText: 'Apartamento')),
            const SizedBox(height: 20),
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
              },
              child: const Text("Registrar Morador"),
            ),
          ],
        ),
      ),
    );
  }
}
