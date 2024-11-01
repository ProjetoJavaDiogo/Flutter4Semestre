import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ResidentsController with ChangeNotifier {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000'));
  List<Map<String, dynamic>> residents = [];
  bool isLoading = false;

  Future<void> fetchResidents() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _dio.get('/residents');
      if (response.statusCode == 200) {
        residents = List<Map<String, dynamic>>.from(response.data);
      }
    } catch (e) {
      print("Erro ao buscar moradores: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
