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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Historial de servicios',
          style: TextStyle(
            color: Color(0xFF6B8C89),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF6B8C89)),
        centerTitle: false,
      ),
      body: Center(
        child: StyledContainer(
          child: _loading
              ? const CircularProgressIndicator()
              : _bookings.isEmpty
                  ? const Text('No hay historial disponible.')
                  : ListView.separated(
                      shrinkWrap: true,
                      itemCount: _bookings.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final booking = _bookings[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          elevation: 2,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: const Color(0xFF6B8C89),
                              child: const Icon(Icons.history, color: Colors.white),
                            ),
                            title: Text(
                              booking.serviceTitle,
                              style: const TextStyle(
                                color: Color(0xFF6B8C89),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(booking.providerName),
                                Text(
                                  '${booking.date.toLocal().toString().split(' ')[0]}',
                                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
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

class DatabaseHelper {
  // Existing methods and properties

  Future<List<Booking>> getBookingsForUser(String userEmail) async {
    // TODO: Replace with actual database query logic
    // This is a placeholder implementation
    // Return an empty list or mock data for now
    return [];
  }
}