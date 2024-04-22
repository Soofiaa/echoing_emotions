import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importa DateFormat
import 'entrada_diario.dart';

// Clase que representa la interfaz de usuario de una página del diario
class InterfazPagina extends StatelessWidget {
  final EntradaDiario entrada;

  InterfazPagina(this.entrada);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(DateFormat('yyyy-mm-dd').format(entrada.fecha))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              entrada.contenido,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

