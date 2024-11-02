import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VisitsView extends StatelessWidget {
  final CollectionReference visitsCollection = FirebaseFirestore.instance.collection('visits');

  VisitsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Visitas"),
        centerTitle: true,
      ),
      body: VisitsList(),
    );
  }
}

class VisitsList extends StatelessWidget {
  final CollectionReference visitsCollection = FirebaseFirestore.instance.collection('visits');

  VisitsList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: visitsCollection.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Erro ao carregar visitas"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final visits = snapshot.data?.docs ?? [];

        if (visits.isEmpty) {
          return const Center(child: Text("Nenhuma visita registrada"));
        }

        return ListView.builder(
          itemCount: visits.length,
          itemBuilder: (context, index) {
            final visit = visits[index];
            return VisitTile(
              visitData: visit,
            );
          },
        );
      },
    );
  }
}

class VisitTile extends StatelessWidget {
  final QueryDocumentSnapshot visitData;

  const VisitTile({super.key, required this.visitData});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: ListTile(
        title: Text(visitData['visitorName'] ?? 'Visitante desconhecido'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Data/Hora: ${visitData['visitDateTime'] ?? 'Não informado'}"),
            Text("Motivo: ${visitData['purpose'] ?? 'Motivo não informado'}"),
            Text("Morador: ${visitData['residentName'] ?? 'Morador não informado'}"),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
