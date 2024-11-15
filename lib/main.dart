import 'package:daar_daar/login/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'daar daar Login',
      theme: ThemeData(
        primarySwatch: const Color.fromARGB(255, 243, 229, 33),
        scaffoldBackgroundColor: Colors.white, // Définition de l'arrière-plan global en blanc
      ),
      home: const LoginScreen(),
    );
  }
}
