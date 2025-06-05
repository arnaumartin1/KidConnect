import 'package:flutter/material.dart';
import 'Service.dart';
import 'BookingPage.dart';
import 'ChatPage.dart';

// Simulación de favoritos global
List<String> favoriteServiceIds = [];

class ServiceDetailPage extends StatefulWidget {
  final Service service;

  const ServiceDetailPage({super.key, required this.service});

  @override
  State<ServiceDetailPage> createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = favoriteServiceIds.contains(widget.service.id);
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      if (isFavorite) {
        favoriteServiceIds.add(widget.service.id);
      } else {
        favoriteServiceIds.remove(widget.service.id);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite
              ? 'Añadido a favoritos'
              : 'Eliminado de favoritos',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final service = widget.service;

    return Scaffold(
      appBar: AppBar(
        title: Text(service.title),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(service.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            Text('Ciudad: ${service.city}'),
            Text('Precio: ${service.price.toStringAsFixed(2)}€/hora'),
            Text('Valoración: ⭐ ${service.rating}'),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookingPage(service: service),
                  ),
                );
              },
              child: const Text('Reservar'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatPage(
                      serviceId: service.id,
                      serviceTitle: service.title,
                    ),
                  ),
                );
              },
              child: const Text('Enviar mensaje'),
            ),
          ],
        ),
      ),
    );
  }
}
