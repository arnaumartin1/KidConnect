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

  Future<void> _addService() async {
    final newService = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => AddServicePage(),
      ),
    );
    if (newService != null) {
      setState(() {
        myServices.add(newService);
      });
    }
  }

  Future<void> _editService(int index) async {
    final updatedService = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => AddServicePage(
          initialData: myServices[index],
          index: index,
        ),
      ),
    );
    if (updatedService != null) {
      setState(() {
        myServices[index] = updatedService;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Mis Servicios',
          style: TextStyle(
            color: Color(0xFF6B8C89),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF6B8C89)),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StyledContainer(
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
              ),
              const SizedBox(height: 16),
              Expanded(
                child: myServices.isEmpty
                    ? const Center(child: Text('No tienes servicios publicados aún.'))
                    : ListView.separated(
                        itemCount: myServices.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final service = myServices[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            elevation: 2,
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              leading: CircleAvatar(
                                backgroundColor: const Color(0xFF6B8C89),
                                child: Icon(Icons.work, color: Colors.white),
                              ),
                              title: Text(
                                service['title'] ?? '',
                                style: const TextStyle(
                                  color: Color(0xFF6B8C89),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(service['description'] ?? ''),
                                  Text(
                                    '${service['city']} • ${service['price']}',
                                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.edit, color: Color(0xFF6B8C89)),
                                onPressed: () => _editService(index),
                              ),
                              onTap: () {
                                // Aquí podrías navegar al detalle del servicio propio
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Añadir servicio'),
        backgroundColor: const Color(0xFF6B8C89),
        onPressed: _addService,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 34, 178, 189),
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