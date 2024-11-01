import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_vehicle_page.dart'; // Página para adicionar novo veículo

class VehiclesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Veículos"),
        centerTitle: true,
      ),
      body: VehiclesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddVehiclePage()),
          );
        },
        child: Icon(Icons.add),
        tooltip: "Adicionar novo veículo",
      ),
    );
  }
}

class VehiclesList extends StatelessWidget {
  final CollectionReference vehiclesCollection = FirebaseFirestore.instance.collection('vehicles');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: vehiclesCollection.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Erro ao carregar veículos"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final vehicles = snapshot.data?.docs ?? [];

        return ListView.builder(
          itemCount: vehicles.length,
          itemBuilder: (context, index) {
            final vehicle = vehicles[index];
            return VehicleTile(
              vehicleData: vehicle,
            );
          },
        );
      },
    );
  }
}

class VehicleTile extends StatelessWidget {
  final QueryDocumentSnapshot vehicleData;

  VehicleTile({required this.vehicleData});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: ListTile(
        title: Text(vehicleData['model'] ?? 'Modelo desconhecido'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Marca: ${vehicleData['brand'] ?? 'Marca não informada'}"),
            Text("Ano: ${vehicleData['year'] ?? 'Ano não informado'}"),
            Text("Placa: ${vehicleData['licensePlate'] ?? 'Placa não informada'}"),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
