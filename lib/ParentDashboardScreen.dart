import 'package:flutter/material.dart';
import '../widgets/styledcontainer.dart';
import 'ParentProfilePage.dart';

class ParentDashboardScreen extends StatelessWidget {
  const ParentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F3),
      body: StyledContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Panel de Padres',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B8C89),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/book_service',
                    arguments: {
                      'id': 's1',
                      'title': 'Clases de inglés para niños',
                      'description': 'Aprende inglés de forma divertida',
                      'city': 'Madrid',
                      'price': 15.0,
                      'rating': 4.5,
                    },
                  );
                },
                child: const Text('Reservar un servicio'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Color.fromARGB(255, 34, 178, 189),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            // Ir al dashboard (pantalla actual)
            Navigator.pushReplacementNamed(context, '/parent_dashboard');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/messages');
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ParentProfilePage(),
              ),
            );
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
