import 'package:flutter/material.dart';

class EditarNotificaiones  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar notificaciones'),
      ),
      body: const Center(
        child: Text(
          'Pantalla de configuración de notificaciones',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
