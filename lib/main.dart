import 'package:flutter/material.dart';
import 'package:project1/ParentMainPage.dart';
import 'package:project1/ProfessionalMessagesScreen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'db_helper.dart';
import 'dart:io';
import 'package:window_size/window_size.dart';

import 'AddServicePage.dart';
import 'ProfessionalProfilePage.dart';
import '/login_splash_screen.dart';
import '/loginscreen.dart';
import '/registerscreen.dart';
import '/usertypeselectionscreen.dart';
import '/parenthomescreen.dart';
import '/parentdashboardscreen.dart';
import '/ProfessionalHomeScreen.dart';
import '/professionaldashboardscreen.dart';
import 'BookingPage.dart';
import 'Service.dart'; 
import 'MessagesScreen.dart'; 
import 'HistoryScreen.dart';
import 'ParentProfilePage.dart';
import 'ServiceSearchPage.dart'; 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('KidConnect');
    setWindowMinSize(const Size(400, 800));
    setWindowMaxSize(const Size(1280, 900));
    setWindowFrame(const Rect.fromLTWH(100, 100, 400, 800)); // X, Y, width, height
  }

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
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF6B8C89),
        colorScheme: ColorScheme.dark(
          primary: const Color.fromARGB(255, 255, 255, 255),
          secondary: const Color(0xFF6B8C89),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginSplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/user_type_selection': (context) => const UserTypeSelectionScreen(),
        '/parent_home': (context) => const ParentHomeScreen(),
        '/parent_dashboard': (context) => const ParentDashboardScreen(),
        '/parent_main': (context) => const ParentMainPage(),
        '/professional_home': (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          final user = args is Map<String, dynamic> ? args : <String, dynamic>{};
          return ProfessionalHomeScreen(user: user);
        }, // Debes crear esta pantalla
        '/professional_dashboard': (context) => const ProfessionalDashboardScreen(),
        '/add_service': (context) => const AddServicePage(),
        '/professional_profile': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ?? {};
          final userInfoDynamic = args['userInfo'] ?? {};
          final servicesDynamic = args['services'] ?? [];
          // Conversión segura a Map<String, String> y List<Map<String, String>>
          final userInfo = Map<String, String>.from(userInfoDynamic);
          final services = List<Map<String, String>>.from(servicesDynamic);
          return ProfessionalProfilePage(userInfo: userInfo, services: services);
        },
        '/book_service': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          final service = Service.fromMap(args);
          return BookingPage(service: service);
        },
        '/messages': (context) => MessagesScreen(), 
        '/professional_messages': (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          final user = args is Map<String, dynamic> ? args : <String, dynamic>{};
          return ProfessionalMessageScreen(user: user);
        },
        '/history': (context) => const HistoryScreen(),
        '/parent_profile': (context) => const ParentProfilePage(),
        '/search_services': (context) => const ServiceSearchPage(),
      },
    );
  }
}






























