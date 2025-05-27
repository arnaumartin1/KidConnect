import 'package:flutter/material.dart';
import 'Service.dart';
import 'BookingPage.dart';

class ServiceExamplesPage extends StatelessWidget {
  final String serviceType;

  ServiceExamplesPage({super.key, required this.serviceType});

  // Ejemplos por tipo
  List<Service> getExamples() {
    switch (serviceType) {
      case 'Niñera':
        return [
          Service(
            id: 'n1',
            title: 'Niñera bilingüe',
            description: 'Cuidado de niños y ayuda con inglés.',
            city: 'Madrid',
            price: 12.0,
            rating: 4.7,
          ),
          Service(
            id: 'n2',
            title: 'Niñera con experiencia',
            description: 'Más de 5 años cuidando niños.',
            city: 'Barcelona',
            price: 10.0,
            rating: 4.5,
          ),
        ];
      case 'Profesora de idiomas':
        return [
          Service(
            id: 'p1',
            title: 'Profesora de inglés',
            description: 'Clases dinámicas para niños.',
            city: 'Madrid',
            price: 15.0,
            rating: 4.8,
          ),
          Service(
            id: 'p2',
            title: 'Profesora de francés',
            description: 'Aprende francés jugando.',
            city: 'Valencia',
            price: 14.0,
            rating: 4.6,
          ),
        ];
      // Añade más casos según tus tipos
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final examples = getExamples();
    return Scaffold(
      appBar: AppBar(
        title: Text('Ejemplos de $serviceType'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF6B8C89)),
      ),
      backgroundColor: const Color(0xFFEFF3F3),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: examples.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final service = examples[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFF6B8C89),
                child: const Icon(Icons.work, color: Colors.white),
              ),
              title: Text(
                service.title,
                style: const TextStyle(
                  color: Color(0xFF6B8C89),
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('${service.city} • ${service.price.toStringAsFixed(2)} €/h'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookingPage(service: service),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}