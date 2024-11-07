import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portaria_condominio/app/controllers/auth_controller.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        String email = _emailController.text.trim();
                        String password = _passwordController.text.trim();

                        // Exibir o estado de carregamento
                        setState(() {
                          _isLoading = true;
                        });

                        User? user = await authController.login(email, password);

                        // Retirar o estado de carregamento
                        setState(() {
                          _isLoading = false;
                        });

                        if (user != null) {
                          // Usuário autenticado com sucesso
                          Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          // Caso o login falhe
                          setState(() {
                            _errorMessage = "Login inválido. Verifique suas credenciais.";
                          });
                        }
                      },
                      child: const Text("Entrar"),
                    ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text("Ainda não tem uma conta? Registre-se"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
