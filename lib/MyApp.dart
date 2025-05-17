import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'LoginScreen.dart';
import 'ParentDashboardScreen.dart';
import 'ParentHomeScreen.dart';
import 'ProfessionalDashboardScreen.dart';
import 'ProfessionalHomeScreen.dart';
import 'RegisterScreen.dart';
import 'UserTypeSelectionScreen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KidConnect',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.

        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
        '/professional_home': (context) => const ProfessionalHomeScreen(), // Debes crear esta pantalla
        '/professional_dashboard': (context) => const ProfessionalDashboardScreen(),
      },
    );
  }
}