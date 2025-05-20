import 'package:flutter/material.dart';

class ProfessionalDashboardScreen extends StatelessWidget {
  const ProfessionalDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulación de mensajes de reservas
    final List<Map<String, String>> messages = [
      {
        'parent': 'Laura Martínez',
        'service': 'Clases de inglés para niños',
        'lastMessage': '¿Está disponible el viernes?',
        'time': '10:30',
      },
      {
        'parent': 'Carlos Pérez',
        'service': 'Taller de robótica',
        'lastMessage': '¡Gracias por la clase!',
        'time': 'Ayer',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mensajes de Reservas'),
      ),
      body: messages.isEmpty
          ? const Center(child: Text('No tienes mensajes aún.'))
          : ListView.separated(
              itemCount: messages.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final msg = messages[index];
                return ListTile(
                  leading: const Icon(Icons.message),
                  title: Text(msg['parent']!),
                  subtitle: Text('${msg['service']} • ${msg['lastMessage']}'),
                  trailing: Text(msg['time']!, style: const TextStyle(fontSize: 12)),
                  onTap: () {
                    // Navegar a la pantalla de chat con el padre/tutor
                  },
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: const Color.fromARGB(255, 34, 178, 189),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/professional_home');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/professional_profile');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Servicios'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Mensajes'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}