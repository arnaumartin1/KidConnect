import 'package:flutter/material.dart';
import 'Booking.dart';

final List<Booking> mockBookings = [
  Booking(
    serviceTitle: 'Cuidado de niños',
    providerName: 'Ana Pérez',
    date: DateTime.now().subtract(const Duration(days: 2)),
    price: 25.0,
  ),
  Booking(
    serviceTitle: 'Clases de inglés',
    providerName: 'Juan López',
    date: DateTime.now().subtract(const Duration(days: 5)),
    price: 30.0,
  ),
];

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (mockBookings.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Historial')),
        body: const Center(child: Text('No tienes servicios contratados aún')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Historial de Servicios')),
      body: ListView.builder(
        itemCount: mockBookings.length,
        itemBuilder: (context, index) {
          final booking = mockBookings[index];
          return ListTile(
            title: Text(booking.serviceTitle),
            subtitle: Text('Proveedor: ${booking.providerName}\n${booking.date.toLocal().toString().split(' ')[0]}'),
            trailing: Text('${booking.price.toStringAsFixed(2)}€'),
          );
        },
      ),
    );
  }
}