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
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(8),
        child: ListTile(
          title: Text(provider['name']),
          subtitle: Text(provider['service']),
          trailing: Text(provider['phone']),
        ),
      ),
    );
  }
}
