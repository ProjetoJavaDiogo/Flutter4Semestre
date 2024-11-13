// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/services_provider_controller.dart';
import 'service_provider_card.dart';

class ServiceProvidersView extends StatefulWidget {
  @override
  _ServiceProvidersViewState createState() => _ServiceProvidersViewState();
}

class _ServiceProvidersViewState extends State<ServiceProvidersView> {
  @override
  void initState() {
    super.initState();
    // Usar addPostFrameCallback para garantir que o contexto está disponível
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Agora o contexto está seguro para ser usado
      Provider.of<ServicesproviderController>(context, listen: false)
          .fetchServiceProviders();
    });
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
                return ServiceProviderCard(
                  provider: provider,
                  onEdit: () => _editServiceProvider(context, provider),
                  onCall: () => _callProvider(provider['phone']),
                  onMessage: () => _sendMessageToProvider(provider['phone']),
                  onPortaria: () => _showPortariaDialog(provider),
                  onDelete: () =>
                      _confirmDeleteServiceProvider(context, provider['id']),
                  onTap: () => _showActionButtons(context, provider),
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

  void _showPortariaDialog(dynamic provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Escolha a Ação de Portaria'),
          content: const Text(
              'Selecione se o prestador de serviço terá a entrada liberada ou bloqueada.'),
          actions: [
            TextButton(
              onPressed: () {
                _updatePortariaStatus(provider, 'Liberado');
                Navigator.pop(context);
              },
              child: const Text('Liberado'),
            ),
            TextButton(
              onPressed: () {
                _updatePortariaStatus(provider, 'Bloqueado');
                Navigator.pop(context);
              },
              child: const Text('Bloqueado'),
            ),
          ],
        );
      },
    );
  }

  void _updatePortariaStatus(dynamic provider, String status) {
    // Lógica para atualizar o status do prestador de serviço (liberado ou bloqueado)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              "Status de portaria de ${provider['name']} atualizado para $status")),
    );
    // Aqui você pode chamar a lógica do backend para salvar a alteração no banco de dados
  }

  void _showActionButtons(BuildContext context, dynamic provider) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                spacing: 8.0, // Espaçamento entre os botões
                runSpacing: 8.0, // Espaçamento entre as linhas
                children: [
                  _buildActionButton(
                    context,
                    icon: Icons.edit,
                    label: "Editar",
                    onPressed: () => _editServiceProvider(context, provider),
                  ),
                  _buildActionButton(
                    context,
                    icon: Icons.call,
                    label: "Ligar",
                    onPressed: () => _callProvider(provider['phone']),
                  ),
                  _buildActionButton(
                    context,
                    icon: Icons.message,
                    label: "Mensagem",
                    onPressed: () => _sendMessageToProvider(provider['phone']),
                  ),
                  _buildActionButton(
                    context,
                    icon: Icons.home,
                    label: "Portaria",
                    onPressed: () => _showPortariaDialog(provider),
                  ),
                  _buildActionButton(
                    context,
                    icon: Icons.delete,
                    label: "Excluir",
                    onPressed: () =>
                        _confirmDeleteServiceProvider(context, provider['id']),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      label: Text(label),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ),
    );
  }

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
                decoration:
                    const InputDecoration(labelText: "Nome do Prestador"),
              ),
              TextField(
                controller: _serviceController,
                decoration:
                    const InputDecoration(labelText: "Serviço Oferecido"),
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

                Provider.of<ServicesproviderController>(context, listen: false)
                    .updateServiceProvider(provider['id'], updatedData);

                Navigator.pop(context);
              },
              child: const Text("Salvar"),
            ),
          ],
        );
      },
    );
  }

  void _callProvider(String phone) async {
    final Uri phoneUrl = Uri(scheme: 'tel', path: phone);

    try {
      final bool launched = await launchUrl(phoneUrl);
      if (!launched) {
        throw 'Não foi possível realizar a ligação';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void _sendMessageToProvider(String phone) async {
    final Uri smsUrl = Uri(scheme: 'sms', path: phone);

    if (await canLaunchUrl(smsUrl)) {
      await launchUrl(smsUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Não foi possível abrir o aplicativo de mensagens.")),
      );
    }
  }

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
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
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
                decoration:
                    const InputDecoration(labelText: "Confirmar Exclusão"),
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
                if (_confirmationController.text.toLowerCase() == 'excluir') {
                  Provider.of<ServicesproviderController>(context,
                          listen: false)
                      .deleteServiceProvider(providerId);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Texto de confirmação errado")),
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
