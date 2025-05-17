import 'package:flutter/material.dart';

class ParentMainPage extends StatefulWidget {
  const ParentMainPage({super.key});

  @override
  State<ParentMainPage> createState() => _ParentMainPageState();
}

class _ParentMainPageState extends State<ParentMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parent Main Page'),
      ),
      body: Center(
        child: Text('Welcome to Parent Main Page!'),
      ),
    );
  }
}