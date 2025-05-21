import 'package:flutter/material.dart';
import 'models/user_model.dart';
import 'databases/database_helper.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // Alliberem memòria
    nameController.dispose();
    surnameController.dispose();
    birthDateController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Funció per registrar
  void _registerUser() async {
    final user = User(
      name: nameController.text.trim(),
      surname: surnameController.text.trim(),
      birthDate: birthDateController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      userType: '', // De moment buit, s'omplirà després
    );

    await DatabaseHelper().insertUser(user);

    Navigator.pushNamed(context, '/user_type_selection');
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
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: surnameController,
              decoration: const InputDecoration(
                labelText: 'Apellidos',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: birthDateController,
              decoration: const InputDecoration(
                labelText: 'DD/MM/YYYY',
                border: OutlineInputBorder(),
                hintText: 'Fecha de nacimiento',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
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
    );
  }
}