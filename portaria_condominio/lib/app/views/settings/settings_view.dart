// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portaria_condominio/app/controllers/auth_controller.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _isDarkTheme = false;
  bool _isVisibleInSearch = true;
  bool _canSendMessage = true;
  String _language = "Português";

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Configuração de Tema
            SwitchListTile(
              title: const Text("Tema Escuro"),
              value: _isDarkTheme,
              onChanged: (value) {
                setState(() {
                  _isDarkTheme = value;
                });
                // Aqui você pode adicionar a lógica para alternar o tema da aplicação
              },
            ),

            // Configuração de Idioma
            ListTile(
              title: const Text("Idioma"),
              subtitle: Text(_language),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Abre um diálogo ou menu para escolher o idioma
                _showLanguageDialog();
              },
            ),

            // Configuração de Visibilidade
            SwitchListTile(
              title: const Text("Permitir Nome em Buscas"),
              subtitle: const Text(
                  "Mostrar seu nome na lista de contatos de outros usuarios"),
              value: _isVisibleInSearch,
              onChanged: (value) {
                setState(() {
                  _isVisibleInSearch = value;
                });
              },
            ),

            // Configuração de Permissão para Mensagens
            SwitchListTile(
              title: const Text("Permitir Recebimento de Mensagens"),
              subtitle: const Text(
                  "Permitir que outras pessoas se comuniquem com você"),
              value: _canSendMessage,
              onChanged: (value) {
                setState(() {
                  _canSendMessage = value;
                });
              },
            ),

            // Botão para Apagar Conta
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  _confirmDeleteAccount();
                },
                child: const Text("Apagar Conta"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Diálogo para escolher o idioma
  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Escolha o Idioma"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text("Português"),
                value: "Português",
                groupValue: _language,
                onChanged: (value) {
                  setState(() {
                    _language = value!;
                  });
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: const Text("Inglês"),
                value: "Inglês",
                groupValue: _language,
                onChanged: (value) {
                  setState(() {
                    _language = value!;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Confirmação para apagar a conta
  void _confirmDeleteAccount() {
    TextEditingController confirmationController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.warning, color: Colors.red),
              SizedBox(width: 10),
              Text("Apagar Conta"),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tem certeza de que deseja apagar sua conta? Esta ação é irreversível.",
                style: TextStyle(color: Colors.black87),
              ),
              const SizedBox(height: 20),
              const Text(
                'Para confirmar, digite "deletar" abaixo:',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: confirmationController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Digite "deletar"',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                "Apagar",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                if (confirmationController.text.trim().toLowerCase() ==
                    "deletar") {
                  // Chama o método de apagar conta do AuthController
                  await Provider.of<AuthController>(context, listen: false)
                      .deleteAccount();

                  // Fecha o diálogo
                  Navigator.of(context).pop();

                  // Redireciona para a tela de login
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                } else {
                  // Exibe uma mensagem de erro se a confirmação estiver incorreta
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          "Confirmação incorreta. Digite 'deletar' para continuar."),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
