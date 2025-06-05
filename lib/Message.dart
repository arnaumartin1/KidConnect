class Message {
  final String sender; // 'parent' o 'provider'
  final String text;
  final DateTime timestamp;

  Message({
    required this.sender,
    required this.text,
    required this.timestamp,
  });
}