import 'package:flutter/material.dart';
import 'pantalla_inicio_sesion.dart'; // Importa el widget de la pantalla de inicio de sesión
import 'pantalla_mi_perfil.dart'; // Importa el widget de la pantalla siguiente al inicio de sesión
import 'package:flutter_localizations/flutter_localizations.dart';
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

