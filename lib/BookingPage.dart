import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Service.dart' as service_lib;
import 'Booking.dart';
import 'ParentDashboardScreen.dart';
import 'mockBooking.dart'; // Importa la lista global
import 'ViewUserProfilePage.dart';


class BookingPage extends StatefulWidget {
  final service_lib.Service service;

  const BookingPage({super.key, required this.service});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Reservar servicio',
          style: TextStyle(
            color: Color(0xFF6B8C89),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF6B8C89)),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFF6B8C89),
                  child: const Icon(Icons.work, color: Colors.white),
                ),
                title: Text(
                  widget.service.title,
                  style: const TextStyle(
                    color: Color(0xFF6B8C89),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.service.description),
                    Text(
                      '${widget.service.city} • ${widget.service.price.toStringAsFixed(2)} €/h',
                      style: const TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Selecciona fecha y hora',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF6B8C89),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.calendar_today),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF6B8C89),
                      side: const BorderSide(color: Color(0xFF6B8C89)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: _pickDate,
                    label: Text(
                      _selectedDate == null
                          ? 'Seleccionar fecha'
                          : DateFormat('dd/MM/yyyy').format(_selectedDate!),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.access_time),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF6B8C89),
                      side: const BorderSide(color: Color(0xFF6B8C89)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: _pickTime,
                    label: Text(
                      _selectedTime == null
                          ? 'Seleccionar hora'
                          : _selectedTime!.format(context),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                icon: const Icon(Icons.person, color: Color(0xFF6B8C89)),
                label: const Text(
                  'Ver el perfil del ofrecedor de servicios',
                  style: TextStyle(
                    color: Color(0xFF6B8C89),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                onPressed: _goToUserProfile,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check_circle),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B8C89),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: (_selectedDate != null && _selectedTime != null)
                    ? _confirmBooking
                    : null,
                label: const Text('Confirmar reserva'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today,
      lastDate: today.add(const Duration(days: 60)),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }
  void _goToUserProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ViewUserProfilePage(
          userInfo: {
            'name': 'Juan',
            'surname': 'Pérez',
            'email': 'juan@example.com',
            'city': widget.service.city,
          },
          services: [
            {
              'title': widget.service.title,
              'description': widget.service.description,
              'price': widget.service.price.toStringAsFixed(2),
            },
          ],
        ),
      ),
    );
  }

  void _confirmBooking() {
    final dateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    mockBookings.add(
      Booking(
        serviceTitle: widget.service.title,
        providerName: 'Proveedor Desconocido',
        date: dateTime,
        price: widget.service.price,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reserva confirmada y guardada en historial')),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.check_circle, color: Color(0xFF6B8C89), size: 64),
            SizedBox(height: 16),
            Text('¡Reserva realizada con éxito!', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pop(); // Cierra el diálogo
      // Luego navega al dashboard
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const ParentDashboardScreen()),
        (route) => false,
      );
    });
  }
}