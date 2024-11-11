import 'package:flutter/material.dart';
import 'package:portaria_condominio/app/views/entry_authorizations/qr_code_view.dart';
import '../app/views/auth/login_view.dart';
import '../app/views/home/home_view.dart';
import '../app/views/notifications/notification_page.dart';
import '../app/views/residents/resident_details_view.dart';
import '../app/views/residents/residents_view.dart';
import '../app/views/settings/settings_view.dart';
import '../app/views/vehicles/vehicles_page.dart';
import '../app/views/visits/visits_page.dart';
import '../app/views/visits/visits_view.dart';
import '../app/views/ServiceProviders/ServiceProvider_View.dart';
import '../app/views/ServiceProviders/ServiceProvider_add.dart';
import '../app/views/auth/register_view.dart';

// Definição de constantes para as rotas
class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String register = '/register';
  static const String residents = '/residents';
  static const String vehicles = '/vehicles';
  static const String visitsView = '/visitsView';
  static const String visits = '/visits';
  static const String notifications = '/notifications';
  static const String settingsView = '/settingsView';
  static const String serviceProviders = '/serviceProviders';
  static const String residentDetails = '/residentDetails';
  static const String addServiceProvider = '/addServiceProvider';
  static const String entryAuthorizations = '/qrCodeView';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case residents:
        return MaterialPageRoute(builder: (_) => const ResidentsView());
      case residentDetails:
        final resident = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ResidentDetailsView(resident: resident),
        );
      case vehicles:
        return MaterialPageRoute(
            builder: (_) => const VehiclesPage()); // Tela de veículos
      case visits:
        return MaterialPageRoute(
            builder: (_) => const AddVisitPage()); // Tela de visitas
      case visitsView:
        return MaterialPageRoute(builder: (_) => VisitsView());
      case settingsView:
        return MaterialPageRoute(builder: (_) => const SettingsView());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsPage());
      case serviceProviders:
        return MaterialPageRoute(builder: (_) => const ServiceProvidersView());
      case addServiceProvider:
        return MaterialPageRoute(builder: (_) => const AddServiceProviderPage());
      case entryAuthorizations:
        return MaterialPageRoute(builder: (_) => QrCodeView());
      default:
        return MaterialPageRoute(builder: (_) => const LoginView());
    }
  }
}
