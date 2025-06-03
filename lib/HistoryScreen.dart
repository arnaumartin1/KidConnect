import 'package:flutter/material.dart';
import '../widgets/styledcontainer.dart';
// import 'Booking.dart';
import 'mockbooking.dart';
import 'Rating.dart' as rating_lib;
import 'RatingDialog.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool isRated(String serviceId) {
    return rating_lib.mockRatings.any((r) => r.serviceId == serviceId);
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
          child: mockBookings.isEmpty
              ? const Text('No hay historial disponible.')
              : ListView.separated(
                  shrinkWrap: true,
                  itemCount: mockBookings.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final booking = mockBookings[index];
                    final rated = isRated(booking.serviceTitle);
                    return Dismissible(
                      key: ValueKey(booking.hashCode),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) {
                        setState(() {
                          mockBookings.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Reserva eliminada del historial')),
                        );
                      },
                      child: Card(
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
                              Text(
                                'Precio: ${booking.price.toStringAsFixed(2)} €',
                                style: const TextStyle(fontSize: 13, color: Colors.black54),
                              ),
                            ],
                          ),
                          trailing: rated
                              ? const Icon(Icons.star, color: Colors.orange)
                              : IconButton(
                                  icon: const Icon(Icons.star_border, color: Colors.orange),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => RatingDialog(
                                        serviceId: booking.serviceTitle,
                                        onRated: () => setState(() {}),
                                      ),
                                    );
                                  },
                                ),
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