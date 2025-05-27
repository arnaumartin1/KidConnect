import 'package:flutter/material.dart';
import '../widgets/styledcontainer.dart';
import 'databases/database_helper.dart';
import 'Booking.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Booking> _bookings = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    // Aquí debes obtener el email del usuario logueado (ajusta según tu lógica de sesión)
    final String userEmail = 'usuario@email.com'; // <-- cámbialo por el email real del usuario logueado

    final bookings = await DatabaseHelper().getBookingsForUser(userEmail);
    setState(() {
      _bookings = bookings;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F3),
      body: Center(
        child: StyledContainer(
          child: _loading
              ? const CircularProgressIndicator()
              : _bookings.isEmpty
                  ? const Text('No hay historial disponible.')
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _bookings.length,
                      itemBuilder: (context, index) {
                        final booking = _bookings[index];
                        return ListTile(
                          title: Text(booking.serviceTitle),
                          subtitle: Text(
                              '${booking.providerName} • ${booking.date.toLocal().toString().split(' ')[0]}'),
                        );
                      },
                    ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: const Color(0xFF6B8C89),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/parent_dashboard');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/messages');
          } else if (index == 2) {
            // Ya estás en historial
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
    );
  }
}