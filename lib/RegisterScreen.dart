import 'package:flutter/material.dart';
import 'models/user_model.dart';
import 'databases/database_helper.dart';
import 'widgets/styledcontainer.dart';

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
  String selectedUserType = 'parent'; // Valor por defecto

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
        userType: selectedUserType, // Debe ser 'parent' o 'professional'
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
      backgroundColor: const Color(0xFFEFF3F3),
      body: StyledContainer(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Tabs de login/registro
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF6B8C89),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Iniciar Sesion'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6B8C89),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Registrarme'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Bienvenido a KidConnect',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6B8C89),
                  ),
                ),
              ),
              const SizedBox(height: 24),
                Form(
                key: _formKey,
                child: Column(
                  children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                    labelText: 'Nombre',
                    labelStyle: const TextStyle(color: Color(0xFF6B8C89)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFF6B8C89)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFF6B8C89)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFF4B6C6A), width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    ),
                    style: const TextStyle(color: Color(0xFF222222)),
                    validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor, ingresa tu nombre';
                    }
                    return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: surnameController,
                    decoration: InputDecoration(
                    labelText: 'Apellidos',
                    labelStyle: const TextStyle(color: Color(0xFF6B8C89)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFF6B8C89)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFF6B8C89)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFF4B6C6A), width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    ),
                    style: const TextStyle(color: Color(0xFF222222)),
                    validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor, ingresa tus apellidos';
                    }
                    return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: birthDateController,
                    readOnly: true,
                    decoration: InputDecoration(
                    labelText: 'Fecha de nacimiento',
                    labelStyle: const TextStyle(color: Color(0xFF6B8C89)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFF6B8C89)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFF6B8C89)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFF4B6C6A), width: 2),
                    ),
                    hintText: 'DD/MM/YYYY',
                    hintStyle: const TextStyle(color: Color(0xFF6B8C89)),
                    filled: true,
                    fillColor: Colors.transparent,
                    suffixIcon: const Icon(Icons.calendar_today, color: Color(0xFF6B8C89)),
                    ),
                    style: const TextStyle(color: Color(0xFF222222)),
                    onTap: () => _selectDate(context),
                    validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, selecciona tu fecha de nacimiento';
                    }
                    return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    labelStyle: const TextStyle(color: Color(0xFF6B8C89)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFF6B8C89)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFF6B8C89)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFF4B6C6A), width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    ),
                    style: const TextStyle(color: Color(0xFF222222)),
                    validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor, ingresa tu correo electrónico';
                    }
                    return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: const TextStyle(color: Color(0xFF6B8C89)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFF6B8C89)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFF6B8C89)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFF4B6C6A), width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    ),
                    style: const TextStyle(color: Color(0xFF222222)),
                    validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor, ingresa tu contraseña';
                    }
                    return null;
                    },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _registerUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6B8C89),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Registrarme',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // Handle Google sign in
                        },
                        icon: Icon(Icons.g_mobiledata, color: Color(0xFF6B8C89)),
                        label: const Text(
                          'Continuar con Google',
                          style: TextStyle(color: Color(0xFF6B8C89)),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF6B8C89)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Botón de debug opcional, puedes quitarlo en producción
                    ElevatedButton(
                      onPressed: debugUsers,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text('Mostrar usuarios (debug)'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}