import 'package:flutter/material.dart';

class ProviderProfileScreen extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String description;
  final double rating;
  final int reviews;
  final int servicesDone;
  final int recurringClients;

  const ProviderProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.description,
    required this.rating,
    required this.reviews,
    required this.servicesDone,
    required this.recurringClients,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Perfil del Proveedor")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 48,
              backgroundImage: AssetImage('assets/images/profile_placeholder.png'), // Cambia por la imagen real
            ),
            const SizedBox(height: 16),
            Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(email, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Text(phone, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.amber[700]),
                const SizedBox(width: 4),
                Text('$rating', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                Text('($reviews valoraciones)'),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navegar a la pantalla de edición de perfil
                },
                icon: const Icon(Icons.edit),
                label: const Text("Editar perfil"),
              ),
            ),
            const SizedBox(height: 32),
            Card(
              child: ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text("Descripción"),
                subtitle: Text(description),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.bar_chart),
                title: const Text("Estadísticas"),
                subtitle: Text("Servicios realizados: $servicesDone\nClientes recurrentes: $recurringClients"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}