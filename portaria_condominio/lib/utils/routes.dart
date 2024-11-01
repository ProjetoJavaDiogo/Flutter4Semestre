import 'package:flutter/material.dart';
import 'package:portaria_condominio/app/views/auth/login_view.dart';
import 'package:portaria_condominio/app/views/auth/register_view.dart';
import 'package:portaria_condominio/app/views/home/home_view.dart';
import 'package:portaria_condominio/app/views/notifications/notification_page.dart';
import 'package:portaria_condominio/app/views/residents/resident_details_view.dart';
import 'package:portaria_condominio/app/views/residents/residents_view.dart';
import 'package:portaria_condominio/app/views/vehicles/vehicles_page.dart';
import 'package:portaria_condominio/app/views/visits/visits_page.dart';
import 'package:portaria_condominio/app/views/visits/visits_view.dart';

// Definição de constantes para as rotas
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
      case vehicles:
        return MaterialPageRoute(
            builder: (_) => VehiclesPage()); // Tela de veículos
      case visits:
        return MaterialPageRoute(
            builder: (_) => AddVisitPage()); // Tela de visitas
      case visits:
        return MaterialPageRoute(builder: (_) => VisitsView());
      // No seu AppRoutes
      case notifications:
        return MaterialPageRoute(builder: (_) => NotificationsPage());
      default:
        return MaterialPageRoute(builder: (_) => LoginView());
    }
  }
}
