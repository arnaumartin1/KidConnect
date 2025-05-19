import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/tutor/home_screen.dart';
import 'screens/tutor/favorites_screen.dart';
import 'screens/tutor/history_screen.dart';
import 'screens/tutor/profile_screen.dart';
import 'screens/provider/dashboard_screen.dart';
import 'screens/provider/messages_screen.dart';
import 'screens/provider/profile_screen.dart';

void main() {
  runApp(const KidConnectApp());
}

class KidConnectApp extends StatelessWidget {
  const KidConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KidConnect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const SignupScreen(),
        // Tutor routes
        '/tutor/home': (context) => const TutorHomeScreen(),
        '/tutor/favorites': (context) => const FavoritesScreen(),
        '/tutor/history': (context) => const HistoryScreen(),
        '/tutor/profile': (context) => const TutorProfileScreen(
              name: '',
              email: '',
              phone: '',
              city: '',
            ),
        // Provider routes
        '/provider/dashboard': (context) => const ProviderDashboardScreen(),
        '/provider/messages': (context) => const ProviderMessagesScreen(),
        '/provider/profile': (context) => const ProviderProfileScreen(
              name: '',
              email: '',
              phone: '',
              description: '',
              rating: 0.0,
              reviews: 0,
              servicesDone: 0,
              recurringClients: 0,
            ),
      },
    );
  }
}