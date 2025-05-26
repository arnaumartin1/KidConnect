import 'package:flutter/material.dart';
import '../widgets/styledcontainer.dart';

class AddServicePage extends StatefulWidget {
  // const AddServicePage({super.key});
  final Map<String, String>? initialData;
  final int? index;

  const AddServicePage({super.key, this.initialData, this.index});

  @override
  State<AddServicePage> createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final List<bool> _disponibilidad = List.filled(7, false);

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    _precioController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _tituloController.text = widget.initialData!['title'] ?? '';
      _descripcionController.text = widget.initialData!['description'] ?? '';
      _precioController.text = widget.initialData!['price']?.replaceAll('€/h', '') ?? '';
      // NOTA: pots afegir també suport per editar disponibilitat si ho tens implementat
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KidConnect'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sube tu anuncio',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '¿Qué servicio ofreces?',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Título',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  hintText: 'Ej: Profesor de inglés',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un título';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              const Text(
                'Descripción',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _descripcionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Ej: Experiencia, estudios...',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una descripción';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              const Text(
                'Disponibilidad',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (index) {
                  final dias = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _disponibilidad[index] = !_disponibilidad[index];
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _disponibilidad[index]
                            ? const Color.fromARGB(255, 34, 178, 189).withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _disponibilidad[index]
                              ? const Color.fromARGB(255, 34, 178, 189)
                              : Colors.grey,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          dias[index],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _disponibilidad[index]
                                ? const Color.fromARGB(255, 34, 178, 189)
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 25),
              const Text(
                'Precio por hora',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _precioController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefixText: '€ ',
                  border: OutlineInputBorder(),
                  hintText: 'Ej: 15.00',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un precio';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Ingresa un número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        side: const BorderSide(color: Color.fromARGB(255, 34, 178, 189)),
                      ),
                      child: const Text(
                        'Atrás',
                        style: TextStyle(color: Color.fromARGB(255, 34, 178, 189)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final updatedService = {
                            'title': _tituloController.text,
                            'description': _descripcionController.text,
                            'city': widget.initialData?['city'] ?? 'Ciudad no definida',
                            'price': '${_precioController.text}€/h',
                          };

                          Navigator.pop(context, updatedService);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 34, 178, 189),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        widget.initialData != null ? 'Guardar Cambios' : 'Continuar',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}