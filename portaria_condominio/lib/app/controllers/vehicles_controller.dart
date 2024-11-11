// vehicles_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VehiclesController with ChangeNotifier {
  final CollectionReference vehiclesCollection = FirebaseFirestore.instance.collection('vehicles');

  Future<void> addVehicle(String model, String brand, String year, String licensePlate, BuildContext context) async {
    if (model.isNotEmpty && brand.isNotEmpty && year.isNotEmpty && licensePlate.isNotEmpty) {
      try {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          await vehiclesCollection.add({
            'model': model,
            'brand': brand,
            'year': year,
            'licensePlate': licensePlate,
            'userId': userId, // Adiciona o ID do usuário
          });
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Erro: Usuário não autenticado")),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao adicionar veículo: $error")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Todos os campos devem ser preenchidos")),
      );
    }
  }
}
