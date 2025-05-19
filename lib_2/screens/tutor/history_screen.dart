import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista simulada de historial de reservas
    final List<Map<String, String>> history = [
      {
        'service': 'Clases de pintura para niños',
        'provider': 'Ana Martínez',
        'date': '12/05/2025',
        'status': 'Completado',
      },
      {
        'service': 'Taller de robótica',
        'provider': 'Robokids',
        'date': '08/05/2025',
        'status': 'Completado',
      },
      {
        'service': 'Cuidado infantil a domicilio',
        'provider': 'María López',
        'date': '01/05/2025',
        'status': 'Cancelado',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Historial")),
      body: history.isEmpty
          ? const Center(child: Text("No tienes reservas aún."))
          : ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: history.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final item = history[index];
                return ListTile(
                  leading: Icon(
                    item['status'] == 'Completado'
                        ? Icons.check_circle
                        : Icons.cancel,
                    color: item['status'] == 'Completado'
                        ? Colors.green
                        : Colors.red,
                  ),
                  title: Text(item['service']!),
                  subtitle: Text(
                      '${item['provider']} • ${item['date']} • ${item['status']}'),
                  trailing: item['status'] == 'Completado'
                      ? TextButton(
                          onPressed: () {
                            // Lógica para valorar el servicio
                          },
                          child: const Text('Valorar'),
                        )
                      : null,
                  onTap: () {
                    // Navegar al detalle de la reserva
                  },
                );
              },
            ),
    );
  }
}