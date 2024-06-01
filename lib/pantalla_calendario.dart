import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'usuario_sesion.dart'; // Importamos el Singleton para la sesión de usuario



class Calendario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    DateTime today = DateTime.now();
    // Imprime el ID del usuario usando el Singleton
    int? userId = UsuarioSesion().id;
    print('El ID del usuario es: $userId');
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calendario'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
          body:TableCalendar(
            locale:'es',
            headerStyle: const HeaderStyle(formatButtonVisible: false , titleCentered: true),
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: today,
          )
      ),


    );
  }

}

