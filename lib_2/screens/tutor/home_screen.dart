import 'package:flutter/material.dart';

class TutorHomeScreen extends StatelessWidget {
  const TutorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista simulada de servicios destacados
    final List<Map<String, String>> featuredServices = [
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
      appBar: AppBar(title: const Text("Inicio - Tutor")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Bienvenido, Tutor",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar servicios...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                // Lógica de búsqueda
              },
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChip(
                    label: const Text('Todos'),
                    selected: true,
                    onSelected: (_) {},
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('Clases'),
                    selected: false,
                    onSelected: (_) {},
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('Talleres'),
                    selected: false,
                    onSelected: (_) {},
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('Cuidado'),
                    selected: false,
                    onSelected: (_) {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Servicios destacados",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: featuredServices.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final service = featuredServices[index];
                  return ListTile(
                    leading: const Icon(Icons.star, color: Colors.amber),
                    title: Text(service['title']!),
                    subtitle: Text('${service['provider']} • ${service['location']}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Navegar al detalle del servicio
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}