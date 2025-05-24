import 'package:flutter/material.dart';

class ProfessionalProfilePage extends StatelessWidget {
  final Map<String, String> userInfo;
  final List<Map<String, String>> services;

  const ProfessionalProfilePage({
    super.key,
    required this.userInfo,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi Perfil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 40,
                child: Icon(Icons.person, size: 50),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nombre completo',
                border: OutlineInputBorder(),
              ),
              initialValue: '${userInfo['name'] ?? ''} ${userInfo['surname'] ?? ''}',
              readOnly: true,
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
              initialValue: userInfo['email'] ?? '',
              readOnly: true,
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Ciudad',
                border: OutlineInputBorder(),
              ),
              initialValue: userInfo['city'] ?? 'Ciudad no definida',
            ),
            const SizedBox(height: 30),
            const Text(
              'Mis Servicios',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            services.isEmpty
                ? const Text('Aún no tienes servicios registrados.')
                : Column(
                    children: services.map((service) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(service['title'] ?? ''),
                          subtitle: Text(
                            '${service['description'] ?? ''} • ${service['price'] ?? ''}',
                          ),
                        ),
                      );
                    }).toList(),
                  ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Perfil actualizado')),
                  );
                },
                child: const Text('Guardar cambios'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Perfil está seleccionado
        selectedItemColor: const Color.fromARGB(255, 34, 178, 189),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/professional_home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/professional_messages');
          } else if (index == 2) {
            // Ya estás en la página de perfil profesional
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
