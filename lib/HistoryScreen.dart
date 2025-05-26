import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> history;

  const HistoryScreen({Key? key, this.history = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historial')),
      body: history.isEmpty
          ? const Center(child: Text('No hay historial disponible.'))
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final item = history[index];
                return ListTile(
                  title: Text(item['title'] ?? 'Sin título'),
                  subtitle: Text(item['date'] ?? ''),
                );
              },
            ),
    );
  }
}