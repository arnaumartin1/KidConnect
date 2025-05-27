import 'package:flutter/material.dart';
import 'ChatScreen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> chats = [
      {
        'name': 'Alex Profesor',
        'lastMessage': 'Perfecto, ¡gracias!',
        'avatarColor': Colors.blueGrey,
      },
      {
        'name': 'Mónica Niñera',
        'lastMessage': '¿A qué hora necesitas el servicio?',
        'avatarColor': Colors.purple,
      },
      {
        'name': 'Jaime Entrenador',
        'lastMessage': 'Nos vemos el sábado.',
        'avatarColor': Colors.teal,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Chats',
          style: TextStyle(
            color: Color(0xFF6B8C89),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF6B8C89)),
        centerTitle: false,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: chats.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final chat = chats[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: chat['avatarColor'],
                child: Text(
                  chat['name'][0],
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                chat['name'],
                style: const TextStyle(
                  color: Color(0xFF6B8C89),
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(chat['lastMessage']),
              trailing: const Icon(Icons.chevron_right, color: Color(0xFF6B8C89)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(
                      contactName: chat['name'],
                      avatarColor: chat['avatarColor'],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}