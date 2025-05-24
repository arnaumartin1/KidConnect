import 'package:flutter/material.dart';
import 'AddServicePage.dart';
import 'ProfessionalProfilePage.dart';
import '../widgets/styledcontainer.dart';

class ProfessionalHomeScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  const ProfessionalHomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfessionalHomeScreen> createState() => _ProfessionalHomeScreenState();
}

class _ProfessionalHomeScreenState extends State<ProfessionalHomeScreen> {
  int _selectedIndex = 0;
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
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F3),
      appBar: AppBar(
        title: Text('Mis Servicios'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Bienvenido, Profesional',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B8C89),
              ),
            ),
          ),
          Expanded(
            child: myServices.isEmpty
                ? Center(child: Text('No tienes servicios publicados aún.'))
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
                            icon: Icon(Icons.edit),
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Añadir servicio'),
        onPressed: () {
          Navigator.pushNamed(context, '/add_service');
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 34, 178, 189),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (_selectedIndex == index) return;
          setState(() {
            _selectedIndex = index;
          });
          if (index == 1) {
            Navigator.pushNamed(context, '/professional_messages');
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
          } else if (index == 0) {
            // Ya estamos en la pantalla de servicios, no hace falta navegar
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Servicios'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Mensajes'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}