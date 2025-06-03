import 'package:flutter/material.dart';
import '../widgets/styledcontainer.dart';
import '../widgets/appbar.dart';

class ParentDashboardScreen extends StatelessWidget {
  const ParentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Panel de Padres', // o 'Panel de Profesionales'
          style: TextStyle(
            color: Color(0xFF6B8C89),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF6B8C89)),
      ),
      backgroundColor: const Color(0xFFEFF3F3),
      body: Center(
        child: StyledContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Panel de Padres',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6B8C89),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '¡Bienvenido/a, usuario!',
                    // Si tienes el nombre real: '¡Bienvenido/a, $nombre!'
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF6B8C89),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/parent_home');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6B8C89),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    child: const Text('Buscar servicios'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF6B8C89),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            // Ya estás en el dashboard
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/messages');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/history');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/parent_profile');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Servicios'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Mensajes'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historial'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
      // appBar: AppBar(
      //   title: const Text('Dashboard'),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 16.0),
      //       child: CircleAvatar(
      //         backgroundColor: const Color(0xFF6B8C89),
      //         child: const Icon(Icons.person, color: Colors.white),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
