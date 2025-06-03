import 'package:flutter/material.dart';
import '../widgets/appbar.dart';

class ParentMainPage extends StatefulWidget {
  const ParentMainPage({super.key});

  @override
  State<ParentMainPage> createState() => _ParentMainPageState();
}

class _ParentMainPageState extends State<ParentMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KidConnectAppBar(),
      body: Center(
        child: Text('Welcome to Parent Main Page!'),
      ),
    );
  }
}