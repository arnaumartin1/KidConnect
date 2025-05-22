import 'package:flutter/material.dart';

class ProfessionalProfilePage extends StatefulWidget {
  const ProfessionalProfilePage({super.key});

  @override
  State<ProfessionalProfilePage> createState() => _ProfessionalProfilePageState();
}

class _ProfessionalProfilePageState extends State<ProfessionalProfilePage> {
  final _nameController = TextEditingController(text: "Álex");
  final _ageController = TextEditingController(text: "26");
  final _cityController = TextEditingController(text: "Barcelona");
  final _descriptionController = TextEditingController(text: "Profesor de idiomas. Traducción e interpretación.");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi perfil')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_placeholder.png'), // Puedes poner una imagen genérica
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre completo'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Edad'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(labelText: 'Ciudad'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Perfil actualizado')),
                );
              },
              child: const Text('Guardar cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
