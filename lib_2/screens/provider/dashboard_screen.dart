import 'package:flutter/material.dart';

class ProviderDashboardScreen extends StatelessWidget {
  const ProviderDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard - Proveedor")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Bienvenido, Proveedor",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Card(
              child: ListTile(
                leading: const Icon(Icons.list_alt),
                title: const Text("Mis servicios"),
                subtitle: const Text("Gestiona los servicios que ofreces"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navegar a la gestión de servicios
                },
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.star),
                title: const Text("Valoraciones"),
                subtitle: const Text("Consulta las valoraciones recibidas"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navegar a valoraciones
                },
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Editar perfil"),
                subtitle: const Text("Modifica tu información personal"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navegar a editar perfil
                },
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Center(
                child: Text(
                  "Aquí podrás ver estadísticas, próximos servicios, mensajes y más.",
                  style: TextStyle(color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}