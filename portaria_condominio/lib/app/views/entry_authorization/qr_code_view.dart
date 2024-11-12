// ignore_for_file: use_key_in_widget_constructors
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
class QrCodeView extends StatelessWidget {
  final String codigoAcesso = "ABCD1234"; // Este valor seria dinâmico e vindo do Firebase
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code de Acesso'),
      ),
      body: Center(
        child: QrImageView(
          data: codigoAcesso, // O código gerado para o visitante
          version: QrVersions.auto,
          size: 320,
          gapless: false,
          embeddedImage: const AssetImage('assets/images/logo_condominio.png'), // Logo ou imagem do condomínio
          embeddedImageStyle: const QrEmbeddedImageStyle(
            size: Size(80, 80),
          ),
        ),
      ),
    );
  }
}