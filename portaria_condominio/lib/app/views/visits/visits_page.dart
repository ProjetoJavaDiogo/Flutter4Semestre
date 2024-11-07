import 'package:flutter/material.dart';
import 'package:portaria_condominio/app/controllers/visits_controller.dart';

class AddVisitPage extends StatefulWidget {
  @override
  _AddVisitPageState createState() => _AddVisitPageState();
}

class _AddVisitPageState extends State<AddVisitPage> {
  final TextEditingController _visitorNameController = TextEditingController();

  final TextEditingController _visitDateController = TextEditingController();

  final TextEditingController _purposeController = TextEditingController();

  final VisitsController _visitsController = VisitsController();

  void _addVisit() {
    final String visitorName = _visitorNameController.text;
    final String purpose = _purposeController.text;
    final String visitDate = DateTime.now().toString(); // Data e hora atuais


    _visitsController.addVisit(visitorName, visitDate, purpose, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Visita"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _visitorNameController,
              decoration: InputDecoration(labelText: "Nome do Visitante"),
            ),
            TextField(

              controller: _visitDateController,
              decoration: InputDecoration(labelText: "Data da Visita (YYYY-MM-DD)"),
            ),
            TextField(

              controller: _purposeController,
              decoration: InputDecoration(labelText: "Motivo da Visita"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addVisit,
              child: Text("Adicionar"),
            ),
          ],
        ),
      ),
    );
  }
}
