// visits_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VisitsController with ChangeNotifier{
  final CollectionReference visitsCollection = FirebaseFirestore.instance.collection('visits');

  Future<void> addVisit(String visitorName, String visitDate, String purpose, BuildContext context) async {
    if (visitorName.isNotEmpty && visitDate.isNotEmpty && purpose.isNotEmpty) {
      try {
        await visitsCollection.add({
          'visitorName': visitorName,
          'visitDate': visitDate,
          'purpose': purpose,
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
