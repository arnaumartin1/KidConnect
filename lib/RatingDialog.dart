import 'package:flutter/material.dart';
import 'Rating.dart';

// Mock data for ratings
final List<Rating> mockRatings = [];

class RatingDialog extends StatefulWidget {
  final String serviceId;
  final VoidCallback onRated;

  const RatingDialog({super.key, required this.serviceId, required this.onRated});

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  double _rating = 3.0;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Valora el servicio"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Slider(
            value: _rating,
            min: 1,
            max: 5,
            divisions: 4,
            label: _rating.toString(),
            onChanged: (value) => setState(() => _rating = value),
          ),
          TextField(
            controller: _commentController,
            decoration: const InputDecoration(hintText: 'Comentario'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: () {
            mockRatings.add(
              Rating(
                serviceId: widget.serviceId,
                score: _rating,
                comment: _commentController.text,
              ),
            );
            widget.onRated();
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Valoración enviada')),
            );
          },
          child: const Text("Enviar"),
        ),
      ],
    );
  }
}