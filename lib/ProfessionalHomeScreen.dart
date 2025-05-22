import 'package:flutter/material.dart';
import 'AddServicePage.dart';
import 'ProfessionalProfilePage.dart';
import '../widgets/styledcontainer.dart';

class ProfessionalHomeScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const ProfessionalHomeScreen({super.key, required this.user});

  @override
  State<ProfessionalHomeScreen> createState() => _ProfessionalHomeScreenState();
}

class _ProfessionalHomeScreenState extends State<ProfessionalHomeScreen> {
  // Simulación de servicios del profesional
  final List<Map<String, String>> myServices = [
    {
      'title': 'Clases de inglés para niños',
      'description': 'Aprende inglés de forma divertida',
      'city': 'Madrid',
      'price': '15€/h',
    },
    {
      'title': 'Taller de robótica',
      'description': 'Robótica educativa para todas las edades',
      'city': 'Barcelona',
      'price': '20€/h',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F3),
      body: StyledContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bienvenido, Profesional',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B8C89),
              ),
      appBar: AppBar(
        title: const Text('Mis Servicios'),
      ),
      body: myServices.isEmpty
          ? const Center(child: Text('No tienes servicios publicados aún.'))
          : ListView.builder(
              itemCount: myServices.length,
              itemBuilder: (context, index) {
                final service = myServices[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(service['title']!),
                    subtitle: Text('${service['description']} • ${service['city']} • ${service['price']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        final updatedService = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddServicePage(
                              initialData: service,
                              index: index,
                            ),
                          ),
                        );

                        if (updatedService != null) {
                          setState(() {
                            myServices[index] = updatedService;
                          });
                        }
                      },
                    ),
                    onTap: () {
                      // Navegar al detalle del servicio propio
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Añadir servicio'),
        onPressed: () {
          Navigator.pushNamed(context, '/add_service');
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color.fromARGB(255, 34, 178, 189),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/professional_dashboard');
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfessionalProfilePage(
                  userInfo: widget.user.map((key, value) => MapEntry(key, value.toString())),
                  services: myServices,
                ),
              ),
            );
          } else {
            Navigator.pushNamed(context, '/professional_home');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Servicios'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Mensajes'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/professional_dashboard');
                },
                child: const Text('Ir al Panel'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}