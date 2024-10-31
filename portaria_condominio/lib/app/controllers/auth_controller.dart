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

  Future<bool> register(String name, String email, String password) async {
    try {
      final response = await _dio.post('/auth/register', data: {
        'name': name,
        'email': email,
        'password': password,
      });

      if (response.statusCode == 201) {
        return true; // Sucesso no registro
      } else {
        return false; // Falha no registro
      }
    } catch (e) {
      print("Erro ao registrar: $e");
      return false;
    }
  }
}
