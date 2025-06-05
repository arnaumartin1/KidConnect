import 'package:flutter/material.dart';

class KidConnectApp extends StatelessWidget {
  const KidConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KidConnect',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: AppRoutes.routes,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
    );
  }
}

class AppRoutes {
  static final routes = <String, WidgetBuilder>{
    '/login': (context) => Scaffold(
          appBar: AppBar(title: Text('Login')),
          body: Center(child: Text('Login Page')),
        ),
    // Add more routes here as needed
  };
}
