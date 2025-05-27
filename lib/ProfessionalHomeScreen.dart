import 'package:flutter/material.dart';
import 'AddServicePage.dart';
import 'ProfessionalProfilePage.dart';
import '../widgets/styledcontainer.dart';

class ProfessionalHomeScreen extends StatefulWidget {
  final Map<String, dynamic>? user;
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
    try {
      final newService = await Navigator.push<Map<String, String>>(
        context,
        MaterialPageRoute(
          builder: (context) => AddServicePage(),
        ),
      );
      if (newService != null && mounted) {
        setState(() {
          myServices.add(newService);
        });
      }
    } catch (e) {
      // Manejo de error opcional
    }
  }

  Future<void> _editService(int index) async {
    try {
      final updatedService = await Navigator.push<Map<String, String>>(
        context,
        MaterialPageRoute(
          builder: (context) => AddServicePage(
            initialData: myServices[index],
            index: index,
          ),
        ),
      );
      if (updatedService != null && mounted) {
        setState(() {
          myServices[index] = updatedService;
        });
      }
    } catch (e) {
      // Manejo de error opcional
    }
  }

  void _onNavBarTap(int index) {
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
            userInfo: (widget.user ?? {}).map((key, value) => MapEntry(key, value.toString())),
            services: myServices,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.user == null) {
      return Scaffold(
        body: Center(
          child: Text(
            'Error: usuario no encontrado',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Servicios'),
      ),
      body: Center(
        child: Text(
          'Aquí aparecerán tus servicios como profesional.',
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // Navegación básica (ajusta según tus rutas)
          if (index == 1) {
            Navigator.pushNamed(context, '/professional_messages', arguments: widget.user);
          } else if (index == 2) {
            Navigator.pushNamed(context, '/professional_profile', arguments: {'userInfo': widget.user, 'services': []});
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