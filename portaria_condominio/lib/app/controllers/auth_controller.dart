import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AuthController with ChangeNotifier {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000'));

  Future<bool> login(String email, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        // Você pode salvar o token de autenticação aqui, se necessário
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Erro ao fazer login: $e");
      return false;
    }
  }
}
