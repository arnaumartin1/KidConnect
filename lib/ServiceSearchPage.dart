import 'package:flutter/material.dart';
import 'Service.dart';
import 'ServiceDetailPage.dart';

class ServiceSearchPage extends StatefulWidget {
  const ServiceSearchPage({super.key});

  @override
  State<ServiceSearchPage> createState() => _ServiceSearchPageState();
}

class _ServiceSearchPageState extends State<ServiceSearchPage> {
  String _search = '';

  // Simulación de servicios reales
  final List<Service> allServices = [
    Service(
      id: '1',
      title: 'Clases de inglés para niños',
      description: 'Aprende inglés de forma divertida',
      city: 'Madrid',
      price: 15.0,
      rating: 4.5,
    ),
    Service(
      id: '2',
      title: 'Taller de robótica',
      description: 'Robótica educativa para todas las edades',
      city: 'Barcelona',
      price: 20.0,
      rating: 4.8,
    ),
    // ...añade más servicios si quieres
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = allServices.where((service) =>
      service.title.toLowerCase().contains(_search.toLowerCase()) ||
      service.description.toLowerCase().contains(_search.toLowerCase()) ||
      service.city.toLowerCase().contains(_search.toLowerCase())
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar servicios'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF6B8C89)),
      ),
      backgroundColor: const Color(0xFFEFF3F3),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar por título, ciudad...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF6B8C89)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
              ),
              onChanged: (value) => setState(() => _search = value),
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? const Center(child: Text('No se encontraron servicios.'))
                : ListView.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final service = filtered[index];
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                                builder: (_) => ServiceDetailPage(service: service),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}