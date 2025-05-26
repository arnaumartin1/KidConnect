import 'package:flutter/material.dart';
import 'Message.dart';
import 'ParentDashboardScreen.dart';
import 'ParentProfilePage.dart';

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

class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<Chat> chats = [
    Chat(
      id: '1',
      name: 'Provider Alice',
      messages: [
        Message(sender: 'provider', text: 'Hello!', timestamp: DateTime.now().subtract(Duration(minutes: 5))),
        Message(sender: 'parent', text: 'Hi Alice!', timestamp: DateTime.now().subtract(Duration(minutes: 4))),
      ],
    ),
    Chat(
      id: '2',
      name: 'Provider Bob',
      messages: [
        Message(sender: 'provider', text: 'How can I help?', timestamp: DateTime.now().subtract(Duration(minutes: 10))),
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
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => ParentDashboardScreen()),
              (route) => false,
            );
          } else if (index == 1) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MessagesScreen()),
              (route) => false,
            );
          } else if (index == 2) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => ParentProfilePage()),
              (route) => false,
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
          sender: 'parent',
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
                  final isMe = msg.sender == 'parent';
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