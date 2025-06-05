import 'package:flutter/material.dart';
import 'Service.dart';
import 'BookingPage.dart';

class ServiceExamplesPage extends StatefulWidget {
  final String serviceType;

  const ServiceExamplesPage({super.key, required this.serviceType});

  @override
  State<ServiceExamplesPage> createState() => _ServiceExamplesPageState();
}

class _ServiceExamplesPageState extends State<ServiceExamplesPage> {
  String _search = '';

  // Set to store favorite service IDs
  final Set<String> _favoriteServiceIds = {};

  bool isFavorite(Service service) {
    return _favoriteServiceIds.contains(service.id);
  }

  void toggleFavorite(Service service) {
    if (isFavorite(service)) {
      _favoriteServiceIds.remove(service.id);
    } else {
      _favoriteServiceIds.add(service.id);
    }
  }

  // Lista de todos los servicios de ejemplo
  final List<Service> allExamples = [
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
    Service(
      id: 'pd1',
      title: 'Pediatra a domicilio',
      description: 'Visitas médicas para niños en casa.',
      city: 'Sevilla',
      price: 30.0,
      rating: 4.9,
    ),
    Service(
      id: 'pd2',
      title: 'Consulta pediátrica online',
      description: 'Consulta médica sin salir de casa.',
      city: 'Online',
      price: 20.0,
      rating: 4.7,
    ),
    Service(
      id: 'e1',
      title: 'Entrenador deportivo infantil',
      description: 'Entrenamiento físico para niños.',
      city: 'Bilbao',
      price: 18.0,
      rating: 4.6,
    ),
    Service(
      id: 'e2',
      title: 'Entrenador personal familiar',
      description: 'Rutinas para toda la familia.',
      city: 'Madrid',
      price: 22.0,
      rating: 4.8,
    ),
    // Puedes añadir más ejemplos aquí
  ];

  List<Service> getFilteredExamples() {
    List<Service> filtered = allExamples;

    // Filtra por tipo si no es "Todos" ni vacío
    if (widget.serviceType.isNotEmpty && widget.serviceType != 'Todos') {
      if (widget.serviceType == 'Niñera') {
        filtered = filtered.where((s) => s.title.toLowerCase().contains('niñera')).toList();
      } else if (widget.serviceType == 'Profesora de idiomas') {
        filtered = filtered.where((s) => s.title.toLowerCase().contains('profesora')).toList();
      } else if (widget.serviceType == 'Pediatra') {
        filtered = filtered.where((s) => s.title.toLowerCase().contains('pediatra')).toList();
      } else if (widget.serviceType == 'Entrenador deportivo') {
        filtered = filtered.where((s) => s.title.toLowerCase().contains('entrenador')).toList();
      }
    }

    // Filtra por búsqueda
    if (_search.isNotEmpty) {
      filtered = filtered.where((s) =>
        s.title.toLowerCase().contains(_search.toLowerCase()) ||
        s.description.toLowerCase().contains(_search.toLowerCase()) ||
        s.city.toLowerCase().contains(_search.toLowerCase())
      ).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final examples = getFilteredExamples();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.serviceType.isEmpty ? 'Todos los servicios' : 'Ejemplos de ${widget.serviceType}'),
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
          const Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              'Consejo: Puedes buscar por ciudad, tipo o nombre del servicio.',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
          Expanded(
            child: examples.isEmpty
                ? const Center(child: Text('No se encontraron servicios.'))
                : ListView.separated(
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
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${service.city} • ${service.price.toStringAsFixed(2)} €/h'),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.orange, size: 18),
                                  Text(
                                    service.rating.toStringAsFixed(1),
                                    style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              isFavorite(service) ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite(service) ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                toggleFavorite(service);
                              });
                            },
                          ),
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
          ),
        ],
      ),
    );
  }
}