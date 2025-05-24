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
  const ProfessionalMessageScreen({Key? key, required this.user}) : super(key: key);

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
        Message(sender: 'parent', text: 'Hello!', timestamp: DateTime.now().subtract(Duration(minutes: 5))),
        Message(sender: 'provider', text: 'Hi Peter! What do you need?', timestamp: DateTime.now().subtract(Duration(minutes: 4))),
      ],
    ),
    Chat(
      id: '2',
      name: 'Parent Mary',
      messages: [
        Message(sender: 'parent', text: 'I need your service!', timestamp: DateTime.now().subtract(Duration(minutes: 10))),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chats')),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          final lastMessage = chat.messages.isNotEmpty ? chat.messages.last.text : '';
          return ListTile(
            title: Text(chat.name),
            subtitle: Text(lastMessage),
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
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Color.fromARGB(255, 34, 178, 189),
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
        items: [
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

  ChatScreen({required this.chat});

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
        appBar: AppBar(title: Text(widget.chat.name)),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[messages.length - 1 - index];
                  final isMe = msg.sender == 'provider';
                  return Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.blue[100] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          Text(msg.text),
                          SizedBox(height: 4),
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
            Divider(height: 1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(hintText: 'Type a message...'),
                      onSubmitted: _sendMessage,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () => _sendMessage(_controller.text),
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