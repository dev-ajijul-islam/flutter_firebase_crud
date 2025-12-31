import 'package:firebase_crud_practice/screens/home_screen.dart';
import 'package:flutter/material.dart';

class FirebaseCrud extends StatelessWidget {
  const FirebaseCrud({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
