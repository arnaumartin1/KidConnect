import 'package:flutter/material.dart';

class TutorProfileScreen extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String city;

  const TutorProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Perfil del Tutor")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 48,
              backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
            ),
            const SizedBox(height: 16),
            Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(email, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Text(phone, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Text(city, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navegar a la pantalla de edición de perfil
                },
                icon: const Icon(Icons.edit),
                label: const Text("Editar perfil"),
              ),
            ),
            const SizedBox(height: 32),
            Card(
              child: ListTile(
                leading: const Icon(Icons.child_care),
                title: const Text("Hijos registrados"),
                subtitle: const Text("2 hijos: Marta (8 años), Pablo (5 años)"),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.history),
                title: const Text("Historial de servicios"),
                subtitle: const Text("Total de servicios contratados: 7"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}