import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/servicesProvider_controller.dart';

class ServiceProvidersView extends StatefulWidget {
  @override
  _ServiceProvidersViewState createState() => _ServiceProvidersViewState();
}

class _ServiceProvidersViewState extends State<ServiceProvidersView> {
  @override
  void initState() {
    super.initState();
    Provider.of<ServiceProvidersController>(context, listen: false).fetchServiceProviders();
  }

  @override
  Widget build(BuildContext context) {
    final serviceProvidersController = Provider.of<ServiceProvidersController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Prestadores de Serviço"),
      ),
      body: serviceProvidersController.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: serviceProvidersController.serviceProviders.length,
              itemBuilder: (context, index) {
                final provider = serviceProvidersController.serviceProviders[index];
                return ListTile(
                  title: Text(provider['name']),
                  subtitle: Text(provider['service']),
                  trailing: Text(provider['phone']),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addServiceProvider');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
