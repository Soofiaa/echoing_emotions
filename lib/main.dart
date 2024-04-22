import 'package:flutter/material.dart';
import 'login_screen.dart'; // Importa el widget de la pantalla de inicio de sesión
import 'home_after_login.dart'; // Importa el widget de la pantalla siguiente al inicio de sesión

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(), // Usa LoginScreen como la pantalla de inicio
    );
  }
}
