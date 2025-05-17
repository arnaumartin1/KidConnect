import 'package:flutter/material.dart';




class UserTypeSelectionScreen extends StatefulWidget {
  const UserTypeSelectionScreen({super.key});

  @override
  _UserTypeSelectionScreenState createState() => _UserTypeSelectionScreenState();
}

class _UserTypeSelectionScreenState extends State<UserTypeSelectionScreen> {
  String? _selectedUserType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuéntanos más sobre ti'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Voy a usar la aplicación como...',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildUserTypeOption(
              title: 'Padre/Madre/Tutor',
              value: 'parent',
              isSelected: _selectedUserType == 'parent',
            ),
            const SizedBox(height: 15),
            _buildUserTypeOption(
              title: 'Profesional',
              value: 'professional',
              isSelected: _selectedUserType == 'professional',
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _selectedUserType != null
                  ? () {
                      // Navegar a la pantalla correspondiente
                      if (_selectedUserType == 'parent') {
                        Navigator.pushReplacementNamed(context, '/parent_home');
                      } else {
                        Navigator.pushReplacementNamed(context, '/professional_home');
                      }
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: _selectedUserType != null ? const Color.fromARGB(255, 34, 178, 189) : Colors.grey,
              ),
              child: const Text(
                'Continuar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserTypeOption({
    required String title,
    required String value,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedUserType = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSelected ? const Color.fromARGB(255, 34, 178, 189).withOpacity(0.1) : Colors.transparent,
          border: Border.all(
            color: isSelected ? const Color.fromARGB(255, 34, 178, 189) : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? const Color.fromARGB(255, 34, 178, 189) : Colors.grey,
            ),
            const SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? const Color.fromARGB(255, 34, 178, 189) : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}