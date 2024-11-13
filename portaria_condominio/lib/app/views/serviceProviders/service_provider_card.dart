import 'package:flutter/material.dart';

class ServiceProviderCard extends StatelessWidget {
  final dynamic provider;
  final VoidCallback onEdit;
  final VoidCallback onCall;
  final VoidCallback onMessage;
  final VoidCallback onPortaria;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const ServiceProviderCard({
    required this.provider,
    required this.onEdit,
    required this.onCall,
    required this.onMessage,
    required this.onPortaria,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4, // Sombra suave para o card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Bordas arredondadas
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ExpansionTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Informações do prestador de serviço
                Text(
                  provider['name'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  provider['service'],
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Text(
                  'Telefone: ${provider['phone']}',
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
            childrenPadding: const EdgeInsets.all(8.0),
            children: [
              const SizedBox(height: 12),
              Wrap(
                spacing: 12.0, // Espaçamento maior entre os botões
                runSpacing: 12.0, // Espaçamento entre as linhas
                children: [
                  _buildActionButton(context, Icons.edit, onEdit),
                  _buildActionButton(context, Icons.call, onCall),
                  _buildActionButton(context, Icons.message, onMessage),
                  _buildActionButton(context, Icons.home, onPortaria),
                  _buildActionButton(context, Icons.delete, onDelete),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent, // Cor do botão
        shape: CircleBorder(), // Botões arredondados
        padding: const EdgeInsets.all(16.0), // Tamanho do ícone maior
        minimumSize: const Size(50, 50), // Tamanho fixo dos botões
      ),
      child: Icon(icon, size: 24, color: Colors.white),
    );
  }
}
