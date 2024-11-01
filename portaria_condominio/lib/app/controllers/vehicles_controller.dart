// vehicles_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VehiclesController with ChangeNotifier{
  final CollectionReference vehiclesCollection = FirebaseFirestore.instance.collection('vehicles');

  Future<void> addVehicle(String model, String brand, String year, String licensePlate, BuildContext context) async {
    if (model.isNotEmpty && brand.isNotEmpty && year.isNotEmpty && licensePlate.isNotEmpty) {
      try {
        await vehiclesCollection.add({
          'model': model,
          'brand': brand,
          'year': year,
          'licensePlate': licensePlate,
        });
        Navigator.pop(context);
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
