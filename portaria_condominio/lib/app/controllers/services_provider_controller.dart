import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServicesproviderController with ChangeNotifier {
  final CollectionReference _serviceProvidersCollection =
      FirebaseFirestore.instance.collection('serviceProviders');

  List<Map<String, dynamic>> serviceProviders = [];
  bool isLoading = false;

  // Função para buscar prestadores de serviço
  Future<void> fetchServiceProviders() async {
    isLoading = true;
    notifyListeners();

    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        final snapshot = await _serviceProvidersCollection
            .where('userId', isEqualTo: userId)
            .get();
        serviceProviders = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return {
            ...data,
            'id': doc.id, // Adiciona o ID do documento aos dados
          };
        }).toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao buscar prestadores de serviço: $e");
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Função para adicionar prestador de serviço
  Future<void> addServiceProvider(
      Map<String, dynamic> serviceProviderData) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        serviceProviderData['userId'] = userId;

        // Inicializa a lista de apartamentos liberados como vazia se não fornecido
        serviceProviderData['liberatedApartments'] =
            serviceProviderData['liberatedApartments'] ?? [];

        await _serviceProvidersCollection.add(serviceProviderData);
        fetchServiceProviders();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao adicionar prestador de serviço: $e");
      }
    }
  }

  // Função para atualizar prestador de serviço
  Future<void> updateServiceProvider(
      String id, Map<String, dynamic> updatedData) async {
    try {
      // Atualiza o campo 'liberatedApartments' para uma lista vazia se não existir
      updatedData['liberatedApartments'] =
          updatedData['liberatedApartments'] ?? [];

      await _serviceProvidersCollection.doc(id).update(updatedData);
      fetchServiceProviders();
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao atualizar prestador de serviço: $e");
      }
    }
  }

  // Função para excluir prestador de serviço
  Future<void> deleteServiceProvider(String id) async {
    try {
      await _serviceProvidersCollection.doc(id).delete();
      fetchServiceProviders();
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao excluir prestador de serviço: $e");
      }
    }
  }
}
