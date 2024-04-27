import 'package:flutter/material.dart';

class EditarNotificaiones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar notificaciones'),
      ),
      body: Center(
        child: Text(
          'Pantalla de configuración de notificaciones',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
