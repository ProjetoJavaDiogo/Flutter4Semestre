import 'package:flutter/material.dart';
import 'package:portaria_condominio/app/views/auth/login_view.dart';
import 'package:portaria_condominio/app/views/auth/register_view.dart';
import 'package:portaria_condominio/app/views/home/home_view.dart';
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

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case home:
        return MaterialPageRoute(builder: (_) => HomeView());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterView());
      // Outras rotas...
      default:
        return MaterialPageRoute(builder: (_) => LoginView());
        
    }
  }
}
