import 'package:flutter/material.dart';
import 'AddServicePage.dart';

class ProfessionalHomeScreen extends StatefulWidget {
  const ProfessionalHomeScreen({super.key});

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