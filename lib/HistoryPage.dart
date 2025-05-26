import 'package:flutter/material.dart';
import 'package:project1/MessagesScreen.dart';
import 'package:project1/ParentDashboardScreen.dart';
import 'package:project1/ParentProfilePage.dart';
import 'Booking.dart';
import 'Rating.dart';

// Mock list to store ratings
final List<Rating> mockRatings = [];

final List<Booking> mockBookings = [
  Booking(
    serviceTitle: 'Cuidado de niños',
    providerName: 'Ana Pérez',
    date: DateTime.now().subtract(const Duration(days: 2)),
    price: 25.0,
  ),
  Booking(
    serviceTitle: 'Clases de inglés',
    providerName: 'Juan López',
    date: DateTime.now().subtract(const Duration(days: 5)),
    price: 30.0,
  ),
  Booking(
    serviceTitle: 'Clases de programación',
    providerName: 'María García',
    date: DateTime.now().subtract(const Duration(days: 10)),
    price: 20.0,
  ),
  Booking(
    serviceTitle: 'Clases de matemáticas',
    providerName: 'Luis Fernández',
    date: DateTime.now().subtract(const Duration(days: 15)),
    price: 35.0,
  ),
  Booking(
    serviceTitle: 'Cuidado de niños',
    providerName: 'Laura Martínez',
    date: DateTime.now().subtract(const Duration(days: 20)),
    price: 40.0,
  ),
  Booking(
    serviceTitle: 'Clases de música',
    providerName: 'Carlos Sánchez',
    date: DateTime.now().subtract(const Duration(days: 25)),
    price: 50.0,
  ),
];

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historial')),
      body: ListView.builder(
        itemCount: mockBookings.length,
        itemBuilder: (context, index) {
          final booking = mockBookings[index];

          return ListTile(
            title: Text(booking.serviceTitle),
            subtitle: Text(
              'Proveedor: ${booking.providerName}\n${booking.date.toLocal().toString().split(' ')[0]}',
            ),
            trailing: booking.isRated
                ? const Icon(Icons.check_circle, color: Colors.green)
                : IconButton(
                    icon: const Icon(Icons.star_border, color: Colors.orange),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => RatingDialog(
                          booking: booking,
                          onRated: () {
                            booking.isRated = true;
                          },
                        ),
                      );
                    },
                  ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: const Color.fromARGB(255, 34, 178, 189),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => ParentDashboardScreen()),
              (route) => false,
            );
          } else if (index == 1) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MessagesScreen()),
              (route) => false,
            );
          } else if (index == 2) {
            // Ya estás en historial, no hacer nada o recargar si quieres
          } else if (index == 3) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => ParentProfilePage()),
              (route) => false,
            );
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

class RatingDialog extends StatefulWidget {
  final Booking booking;
  final VoidCallback onRated;

  const RatingDialog({
    super.key,
    required this.booking,
    required this.onRated,
  });

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  double _rating = 3.0;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('¿Cómo ha sido el servicio?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Slider(
            value: _rating,
            min: 1,
            max: 5,
            divisions: 4,
            label: _rating.toString(),
            onChanged: (value) => setState(() => _rating = value),
          ),
          TextField(
            controller: _commentController,
            decoration: const InputDecoration(hintText: 'Escribe un comentario'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            mockRatings.add(
              Rating(
                serviceId: widget.booking.serviceTitle,
                score: _rating,
                comment: _commentController.text,
              ),
            );
            widget.onRated();
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Gracias por tu valoración')),
            );
          },
          child: const Text('Enviar'),
        ),
      ],
    );
  }
}
