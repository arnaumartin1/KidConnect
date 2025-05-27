import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Service.dart' as service_lib;
import 'Booking.dart';
import 'ParentDashboardScreen.dart';
import 'mockbooking.dart'; // Importa la lista global

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
      appBar: AppBar(title: const Text('Seleccionar fecha y hora')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickDate,
              child: Text(
                _selectedDate == null
                    ? 'Seleccionar fecha'
                    : DateFormat('dd/MM/yyyy').format(_selectedDate!),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickTime,
              child: Text(
                _selectedTime == null
                    ? 'Seleccionar hora'
                    : _selectedTime!.format(context),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: (_selectedDate != null && _selectedTime != null)
                  ? _confirmBooking
                  : null,
              child: const Text('Confirmar reserva'),
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

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const ParentDashboardScreen()),
      (route) => false,
    );
  }
}