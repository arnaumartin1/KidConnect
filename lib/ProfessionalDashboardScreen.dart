import 'package:flutter/material.dart';

class ProfessionalDashboardScreen extends StatelessWidget {
  const ProfessionalDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Recibir los argumentos del anuncio
    final anuncio = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Profesional'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (anuncio != null) ...[
              Text('Título: ${anuncio['titulo']}'),
              Text('Precio: \$${anuncio['precio']}'),
              // Puedes mostrar más datos aquí
            ],
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}