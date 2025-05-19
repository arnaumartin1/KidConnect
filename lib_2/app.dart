import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

class KidConnectApp extends StatelessWidget {
  const KidConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoutes.router,
    );
  }
}