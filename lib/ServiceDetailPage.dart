import 'package:flutter/material.dart';
import 'Service.dart';
import 'Booking.dart';
import 'ChatPage.dart';
import 'BookingPage.dart';

class ServiceDetailPage extends StatelessWidget {
  final Service service;

  const ServiceDetailPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(service.title)),
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


// Mock data for bookings
final List<Booking> mockBookings = [
  Booking(
    serviceTitle: 'Clases de inglés',
    providerName: 'Ana López',
    date: DateTime.now().subtract(const Duration(days: 2)),
    price: 15.0,
  ),
  Booking(
    serviceTitle: 'Niñera bilingüe',
    providerName: 'María García',
    date: DateTime.now().subtract(const Duration(days: 7)),
    price: 12.0,
  ),
  Booking(
    serviceTitle: 'Clases de matemáticas',
    providerName: 'Luis Fernández',
    date: DateTime.now().subtract(const Duration(days: 10)),
    price: 20.0,
  ),
  Booking(
    serviceTitle: 'Cuidado de niños',
    providerName: 'Laura Martínez',
    date: DateTime.now().subtract(const Duration(days: 15)),
    price: 40.0,
  ),
  Booking(
    serviceTitle: 'Clases de música',
    providerName: 'Carlos Sánchez',
    date: DateTime.now().subtract(const Duration(days: 20)),
    price: 50.0,
  ),
  Booking(
    serviceTitle: 'Clases de programación',
    providerName: 'María García',
    date: DateTime.now().subtract(const Duration(days: 25)),
    price: 30.0,
  ),
  Booking(
    serviceTitle: 'Cuidado de niños',
    providerName: 'Ana Pérez',
    date: DateTime.now().subtract(const Duration(days: 30)),
    price: 25.0,
  ),
];