import 'package:flutter/material.dart';
import 'Service.dart';
import 'ServiceDetailPage.dart';
import 'Booking.dart';
class ParentDashboardScreen extends StatefulWidget {
  const ParentDashboardScreen({super.key});

  @override
  State<ParentDashboardScreen> createState() => _ParentDashboardScreenState();
}

class _ParentDashboardScreenState extends State<ParentDashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const ParentMainPage(),
    const FavoritesPage(),
    const HistoryPage(),
    const ParentProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color.fromARGB(255, 34, 178, 189),
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoritos'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historial'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
class ParentMainPage extends StatefulWidget {
  const ParentMainPage({super.key});

  @override
  State<ParentMainPage> createState() => _ParentMainPageState();
}

class _ParentMainPageState extends State<ParentMainPage> {
  String _selectedCity = '';
  final List<Service> _allServices = [
    Service(
      id: '1',
      title: 'Clases de inglés',
      description: 'Profesor con experiencia para niños de primaria',
      city: 'Madrid',
      price: 15.0,
      rating: 4.5,
    ),
    Service(
      id: '2',
      title: 'Niñera bilingüe',
      description: 'Cuido niños en inglés y español',
      city: 'Barcelona',
      price: 12.0,
      rating: 4.8,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredServices = _selectedCity.isEmpty
        ? _allServices
        : _allServices.where((s) => s.city == _selectedCity).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Explora servicios')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Filtrar por ciudad',
                border: OutlineInputBorder(),
              ),
              value: _selectedCity.isEmpty ? null : _selectedCity,
              items: ['Madrid', 'Barcelona']
                  .map((city) => DropdownMenuItem(
                        value: city,
                        child: Text(city),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCity = value ?? '';
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredServices.length,
              itemBuilder: (context, index) {
                final service = filteredServices[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(service.title),
                    subtitle: Text('${service.city} • ${service.price}€/h • ⭐ ${service.rating}'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ServiceDetailPage(service: service),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: const Center(child: Text('Lista de servicios favoritos')),
    );
  }
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (mockBookings.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Historial')),
        body: const Center(child: Text('No tienes servicios contratados aún')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Historial de Servicios')),
      body: ListView.builder(
        itemCount: mockBookings.length,
        itemBuilder: (context, index) {
          final booking = mockBookings[index];
          return ListTile(
            title: Text(booking.serviceTitle),
            subtitle: Text('Proveedor: ${booking.providerName}\n${booking.date.toLocal().toString().split(' ')[0]}'),
            trailing: Text('${booking.price.toStringAsFixed(2)}€'),
          );
        },
      ),
    );
  }
}

class ParentProfilePage extends StatelessWidget {
  const ParentProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
              initialValue: 'Nombre Ejemplo',
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Ciudad',
                border: OutlineInputBorder(),
              ),
              initialValue: 'Madrid',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Perfil actualizado')),
                );
              },
              child: const Text('Guardar cambios'),
            ),
          ],
        ),
      ),
    );
  }
}

// Mock data for bookings
final List<Booking> mockBookings = [
  Booking(
    serviceTitle: 'Clases de inglés',
    providerName: 'Ana López',
    date: DateTime.now().subtract(const Duration(days: 2)),
    price: 15.0,
  ),
  Booking(
    serviceTitle: 'Niñera bilingüe',
    providerName: 'María García',
    date: DateTime.now().subtract(const Duration(days: 7)),
    price: 12.0,
  ),
];