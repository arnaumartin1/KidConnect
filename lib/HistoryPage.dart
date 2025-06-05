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
      body: mockBookings.isEmpty
          ? const Center(child: Text('No hay historial disponible.'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: mockBookings.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final booking = mockBookings[index];
                final bool isRated = booking.isRated;
                final Color mainColor = isRated ? const Color(0xFF6B8C89) : Colors.orange;

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: mainColor,
                        child: Icon(
                          isRated ? Icons.check_circle : Icons.star_border,
                          color: Colors.white,
                        ),
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
                          Text('Proveedor: ${booking.providerName}'),
                          Text(
                            'Fecha: ${booking.date.toLocal().toString().split(' ')[0]}',
                            style: const TextStyle(fontSize: 13, color: Colors.black54),
                          ),
                          Text(
                            'Precio: ${booking.price.toStringAsFixed(2)} €',
                            style: const TextStyle(fontSize: 13, color: Colors.black54),
                          ),
                        ],
                      ),
                      trailing: isRated
                          ? Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6B8C89).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Valorado',
                                style: TextStyle(
                                  color: Color(0xFF6B8C89),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
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
                    ),
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
            // Ya estás en historial
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
            activeColor: const Color(0xFF6B8C89),
            inactiveColor: const Color(0xFF6B8C89).withOpacity(0.3),
          ),
          TextField(
            controller: _commentController,
            decoration: const InputDecoration(
              hintText: 'Escribe un comentario',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              filled: true,
              fillColor: Color(0xFFF5F5F5),
            ),
            maxLines: 2,
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
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6B8C89),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('Enviar'),
        ),
      ],
    );
  }
}
