import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({super.key});

  @override
  _QRCodeScreenState createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  String qrData = ''; // Variável para armazenar os dados do Firebase

  @override
  void initState() {
    super.initState();
    // Chama o método para obter dados do Firebase
    getDataFromFirebase();
  }

  // Método para obter dados do Firebase
  Future<void> getDataFromFirebase() async {
    try {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('qr_codes')
          .doc('exampleDocId') // Substitua pelo ID do documento desejado
          .get();
      
      // Verifica se o documento existe
      if (document.exists) {
        setState(() {
          qrData = document['data']; // A chave 'data' contém o texto para o QR Code
        });
      } else {
        if (kDebugMode) {
          print("Documento não encontrado!");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao obter dados do Firebase: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code com Imagem'),
      ),
      body: Center(
        child: qrData.isEmpty
            ? const CircularProgressIndicator() // Mostra um carregando enquanto os dados são carregados
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Exibe o QR Code com a imagem embutida
                  QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 320,
                    gapless: false,
                    embeddedImage: const AssetImage('assets/images/logo.png'),
                    embeddedImageStyle: const QrEmbeddedImageStyle(
                      size: Size(80, 80),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Texto para indicar o QR Code gerado
                  const Text(
                    'QR Code gerado com os dados do Firebase',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
      ),
    );
  }
}
