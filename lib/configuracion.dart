import 'package:flutter/material.dart';

class Configuracion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
      ),
      body: Center(
        child: Text(
          'Pantalla de configuración',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
