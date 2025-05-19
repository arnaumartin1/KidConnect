import 'package:flutter/material.dart';

class ProviderMessagesScreen extends StatelessWidget {
  const ProviderMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ejemplo de conversaciones simuladas
    final List<Map<String, String>> conversations = [
      {
        'name': 'María López',
        'lastMessage': '¿Está disponible el sábado?',
        'time': '10:30',
      },
      {
        'name': 'Carlos Pérez',
        'lastMessage': 'Gracias por el servicio!',
        'time': 'Ayer',
      },
      {
        'name': 'Ana Torres',
        'lastMessage': '¿Podemos cambiar la hora?',
        'time': 'Lun',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Mensajes")),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: conversations.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final convo = conversations[index];
          return ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(convo['name']!),
            subtitle: Text(convo['lastMessage']!),
            trailing: Text(convo['time']!, style: const TextStyle(fontSize: 12)),
            onTap: () {
              // Navegar a la pantalla de chat (por implementar)
              // Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen()));
            },
          );
        },
      ),
    );
  }
}