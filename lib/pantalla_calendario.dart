import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'usuario_sesion.dart';
import 'entrada.dart';
import 'basedatos_calen_helper.dart';
import 'pantalla_nueva_entrada_diario.dart';

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

  Entrada toEntrada() {
    return Entrada(
      id_entrada: id,
      id_usuario: idUsuario,
      titulo: titulo,
      contenido: contenido,
      dibujo: dibujo,
      audio: audio,
      fecha: fecha,
      emocion: emocion,
      emoji: emoji,
    );
  }

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
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    initializeDateFormatting();
    cargarEntradas();
  }

  Future<void> cargarEntradas() async {
    int userId = UsuarioSesion().id ?? 0; // Asegúrate de que userId no sea nulo
    final entradas = await DBHelper_calendario.instance.buscarUsuario(userId);
    _processEntries(entradas);
  }

  void _processEntries(List<Map<String, dynamic>> entries) {
    for (var entry in entries) {
      DateTime entryDate = DateTime.parse(entry["fecha"]);
      DateTime entryDateUtc = DateTime.utc(entryDate.year, entryDate.month, entryDate.day);
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
    }
    setState(() {
      _selectedEvents.value = _getEventsForDay(_selectedDay!);
    });
  }

  void _deleteEvent(DateTime day, Event event) {
    setState(() async {
      await DBHelper_calendario.instance.eliminarEntrada(event.id);
      _events[day]?.remove(event);
      if (_events[day]?.isEmpty ?? false) {
        _events.remove(day);
      }
      _selectedEvents.value = _getEventsForDay(_selectedDay!);
    });
  }

  void _modifyEvent(DateTime day, Event oldEvent, Event newEvent) {
    setState(() {
      int index = _events[day]?.indexOf(oldEvent) ?? -1;
      if (index != -1) {
        _events[day]?[index] = newEvent;
      }
      _selectedEvents.value = _getEventsForDay(_selectedDay!);
    });
    DBHelper_calendario.instance.modificarEntrada(newEvent.toEntrada());
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
    return Scaffold(
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EntradaDiario(
                                      emocion: event.emocion,
                                      emoji: event.emoji,
                                    ),
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EntradaDiario(
                                emocion: event.emocion,
                                emoji: event.emoji,
                                evento: event,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}