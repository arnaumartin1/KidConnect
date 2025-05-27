import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String contactName;
  final Color avatarColor;

  const ChatScreen({
    super.key,
    required this.contactName,
    required this.avatarColor,
  });

  List<Map<String, dynamic>> getMessagesForContact(String name) {
    switch (name) {
      case 'Alex Profesor':
        return [
          {'text': '¡Hola!', 'isMe': false},
          {'text': 'Nos interesan tus servicios de profesor de idiomas', 'isMe': true},
          {'text': '¿Podrías proporcionarnos información de disponibilidad y precios, gracias?', 'isMe': true},
          {'text': '¡Hola encantado!', 'isMe': false},
          {'text': 'Trabajo por las tardes de 15 a 19 h.', 'isMe': false},
          {'text': 'Puedes consultar disponibilidad en el apartado "reservar" en mi perfil.', 'isMe': false},
          {'text': 'Los precios rondan los 15 €/h.', 'isMe': false},
          {'text': 'Perfecto, ¡gracias!', 'isMe': true},
        ];
      case 'Mónica Niñera':
        return [
          {'text': '¡Buenas tardes!', 'isMe': false},
          {'text': '¿Tienes disponibilidad para el viernes?', 'isMe': true},
          {'text': 'Sí, ¿a qué hora necesitas el servicio?', 'isMe': false},
          {'text': 'Por la tarde, sobre las 17:00.', 'isMe': true},
          {'text': 'Perfecto, apunto la reserva.', 'isMe': false},
          {'text': '¡Gracias!', 'isMe': true},
        ];
      case 'Jaime Entrenador':
        return [
          {'text': 'Hola Jaime, ¿hay entrenamiento este sábado?', 'isMe': true},
          {'text': '¡Hola! Sí, nos vemos el sábado a las 10:00.', 'isMe': false},
          {'text': '¿En el polideportivo de siempre?', 'isMe': true},
          {'text': 'Exacto, allí mismo.', 'isMe': false},
          {'text': '¡Genial, gracias!', 'isMe': true},
        ];
      default:
        return [
          {'text': '¡Hola!', 'isMe': false},
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final messages = getMessagesForContact(contactName);

    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF6B8C89)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: avatarColor,
              child: Text(
                contactName[0],
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              contactName,
              style: const TextStyle(
                color: Color(0xFF6B8C89),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isMe = msg['isMe'] as bool;
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 6,
                      bottom: 6,
                      left: isMe ? 60 : 0,
                      right: isMe ? 0 : 60,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    decoration: BoxDecoration(
                      color: isMe ? const Color(0xFF6B8C89) : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(18),
                        topRight: const Radius.circular(18),
                        bottomLeft: Radius.circular(isMe ? 18 : 6),
                        bottomRight: Radius.circular(isMe ? 6 : 18),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      msg['text'],
                      style: TextStyle(
                        color: isMe ? Colors.white : const Color(0xFF6B8C89),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Escribe un mensaje...',
                      hintStyle: const TextStyle(color: Color(0xFF6B8C89)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: const Color(0xFF6B8C89),
                  radius: 24,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      // Tu lógica de enviar mensaje aquí
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}