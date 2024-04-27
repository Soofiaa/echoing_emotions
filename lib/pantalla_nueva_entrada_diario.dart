/*
class EntradaDiario {
  String contenido;
  DateTime fecha;
  // podemos agregar la personalización de colores de hoja y tipo de hoja (con lineas - punteada - blanca)

  EntradaDiario({required this.fecha}) : contenido = '';
}
*/

import 'package:flutter/material.dart';

class EntradaDiario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrada nueva del diario'),
      ),
      body: Center(
        child: Text(
          'Esta es la interfaz para agregar una entrada al diario',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
