import 'package:flutter/material.dart';
import '../widgets/StyledContainer.dart';
import 'ServiceExamplesPage.dart'; // Asegúrate de importar la página de ejemplos de servicio

class ParentHomeScreen extends StatelessWidget {
  const ParentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F3),
      appBar: AppBar(
        title: const Text('Buscar servicios'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StyledContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '¿Qué servicio te interesa?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6B8C89),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  filled: true,
                  fillColor: Color(0xFFF5F5F5),
                ),
              ),
              const SizedBox(height: 24),
              ...[
                'Profesora de idiomas',
                'Pediatra',
                'Niñera',
                'Entrenador deportivo',
                'Todos'
              ].map((service) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ServiceExamplesPage(serviceType: service == 'Todos' ? '' : service),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: service == 'Todos'
                          ? Color(0xFF6B8C89)
                          : Colors.white,
                      foregroundColor: service == 'Todos'
                          ? Colors.white
                          : Color(0xFF6B8C89),
                      side: BorderSide(
                        color: Color(0xFF6B8C89),
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      service,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: service == 'Todos'
                            ? Colors.white
                            : Color(0xFF6B8C89),
                      ),
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}