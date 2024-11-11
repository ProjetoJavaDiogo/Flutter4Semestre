// visits_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VisitsController with ChangeNotifier {
  final CollectionReference visitsCollection = FirebaseFirestore.instance.collection('visits');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addVisit(String visitorName, String visitDate, String purpose, BuildContext context) async {
    final User? user = _auth.currentUser;
    if (user != null && visitorName.isNotEmpty && visitDate.isNotEmpty && purpose.isNotEmpty) {
      try {
        await visitsCollection.add({
          'visitorName': visitorName,
          'visitDate': visitDate,
          'purpose': purpose,
          'userId': user.uid, // Armazena o uid do usuário
        });
        Navigator.pop(context);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao adicionar visita: $error")),
        );
      }
    }
  }
}