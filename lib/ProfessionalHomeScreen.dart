import 'package:flutter/material.dart';
import '../widgets/styledcontainer.dart';

class ProfessionalHomeScreen extends StatelessWidget {
  const ProfessionalHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F3),
      body: StyledContainer(
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
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/professional_dashboard');
                },
                child: const Text('Ir al Panel'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}