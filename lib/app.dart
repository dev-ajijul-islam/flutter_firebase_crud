import 'package:firebase_crud_practice/screens/home_screen.dart';
import 'package:flutter/material.dart';

class FirebaseCrud extends StatefulWidget {
  const FirebaseCrud({super.key});

  static bool isLight = true;

  @override
  State<FirebaseCrud> createState() => _FirebaseCrudState();
}

class _FirebaseCrudState extends State<FirebaseCrud> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: FirebaseCrud.isLight ? ThemeMode.light : ThemeMode.dark,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.teal,
          surface: Colors.grey.shade100,
        ),
        listTileTheme: ListTileThemeData(
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: Colors.blueGrey.shade900,
          surface: Colors.black,
        ),
        listTileTheme: ListTileThemeData(
          tileColor: Colors.white12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(onThemeChanged: () => setState(() {})),
    );
  }
}
