import 'package:flutter/material.dart';
import '/widgets/styledcontainer.dart';
import 'ParentDashboardScreen.dart';

class UserTypeSelectionScreen extends StatefulWidget {
  const UserTypeSelectionScreen({super.key});

  @override
  State<UserTypeSelectionScreen> createState() => _UserTypeSelectionScreenState();
}

class _UserTypeSelectionScreenState extends State<UserTypeSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F3),
      body: StyledContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Cuéntanos más sobre ti',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B8C89),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Voy a usar la aplicación como...',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ParentDashboardScreen()),
                  );
                },
                icon: Icon(Icons.family_restroom),
                label: const Text('Padre/Madre/Tutor'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B8C89),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/professional_home');
                },
                icon: Icon(Icons.work),
                label: const Text('Profesional'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B8C89),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
                label: const Text('Atrás'),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF6B8C89),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}