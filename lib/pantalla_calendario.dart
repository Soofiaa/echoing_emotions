

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'usuario_sesion.dart'; // Importamos el Singleton para la sesión de usuario
import 'entrada.dart';
import 'package:echoing_emotions/entrada.dart';
import 'basedatos_calen_helper.dart';


class Event {
  final int id;
  final int idUsuario;
  final String titulo;
  final String contenido;
  final String dibujo;
  final String? audio;
  final String fecha;
  final String? emocion;
  final String? emoji;

  Event({
    required this.id,
    required this.idUsuario,
    this.titulo = '',
    this.contenido = '',
    this.dibujo = '',
    this.audio = '',
    required this.fecha,
    this.emocion = '',
    this.emoji = ''
  });

  @override
  String toString() {
    return 'Event(id: $id, idUsuario: $idUsuario, titulo: $titulo, fecha: $fecha)';
  }
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

  final Map<DateTime, List<Event>> _events = {};

  @override
  void initState() {
    super.initState();
    print('initState se ha ejecutado correctamente'); // Mensaje de consola
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    initializeDateFormatting();

    // para utilizar

    // deberia funcionar  errores  si muchos click modificar
    cargarEntradas();


    // Llamar a la función para procesar las entradas de ejemplo
    /*_processEntries([
      {
        "id_entrada": 1,
        "id_usuario": 1,
        "titulo": "Evento 1",
        "contenido": "Descripción del evento 1",
        "dibujo": "dibujo1",
        "audio": "audio1",
        "fecha": "2024-05-28"
      },
      {
        "id_entrada": 2,
        "id_usuario": 1,
        "titulo": "Evento 2",
        "contenido": "Descripción del evento 2",
        "dibujo": "dibujo2",
        "audio": "audio2",
        "fecha": "2024-05-28"
      },
      {
        "id_entrada": 3,
        "id_usuario": 1,
        "titulo": "Evento 3",
        "contenido": "Descripción del evento 3",
        "dibujo": "dibujo3",
        "audio": "audio3",
        "fecha": "2024-04-28"
      }
    ]);*/
    print('Eventos procesados: ${_events.length}');
  }

  void _processEntries(List<Map<String, dynamic>> entries) {
    for (var entry in entries) {
      DateTime entryDate = DateTime.parse(entry["fecha"]);
      DateTime entryDateUtc = DateTime.utc(entryDate.year, entryDate.month, entryDate.day);
      print('Procesando entrada con fecha UTC: $entryDateUtc'); // Mensaje de consola para la fecha
      Event event = Event(
        id: entry["id_entrada"],
        idUsuario: entry["id_usuario"],
        titulo: entry["titulo"],
        contenido: entry["contenido"],
        dibujo: entry["dibujo"],
        audio: entry["audio"],
        fecha: entryDateUtc.toString(),
        emocion: entry["emocion"],
        emoji: entry["emoji"],
      );
      if (!_events.containsKey(entryDateUtc)) {
        _events[entryDateUtc] = [];
      }
      _events[entryDateUtc]!.add(event);
      print('Evento añadido: $event'); // Mensaje de consola para el evento
    }
    setState(() {
      _selectedEvents.value = _getEventsForDay(_selectedDay!);
    });
    print('Eventos añadidos a _events: $_events'); // Mensaje de consola para todos los eventos
  }
  Future<void> cargarEntradas() async {
    final entradas = await DBHelper_calendario.instance.buscarUsuario(1);
    _processEntries(entradas);
  }
  // agregar quitar de base de datos dentro del if
  //I/flutter (15947): Evento eliminado: Event(id: 1, idUsuario: 1, titulo: Evento 1, fecha: 2024-05-28 00:00:00.000Z)
  //fijate que al final del tiempo tiene una Z ni idea
  void _deleteEvent(DateTime day, Event event) {
    setState(() {
      _events[day]?.remove(event);
      if (_events[day]?.isEmpty ?? false) {
        _events.remove(day);
      }
      _selectedEvents.value = _getEventsForDay(_selectedDay!);
    });
    print('Evento eliminado: $event');
  }

  // agregar cambiar de pantalla a modificar y cambiar de base de datos dentro del if
  //Evento modificado: Event(id: 2, idUsuario: 1, titulo: Evento 2 (Modificado), fecha: 2024-05-28 00:00:00.000Z)
  //fijate que al final del tiempo tiene una Z ni idea
  void _modifyEvent(DateTime day, Event oldEvent, Event newEvent) {
    setState(() {
      int index = _events[day]?.indexOf(oldEvent) ?? -1;
      if (index != -1) {
        _events[day]?[index] = newEvent;
      }
      _selectedEvents.value = _getEventsForDay(_selectedDay!);
    });
    print('Evento modificado: $newEvent');
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
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
        body: Container(
          color: Colors.grey[200],
          child: Column(
            children: [
              TableCalendar(
                locale: 'es',
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
                calendarStyle: const CalendarStyle(
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
                        Event event = value[index];
                        return ListTile(
                          title: Text(event.titulo),
                          subtitle: Text(event.contenido),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  // Aquí agregaríamos el código para modificar el evento
                                  _modifyEvent(
                                    _selectedDay!,
                                    event,
                                    Event(
                                      id: event.id,
                                      idUsuario: event.idUsuario,
                                      titulo: '${event.titulo} (Modificado)',
                                      contenido: event.contenido,
                                      dibujo: event.dibujo,
                                      audio: event.audio,
                                      fecha: event.fecha,
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _deleteEvent(_selectedDay!, event);
                                },
                              ),
                            ],
                          ),
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
