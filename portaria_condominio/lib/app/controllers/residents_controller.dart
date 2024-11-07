import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResidentsController with ChangeNotifier {
  final CollectionReference _residentsCollection =
      FirebaseFirestore.instance.collection('residents');
  
  List<Map<String, dynamic>> residents = [];
  bool isLoading = false;

  // Busca moradores do Firestore
  Future<void> fetchResidents() async {
    isLoading = true;
    notifyListeners();

    try {
      final snapshot = await _residentsCollection.get();
      residents = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print("Erro ao buscar moradores: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
