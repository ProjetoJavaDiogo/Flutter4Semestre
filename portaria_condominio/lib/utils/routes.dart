import 'package:flutter/material.dart';
import 'package:portaria_condominio/app/views/auth/login_view.dart';
import 'package:portaria_condominio/app/views/auth/register_view.dart';
import 'package:portaria_condominio/app/views/home/home_view.dart';
import 'package:portaria_condominio/app/views/residents/resident_details_view.dart';
import 'package:portaria_condominio/app/views/residents/residents_view.dart';
// Importe outras views...

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String register = '/register';
  static const String residents = '/residents';
  static const String vehicles = '/vehicles';
  static const String visits = '/visits';
  static const String notifications = '/notifications';
  static const String serviceProviders = '/serviceProviders';
  static const String residentDetails = '/residentDetails';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case home:
        return MaterialPageRoute(builder: (_) => HomeView());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case residents:
        return MaterialPageRoute(builder: (_) => ResidentsView());
      case residentDetails:
      final resident = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (_) => ResidentDetailsView(resident: resident),
      );
      // Outras rotas...
      default:
        return MaterialPageRoute(builder: (_) => LoginView());
        
    }
  }
}
