import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista simulada de servicios favoritos
    final List<Map<String, String>> favorites = [
      {
        'title': 'Clases de pintura para niños',
        'provider': 'Ana Martínez',
        'location': 'Barcelona',
      },
      {
        'title': 'Taller de robótica',
        'provider': 'Robokids',
        'location': 'Madrid',
      },
      {
        'title': 'Cuidado infantil a domicilio',
        'provider': 'María López',
        'location': 'Valencia',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Favoritos")),
      body: favorites.isEmpty
          ? const Center(child: Text("No tienes servicios favoritos aún."))
          : ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: favorites.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final fav = favorites[index];
                return ListTile(
                  leading: const Icon(Icons.favorite, color: Colors.red),
                  title: Text(fav['title']!),
                  subtitle: Text('${fav['provider']} • ${fav['location']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.grey),
                    onPressed: () {
                      // Aquí iría la lógica para eliminar de favoritos
                    },
                  ),
                  onTap: () {
                    // Navegar al detalle del servicio
                  },
                );
              },
            ),
    );
  }
}