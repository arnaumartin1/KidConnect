import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // <-- Agrega esto

import 'HomePage.dart';
import 'LoginScreen.dart';
import 'RegisterScreen.dart';
import 'UserTypeSelectionScreen.dart';
import 'ParentHomeScreen.dart';
import 'ParentDashboardScreen.dart';
import 'ProfessionalHomeScreen.dart';
import 'ProfessionalDashboardScreen.dart';
import 'db_helper.dart';
import 'AddServicePage.dart';
import 'ProfessionalProfilePage.dart';

void main() async {
  // Ensure Flutter is initialized before using platform channels
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializa sqflite para escritorio
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  try {
    // Initialize the database
    await DBHelper.initDB();
    print('Database initialized successfully');
  } catch (e) {
    print('Error initializing database: $e');
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KidConnect',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: const Color.fromARGB(255, 34, 178, 189),
          onPrimary: Colors.white,
          secondary: const Color.fromARGB(255, 34, 178, 189),
          onSecondary: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 34, 178, 189), // Fondo del botón
            foregroundColor: Colors.white, // Texto del botón
            minimumSize: const Size.fromHeight(50), // Altura uniforme
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Bordes redondeados
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 34, 178, 189), // Color para TextButtons
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(title: 'KidConnect'),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/user_type_selection': (context) => const UserTypeSelectionScreen(),
        '/parent_home': (context) => const ParentHomeScreen(), // Debes crear esta pantalla
        '/parent_dashboard': (context) => const ParentDashboardScreen(),
        '/professional_home': (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          final user = args is Map<String, dynamic> ? args : <String, dynamic>{};
          return ProfessionalHomeScreen(user: user);
        }, // Debes crear esta pantalla
        '/professional_dashboard': (context) => const ProfessionalDashboardScreen(),
        '/add_service': (context) => const AddServicePage(),
      },
    );
  }
}
