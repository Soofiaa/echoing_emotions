import 'package:flutter/material.dart';

class EntradaDiario {
  String contenido;
  DateTime fecha;
  // podemos agregar la personalización de colores de hoja y tipo de hoja (con lineas - punteada - blanca)

  EntradaDiario({required this.fecha}) : contenido = '';
}
