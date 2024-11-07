import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceProvidersController with ChangeNotifier {
  final CollectionReference _serviceProvidersCollection =
      FirebaseFirestore.instance.collection('serviceProviders');

  List<Map<String, dynamic>> serviceProviders = [];
  bool isLoading = false;

  Future<void> fetchServiceProviders() async {
    isLoading = true;
    notifyListeners();

    try {
      final snapshot = await _serviceProvidersCollection.get();
      serviceProviders = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print("Erro ao buscar prestadores de serviço: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addServiceProvider(Map<String, dynamic> serviceProviderData) async {
    try {
      await _serviceProvidersCollection.add(serviceProviderData);
      fetchServiceProviders(); // Atualiza lista após adicionar
    } catch (e) {
      print("Erro ao adicionar prestador de serviço: $e");
    }
  }
}
