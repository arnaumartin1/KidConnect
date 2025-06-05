import 'package:flutter/material.dart';
import 'Message.dart';
import 'ProfessionalProfilePage.dart';

// Chat model
class Chat {
  final String id;
  final String name;
  final List<Message> messages;

  Chat({
    required this.id,
    required this.name,
    required this.messages,
  });

  Chat copyWith({
    String? id,
    String? name,
    List<Message>? messages,
  }) {
    return Chat(
      id: id ?? this.id,
      name: name ?? this.name,
      messages: messages ?? this.messages,
    );
  }
}

class ProfessionalMessageScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  const ProfessionalMessageScreen({super.key, required this.user});

  @override
  _ProfessionalMessagesScreenState createState() => _ProfessionalMessagesScreenState();
}

class _ProfessionalMessagesScreenState extends State<ProfessionalMessageScreen> {
  final List<Map<String, String>> myServices = [
    {
      'title': 'Clases de inglés para niños',
      'description': 'Aprende inglés de forma divertida',
      'city': 'Madrid',
      'price': '15€/h',
    },
    {
      'title': 'Taller de robótica',
      'description': 'Robótica educativa para todas las edades',
      'city': 'Barcelona',
      'price': '20€/h',
    }
  ];

  List<Chat> chats = [
    Chat(
      id: '1',
      name: 'Parent Peter',
      messages: [
        Message(sender: 'parent', text: '¡Hola!', timestamp: DateTime.now().subtract(Duration(minutes: 5))),
        Message(sender: 'provider', text: '¡Hola Peter! ¿En qué puedo ayudarte?', timestamp: DateTime.now().subtract(Duration(minutes: 4))),
      ],
    ),
    Chat(
      id: '2',
      name: 'Parent Mary',
      messages: [
        Message(sender: 'parent', text: 'Necesito tu servicio para el viernes.', timestamp: DateTime.now().subtract(Duration(minutes: 10))),
        Message(sender: 'provider', text: '¡Por supuesto! ¿A qué hora lo necesitas?', timestamp: DateTime.now().subtract(Duration(minutes: 9))),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
          final lastMessage = chat.messages.isNotEmpty ? chat.messages.last.text : '';
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFF6B8C89),
                child: Text(
                  chat.name[0],
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                chat.name,
                style: const TextStyle(
                  color: Color(0xFF6B8C89),
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(lastMessage),
              trailing: const Icon(Icons.chevron_right, color: Color(0xFF6B8C89)),
              onTap: () async {
                final updatedChat = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(chat: chat),
                  ),
                );
                if (updatedChat != null) {
                  setState(() {
                    chats[index] = updatedChat;
                  });
                }
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: const Color.fromARGB(255, 34, 178, 189),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0 && 1 != 0) {
            Navigator.pushReplacementNamed(context, '/professional_home');
          } else if (index == 1 && 1 != 1) {
            Navigator.pushReplacementNamed(context, '/professional_messages');
          } else if (index == 2 && 1 != 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfessionalProfilePage(
                  userInfo: widget.user.map((key, value) => MapEntry(key, value.toString())),
                  services: myServices,
                ),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Servicios'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Mensajes'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final Chat chat;

  const ChatScreen({super.key, required this.chat});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late List<Message> messages;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    messages = List.from(widget.chat.messages);
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      messages.add(
        Message(
          sender: 'provider', // El profesional envía el mensaje
          text: text,
          timestamp: DateTime.now(),
        ),
      );
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, widget.chat.copyWith(messages: messages));
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFEFF3F3),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF6B8C89)),
            onPressed: () {
              Navigator.pop(context, widget.chat.copyWith(messages: messages));
            },
          ),
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFF6B8C89),
                child: Text(
                  widget.chat.name[0],
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                widget.chat.name,
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
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[messages.length - 1 - index];
                  final isMe = msg.sender == 'provider';
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
                      child: Column(
                        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          Text(
                            msg.text,
                            style: TextStyle(
                              color: isMe ? Colors.white : const Color(0xFF6B8C89),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${msg.timestamp.hour.toString().padLeft(2, '0')}:${msg.timestamp.minute.toString().padLeft(2, '0')}',
                            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                          ),
                        ],
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
                      controller: _controller,
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
                      onSubmitted: _sendMessage,
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: const Color(0xFF6B8C89),
                    radius: 24,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () => _sendMessage(_controller.text),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}