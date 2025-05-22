import 'package:flutter/material.dart';
import 'models/user_model.dart';
import 'databases/database_helper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  DateTime? selectedBirthDate;

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    birthDateController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _registerUser() async {
    if (_formKey.currentState!.validate()) {
      final user = User(
        name: nameController.text.trim(),
        surname: surnameController.text.trim(),
        birthDate: birthDateController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        userType: '',
      );

      await DatabaseHelper().insertUser(user);

      Navigator.pushNamed(context, '/user_type_selection');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2010, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedBirthDate) {
      setState(() {
        selectedBirthDate = picked;
        birthDateController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  void debugUsers() async {
    List<User> users = await DatabaseHelper().getUsers();
    for (var user in users) {
      print('${user.name} - ${user.email} - ${user.userType}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KidConnect'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Bienvenido a KidConnect',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, ingresa tu nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: surnameController,
                decoration: const InputDecoration(
                  labelText: 'Apellidos',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, ingresa tus apellidos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: birthDateController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Fecha de nacimiento',
                  border: OutlineInputBorder(),
                  hintText: 'DD/MM/YYYY',
                ),
                onTap: () => _selectDate(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecciona tu fecha de nacimiento';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, ingresa tu correo electrónico';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, ingresa tu contraseña';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _registerUser,
                child: const Text('Registrarme'),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  // Handle Google sign in
                },
                child: const Text('Continuar con Google'),
              ),
              ElevatedButton(
                onPressed: debugUsers,
                child: const Text('Mostrar usuaris (debug)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}