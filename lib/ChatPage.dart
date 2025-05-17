import 'package:flutter/material.dart';
import 'Message.dart';

// Mock chat data storage
final Map<String, List<Message>> mockChats = {};

class ChatPage extends StatefulWidget {
  final String serviceId;
  final String serviceTitle;

  const ChatPage({
    super.key,
    required this.serviceId,
    required this.serviceTitle,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();

  List<Message> get messages => mockChats[widget.serviceId] ?? [];

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        mockChats.putIfAbsent(widget.serviceId, () => []);
        mockChats[widget.serviceId]!.add(
          Message(
            sender: 'parent',
            text: text,
            timestamp: DateTime.now(),
          ),
        );
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat con ${widget.serviceTitle}')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              reverse: true,
              itemBuilder: (context, index) {
                final message = messages[messages.length - 1 - index];
                final isMe = message.sender == 'parent';
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isMe
                          ? const Color.fromARGB(255, 34, 178, 189).withOpacity(0.2)
                          : Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(message.text),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Escribe un mensaje...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send, color: Color.fromARGB(255, 34, 178, 189)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}