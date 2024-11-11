import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:portaria_condominio/app/controllers/vehicles_controller.dart';
import 'package:portaria_condominio/app/controllers/visits_controller.dart';
import 'package:provider/provider.dart';
import 'package:portaria_condominio/app/controllers/auth_controller.dart';
import 'package:portaria_condominio/app/controllers/residents_controller.dart';
import 'package:portaria_condominio/utils/routes.dart';

import 'app/controllers/ServicesProvider_controller.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ServiceProvidersController()),
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => ResidentsController()),
        ChangeNotifierProvider(create: (_) => VisitsController()), // Controller de visitas
        ChangeNotifierProvider(create: (_) => VehiclesController()), // Controller de veículos
      ],
      child: MaterialApp(
        title: 'Condomínio App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: AppRoutes.login,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
