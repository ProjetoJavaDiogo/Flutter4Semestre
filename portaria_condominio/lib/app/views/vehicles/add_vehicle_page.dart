// add_vehicle_page.dart
import 'package:flutter/material.dart';
import 'package:portaria_condominio/app/controllers/vehicles_controller.dart';

class AddVehiclePage extends StatefulWidget {
  const AddVehiclePage({super.key});

  @override
  _AddVehiclePageState createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _licensePlateController = TextEditingController();

  final VehiclesController _vehiclesController = VehiclesController();

  void _addVehicle() {
    final String model = _modelController.text;
    final String brand = _brandController.text;
    final String year = _yearController.text;
    final String licensePlate = _licensePlateController.text;

    _vehiclesController.addVehicle(model, brand, year, licensePlate, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Veículo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _modelController,
              decoration: const InputDecoration(labelText: "Modelo do Veículo"),
            ),
            TextField(
              controller: _brandController,
              decoration: const InputDecoration(labelText: "Marca do Veículo"),
            ),
            TextField(
              controller: _yearController,
              decoration: const InputDecoration(labelText: "Ano do Veículo"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _licensePlateController,
              decoration: const InputDecoration(labelText: "Placa do Veículo"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addVehicle,
              child: const Text("Adicionar"),
            ),
          ],
        ),
      ),
    );
  }
}
