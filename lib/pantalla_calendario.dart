// Path: lib/calendario.dart

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'usuario_sesion.dart'; // Importamos el Singleton para la sesión de usuario
import 'entrada.dart';
import 'package:echoing_emotions/entrada.dart';
import 'basedatos_calen_helper.dart';

void main() => runApp(Calendario());

class Event {
  final String title;
  final String description;

  Event(this.title, this.description);
}

class Calendario extends StatefulWidget {
  final dbCalendario = DBHelper_calendario.instance;
  @override
  _CalendarioState createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, List<Event>> _events = {
    DateTime.utc(2023, 6, 5): [
      Event('Evento 1', 'Descripción del evento 1'),
      Event('Evento 2', 'Descripción del evento 2')
    ],
    DateTime.utc(2023, 6, 6): [Event('Evento 3', 'Descripción del evento 3')],
  };

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    initializeDateFormatting();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    int? userId = UsuarioSesion().id;
    print('El ID del usuario es: $userId');

    //await DBHelper_calendario.instance.databaseC;
    //final entradas =await DBHelper_calendario.instance.buscarUsuario(userId!);
    //print(entradas);

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
        body: Container(
          color: Colors.grey[200], // Set the desired background color
          child: Column(
            children: [
              TableCalendar(
                locale: 'es',
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  decoration: BoxDecoration(
                    color: Colors.transparent, // Make header background transparent
                  ),
                ),
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  todayDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  weekendTextStyle: TextStyle(color: Colors.red),
                  defaultTextStyle: TextStyle(color: Colors.black),
                ),
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    _selectedEvents.value = _getEventsForDay(selectedDay);
                  });
                },
                eventLoader: _getEventsForDay,
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: ValueListenableBuilder<List<Event>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(value[index].title),
                          subtitle: Text(value[index].description),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
