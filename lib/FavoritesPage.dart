import 'package:flutter/material.dart';
import 'ServiceDetailPage.dart';
import 'Service.dart'; // Make sure this file defines the Service class



class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulando que tienes acceso a todos los servicios (puedes mejorarlo con un provider más adelante)
    final List<Service> allServices = []; // TODO: Populate this list with your Service objects
    final favoriteServices = allServices
        .where((service) => favoriteServiceIds.contains(service.id))
        .toList();

    if (favoriteServices.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Favoritos')),
        body: const Center(child: Text('Aún no has añadido favoritos')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: ListView.builder(
        itemCount: favoriteServices.length,
        itemBuilder: (context, index) {
          final service = favoriteServices[index];
          return ListTile(
            title: Text(service.title),
            subtitle: Text('${service.city} • ${service.price}€/h'),
            trailing: const Icon(Icons.favorite, color: Colors.red),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ServiceDetailPage(service: service),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
