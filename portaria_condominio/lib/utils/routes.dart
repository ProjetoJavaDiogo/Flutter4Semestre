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
import '../app/views/ServiceProviders/ServiceProvider_View.dart';
import '../app/views/ServiceProviders/ServiceProvider_add.dart';

// Definição de constantes para as rotas
class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String register = '/register';
  static const String residents = '/residents';
  static const String vehicles = '/vehicles';
  static const String visitsView = '/visitsView'; // Atualize se necessário
  static const String visits = '/visits';
  static const String notifications = '/notifications';
  static const String serviceProviders = '/serviceProviders';
  static const String residentDetails = '/residentDetails';
  static const String addServiceProvider = '/addServiceProvider';


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
        return MaterialPageRoute(builder: (_) => ResidentDetailsView(resident: resident),
        );
      case vehicles:
        return MaterialPageRoute(builder: (_) => VehiclesPage()); // Tela de veículos
      case visits:
        return MaterialPageRoute(builder: (_) => AddVisitPage()); // Tela de visitas
      case visitsView:
        return MaterialPageRoute(builder: (_) => VisitsView());
      case notifications:
        return MaterialPageRoute(builder: (_) => NotificationsPage());
      case serviceProviders:
        return MaterialPageRoute(builder: (_) => ServiceProvidersView());
      case addServiceProvider:
        return MaterialPageRoute(builder: (_) => AddServiceProviderPage());
      default:
        return MaterialPageRoute(builder: (_) => LoginView());
    }
  }
}
