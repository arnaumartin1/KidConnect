import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'db_helper.dart';

import 'AddServicePage.dart';
import 'ProfessionalProfilePage.dart';
import '/login_splash_screen.dart';
import '/loginscreen.dart';
import '/registerscreen.dart';
import '/usertypeselectionscreen.dart';
import '/parenthomescreen.dart';
import '/parentdashboardscreen.dart';
import '/professionalhomescreen.dart';
import '/professionaldashboardscreen.dart';
import '/addservicepage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  try {
    await DBHelper.initDB();
    print('Database initialized successfully');
  } catch (e) {
    print('Error initializing database: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KidConnect',
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: const Color.fromARGB(255, 34, 178, 189),
          onPrimary: Colors.white,
          secondary: const Color.fromARGB(255, 34, 178, 189),
          onSecondary: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 34, 178, 189),
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 34, 178, 189),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginSplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/user_type_selection': (context) => const UserTypeSelectionScreen(),
        '/parent_home': (context) => const ParentHomeScreen(),
        '/parent_dashboard': (context) => const ParentDashboardScreen(),
        '/professional_home': (context) => const ProfessionalHomeScreen(),
        '/professional_dashboard': (context) => const ProfessionalDashboardScreen(),
        '/add_service': (context) => const AddServicePage(),
        '/professional_profile': (context) => const ProfessionalProfilePage(),
      },
    );
  }
}






























