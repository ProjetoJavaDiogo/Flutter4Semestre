// ignore_for_file: use_build_context_synchronously

import 'package:portaria_condominio/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _service = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmedPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: const Icon(FontAwesomeIcons.envelope),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Insira um e-mail';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _emailController.text = value!;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: const Icon(FontAwesomeIcons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Insira uma senha';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _confirmedPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirmar Senha',
                    prefixIcon: const Icon(FontAwesomeIcons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Confirme a senha';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _registrarUser();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _registrarUser() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text == _confirmedPasswordController.text) {
        var user = await _service.registerUsuario(
          _emailController.text,
          _passwordController.text,
        );

        if (user != null) {
          // Exibir mensagem de sucesso no terminal
          print("Registro realizado com sucesso para o usuário: ${user.email}");
          // Mostrar mensagem de sucesso
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cadastro realizado com sucesso!'),
              duration: Duration(seconds: 2),
            ),
          );
          // Navegar para a tela de login após o cadastro
          Navigator.pushNamed(context, '/login');
        } else {
          // Exibir mensagem de erro no terminal
          print("Erro ao registrar o usuário.");
          // Mostrar mensagem de erro no app
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Erro ao realizar o cadastro. Tente novamente.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        // Limpar campos de senha e exibir mensagem de erro
        _passwordController.clear();
        _confirmedPasswordController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('As senhas não conferem!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
